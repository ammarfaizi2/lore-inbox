Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316530AbSFGCF2>; Thu, 6 Jun 2002 22:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSFGCF1>; Thu, 6 Jun 2002 22:05:27 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:60367 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316530AbSFGCFY>; Thu, 6 Jun 2002 22:05:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH] initcall dependency solution.
Date: Fri, 07 Jun 2002 12:02:11 +1000
Message-Id: <E17G94u-0000K4-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows you to name initcall dependencies and subsystems.
It is backward compatible with the current initcall levels, but
doesn't respect link order: a couple of changes to make it boot, but
more will be needed I expect.

Example usages:
	/* Simple initcall, don't care when we run. */
	initcall(myinitfn, foodriver);

	/* Initcall which must run after it */
	initcall(myinitfn, bardriver, init_after(foodriver));

	/* Initcalls which are part of a subsystem */
	initcall(myinitfn, bazdriver_a, init_as_part_of(bazdriver_init));
	initcall(myinitfn, bazdriver_b,
		 init_as_part_of(bazdriver_init),
		 init_after(bazdriver_a));

	/* Initcall which requires a subsystem */
	initcall(myinitfn, wuzdriver, init_after(bazdriver_init));

I think we should keep core_init (for mm), and probably let the others
evolve as required.  We can move much more to initfuncs now, too.

Questions & feedback welcome...
Rusty.
PS.  Yes, it slows down kernel build.  But sh is portable and easy.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/include/linux/init.h working-2.5.20-initorder/include/linux/init.h
--- linux-2.5.20/include/linux/init.h	Wed Jun  5 11:58:08 2002
+++ working-2.5.20-initorder/include/linux/init.h	Fri Jun  7 10:10:19 2002
@@ -1,7 +1,12 @@
 #ifndef _LINUX_INIT_H
 #define _LINUX_INIT_H
+/* Hacked on by just about everyone.  Explicit ordering work by:
+ * Rusty Russell (C) 2002 IBM Corporation */
+
+/* Change this file, make sure you don't break scripts/build-initcalls */
 
 #include <linux/config.h>
+#include <linux/stringify.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
@@ -48,29 +53,46 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __initcall_start, __initcall_end;
+#define INITCALL_MAX_NAMELEN 32
+#define INITCALL_MAX_DEPS 3
 
-/* initcalls are now grouped by functionality into separate 
- * subsections. Ordering inside the subsections is determined
- * by link order. 
- * For backwards compatability, initcall() puts the call in 
- * the device init subsection.
- */
+/* Ensure it's initialized after x */
+#define init_after(x) { .follows = __stringify(x) "-end" }
 
-#define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".initcall" level ".init"))) = fn
+/* Ensure it's initialized before x */
+#define init_before(x) { .preceeds = __stringify(x) "-start" }
 
-#define core_initcall(fn)		__define_initcall("1",fn)
-#define unused_initcall(fn)		__define_initcall("2",fn)
-#define arch_initcall(fn)		__define_initcall("3",fn)
-#define subsys_initcall(fn)		__define_initcall("4",fn)
-#define fs_initcall(fn)			__define_initcall("5",fn)
-#define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
+/* This is part of the x subsystem initialization */
+#define init_as_part_of(x)						\
+  { .follows = __stringify(x) "-start",  .preceeds = __stringify(x) "-end" }
 
-#define __initcall(fn) device_initcall(fn)
+/* Example usage:
+	initcall(myinit, ppc_extras,
+		 init_after(ppc_core),
+		 init_as_part_of(arch_init));
+   Do not use a "_init" name except for subsystems (ie. init_as_part_of()).
+*/
+#define initcall(initfn,initname,...)					\
+	static inline initcall_t __init_##initname##_test(void)		\
+	{ return initfn; }						\
+	int __init_##initname(void) __attribute__((alias(#initfn)));	\
+	static const struct initcall_info initfn##_initcall_info	\
+	__attribute__ ((__section__ (".initcalls"))) =			\
+	{ .name = __stringify(initname), { __VA_ARGS__ } };
 
-#define __exitcall(fn)								\
+struct initcall_order
+{
+	char preceeds[INITCALL_MAX_NAMELEN];
+	char follows[INITCALL_MAX_NAMELEN];
+};
+
+struct initcall_info
+{
+	char name[INITCALL_MAX_NAMELEN];
+	struct initcall_order order[INITCALL_MAX_DEPS];
+};
+
+#define __exitcall(fn)	\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
 /*
@@ -86,7 +108,6 @@
 #define __setup(str, fn)								\
 	static char __setup_str_##fn[] __initdata = str;				\
 	static struct kernel_param __setup_##fn __attribute__((unused)) __initsetup = { __setup_str_##fn, fn }
-
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -135,7 +156,6 @@
 #define __exit
 #define __initdata
 #define __exitdata
-#define __initcall(fn)
 /* For assembly routines */
 #define __INIT
 #define __FINIT
@@ -159,14 +179,7 @@
 
 #define __setup(str,func) /* nothing */
 
-#define core_initcall(fn)		module_init(fn)
-#define unused_initcall(fn)		module_init(fn)
-#define arch_initcall(fn)		module_init(fn)
-#define subsys_initcall(fn)		module_init(fn)
-#define fs_initcall(fn)			module_init(fn)
-#define device_initcall(fn)		module_init(fn)
-#define late_initcall(fn)		module_init(fn)
-
+#define initcall(initfn,initname,...) module_init(initfn)
 #endif
 
 /* Data marked not to be saved by software_suspend() */
@@ -185,5 +198,21 @@
 #define __devexitdata __exitdata
 #define __devexit_p(x)  0
 #endif
+
+/* This many levels of indirection really required */
+#define ___CAT2(a,b) a##b
+#define __CAT2(a,b) ___CAT2(a,b)
+#define __FAKENAME __CAT2(KBUILD_BASENAME,__LINE__)
+#define __obs_initcall(fn,name,subsys) \
+	initcall(fn,name,init_as_part_of(subsys))
+
+/* Backwards compat macros: deprecated */
+#define core_initcall(fn) __obs_initcall(fn,__FAKENAME,core_init)
+#define arch_initcall(fn) __obs_initcall(fn,__FAKENAME,arch_init)
+#define subsys_initcall(fn) __obs_initcall(fn,__FAKENAME,subsys_init)
+#define fs_initcall(fn) __obs_initcall(fn,__FAKENAME,fs_init)
+#define device_initcall(fn) __obs_initcall(fn,__FAKENAME,device_init)
+#define late_initcall(fn) __obs_initcall(fn,__FAKENAME,late_init)
+#define __initcall(fn) device_initcall(fn)
 
 #endif /* _LINUX_INIT_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/Makefile working-2.5.20-initorder/Makefile
--- linux-2.5.20/Makefile	Mon Jun  3 12:21:18 2002
+++ working-2.5.20-initorder/Makefile	Fri Jun  7 09:44:23 2002
@@ -156,6 +156,7 @@
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -172,7 +173,10 @@
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(CONFIGURATION) $(vmlinux-objs) FORCE
+init/generated-initcalls.c: $(vmlinux-objs) scripts/build-initcalls
+	scripts/build-initcalls $(OBJDUMP) $(vmlinux-objs) >$@
+
+vmlinux: $(CONFIGURATION) $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
 #	The actual objects are generated when descending, 
@@ -440,7 +444,7 @@
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
-	kernel/ksyms.lst include/linux/compile.h \
+	init/generated-initcalls.c kernel/ksyms.lst include/linux/compile.h \
 	vmlinux System.map \
 	.tmp* \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/init/main.c working-2.5.20-initorder/init/main.c
--- linux-2.5.20/init/main.c	Mon Jun  3 12:21:28 2002
+++ working-2.5.20-initorder/init/main.c	Thu Jun  6 15:05:53 2002
@@ -421,19 +421,7 @@
 
 struct task_struct *child_reaper = &init_task;
 
-static void __init do_initcalls(void)
-{
-	initcall_t *call;
-
-	call = &__initcall_start;
-	do {
-		(*call)();
-		call++;
-	} while (call < &__initcall_end);
-
-	/* Make sure there is no pending stuff from the initcall sequence */
-	flush_scheduled_tasks();
-}
+extern void do_initcalls(void);
 
 /*
  * Ok, the machine is now initialized. None of the devices
@@ -485,6 +473,8 @@
 
 	start_context_thread();
 	do_initcalls();
+	/* Make sure there is no pending stuff from the initcall sequence */
+	flush_scheduled_tasks();
 }
 
 extern void prepare_namespace(void);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/kernel/exec_domain.c working-2.5.20-initorder/kernel/exec_domain.c
--- linux-2.5.20/kernel/exec_domain.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.20-initorder/kernel/exec_domain.c	Fri Jun  7 09:41:16 2002
@@ -281,7 +281,7 @@
 	return 0;
 }
 
-__initcall(abi_register_sysctl);
+initcall(abi_register_sysctl, exec_domain, init_as_part_of(core_init));
 
 
 EXPORT_SYMBOL(abi_defhandler_coff);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/kernel/softirq.c working-2.5.20-initorder/kernel/softirq.c
--- linux-2.5.20/kernel/softirq.c	Mon Jun  3 12:21:28 2002
+++ working-2.5.20-initorder/kernel/softirq.c	Fri Jun  7 09:41:42 2002
@@ -412,4 +412,4 @@
 	return 0;
 }
 
-__initcall(spawn_ksoftirqd);
+initcall(spawn_ksoftirqd, ksoftirqd, init_as_part_of(core_init));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/mm/highmem.c working-2.5.20-initorder/mm/highmem.c
--- linux-2.5.20/mm/highmem.c	Mon Apr 29 16:00:30 2002
+++ working-2.5.20-initorder/mm/highmem.c	Fri Jun  7 09:43:34 2002
@@ -220,7 +220,7 @@
 	return 0;
 }
 
-__initcall(init_emergency_pool);
+initcall(init_emergency_pool, "highmem", init_as_part_of(core_init));
 
 /*
  * highmem version, map in to vec
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/mm/slab.c working-2.5.20-initorder/mm/slab.c
--- linux-2.5.20/mm/slab.c	Mon May 13 12:00:40 2002
+++ working-2.5.20-initorder/mm/slab.c	Fri Jun  7 10:07:26 2002
@@ -508,7 +508,7 @@
 	return 0;
 }
 
-__initcall(kmem_cpucache_init);
+initcall(kmem_cpucache_init, slab, init_as_part_of(core_init));
 
 /* Interface to system's page allocator. No need to hold the cache-lock.
  */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/scripts/build-initcalls working-2.5.20-initorder/scripts/build-initcalls
--- linux-2.5.20/scripts/build-initcalls	Thu Jan  1 10:00:00 1970
+++ working-2.5.20-initorder/scripts/build-initcalls	Fri Jun  7 10:27:19 2002
@@ -0,0 +1,104 @@
+#! /bin/sh -e
+# Given an objdump, and a list of object files, spit out C code to
+# call all the inits in order.
+
+# Hardcoded section orderings here.
+FIXED="core_init arch_init subsys_init fs_init device_init late_init"
+
+if [ `expr $# \> 1` = 0 ]; then
+    echo Usage: $0 objdump objfile... >&2
+    exit 1
+fi
+
+OBJDUMP="$1"
+shift
+
+# Get the structure sizes.
+INCLUDE_FILE=include/linux/init.h
+NAMELEN=`grep '^#define.*INITCALL_MAX_NAMELEN' $INCLUDE_FILE | cut -d' ' -f3`
+NUMDEPS=`grep '^#define.*INITCALL_MAX_DEPS' $INCLUDE_FILE | cut -d' ' -f3`
+if [ x$NUMDEPS = x ] || [ x$NAMELEN = x ] || [ `expr $NAMELEN % 16` != 0 ];then
+    echo Invalid include file values: "$NAMELEN" and "$NUMDEPS" >&2
+    exit 1
+fi
+# Objdump deals in 16-byte quantities.
+NAMELEN=`expr $NAMELEN / 16`
+
+# I hate mktemp, but tempfile isn't avail on RedHat
+TMPFILE=`mktemp ${TMPDIR:-/tmp/}build-initcalls.XXXXXX`
+TMPFILE2=`mktemp ${TMPDIR:-/tmp/}build-initcalls2.XXXXXX`
+REGEX=`mktemp ${TMPDIR:-/tmp/}build-real.XXXXXX`
+trap "rm -f $TMPFILE $TMPFILE2 $NAMES" 0
+
+echo -n "s/\(" > $REGEX
+
+STATE=IN_NAME
+HEXABYTES=0
+FULLSTRING=""
+"$OBJDUMP" --section=.initcalls --full-contents "$@" |
+grep '^ *[0-9a-f][0-9a-f][0-9a-f][0-9a-f]' |
+while read POS HEX1 HEX2 HEX3 HEX4 STRING; do
+    # objdump uses . for non-printable, and we don't use real ones.
+    FULLSTRING="$FULLSTRING`echo -n \"$STRING\" | tr -d .`"
+    HEXABYTES=`expr $HEXABYTES + 1`
+    if [ $HEXABYTES = $NAMELEN ]; then
+	case $STATE in
+	IN_NAME)
+	    NAME="$FULLSTRING"
+	    # Mentioned as a name: actual routine, not subsystem.
+	    [ -z "$NAME" ] || echo -n "$NAME\|" >> $REGEX
+	    STATE=IN_INITCALL_PRECEEDS
+	    INITCALL_NUM=0
+	    ;;
+	IN_INITCALL_PRECEEDS)
+	    [ -z "$FULLSTRING" ] || echo "$NAME"-start "$FULLSTRING"
+	    STATE=IN_INITCALL_FOLLOWS
+	    ;;
+	IN_INITCALL_FOLLOWS)
+	    [ -z "$FULLSTRING" ] || echo "$FULLSTRING" "$NAME"-end
+	    INITCALL_NUM=`expr $INITCALL_NUM + 1`
+	    if [ $INITCALL_NUM = $NUMDEPS ]; then
+		STATE=IN_NAME
+	    else
+		STATE=IN_INITCALL_PRECEEDS
+	    fi
+	    ;;
+	esac
+	HEXABYTES=0
+	FULLSTRING=""
+    fi
+done > $TMPFILE
+
+# For everything which is an actual routine name, -start and -end are
+# the same.  Use regex to strip them.
+echo "INVALID-NAME\)-\(start\|end\)/\1/g" >> $REGEX
+sed "`cat $REGEX`" < $TMPFILE > $TMPFILE2
+
+# Add in fixed orderings.
+prev_fixed=""
+for fixed in $FIXED; do
+    [ x"$prev_fixed" = x ] || echo $prev_fixed-end $fixed-start
+    echo $fixed-start $fixed-end
+    prev_fixed=$fixed
+done >> $TMPFILE2
+
+# Do the sort.
+tsort < $TMPFILE2 > $TMPFILE
+
+# Generate output
+echo "/* Auto-generated by build-initcalls: DO NOT EDIT. */"
+echo "#include <linux/init.h>"
+echo ""
+echo "void __init do_initcalls(void)"
+echo "{"
+while read VALUE; do
+    case $VALUE in
+    *-end|*-start)
+	echo "/* $VALUE */"
+	;;
+    *)
+	echo "	{ extern int __init_$VALUE(void); __init_$VALUE(); }"
+	;;
+    esac
+done < $TMPFILE
+echo "}"
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

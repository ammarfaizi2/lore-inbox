Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSHEGPe>; Mon, 5 Aug 2002 02:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSHEGPe>; Mon, 5 Aug 2002 02:15:34 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:40170 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318305AbSHEGPb>;
	Mon, 5 Aug 2002 02:15:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] automatic module_init ordering 
In-reply-to: Your message of "Sun, 04 Aug 2002 17:30:47 +0200."
             <3D4D48A7.6BA919D2@linux-m68k.org> 
Date: Mon, 05 Aug 2002 16:13:36 +1000
Message-Id: <20020805062048.E41684273@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D4D48A7.6BA919D2@linux-m68k.org> you write:
> Hi,
> 
> Martin, could you please check the ide initialization? Why are device
> type driver initialized twice? If I try to remove one of them, one
> machine here doesn't boot anymore.

Sorry for being out of the loop for a while.

This patch takes Roman's work and massages it a little so the addition
of explicit initcall dependencies is easier.  I'm testing it now (see
my kernel.org page for updates).

1) Rename build-initcalls to build-module-initcalls
2) Generate explicit calls, which is clearer than an array.
3) Simplify (and hopefully speed up) by calling $(NM) once for all files.
4) Call initcalls from init/main.c rather then kernel/module.c

There seems to be a problem in that .allbuiltin_mods doesn't include
stuff in net/ipv4/netfilter/.builtin_mods for example (set
CONFIG_NETFILTER=y, CONFIG_IP_NF_IPTABLES=y, everything else there to Y).

Rusty.
PS.  Patch requires Kai's -DMODNAME patch, also on kernel.org page.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module initcall depends
Author: Roman Zippel
Status: Experimental
Depends: Misc/kbuild_object.patch.gz

D: The initialization of modules which are built into the kernel can be
D: derived implicitly from their dependencies.  This patch does that,
D: and also makes module_init() illegal for code which can never be a module.

diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-modname/Makefile working-2.5.30-module-init/Makefile
--- working-2.5.30-modname/Makefile	2002-08-02 11:15:05.000000000 +1000
+++ working-2.5.30-module-init/Makefile	2002-08-05 15:33:49.000000000 +1000
@@ -268,6 +268,7 @@ cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LD
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -283,9 +284,22 @@ define rule_link_vmlinux
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
+builtin_mods := $(addsuffix .builtin_mods,$(sort $(dir $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS))))
+
+quiet_cmd_gen_initcalls = GEN    $@
+cmd_gen_initcalls = $(CONFIG_SHELL) scripts/build-initcalls $(builtin_mods) > $@
+
+define rule_gen_initcalls
+	$(call cmd,gen_initcalls)
+	@echo 'cmd_$(@F) := $(cmd_gen_initcalls)' > .$(@F).cmd
+endef
+
+init/generated-initcalls.c: $(builtin_mods) FORCE
+	$(call if_changed_rule,gen_initcalls)
+
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
@@ -585,6 +599,7 @@ defconfig:
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
+	.allbuiltin_mods \
 	include/linux/compile.h \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
@@ -646,7 +661,7 @@ clean:	archclean
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
+		-name .\*.tmp -o -name .\*.d -o -name .builtin_mods -o -name generated\* -o -name .generated\* \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
 	@$(MAKE) -f Documentation/DocBook/Makefile clean
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-modname/Rules.make working-2.5.30-module-init/Rules.make
--- working-2.5.30-modname/Rules.make	2002-08-05 15:50:27.000000000 +1000
+++ working-2.5.30-module-init/Rules.make	2002-08-05 15:28:23.000000000 +1000
@@ -268,7 +269,7 @@ endif
 #	The echo suppresses the "Nothing to be done for first_rule"
 first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
 	    $(if $(KBUILD_MODULES),$(obj-m)) \
-	    sub_dirs
+	    sub_dirs .builtin_mods
 	@echo -n
 
 # Compile C sources (.c)
@@ -319,6 +320,25 @@ cmd_cc_lst_c     = $(CC) $(c_flags) -g -
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
 
+subdir-builtin_mods := $(addsuffix /.builtin_mods,$(subdir-y))
+
+$(subdir-builtin_mods): sub_dirs
+
+quiet_cmd_gen_builtin_mod = MOD    $(echo_target)
+define cmd_gen_builtin_mod
+	objs="$(sort $(local-objs-y))"; for o in $$objs; do \
+	  if [ -n "$$($(OBJDUMP) -h $$o | grep .initcall.module)" ]; then \
+	    echo $$o; \
+	  fi \
+	done > $@; \
+	dirs="$(sort $(subdir-y))"; for d in $$dirs; do \
+	  sed "s,^,$$d/," < $$d/.builtin_mods; \
+	done >> $@
+endef
+
+.builtin_mods: $(local-objs-y) $(subdir-builtin_mods) FORCE
+	$(call if_changed,gen_builtin_mod)
+
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-modname/drivers/ide/main.c working-2.5.30-module-init/drivers/ide/main.c
--- working-2.5.30-modname/drivers/ide/main.c	2002-08-02 11:15:08.000000000 +1000
+++ working-2.5.30-module-init/drivers/ide/main.c	2002-08-05 15:19:31.000000000 +1000
@@ -1417,23 +1417,6 @@ static int __init ata_module_init(void)
 	}
 # endif
 #endif
-
-	/*
-	 * Initialize all device type driver modules.
-	 */
-#ifdef CONFIG_BLK_DEV_IDEDISK
-	idedisk_init();
-#endif
-#ifdef CONFIG_BLK_DEV_IDECD
-	ide_cdrom_init();
-#endif
-#ifdef CONFIG_BLK_DEV_IDETAPE
-	idetape_init();
-#endif
-#ifdef CONFIG_BLK_DEV_IDEFLOPPY
-	idefloppy_init();
-#endif
-
 	initializing = 0;
 
 	register_reboot_notifier(&ata_notifier);
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-modname/include/linux/init.h working-2.5.30-module-init/include/linux/init.h
--- working-2.5.30-modname/include/linux/init.h	2002-06-10 16:03:55.000000000 +1000
+++ working-2.5.30-module-init/include/linux/init.h	2002-08-05 15:19:31.000000000 +1000
@@ -106,6 +111,9 @@ extern struct kernel_param __setup_start
 #define __FINIT		.previous
 #define __INITDATA	.section	".data.init","aw"
 
+#define ___concat(a,b)	a##b
+#define __concat(a,b)	___concat(a,b)
+
 /**
  * module_init() - driver initialization entry point
  * @x: function to be run at kernel boot time or module insertion
@@ -116,7 +124,10 @@ extern struct kernel_param __setup_start
  * routine with init_module() which is used by insmod and
  * modprobe when the driver is used as a module.
  */
-#define module_init(x)	__initcall(x);
+#define module_init(x)					\
+int __attribute__((__section__ (".initcall.module")))	\
+__concat(init_module_,KBUILD_MODNAME)(void)		\
+{ return x(); }
 
 /**
  * module_exit() - driver exit entry point
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-modname/init/main.c working-2.5.30-module-init/init/main.c
--- working-2.5.30-modname/init/main.c	2002-08-02 11:15:10.000000000 +1000
+++ working-2.5.30-module-init/init/main.c	2002-08-05 15:21:32.000000000 +1000
@@ -464,6 +464,8 @@ asmlinkage void __init start_kernel(void
 
 struct task_struct *child_reaper = &init_task;
 
+extern void do_module_initcalls(void);
+
 static void __init do_initcalls(void)
 {
 	initcall_t *call;
@@ -474,6 +476,8 @@ static void __init do_initcalls(void)
 		call++;
 	} while (call < &__initcall_end);
 
+	do_module_initcalls();
+
 	/* Make sure there is no pending stuff from the initcall sequence */
 	flush_scheduled_tasks();
 }
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-modname/net/irda/irsyms.c working-2.5.30-module-init/net/irda/irsyms.c
--- working-2.5.30-modname/net/irda/irsyms.c	2002-06-21 09:41:57.000000000 +1000
+++ working-2.5.30-module-init/net/irda/irsyms.c	2002-08-05 15:19:31.000000000 +1000
@@ -332,7 +332,7 @@ void __exit irda_cleanup(void)
  *
  * Jean II
  */
-subsys_initcall(irda_init);
+module_init(irda_init);
 module_exit(irda_cleanup);
  
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> & Jean Tourrilhes <jt@hpl.hp.com>");
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-modname/net/unix/af_unix.c working-2.5.30-module-init/net/unix/af_unix.c
--- working-2.5.30-modname/net/unix/af_unix.c	2002-07-17 10:25:54.000000000 +1000
+++ working-2.5.30-module-init/net/unix/af_unix.c	2002-08-05 15:19:31.000000000 +1000
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.30-modname/scripts/build-module-initcalls working-2.5.30-module-init/scripts/build-module-initcalls
--- working-2.5.30-modname/scripts/build-module-initcalls	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5.30-module-init/scripts/build-module-initcalls	2002-08-05 15:33:22.000000000 +1000
@@ -0,0 +1,34 @@
+#! /bin/sh
+# Given a list of module objects, spit out C code to call all the inits
+# in order, based on dependencies.
+
+# Don't do this in the top line, as we are invoked with sh explicitly.
+set -e
+
+# Clean up however we exit.
+trap 'rm .undefined.tmp .defined.tmp .sorted.tmp .other.tmp' 0
+
+# initialize files
+echo -n > .undefined.tmp
+echo -n > .defined.tmp
+
+# get all global defined/undefined symbols and sort them into the right files
+for f; do sed "s;^;$(dirname $f)/;" < $f; done | xargs $NM -A |
+    awk '/:[	]*U/ { sub(/:[	]*U/," "); print $0 | "sort -u > .undefined.tmp" }
+	/:[A-Fa-f0-9	]*[TD]/ { sub(/:[A-Fa-f0-9	]*[TD]/," "); print $0  | "sort -u > .defined.tmp" }'
+
+# topological sort objects and append all independent objects
+join -1 2 -2 2 -o "1.1 2.1" .defined.tmp .undefined.tmp | sort -u | tsort > .sorted.tmp
+fgrep -v -f .sorted.tmp < $list > .other.tmp
+cat .other.tmp >> .sorted.tmp
+
+# Output header.
+echo '/* Builtin module initcalls: autogenerated by build-module-initcalls */'
+echo '#include <linux/init.h>'
+echo ''
+echo 'void __init do_module_initcalls(void)'
+echo '{'
+
+$OBJDUMP -t `cat .sorted.tmp .other.tmp` |
+	awk '/F \.initcall\.module/ { print "	{ extern int " $6 "(void); " $6 "(); }" }'
+echo '}'

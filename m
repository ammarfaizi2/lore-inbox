Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318815AbSG0UUd>; Sat, 27 Jul 2002 16:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318817AbSG0UUd>; Sat, 27 Jul 2002 16:20:33 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:59665 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318815AbSG0UUa>; Sat, 27 Jul 2002 16:20:30 -0400
Message-ID: <3D430123.739CA34D@linux-m68k.org>
Date: Sat, 27 Jul 2002 22:22:59 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] automatic initcalls
Content-Type: multipart/mixed;
 boundary="------------C68B8DDB453ECF6D7029913B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C68B8DDB453ECF6D7029913B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch is based on Rusty's patch, I did these changes to get it
working:
- I only look at modules which contain an initcall
- I only order initcalls of level 6 and 7
This makes the problem managable, so that everything what can be built
as module is also correctly initialized when compiled in. Other
initcalls still have to be ordered manually, but these are the minority
and so easier to manage.
I had to push up a few initcall levels and fix a bug in the IDE driver,
but otherwise it seems to work fine.
I also included my version of KBUILD_MODNAME (IMO my version should be a
bit faster :) ).

bye, Roman
--------------C68B8DDB453ECF6D7029913B
Content-Type: text/plain; charset=us-ascii;
 name="initcall.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initcall.diff"

Index: Makefile
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/Makefile,v
retrieving revision 1.1.1.30
diff -u -p -r1.1.1.30 Makefile
--- Makefile	27 Jul 2002 12:34:13 -0000	1.1.1.30
+++ Makefile	27 Jul 2002 13:19:29 -0000
@@ -268,6 +268,7 @@ cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LD
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -284,9 +285,25 @@ define rule_link_vmlinux
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+init/generated-initcalls.c: .allinit.defs
+	set -e; echo '#include <linux/init.h>' > $@; \
+	sed -n < $< "s,^T ,,p" | sort > .defined.all; \
+	sed -n < $< "s,^U ,,p" | sort > .undefined.all; \
+	join -o "1.2 2.2" .defined.all .undefined.all | sort -u | tsort > .sorted.all; \
+	cut -d ' ' -f 3 < .allinit.defs | sort -u | grep -v -f .sorted.all > .other.all; \
+	cat .other.all >> .sorted.all; \
+	while read obj; do objdump -t $$obj | awk '/F \.initcall\.test/ { print "extern int " $$6 "(void);" }'; done < .other.all >> $@; \
+	echo 'initcall_t generated_initcalls[] = {' >> $@; \
+	while read obj; do objdump -t $$obj | awk '/F \.initcall\.test/ { print $$6 "," }'; done < .other.all >> $@; \
+	echo '0 };' >> $@
+
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
+.allinit.defs: $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)
+	rm -f $@; \
+	for s in $(dir $^); do ls -ld $$s; awk "{ print \$$1 \" \" \$$2 \" $$s\" \$$3 }" < $${s}.all_defs >> $@; done
+
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
@@ -586,6 +603,7 @@ defconfig:
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
+	init/generated-initcalls.c .allinit.defs .defined.all .undefined.all .other.all .sorted.all \
 	include/linux/compile.h \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
@@ -647,7 +665,7 @@ clean:	archclean
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
+		-name .\*.tmp -o -name .\*.d -o -name .\*[._]defs \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
 	@$(MAKE) -f Documentation/DocBook/Makefile clean
Index: Rules.make
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/Rules.make,v
retrieving revision 1.1.1.17
diff -u -p -r1.1.1.17 Rules.make
--- Rules.make	6 Jul 2002 00:33:37 -0000	1.1.1.17
+++ Rules.make	27 Jul 2002 18:56:39 -0000
@@ -105,9 +105,16 @@ multi-objs-m := $(foreach m, $(multi-use
 subdir-obj-y := $(foreach o,$(obj-y),$(if $(filter-out $(o),$(notdir $(o))),$(o)))
 
 # Replace multi-part objects by their individual parts, look at local dir only
-real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
+mod-objs-y := $(filter-out $(subdir-obj-y), $(obj-y))
+real-objs-y := $(foreach m, $(mod-objs-y), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
 real-objs-m := $(foreach m, $(obj-m), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m)))
 
+modnames := $(foreach m, $(sort $(mod-objs-y) $(objs-m)), $(if $($(m:.o=-objs)),$(foreach mm,$($(m:.o=-objs)),.$(mm).$(m))))
+
+modname = $(*F)
+
+$(multi-objs-y) $(multi-objs-m) : modname = $(patsubst .$@.%,%,$(filter .$@.%,$(modnames)))
+
 # Only build module versions for files which are selected to be built
 export-objs := $(filter $(export-objs),$(real-objs-y) $(real-objs-m))
 
@@ -168,6 +175,7 @@ $(addprefix $(MODVERDIR)/,$(export-objs:
 c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
 	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
+	  -DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname:.o=))) \
 	  $(export_flags) 
 
 # Our objects only depend on modversions.h, not on the individual .ver
@@ -248,7 +256,7 @@ endif
 #	The echo suppresses the "Nothing to be done for first_rule"
 first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
 	    $(if $(KBUILD_MODULES),$(obj-m)) \
-	    sub_dirs
+	    sub_dirs .all_defs
 	@echo -n
 
 # Compile C sources (.c)
@@ -269,6 +277,7 @@ $(export-objs:.o=.lst): export_flags   :
 c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
 	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
+	  -DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname:.o=))) \
 	  $(export_flags) 
 
 quiet_cmd_cc_s_c = CC     $(echo_target)
@@ -294,6 +303,17 @@ cmd_cc_lst_c     = $(CC) $(c_flags) -g -
 
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
+
+.%.defs: %.o
+	if [ -n "$$(objdump -h $< | egrep '^[ ]*[0-9]+ \.initcall\.test')" ]; then \
+	nm $< | sed -n "s,^[0-9a-f ]*\([TU].*\),\1 $<,p" > $@; \
+	else > $@; fi
+
+$(subdir-y:%=%/.all_defs): sub_dirs
+
+.all_defs: $(mod-objs-y:%.o=.%.defs) $(subdir-y:%=%/.all_defs)
+	cat $(mod-objs-y:%.o=.%.defs) /dev/null > $@; \
+	for s in $(subdir-y); do awk "{ print \$$1 \" \" \$$2 \" $$s/\" \$$3 }" < $$s/.all_defs; done >> $@
 
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
Index: drivers/ide/main.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/drivers/ide/main.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 main.c
--- drivers/ide/main.c	27 Jul 2002 12:40:01 -0000	1.1.1.7
+++ drivers/ide/main.c	27 Jul 2002 13:19:30 -0000
@@ -1401,12 +1401,6 @@ static int __init ata_module_init(void)
 	/*
 	 * Initialize all device type driver modules.
 	 */
-#ifdef CONFIG_BLK_DEV_IDEDISK
-	idedisk_init();
-#endif
-#ifdef CONFIG_BLK_DEV_IDECD
-	ide_cdrom_init();
-#endif
 #ifdef CONFIG_BLK_DEV_IDETAPE
 	idetape_init();
 #endif
Index: fs/dnotify.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/dnotify.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 dnotify.c
--- fs/dnotify.c	27 Jul 2002 12:34:15 -0000	1.1.1.5
+++ fs/dnotify.c	27 Jul 2002 13:19:30 -0000
@@ -155,4 +155,4 @@ static int __init dnotify_init(void)
 	return 0;
 }
 
-module_init(dnotify_init)
+fs_initcall(dnotify_init);
Index: fs/fcntl.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/fcntl.c,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 fcntl.c
--- fs/fcntl.c	27 Jul 2002 12:34:14 -0000	1.1.1.8
+++ fs/fcntl.c	27 Jul 2002 13:19:30 -0000
@@ -568,4 +568,4 @@ static int __init fasync_init(void)
 	return 0;
 }
 
-module_init(fasync_init)
+fs_initcall(fasync_init);
Index: fs/locks.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/locks.c,v
retrieving revision 1.1.1.9
diff -u -p -r1.1.1.9 locks.c
--- fs/locks.c	27 Jul 2002 12:34:14 -0000	1.1.1.9
+++ fs/locks.c	27 Jul 2002 13:19:30 -0000
@@ -1936,4 +1936,4 @@ static int __init filelock_init(void)
 	return 0;
 }
 
-module_init(filelock_init)
+fs_initcall(filelock_init);
Index: include/linux/init.h
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/include/linux/init.h,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 init.h
--- include/linux/init.h	13 Jun 2002 00:22:57 -0000	1.1.1.6
+++ include/linux/init.h	27 Jul 2002 13:19:30 -0000
@@ -65,10 +65,16 @@ extern initcall_t __initcall_start, __in
 #define arch_initcall(fn)		__define_initcall("3",fn)
 #define subsys_initcall(fn)		__define_initcall("4",fn)
 #define fs_initcall(fn)			__define_initcall("5",fn)
-#define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
 
-#define __initcall(fn) device_initcall(fn)
+#define device_initcall(fn)		__initcall(fn)
+#define late_initcall(fn)		__initcall(fn)
+
+#define __CAT3(a,b,c) a##b##c
+#define _CAT3(a,b,c) __CAT3(a,b,c)
+
+#define __initcall(fn)								\
+  int __attribute__((__section__ (".initcall.test"))) _CAT3(fn,_,KBUILD_MODNAME)(void) \
+       { return fn(); }
 
 #define __exitcall(fn)								\
 	static exitcall_t __exitcall_##fn __exit_call = fn
Index: init/main.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/init/main.c,v
retrieving revision 1.1.1.17
diff -u -p -r1.1.1.17 main.c
--- init/main.c	27 Jul 2002 12:34:42 -0000	1.1.1.17
+++ init/main.c	27 Jul 2002 13:19:31 -0000
@@ -464,6 +464,8 @@ asmlinkage void __init start_kernel(void
 
 struct task_struct *child_reaper = &init_task;
 
+extern initcall_t generated_initcalls[];
+
 static void __init do_initcalls(void)
 {
 	initcall_t *call;
@@ -473,6 +475,9 @@ static void __init do_initcalls(void)
 		(*call)();
 		call++;
 	} while (call < &__initcall_end);
+
+	for (call = generated_initcalls; *call; call++)
+		(*call)();
 
 	/* Make sure there is no pending stuff from the initcall sequence */
 	flush_scheduled_tasks();
Index: kernel/sched.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/kernel/sched.c,v
retrieving revision 1.1.1.22
diff -u -p -r1.1.1.22 sched.c
--- kernel/sched.c	27 Jul 2002 12:34:42 -0000	1.1.1.22
+++ kernel/sched.c	27 Jul 2002 15:50:14 -0000
@@ -1910,7 +1910,7 @@ int __init migration_init(void)
 	return 0;
 }
 
-__initcall(migration_init);
+fs_initcall(migration_init);
 #endif
 
 extern void init_timervecs(void);
Index: kernel/softirq.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/kernel/softirq.c,v
retrieving revision 1.1.1.12
diff -u -p -r1.1.1.12 softirq.c
--- kernel/softirq.c	27 Jul 2002 12:34:43 -0000	1.1.1.12
+++ kernel/softirq.c	27 Jul 2002 15:50:14 -0000
@@ -417,4 +417,4 @@ static __init int spawn_ksoftirqd(void)
 	return 0;
 }
 
-__initcall(spawn_ksoftirqd);
+fs_initcall(spawn_ksoftirqd);

--------------C68B8DDB453ECF6D7029913B--


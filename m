Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319093AbSIJJWP>; Tue, 10 Sep 2002 05:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319092AbSIJJWO>; Tue, 10 Sep 2002 05:22:14 -0400
Received: from dp.samba.org ([66.70.73.150]:38875 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319080AbSIJJWB>;
	Tue, 10 Sep 2002 05:22:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2/2 Initialization Ordering For Built-in Modules
Date: Tue, 10 Sep 2002 19:10:13 +1000
Message-Id: <20020910092648.3F3532C2A0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch actually generates an initialization ordering for modular
code which is built-in, and initializes those as "driver_initcalls".

This is relatively trivial, since a correct module initialization
order can be determined by their symbol dependencies (thought
experiment: if they were really modules, you'd have to insert them in
that order).

Stephen Rothwell and I did the first cut, Kai suggested that we only
deal with modules, Roman did the coding, and I kicked the tyres and
did some tweaks.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module initcall depends
Author: Roman Zippel
Status: Tested on 2.5.34
Depends: Misc/kbuild_object.patch.gz

D: The initialization of modules which are built into the kernel can be
D: derived implicitly from their dependencies.  This patch does that,
D: and also makes module_init() illegal for code which can never be a module.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/Makefile .21775-2.5.34-ordered-module-initcalls/Makefile
--- .21775-2.5.34-ordered-module-initcalls.pre/Makefile	2002-09-10 09:11:14.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/Makefile	2002-09-10 18:56:44.000000000 +1000
@@ -279,6 +279,7 @@ cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LD
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -294,13 +295,29 @@ define rule_link_vmlinux
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
+#	.builtin_mods contains a list of objects with module_init() calls
+#	sort these calls into the right order similiar to depmod
+
+builtin_mods := $(addsuffix .builtin_mods,$(sort $(dir $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS))))
+
+quiet_cmd_gen_initcalls = GEN    $@
+cmd_gen_initcalls = $(CONFIG_SHELL) scripts/build-module-initcalls > $@ $(builtin_mods)
+
+define rule_gen_initcalls
+	$(call cmd,gen_initcalls)
+	@echo 'cmd_$(notdir $@) := $(cmd_gen_initcalls)' > .$(notdir $@).cmd
+endef
+
+init/generated-initcalls.c: $(builtin_mods) scripts/build-module-initcalls FORCE
+	$(call if_changed_rule,gen_initcalls)
+
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
-$(sort $(vmlinux-objs)): $(SUBDIRS) ;
+$(sort $(vmlinux-objs)) $(builtin_mods): $(SUBDIRS) ;
 
 # 	Handle descending into subdirectories listed in $(SUBDIRS)
 
@@ -602,7 +619,7 @@ defconfig:
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
-	include/linux/compile.h \
+	include/linux/compile.h init/generated-initcalls.c \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
 	drivers/char/conmakehash \
@@ -660,7 +677,7 @@ clean:	archclean
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
+		-name .\*.tmp -o -name .\*.d -o -name .builtin_mods \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
 	@$(MAKE) -f Documentation/DocBook/Makefile clean
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/Rules.make .21775-2.5.34-ordered-module-initcalls/Rules.make
--- .21775-2.5.34-ordered-module-initcalls.pre/Rules.make	2002-09-10 18:56:23.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/Rules.make	2002-09-10 18:56:44.000000000 +1000
@@ -109,7 +109,8 @@ multi-objs   := $(multi-objs-y) $(multi-
 subdir-obj-y := $(foreach o,$(obj-y),$(if $(filter-out $(o),$(notdir $(o))),$(o)))
 
 # Replace multi-part objects by their individual parts, look at local dir only
-real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
+local-objs-y := $(filter-out $(subdir-obj-y), $(obj-y))
+real-objs-y := $(foreach m, $(local-objs-y), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
 real-objs-m := $(foreach m, $(obj-m), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m)))
 
 # Only build module versions for files which are selected to be built
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
 
@@ -342,7 +362,7 @@ cmd_as_o_S       = $(CC) $(a_flags) -c -
 %.o: %.S FORCE
 	$(call if_changed_dep,as_o_S)
 
-targets += $(real-objs-y) $(real-objs-m) $(EXTRA_TARGETS) $(MAKECMDGOALS)
+targets += $(real-objs-y) $(real-objs-m) $(EXTRA_TARGETS) $(MAKECMDGOALS) .builtin_mods
 
 # Build the compiled-in targets
 # ---------------------------------------------------------------------------
@@ -547,7 +567,7 @@ if_changed = $(if $(strip $? \
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
 	$(cmd_$(1)); \
-	echo 'cmd_$@ := $(cmd_$(1))' > $(@D)/.$(@F).cmd)
+	echo 'cmd_$@ := $(subst $$,$$$$,$(cmd_$(1)))' > $(@D)/.$(@F).cmd)
 
 
 # execute the command and also postprocess generated .d dependencies
@@ -559,7 +579,7 @@ if_changed_dep = $(if $(strip $? $(filte
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
 	$(cmd_$(1)); \
-	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
+	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(subst $$,$$$$,$(cmd_$(1)))' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/drivers/md/md.c .21775-2.5.34-ordered-module-initcalls/drivers/md/md.c
--- .21775-2.5.34-ordered-module-initcalls.pre/drivers/md/md.c	2002-09-10 09:11:18.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/drivers/md/md.c	2002-09-10 18:56:44.000000000 +1000
@@ -3195,6 +3195,28 @@ int __init md_init(void)
 	return (0);
 }
 
+void __exit md_exit(void)
+{
+	md_unregister_thread(md_recovery_thread);
+	devfs_unregister(devfs_handle);
+
+	unregister_blkdev(MAJOR_NR,"md");
+	unregister_reboot_notifier(&md_notifier);
+	unregister_sysctl_table(raid_table_header);
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("mdstat", NULL);
+#endif
+
+	blk_dev[MAJOR_NR].queue = NULL;
+	blk_clear(MAJOR_NR);
+
+	while (!list_empty(&device_names)) {
+		dev_name_t *tmp = list_entry(device_names.next,
+					     dev_name_t, list);
+		list_del(&tmp->list);
+		kfree(tmp);
+	}
+}
 
 #ifndef MODULE
 
@@ -3497,45 +3519,12 @@ static int __init md_run_setup(void)
 __setup("raid=", raid_setup);
 __setup("md=", md_setup);
 
-__initcall(md_init);
-__initcall(md_run_setup);
-
-#else /* It is a MODULE */
-
-int init_module(void)
-{
-	return md_init();
-}
-
-static void free_device_names(void)
-{
-	while (!list_empty(&device_names)) {
-		dev_name_t *tmp = list_entry(device_names.next,
-					     dev_name_t, list);
-		list_del(&tmp->list);
-		kfree(tmp);
-	}
-}
-
-
-void cleanup_module(void)
-{
-	md_unregister_thread(md_recovery_thread);
-	devfs_unregister(devfs_handle);
+late_initcall(md_run_setup);
 
-	unregister_blkdev(MAJOR_NR,"md");
-	unregister_reboot_notifier(&md_notifier);
-	unregister_sysctl_table(raid_table_header);
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("mdstat", NULL);
 #endif
 
-	blk_dev[MAJOR_NR].queue = NULL;
-	blk_clear(MAJOR_NR);
-	
-	free_device_names();
-}
-#endif
+module_init(md_init);
+module_exit(md_exit);
 
 EXPORT_SYMBOL(md_size);
 EXPORT_SYMBOL(register_md_personality);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/fs/bio.c .21775-2.5.34-ordered-module-initcalls/fs/bio.c
--- .21775-2.5.34-ordered-module-initcalls.pre/fs/bio.c	2002-07-07 02:12:22.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/fs/bio.c	2002-09-10 18:56:44.000000000 +1000
@@ -498,7 +498,7 @@ static int __init init_bio(void)
 	return 0;
 }
 
-module_init(init_bio);
+fs_initcall(init_bio);
 
 EXPORT_SYMBOL(bio_alloc);
 EXPORT_SYMBOL(bio_put);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/fs/dnotify.c .21775-2.5.34-ordered-module-initcalls/fs/dnotify.c
--- .21775-2.5.34-ordered-module-initcalls.pre/fs/dnotify.c	2002-09-10 09:11:19.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/fs/dnotify.c	2002-09-10 18:56:44.000000000 +1000
@@ -151,4 +151,4 @@ static int __init dnotify_init(void)
 	return 0;
 }
 
-module_init(dnotify_init)
+fs_initcall(dnotify_init);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/fs/fcntl.c .21775-2.5.34-ordered-module-initcalls/fs/fcntl.c
--- .21775-2.5.34-ordered-module-initcalls.pre/fs/fcntl.c	2002-09-10 09:11:19.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/fs/fcntl.c	2002-09-10 18:56:44.000000000 +1000
@@ -628,7 +628,7 @@ static int __init fasync_init(void)
 	return 0;
 }
 
-module_init(fasync_init)
+fs_initcall(fasync_init);
 
 EXPORT_SYMBOL(f_setown);
 EXPORT_SYMBOL(f_delown);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/fs/locks.c .21775-2.5.34-ordered-module-initcalls/fs/locks.c
--- .21775-2.5.34-ordered-module-initcalls.pre/fs/locks.c	2002-09-10 09:11:20.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/fs/locks.c	2002-09-10 18:56:44.000000000 +1000
@@ -1890,4 +1890,4 @@ static int __init filelock_init(void)
 	return 0;
 }
 
-module_init(filelock_init)
+fs_initcall(filelock_init);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/include/linux/init.h .21775-2.5.34-ordered-module-initcalls/include/linux/init.h
--- .21775-2.5.34-ordered-module-initcalls.pre/include/linux/init.h	2002-08-11 15:31:43.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/include/linux/init.h	2002-09-10 18:56:44.000000000 +1000
@@ -106,6 +106,9 @@ extern struct kernel_param __setup_start
 #define __FINIT		.previous
 #define __INITDATA	.section	".data.init","aw"
 
+#define ___concat(a,b)	a##b
+#define __concat(a,b)	___concat(a,b)
+
 /**
  * module_init() - driver initialization entry point
  * @x: function to be run at kernel boot time or module insertion
@@ -116,7 +119,10 @@ extern struct kernel_param __setup_start
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
@@ -158,15 +164,6 @@ typedef void (*__cleanup_module_func_t)(
 	{ return x; }
 
 #define __setup(str,func) /* nothing */
-
-#define core_initcall(fn)		module_init(fn)
-#define postcore_initcall(fn)		module_init(fn)
-#define arch_initcall(fn)		module_init(fn)
-#define subsys_initcall(fn)		module_init(fn)
-#define fs_initcall(fn)			module_init(fn)
-#define device_initcall(fn)		module_init(fn)
-#define late_initcall(fn)		module_init(fn)
-
 #endif
 
 /* Data marked not to be saved by software_suspend() */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/mm/page-writeback.c .21775-2.5.34-ordered-module-initcalls/mm/page-writeback.c
--- .21775-2.5.34-ordered-module-initcalls.pre/mm/page-writeback.c	2002-09-01 12:23:08.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/mm/page-writeback.c	2002-09-10 18:56:44.000000000 +1000
@@ -299,7 +299,7 @@ static int __init page_writeback_init(vo
 	register_cpu_notifier(&ratelimit_nb);
 	return 0;
 }
-module_init(page_writeback_init);
+fs_initcall(page_writeback_init);
 
 /*
  * A library function, which implements the vm_writeback a_op.  It's fairly
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/mm/pdflush.c .21775-2.5.34-ordered-module-initcalls/mm/pdflush.c
--- .21775-2.5.34-ordered-module-initcalls.pre/mm/pdflush.c	2002-09-10 09:11:21.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/mm/pdflush.c	2002-09-10 18:56:44.000000000 +1000
@@ -215,4 +215,4 @@ static int __init pdflush_init(void)
 	return 0;
 }
 
-module_init(pdflush_init);
+fs_initcall(pdflush_init);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/mm/vmscan.c .21775-2.5.34-ordered-module-initcalls/mm/vmscan.c
--- .21775-2.5.34-ordered-module-initcalls.pre/mm/vmscan.c	2002-09-10 09:11:21.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/mm/vmscan.c	2002-09-10 18:56:44.000000000 +1000
@@ -702,4 +702,4 @@ static int __init kswapd_init(void)
 	return 0;
 }
 
-module_init(kswapd_init)
+fs_initcall(kswapd_init);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21775-2.5.34-ordered-module-initcalls.pre/scripts/build-module-initcalls .21775-2.5.34-ordered-module-initcalls/scripts/build-module-initcalls
--- .21775-2.5.34-ordered-module-initcalls.pre/scripts/build-module-initcalls	1970-01-01 10:00:00.000000000 +1000
+++ .21775-2.5.34-ordered-module-initcalls/scripts/build-module-initcalls	2002-09-10 18:56:44.000000000 +1000
@@ -0,0 +1,37 @@
+#! /bin/sh
+# Given a list of module objects, spit out C code to call all the inits
+# in order, based on dependencies.
+
+set -e
+
+# initialize files
+echo -n > .undefined.tmp
+echo -n > .defined.tmp
+
+# get all global defined/undefined symbols and sort them into the right files
+for file in $@; do
+  sed "s;^;$(dirname $file)/;" < $file
+done > .all.tmp
+xargs $NM -A < .all.tmp |
+awk -F "[ :	]*" \
+  '$2 == "U" { print $3 " " $1 | "sort -u > .undefined.tmp" }
+   $3 ~ /[TD]/ { print $4 " " $1 | "sort -u > .defined.tmp" }'
+
+# topological sort objects and append all independent objects
+join -o "1.2 2.2" .defined.tmp .undefined.tmp | sort -u | tsort > .sorted.tmp
+grep -v -f .sorted.tmp < .all.tmp > .other.tmp || true
+
+# extract init function calls and write them
+echo "/* Builtin module initcalls: autogenerated by $0 */"
+echo "#include <linux/init.h>"
+echo "static int __init init_builtin_modules(void)"
+echo "{"
+cat .sorted.tmp .other.tmp |
+xargs $OBJDUMP -t |
+awk '/F \.initcall\.module/ { print "  { extern int " $6 "(void);\n    " $6 "(); }" }'
+echo "  return 0;"
+echo "}"
+echo "device_initcall(init_builtin_modules);"
+
+# clean up
+rm .undefined.tmp .defined.tmp .all.tmp .sorted.tmp .other.tmp

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSHAXtj>; Thu, 1 Aug 2002 19:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSHAXtj>; Thu, 1 Aug 2002 19:49:39 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:44294 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317388AbSHAXtg>; Thu, 1 Aug 2002 19:49:36 -0400
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] automatic module_init ordering
Message-Id: <E17aPjw-0007zG-00@scrub.xs4all.nl>
From: Roman Zippel <zippel@linux-m68k.org>
Date: Fri, 02 Aug 2002 01:52:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is latest version of the automatic module_init ordering patch.
IMO the patch is almost ready. A bit annoying problem is that
-DKBUILD_MODNAME=unix becomes -DKBUILD_MODNAME=1. An undef helps
of course, but I'm not sure whether we should put it on the command
line or in the source.
This patch depends on Kai's KBUILD_MODNAME patch.
Kai, do you see any possible kbuild problem left? I hope I found
everything. :)

bye, Roman

diff -Nur linux-2.5/Makefile linux-initcall/Makefile
--- linux-2.5/Makefile	Fri Aug  2 00:40:57 2002
+++ linux-initcall/Makefile	Thu Aug  1 23:28:32 2002
@@ -268,6 +268,7 @@
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -284,9 +285,15 @@
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
+init/generated-initcalls.c: .allbuiltin_mods
+	$(CONFIG_SHELL) -e scripts/build-initcalls $< $@
+
+.allbuiltin_mods: $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)
+	for s in $(dir $^); do sed "s,^,$$s," < $${s}.builtin_mods; done > $@
+
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
@@ -586,6 +593,7 @@
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
+	init/generated-initcalls.c .allbuiltin_mods \
 	include/linux/compile.h \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
@@ -647,7 +655,7 @@
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
+		-name .\*.tmp -o -name .\*.d -o -name .builtin_mods \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
 	@$(MAKE) -f Documentation/DocBook/Makefile clean
diff -Nur linux-2.5/Rules.make linux-initcall/Rules.make
--- linux-2.5/Rules.make	Fri Aug  2 00:42:14 2002
+++ linux-initcall/Rules.make	Thu Aug  1 21:21:40 2002
@@ -109,7 +109,8 @@
 subdir-obj-y := $(foreach o,$(obj-y),$(if $(filter-out $(o),$(notdir $(o))),$(o)))
 
 # Replace multi-part objects by their individual parts, look at local dir only
-real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
+local-objs-y := $(filter-out $(subdir-obj-y), $(obj-y))
+real-objs-y := $(foreach m, $(local-objs-y), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
 real-objs-m := $(foreach m, $(obj-m), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m)))
 
 # Only build module versions for files which are selected to be built
@@ -268,7 +269,7 @@
 #	The echo suppresses the "Nothing to be done for first_rule"
 first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
 	    $(if $(KBUILD_MODULES),$(obj-m)) \
-	    sub_dirs
+	    sub_dirs .builtin_mods
 	@echo -n
 
 # Compile C sources (.c)
@@ -318,6 +319,23 @@
 
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
+
+quiet_cmd_gen_builtin_mod = '  Generating $(echo_target)'
+define cmd_gen_builtin_mod
+	for o in $(sort $(local-objs-y)); do \
+	  if [ -n "$$($(OBJDUMP) -h $$o | grep .initcall.module)" ]; then \
+	    echo $$o; \
+	  fi \
+	done > $@; \
+	for s in $(sort $(subdir-y)); do \
+	  sed "s,^,$$s/," < $$s/.builtin_mods; \
+	done >> $@
+endef
+
+$(subdir-y:%=%/.builtin_mods): sub_dirs
+
+.builtin_mods: $(local-objs-y) $(subdir-y:%=%/.builtin_mods)
+	$(call if_changed,gen_builtin_mod)
 
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
diff -Nur linux-2.5/drivers/ide/main.c linux-initcall/drivers/ide/main.c
--- linux-2.5/drivers/ide/main.c	Fri Aug  2 00:40:57 2002
+++ linux-initcall/drivers/ide/main.c	Wed Jul 31 00:51:58 2002
@@ -1397,23 +1397,6 @@
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
diff -Nur linux-2.5/fs/dnotify.c linux-initcall/fs/dnotify.c
--- linux-2.5/fs/dnotify.c	Fri Aug  2 00:40:57 2002
+++ linux-initcall/fs/dnotify.c	Wed Jul 31 00:51:58 2002
@@ -155,4 +155,4 @@
 	return 0;
 }
 
-module_init(dnotify_init)
+fs_initcall(dnotify_init);
diff -Nur linux-2.5/fs/fcntl.c linux-initcall/fs/fcntl.c
--- linux-2.5/fs/fcntl.c	Fri Aug  2 00:40:57 2002
+++ linux-initcall/fs/fcntl.c	Wed Jul 31 00:51:58 2002
@@ -568,4 +568,4 @@
 	return 0;
 }
 
-module_init(fasync_init)
+fs_initcall(fasync_init);
diff -Nur linux-2.5/fs/locks.c linux-initcall/fs/locks.c
--- linux-2.5/fs/locks.c	Fri Aug  2 00:40:57 2002
+++ linux-initcall/fs/locks.c	Wed Jul 31 00:51:58 2002
@@ -1936,4 +1936,4 @@
 	return 0;
 }
 
-module_init(filelock_init)
+fs_initcall(filelock_init);
diff -Nur linux-2.5/include/linux/init.h linux-initcall/include/linux/init.h
--- linux-2.5/include/linux/init.h	Fri Aug  2 00:40:57 2002
+++ linux-initcall/include/linux/init.h	Wed Jul 31 00:51:58 2002
@@ -106,6 +106,9 @@
 #define __FINIT		.previous
 #define __INITDATA	.section	".data.init","aw"
 
+#define ___concat(a,b)	a##b
+#define __concat(a,b)	___concat(a,b)
+
 /**
  * module_init() - driver initialization entry point
  * @x: function to be run at kernel boot time or module insertion
@@ -116,7 +119,10 @@
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
diff -Nur linux-2.5/kernel/module.c linux-initcall/kernel/module.c
--- linux-2.5/kernel/module.c	Fri Aug  2 00:40:57 2002
+++ linux-initcall/kernel/module.c	Wed Jul 31 00:51:58 2002
@@ -252,6 +252,19 @@
 	arch_init_modules(&kernel_module);
 }
 
+extern initcall_t generated_initcalls[];
+
+static int __init init_builtin_modules(void)
+{
+	initcall_t *call;
+
+	for (call = generated_initcalls; *call; call++)
+		(*call)();
+	return 0;
+}
+
+device_initcall(init_builtin_modules);
+
 /*
  * Copy the name of a module from user space.
  */
diff -Nur linux-2.5/net/unix/af_unix.c linux-initcall/net/unix/af_unix.c
--- linux-2.5/net/unix/af_unix.c	Fri Aug  2 00:40:57 2002
+++ linux-initcall/net/unix/af_unix.c	Thu Aug  1 23:31:27 2002
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
diff -Nur linux-2.5/scripts/build-initcalls linux-initcall/scripts/build-initcalls
--- linux-2.5/scripts/build-initcalls	Thu Jan  1 01:00:00 1970
+++ linux-initcall/scripts/build-initcalls	Thu Aug  1 23:28:15 2002
@@ -0,0 +1,35 @@
+list=$1
+initsrc=$2
+
+# initialize files
+echo -n > .undefined.tmp
+echo -n > .defined.tmp
+
+# get all global defined/undefined symbols and sort them into the right files
+while read obj; do
+  $NM $obj | sed -n "s,^[0-9a-f ]*\([UTD] .*\),\1 $(echo $obj | sed s/,/\\\\,/),p"
+done < $list |
+awk '/^U/ { print $2 " " $3 | "sort -u > .undefined.tmp" }
+     /^[TD]/ { print $2 " " $3 | "sort -u > .defined.tmp" }'
+
+# topological sort objects and append all independent objects
+join -o "1.2 2.2" .defined.tmp .undefined.tmp | sort -u | tsort > .sorted.tmp
+grep -v -f .sorted.tmp < $list > .other.tmp
+cat .other.tmp >> .sorted.tmp
+
+# extract init function call and prepare declarations and array
+while read obj; do
+  call=$($OBJDUMP -t $obj | awk '/F \.initcall\.module/ { print $6 }')
+  defs="$defs extern int $call(void);"
+  arr="$arr $call,"
+done < .sorted.tmp
+
+# finally write it
+echo "#include <linux/init.h>" > $initsrc
+echo $defs >> $initsrc
+echo 'initcall_t generated_initcalls[] = {' >> $initsrc
+echo $arr >> $initsrc
+echo '0 };' >> $initsrc
+
+# clean up
+rm .undefined.tmp .defined.tmp .sorted.tmp .other.tmp

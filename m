Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSG3XCZ>; Tue, 30 Jul 2002 19:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317276AbSG3XCZ>; Tue, 30 Jul 2002 19:02:25 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:20499 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317269AbSG3XCV>; Tue, 30 Jul 2002 19:02:21 -0400
Message-ID: <3D471B9B.5801FD6C@linux-m68k.org>
Date: Wed, 31 Jul 2002 01:04:59 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] automatic module_init ordering
References: <20020729235746.2FD3C427D@lists.samba.org>
Content-Type: multipart/mixed;
 boundary="------------AEC0F04EF21013B9CBFB3B4C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AEC0F04EF21013B9CBFB3B4C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Rusty Russell wrote:

> Yes, I think we should do this: merge the two together.  You seem to
> be in a coding frenzy: want to do the first cut?

I attached a new version, that only orders module_init(). I did some
small compile performance tests and I could only see a few seconds
difference, so the overhead should be negligible.

bye, Roman
--------------AEC0F04EF21013B9CBFB3B4C
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
+++ Makefile	30 Jul 2002 21:57:02 -0000
@@ -268,6 +268,7 @@ cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LD
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -284,9 +285,30 @@ define rule_link_vmlinux
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+init/generated-initcalls.c: .allbuiltin_mods
+	set -e; \
+	while read obj; do $(NM) $$obj | sed -n "s,^[0-9a-f ]*\([UTD] .*\),\1 $$obj,p"; done < $< | \
+	awk '/^U/ { print $$2 " " $$3 | "sort -u > .undefined.tmp" }; \
+	     /^[TD]/ { print $$2 " " $$3 | "sort -u > .defined.tmp" }'; \
+	join -o "1.2 2.2" .defined.tmp .undefined.tmp | sort -u | tsort > .sorted.tmp; \
+	grep -v -f .sorted.tmp < $< > .other.tmp; \
+	cat .other.tmp >> .sorted.tmp; \
+	while read obj; do \
+	  call=$$($(OBJDUMP) -t $$obj | awk '/F \.initcall\.module/ { print $$6 }' ); \
+	  defs="$$defs extern int $$call(void);"; arr="$$arr $$call,"; \
+	done < .sorted.tmp; \
+	echo "#include <linux/init.h>" > $@; \
+	echo $$defs >> $@; \
+	echo 'initcall_t generated_initcalls[] = {' >> $@; \
+	echo $$arr >> $@; \
+	echo '0 };' >> $@
+
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
+.allbuiltin_mods: $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)
+	for s in $(dir $^); do sed "s,^,$$s," < $${s}.builtin_mods; done > $@
+
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
@@ -586,6 +608,7 @@ defconfig:
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
+	init/generated-initcalls.c .allbuiltin_mods \
 	include/linux/compile.h \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
@@ -647,7 +670,7 @@ clean:	archclean
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
+		-name .\*.tmp -o -name .\*.d -o -name .builtin_mods \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
 	@$(MAKE) -f Documentation/DocBook/Makefile clean
Index: Rules.make
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/Rules.make,v
retrieving revision 1.1.1.17
diff -u -p -r1.1.1.17 Rules.make
--- Rules.make	6 Jul 2002 00:33:37 -0000	1.1.1.17
+++ Rules.make	30 Jul 2002 18:37:47 -0000
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
+	    sub_dirs .builtin_mods
 	@echo -n
 
 # Compile C sources (.c)
@@ -269,6 +277,7 @@ $(export-objs:.o=.lst): export_flags   :
 c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
 	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
+	  -DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname:.o=))) \
 	  $(export_flags) 
 
 quiet_cmd_cc_s_c = CC     $(echo_target)
@@ -294,6 +303,14 @@ cmd_cc_lst_c     = $(CC) $(c_flags) -g -
 
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
+
+$(subdir-y:%=%/.builtin_mods): sub_dirs
+
+.builtin_mods: $(mod-objs-y) $(subdir-y:%=%/.builtin_mods)
+	for o in $(mod-objs-y); do \
+	if [ -n "$$($(OBJDUMP) -h $$o | grep .initcall.module)" ]; then echo $$o; fi \
+	done > $@; \
+	for s in $(subdir-y); do sed "s,^,$$s/," < $$s/.builtin_mods; done >> $@
 
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
Index: drivers/ide/main.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/drivers/ide/main.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 main.c
--- drivers/ide/main.c	27 Jul 2002 12:40:01 -0000	1.1.1.7
+++ drivers/ide/main.c	30 Jul 2002 18:37:47 -0000
@@ -1397,23 +1397,6 @@ static int __init ata_module_init(void)
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
Index: fs/dnotify.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/fs/dnotify.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 dnotify.c
--- fs/dnotify.c	27 Jul 2002 12:34:15 -0000	1.1.1.5
+++ fs/dnotify.c	30 Jul 2002 18:37:47 -0000
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
+++ fs/fcntl.c	30 Jul 2002 18:37:47 -0000
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
+++ fs/locks.c	30 Jul 2002 18:37:47 -0000
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
+++ include/linux/init.h	30 Jul 2002 18:37:47 -0000
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
Index: kernel/module.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/kernel/module.c,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 module.c
--- kernel/module.c	14 Apr 2002 20:01:36 -0000	1.1.1.3
+++ kernel/module.c	30 Jul 2002 22:23:53 -0000
@@ -252,6 +252,19 @@ void __init init_modules(void)
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

--------------AEC0F04EF21013B9CBFB3B4C--


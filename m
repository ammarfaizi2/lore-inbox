Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267504AbSLNBlw>; Fri, 13 Dec 2002 20:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbSLNBlw>; Fri, 13 Dec 2002 20:41:52 -0500
Received: from dp.samba.org ([66.70.73.150]:36058 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267504AbSLNBls>;
	Fri, 13 Dec 2002 20:41:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (Again) Revert module directory hierarchy and depmod invocation
Date: Sat, 14 Dec 2002 12:11:54 +1100
Message-Id: <20021214014915.789EE2C51C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[As Greg Kroah-Hartman pointed out, wrong patch appended last time.]

Linus, please apply.

While the kernel, depmod et. al. don't care, other tools want the
directory hierarchy under /lib/modules/`uname -r`/.  Sure, it's bogus
for them to rely on kernel source layout, but noone has come up with a
better alternative, so revert.

NOTE: You *still* can't have two modules of the same name!  (You never
could).

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Revert depmod and hierarchy changes
Author: Rusty Russell
Status: Tested on 2.5.51

D: module-init-tools 0.9 and newer supply a replacement depmod, so
D: it's safe to run again.  Also, some external programs like PCMCIA
D: and mkinitrd really want the directory hierarchy in /lib/modules
D: back again: it makes no difference to the tools (since 0.9), so
D: revert it.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.51/Makefile working-2.5.51-revert-dirs/Makefile
--- linux-2.5.51/Makefile	Tue Dec 10 15:56:46 2002
+++ working-2.5.51-revert-dirs/Makefile	Fri Dec 13 09:18:06 2002
@@ -157,6 +157,7 @@ OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
 AWK		= awk
 GENKSYMS	= /sbin/genksyms
+DEPMOD		= /sbin/depmod
 KALLSYMS	= scripts/kallsyms
 PERL		= perl
 MODFLAGS	= -DMODULE
@@ -534,7 +535,7 @@ modules: $(SUBDIRS)
 #	Install modules
 
 .PHONY: modules_install
-modules_install: _modinst_ $(patsubst %, _modinst_%, $(SUBDIRS))
+modules_install: _modinst_ $(patsubst %, _modinst_%, $(SUBDIRS)) _modinst_post
 
 .PHONY: _modinst_
 _modinst_:
@@ -542,6 +543,20 @@ _modinst_:
 	@rm -f $(MODLIB)/build
 	@mkdir -p $(MODLIB)/kernel
 	@ln -s $(TOPDIR) $(MODLIB)/build
+
+# If System.map exists, run depmod.  This deliberately does not have a
+# dependency on System.map since that would run the dependency tree on
+# vmlinux.  This depmod is only for convenience to give the initial
+# boot a modules.dep even before / is mounted read-write.  However the
+# boot script depmod is the master version.
+ifeq "$(strip $(INSTALL_MOD_PATH))" ""
+depmod_opts	:=
+else
+depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
+endif
+.PHONY: _modinst_post
+_modinst_post:
+	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
 .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
 $(patsubst %, _modinst_%, $(SUBDIRS)) :
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.51/scripts/Makefile.modinst working-2.5.51-revert-dirs/scripts/Makefile.modinst
--- linux-2.5.51/scripts/Makefile.modinst	Tue Dec 10 15:56:54 2002
+++ working-2.5.51-revert-dirs/scripts/Makefile.modinst	Fri Dec 13 09:28:42 2002
@@ -16,8 +16,8 @@ include scripts/Makefile.lib
 # ==========================================================================
 
 quiet_cmd_modules_install = INSTALL $(obj-m:.o=.ko)
-      cmd_modules_install = mkdir -p $(MODLIB)/kernel && \
-		      cp $(obj-m:.o=.ko) $(MODLIB)/kernel/
+      cmd_modules_install = mkdir -p $(MODLIB)/kernel/$(obj); \
+			    cp $(obj-m:.o=.ko) $(MODLIB)/kernel/$(obj)
 
 modules_install: $(subdir-ym)
 ifneq ($(obj-m:.o=.ko),)

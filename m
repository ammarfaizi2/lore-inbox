Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbSJWJ3v>; Wed, 23 Oct 2002 05:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSJWJ3u>; Wed, 23 Oct 2002 05:29:50 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:68 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S263207AbSJWJ3h>; Wed, 23 Oct 2002 05:29:37 -0400
Date: Wed, 23 Oct 2002 02:44:04 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: linux-kernel@vger.kernel.org
cc: lkcd-devel@lists.sourceforge.net
Subject: [PATCH] LKCD for 2.5.44 (3/8): kerntypes addition
In-Reply-To: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210230243480.27315-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds kerntypes into the build so that symbols can be
extracted from a single build object in the kernel.  This
also modifies the install process (where applicable) to
copy the Kerntypes file along with the kernel and map.

 Makefile                   |   15 +++++++++++++--
 arch/i386/boot/Makefile    |    2 +-
 arch/i386/boot/install.sh  |   24 +++++++++++++++++-------
 arch/s390/boot/install.sh  |   24 +++++++++++++++++-------
 arch/s390x/boot/install.sh |   24 +++++++++++++++++-------
 init/Makefile              |    5 +++++
 init/kerntypes.c           |   24 ++++++++++++++++++++++++
 7 files changed, 94 insertions(+), 24 deletions(-)

diff -Naur linux-2.5.44.orig/Makefile linux-2.5.44.lkcd/Makefile
--- linux-2.5.44.orig/Makefile	Fri Oct 18 21:01:12 2002
+++ linux-2.5.44.lkcd/Makefile	Sat Oct 19 12:53:45 2002
@@ -273,6 +273,17 @@
 MODLIB	:= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 export MODLIB
 
+#
+# For crash dumps, pull out the Kerntypes copying for now.  We may
+# still build init/kerntypes.o, but we don't copy it every time.
+#
+ifdef CONFIG_CRASH_DUMP
+vmlinux-extra += Kerntypes
+
+Kerntypes:	init/kerntypes.o
+	/bin/cp $< $@
+endif
+
 # Build vmlinux
 # ---------------------------------------------------------------------------
 
@@ -353,7 +364,7 @@
 
 #	Finally the vmlinux rule
 
-vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/vmlinux.lds.s FORCE
+vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/vmlinux.lds.s $(vmlinux-extra) FORCE
 	$(call if_changed_rule,vmlinux)
 
 #	The actual objects are generated when descending, 
@@ -675,7 +686,7 @@
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Files removed with 'make clean'
-CLEAN_FILES += vmlinux System.map MC*
+CLEAN_FILES += vmlinux System.map MC* Kerntypes
 
 # Files removed with 'make mrproper'
 MRPROPER_FILES += \
diff -Naur linux-2.5.44.orig/arch/i386/boot/Makefile linux-2.5.44.lkcd/arch/i386/boot/Makefile
--- linux-2.5.44.orig/arch/i386/boot/Makefile	Fri Oct 18 21:01:49 2002
+++ linux-2.5.44.lkcd/arch/i386/boot/Makefile	Sat Oct 19 12:39:15 2002
@@ -79,7 +79,7 @@
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
 install: $(BOOTIMAGE)
-	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
+	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map $(TOPDIR)/Kerntypes "$(INSTALL_PATH)"
 
 archhelp:
 	@echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
diff -Naur linux-2.5.44.orig/arch/i386/boot/install.sh linux-2.5.44.lkcd/arch/i386/boot/install.sh
--- linux-2.5.44.orig/arch/i386/boot/install.sh	Fri Oct 18 21:02:28 2002
+++ linux-2.5.44.lkcd/arch/i386/boot/install.sh	Sun Oct 20 23:25:18 2002
@@ -16,7 +16,8 @@
 #   $1 - kernel version
 #   $2 - kernel image file
 #   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
+#   $4 - kernel type file
+#   $5 - default install path (blank if root directory)
 #
 
 # User may have a custom install script
@@ -26,15 +27,24 @@
 
 # Default install - same as make zlilo
 
-if [ -f $4/vmlinuz ]; then
-	mv $4/vmlinuz $4/vmlinuz.old
+if [ -f $5/vmlinuz ]; then
+	mv $5/vmlinuz $5/vmlinuz.old
 fi
 
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
+if [ -f $5/System.map ]; then
+	mv $5/System.map $5/System.old
 fi
 
-cat $2 > $4/vmlinuz
-cp $3 $4/System.map
+if [ -f $5/Kerntypes ]; then
+	mv $5/Kerntypes $5/Kerntypes.old
+fi
+
+cat $2 > $5/vmlinuz
+cp $3 $5/System.map
+
+# copy the kernel type file if it exists
+if [ -f $4 ]; then
+	cp $4 $5/Kerntypes
+fi
 
 if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
diff -Naur linux-2.5.44.orig/arch/s390/boot/install.sh linux-2.5.44.lkcd/arch/s390/boot/install.sh
--- linux-2.5.44.orig/arch/s390/boot/install.sh	Fri Oct 18 21:02:00 2002
+++ linux-2.5.44.lkcd/arch/s390/boot/install.sh	Sun Oct 20 23:25:28 2002
@@ -16,7 +16,8 @@
 #   $1 - kernel version
 #   $2 - kernel image file
 #   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
+#   $4 - kernel type file
+#   $5 - default install path (blank if root directory)
 #
 
 # User may have a custom install script
@@ -26,13 +27,22 @@
 
 # Default install - same as make zlilo
 
-if [ -f $4/vmlinuz ]; then
-	mv $4/vmlinuz $4/vmlinuz.old
+if [ -f $5/vmlinuz ]; then
+	mv $5/vmlinuz $5/vmlinuz.old
 fi
 
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
+if [ -f $5/System.map ]; then
+	mv $5/System.map $5/System.old
 fi
 
-cat $2 > $4/vmlinuz
-cp $3 $4/System.map
+if [ -f $5/Kerntypes ]; then
+	mv $5/Kerntypes $5/Kerntypes.old
+fi
+
+cat $2 > $5/vmlinuz
+cp $3 $5/System.map
+
+# copy the kernel type file if it exists
+if [ -f $4 ]; then
+	cp $4 $5/Kerntypes
+fi
diff -Naur linux-2.5.44.orig/arch/s390x/boot/install.sh linux-2.5.44.lkcd/arch/s390x/boot/install.sh
--- linux-2.5.44.orig/arch/s390x/boot/install.sh	Fri Oct 18 21:02:35 2002
+++ linux-2.5.44.lkcd/arch/s390x/boot/install.sh	Sun Oct 20 23:25:33 2002
@@ -16,7 +16,8 @@
 #   $1 - kernel version
 #   $2 - kernel image file
 #   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
+#   $4 - kernel type file
+#   $5 - default install path (blank if root directory)
 #
 
 # User may have a custom install script
@@ -26,13 +27,22 @@
 
 # Default install - same as make zlilo
 
-if [ -f $4/vmlinuz ]; then
-	mv $4/vmlinuz $4/vmlinuz.old
+if [ -f $5/vmlinuz ]; then
+	mv $5/vmlinuz $5/vmlinuz.old
 fi
 
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
+if [ -f $5/System.map ]; then
+	mv $5/System.map $5/System.old
 fi
 
-cat $2 > $4/vmlinuz
-cp $3 $4/System.map
+if [ -f $5/Kerntypes ]; then
+	mv $5/Kerntypes $5/Kerntypes.old
+fi
+
+cat $2 > $5/vmlinuz
+cp $3 $5/System.map
+
+# copy the kernel type file if it exists
+if [ -f $4 ]; then
+	cp $4 $5/Kerntypes
+fi
diff -Naur linux-2.5.44.orig/init/Makefile linux-2.5.44.lkcd/init/Makefile
--- linux-2.5.44.orig/init/Makefile	Fri Oct 18 21:01:49 2002
+++ linux-2.5.44.lkcd/init/Makefile	Sat Oct 19 12:39:15 2002
@@ -1,6 +1,10 @@
 #
 # Makefile for the linux kernel.
 #
+ifdef CONFIG_CRASH_DUMP
+EXTRA_TARGETS := kerntypes.o
+CFLAGS_kerntypes.o := -gstabs
+endif
 
 obj-y    := main.o version.o do_mounts.o
 
@@ -21,3 +25,4 @@
 $(obj)/../include/linux/compile.h: FORCE
 	@echo -n '  Generating $(echo_target)'
 	@sh $(srctree)/scripts/mkcompile_h $@ "$(ARCH)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"
+
diff -Naur linux-2.5.44.orig/init/kerntypes.c linux-2.5.44.lkcd/init/kerntypes.c
--- linux-2.5.44.orig/init/kerntypes.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/init/kerntypes.c	Sat Oct 19 12:39:15 2002
@@ -0,0 +1,24 @@
+/*
+ * kerntypes.c
+ *
+ * Copyright (C) 2000 Tom Morano (tjm@sgi.com) and
+ *                    Matt D. Robinson (yakker@alacritech.com)
+ *
+ * Dummy module that includes headers for all kernel types of interest. 
+ * The kernel type information is used by the lcrash utility when 
+ * analyzing system crash dumps or the live system. Using the type 
+ * information for the running system, rather than kernel header files,
+ * makes for a more flexible and robust analysis tool.
+ *
+ * This source code is released under version 2 of the GNU GPL.
+ */
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/config.h>
+#include <linux/utsname.h>
+#include <linux/dump.h>
+
+void
+kerntypes_dummy(void)
+{
+}


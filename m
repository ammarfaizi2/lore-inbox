Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbSJJTzx>; Thu, 10 Oct 2002 15:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSJJTyX>; Thu, 10 Oct 2002 15:54:23 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:11598 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262186AbSJJTuV>; Thu, 10 Oct 2002 15:50:21 -0400
Date: Thu, 10 Oct 2002 13:04:23 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210102004.g9AK4Nm29561@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, yakker@aparity.com
Subject: [PATCH] 2.5.41: lkcd (3/8): kerntypes addition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds kerntypes into the build so that symbols can be
extracted from a single build object in the kernel.  This
also modifies the install process to copy the Kerntypes
file along with the kernel and map.


 Makefile                  |   11 ++++++++++-
 arch/i386/boot/Makefile   |    2 +-
 arch/i386/boot/install.sh |   20 +++++++++++++-------
 init/kerntypes.c          |   28 ++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 9 deletions(-)


diff -Naur linux-2.5.41.orig/Makefile linux-2.5.41.lkcd/Makefile
--- linux-2.5.41.orig/Makefile	Mon Oct  7 11:23:25 2002
+++ linux-2.5.41.lkcd/Makefile	Tue Oct  8 01:15:48 2002
@@ -353,9 +353,17 @@
 
 #	Finally the vmlinux rule
 
-vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/vmlinux.lds.s FORCE
+vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/vmlinux.lds.s Kerntypes FORCE
 	$(call if_changed_rule,vmlinux)
 
+Kerntypes: init/kerntypes.o
+	@if [ -f init/kerntypes.o ]; then \
+		mv init/kerntypes.o Kerntypes; \
+	fi
+
+init/kerntypes.o: init/kerntypes.c include/config/MARKER
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -gstabs -c -o $*.o $<
+
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
@@ -706,6 +714,7 @@
 	.version .config* config.in config.old \
 	.menuconfig.log \
 	include/asm \
+	Kerntypes \
 	.hdepend include/linux/modversions.h \
 	tags TAGS kernel.spec \
 	.tmp*
diff -Naur linux-2.5.41.orig/arch/i386/boot/Makefile linux-2.5.41.lkcd/arch/i386/boot/Makefile
--- linux-2.5.41.orig/arch/i386/boot/Makefile	Mon Oct  7 11:24:08 2002
+++ linux-2.5.41.lkcd/arch/i386/boot/Makefile	Tue Oct  8 01:16:35 2002
@@ -77,7 +77,7 @@
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
 install: $(BOOTIMAGE)
-	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
+	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map $(TOPDIR)/Kerntypes "$(INSTALL_PATH)"
 
 clean:
 	@echo 'Cleaning up (boot)'
diff -Naur linux-2.5.41.orig/arch/i386/boot/install.sh linux-2.5.41.lkcd/arch/i386/boot/install.sh
--- linux-2.5.41.orig/arch/i386/boot/install.sh	Mon Oct  7 11:24:50 2002
+++ linux-2.5.41.lkcd/arch/i386/boot/install.sh	Tue Oct  8 01:15:13 2002
@@ -16,7 +16,8 @@
 #   $1 - kernel version
 #   $2 - kernel image file
 #   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
+#   $4 - kernel type file
+#   $5 - default install path (blank if root directory)
 #
 
 # User may have a custom install script
@@ -26,15 +27,20 @@
 
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
+cp $4 $5/Kerntypes
 
 if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
diff -Naur linux-2.5.41.orig/init/kerntypes.c linux-2.5.41.lkcd/init/kerntypes.c
--- linux-2.5.41.orig/init/kerntypes.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.41.lkcd/init/kerntypes.c	Tue Oct  8 01:15:13 2002
@@ -0,0 +1,28 @@
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
+#ifndef __KERNEL__
+#define __KERNEL__
+#endif
+#include <linux/module.h>
+#include <linux/autoconf.h>
+#include <linux/mm.h>
+#include <linux/config.h>
+#include <linux/utsname.h>
+#include <linux/dump.h>
+
+void
+kerntypes_dummy(void)
+{
+}

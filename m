Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261885AbSJDWzN>; Fri, 4 Oct 2002 18:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSJDWyO>; Fri, 4 Oct 2002 18:54:14 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:34379 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261790AbSJDWtk>; Fri, 4 Oct 2002 18:49:40 -0400
Date: Fri, 4 Oct 2002 16:03:38 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3cr10022@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40: lkcd (3/9): kerntypes addition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds kerntypes into the build so that symbols can be
extracted from a single build object in the kernel.  This
also modifies the install process to copy the Kerntypes
file along with the kernel and map.

diff -urN -X /home/bharata/dontdiff linux-2.5.40/Makefile linux-2.5.40+lkcd/Makefile
--- linux-2.5.40/Makefile	Tue Oct  1 12:36:17 2002
+++ linux-2.5.40+lkcd/Makefile	Thu Oct  3 07:20:38 2002
@@ -351,9 +351,17 @@
 
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
 
diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/boot/Makefile linux-2.5.40+lkcd/arch/i386/boot/Makefile
--- linux-2.5.40/arch/i386/boot/Makefile	Tue Oct  1 12:36:56 2002
+++ linux-2.5.40+lkcd/arch/i386/boot/Makefile	Thu Oct  3 07:19:14 2002
@@ -70,12 +70,14 @@
 zlilo: $(BOOTIMAGE)
 	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
 	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
+	if [ -f $(INSTALL_PATH)/Kerntypes ]; then mv $(INSTALL_PATH)/Kerntypes $(INSTALL_PATH)/Kerntypes.old; fi
 	cat $(BOOTIMAGE) > $(INSTALL_PATH)/vmlinuz
 	cp $(TOPDIR)/System.map $(INSTALL_PATH)/
+	cp $(TOPDIR)/Kerntypes $(INSTALL_PATH)/
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
 install: $(BOOTIMAGE)
-	sh -x ./install.sh $(KERNELRELEASE) $(BOOTIMAGE) $(TOPDIR)/System.map "$(INSTALL_PATH)"
+	sh -x ./install.sh $(KERNELRELEASE) $(BOOTIMAGE) $(TOPDIR)/System.map $(TOPDIR)/Kerntypes "$(INSTALL_PATH)"
 
 clean:
 	@echo 'Cleaning up (boot)'
diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/boot/install.sh linux-2.5.40+lkcd/arch/i386/boot/install.sh
--- linux-2.5.40/arch/i386/boot/install.sh	Tue Oct  1 12:37:35 2002
+++ linux-2.5.40+lkcd/arch/i386/boot/install.sh	Thu Oct  3 07:19:14 2002
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
diff -urN -X /home/bharata/dontdiff linux-2.5.40/init/kerntypes.c linux-2.5.40+lkcd/init/kerntypes.c
--- linux-2.5.40/init/kerntypes.c	Thu Jan  1 05:30:00 1970
+++ linux-2.5.40+lkcd/init/kerntypes.c	Thu Oct  3 07:19:14 2002
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317780AbSGVQJa>; Mon, 22 Jul 2002 12:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317787AbSGVQJa>; Mon, 22 Jul 2002 12:09:30 -0400
Received: from mnh-1-07.mv.com ([207.22.10.39]:36868 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317780AbSGVQJ0>;
	Mon, 22 Jul 2002 12:09:26 -0400
Message-Id: <200207221715.MAA03040@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, jdike@ccure.karaya.com
Subject: [PATCH] UML - part 1 of 2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Jul 2002 12:15:29 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (against 2.5.27) contains all of the changes to generic code 
needed by UML:

CREDITS -
	Changes my address and adds a UML credit for Lars Brinkoff.

MAINTAINERS -
	Adds a UML entry.

Makefile -
	When ARCH=um is on the command line to do a UML build, the old value
of ARCH is saved in $(SUBARCH) for the later use of the UML build.

drivers/char/Makefile -
	Sets KEYMAP, KEYBD, CONSOLE empty to prevent hardware drivers from
being compiled in.

drivers/net/setup.c -
	Backs out a UML hook which leaked into your tree which UML no
longer uses.

include/linux/kernel_stat.h -
	Bumps DK_MAX_MAJOR to 99 so that the UML block driver (major 98)
gets stats.

include/linux/linkage.h -
	UML needs FASTCALL defined as regparm(3), too.

init/do_mounts.c -
	Adds a set of entries to dev_name_struct for the UML block device.

				Jeff


diff -Naur orig/CREDITS linus/CREDITS
--- orig/CREDITS	Tue Jul 16 23:55:49 2002
+++ linus/CREDITS	Tue Jul 16 23:56:12 2002
@@ -433,6 +433,7 @@
 E: lars@nocrew.org
 W: http://lars.nocrew.org/
 D: dsp56k device driver
+D: ptrace proxy in user mode kernel port
 S: Kopmansg 2
 S: 411 13  Goteborg
 S: Sweden
@@ -725,7 +726,7 @@
 E: jdike@karaya.com
 W: http://user-mode-linux.sourceforge.net
 D: User mode kernel port
-S: RR1 Box 67C
+S: 375 Tubbs Hill Rd
 S: Deering NH 03244
 S: USA
 
diff -Naur orig/MAINTAINERS linus/MAINTAINERS
--- orig/MAINTAINERS	Tue Jul 16 23:55:50 2002
+++ linus/MAINTAINERS	Wed Jul 17 17:13:26 2002
@@ -1842,6 +1842,14 @@
 L:	linux-usb-devel@lists.sourceforge.net
 W:	http://usb.in.tum.de
 S:	Maintained
+
+USER-MODE LINUX
+P:	Jeff Dike
+M:	jdike@karaya.com
+L:	user-mode-linux-devel@lists.sourceforge.net
+L:	user-mode-linux-user@lists.sourceforge.net
+W:	http://user-mode-linux.sourceforge.net
+S:	Maintained
 	
 USB "USBNET" DRIVER
 P:	David Brownell
diff -Naur orig/Makefile linus/Makefile
--- orig/Makefile	Sun Jul 21 19:08:23 2002
+++ linus/Makefile	Mon Jul 22 11:48:08 2002
@@ -27,7 +27,15 @@
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
-ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
+# SUBARCH tells the usermode build what the underlying arch is.  That is set
+# first, and if a usermode build is happening, the "ARCH=um" on the command
+# line overrides the setting of ARCH below.  If a native build is happening,
+# then ARCH is assigned, getting whatever value it gets normally, and 
+# SUBARCH is subsequently ignored.
+
+SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
+ARCH := $(SUBARCH)
+
 KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")
 
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
diff -Naur orig/drivers/char/Makefile linus/drivers/char/Makefile
--- orig/drivers/char/Makefile	Tue Jul 16 23:55:54 2002
+++ linus/drivers/char/Makefile	Tue Jul 16 23:56:16 2002
@@ -60,6 +60,12 @@
   endif
 endif
 
+ifeq ($(ARCH),um)
+  KEYMAP   =
+  KEYBD    =
+  CONSOLE  =
+endif
+
 ifeq ($(ARCH),sh)
   KEYMAP   =
   KEYBD    =
diff -Naur orig/drivers/net/setup.c linus/drivers/net/setup.c
--- orig/drivers/net/setup.c	Sat Jul 21 21:26:53 2001
+++ linus/drivers/net/setup.c	Wed Jul 10 15:40:57 2002
@@ -28,7 +28,6 @@
 extern int lmc_setup(void);
 
 extern int madgemc_probe(void);
-extern int uml_net_probe(void);
 
 /* Pad device name to IFNAMSIZ=16. F.e. __PAD6 is string of 9 zeros. */
 #define __PAD6 "\0\0\0\0\0\0\0\0\0"
@@ -102,9 +101,6 @@
  */  
 #ifdef CONFIG_MADGEMC
 	{madgemc_probe, 0},
-#endif
-#ifdef CONFIG_UML_NET
-	{uml_net_probe, 0},
 #endif
  
 	{NULL, 0},
diff -Naur orig/include/linux/kernel_stat.h linus/include/linux/kernel_stat.h
--- orig/include/linux/kernel_stat.h	Sun Jul 21 19:08:26 2002
+++ linus/include/linux/kernel_stat.h	Mon Jul 22 11:48:08 2002
@@ -12,7 +12,7 @@
  * used by rstatd/perfmeter
  */
 
-#define DK_MAX_MAJOR 16
+#define DK_MAX_MAJOR 99
 #define DK_MAX_DISK 16
 
 struct kernel_stat {
diff -Naur orig/include/linux/linkage.h linus/include/linux/linkage.h
--- orig/include/linux/linkage.h	Sun Jul 14 14:10:17 2002
+++ linus/include/linux/linkage.h	Wed Jul 17 17:20:09 2002
@@ -56,7 +56,7 @@
 # define ATTRIB_NORET  __attribute__((noreturn))
 # define NORET_AND     noreturn,
 
-#ifdef __i386__
+#if defined(__i386__) || defined(__arch_um__)
 #define FASTCALL(x)	x __attribute__((regparm(3)))
 #else
 #define FASTCALL(x)	x
diff -Naur orig/init/do_mounts.c linus/init/do_mounts.c
--- orig/init/do_mounts.c	Mon Jul 15 16:27:35 2002
+++ linus/init/do_mounts.c	Mon Jul 15 16:28:16 2002
@@ -156,6 +156,22 @@
 	{ "pf",		0x2f00 },
 	{ "apblock", APBLOCK_MAJOR << 8},
 	{ "ddv", DDV_MAJOR << 8},
+ 	{ "ubd0", UBD_MAJOR << 8 | 0 << 4},
+ 	{ "ubda", UBD_MAJOR << 8 | 0 << 4},
+ 	{ "ubd1", UBD_MAJOR << 8 | 1 << 4},
+ 	{ "ubdb", UBD_MAJOR << 8 | 1 << 4},
+ 	{ "ubd2", UBD_MAJOR << 8 | 2 << 4},
+ 	{ "ubdc", UBD_MAJOR << 8 | 2 << 4},
+ 	{ "ubd3", UBD_MAJOR << 8 | 3 << 4},
+ 	{ "ubdd", UBD_MAJOR << 8 | 3 << 4},
+ 	{ "ubd4", UBD_MAJOR << 8 | 4 << 4},
+ 	{ "ubde", UBD_MAJOR << 8 | 4 << 4},
+ 	{ "ubd5", UBD_MAJOR << 8 | 5 << 4},
+ 	{ "ubdf", UBD_MAJOR << 8 | 5 << 4},
+ 	{ "ubd6", UBD_MAJOR << 8 | 6 << 4},
+ 	{ "ubdg", UBD_MAJOR << 8 | 6 << 4},
+ 	{ "ubd7", UBD_MAJOR << 8 | 7 << 4},
+ 	{ "ubdh", UBD_MAJOR << 8 | 7 << 4},
 	{ "jsfd",    JSFD_MAJOR << 8},
 #if defined(CONFIG_ARCH_S390)
 	{ "dasda", (DASD_MAJOR << MINORBITS) },


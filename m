Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSGYXM1>; Thu, 25 Jul 2002 19:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSGYXM1>; Thu, 25 Jul 2002 19:12:27 -0400
Received: from jdike.solana.com ([198.99.130.100]:12673 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S316662AbSGYXM0>;
	Thu, 25 Jul 2002 19:12:26 -0400
Message-Id: <200207252316.g6PNGdp14068@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: [PATCH] UML - part 1 of 2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Jul 2002 19:16:39 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (against 2.5.28) contains all of the changes to generic code 
needed by UML.  

I removed the kernel_stat.h change since UML can live without disk statistics 
for a bit.  

I looked at the linkage.h change, but since that file is nothing but 
architecture nastiness which I don't have any particular insight how to 
clean up, I decided to leave the UML piece in.

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
+++ linus/MAINTAINERS	Thu Jul 25 18:49:30 2002
@@ -1849,6 +1849,14 @@
 L:	linux-usb-devel@lists.sourceforge.net
 S:	Maintained
 
+USER-MODE LINUX
+P:	Jeff Dike
+M:	jdike@karaya.com
+L:	user-mode-linux-devel@lists.sourceforge.net
+L:	user-mode-linux-user@lists.sourceforge.net
+W:	http://user-mode-linux.sourceforge.net
+S:	Maintained
+	
 VFAT FILESYSTEM:
 P:	Gordon Chaffee
 M:	chaffee@cs.berkeley.edu
diff -Naur orig/Makefile linus/Makefile
--- orig/Makefile	Thu Jul 25 12:31:22 2002
+++ linus/Makefile	Thu Jul 25 17:07:01 2002
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
--- orig/drivers/char/Makefile	Thu Jul 25 12:31:26 2002
+++ linus/drivers/char/Makefile	Thu Jul 25 17:07:06 2002
@@ -65,6 +65,12 @@
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


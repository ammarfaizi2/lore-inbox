Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTHYWrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTHYWrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:47:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37851 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262439AbTHYWrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:47:25 -0400
Date: Tue, 26 Aug 2003 00:47:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: spyro@f2s.com, linux-arm-kernel@lists.arm.linux.org.uk,
       Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [2.6 patch] add a config option for -Os
Message-ID: <20030825224717.GZ7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds a config option for compiling the kernel with -Os.

Compared to the last patch, the option moved to the embedded to the 
General Setup menu and depends on EXPERIMENTAL instead of EMBEDDED 
(retionale: it might even produce a faster kernel but it's less tested).

I removed the special cases in the arm, arm26 and h8300 Makefiles, users 
on these architectures can now use OPTIMIZE_FOR_SIZE.

Compiling with this option enabled produced a working kernel for me on 
i386.

cu
Adrian

--- linux-2.6.0-test4/init/Kconfig.old	2003-08-24 14:51:15.000000000 +0200
+++ linux-2.6.0-test4/init/Kconfig	2003-08-24 14:55:45.000000000 +0200
@@ -48,6 +48,15 @@
 
 menu "General setup"
 
+config OPTIMIZE_FOR_SIZE
+	bool "Optimize for size" if EXPERIMENTAL
+	default n
+	help
+	  Enabling this option will pass "-Os" instead of "-O2" to gcc
+	  resulting in a smaller kernel.
+
+	  If unsure, say N.
+
 config SWAP
 	bool "Support for paging of anonymous memory"
 	depends on MMU
--- linux-2.6.0-test3/Makefile.old	2003-08-11 01:34:41.000000000 +0200
+++ linux-2.6.0-test3/Makefile	2003-08-11 01:37:16.000000000 +0200
@@ -223,7 +223,7 @@
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
 
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
@@ -318,6 +318,12 @@
 
 -include .config.cmd
 
+ifdef CONFIG_OPTIMIZE_FOR_SIZE
+CFLAGS		+= -Os
+else
+CFLAGS		+= -O2
+endif
+
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
 endif
--- linux-2.6.0-test4/arch/arm26/Makefile.old	2003-08-24 14:50:45.000000000 +0200
+++ linux-2.6.0-test4/arch/arm26/Makefile	2003-08-24 14:56:15.000000000 +0200
@@ -13,7 +13,6 @@
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
 #CFLAGS		+=-pipe
-CFLAGS		:=$(CFLAGS:-O2=-Os)
 
 ifeq ($(CONFIG_FRAME_POINTER),y)
 CFLAGS		+=-fno-omit-frame-pointer -mno-sched-prolog
--- linux-2.6.0-test4/arch/arm/Makefile.old	2003-08-24 14:56:41.000000000 +0200
+++ linux-2.6.0-test4/arch/arm/Makefile	2003-08-24 14:56:57.000000000 +0200
@@ -14,8 +14,6 @@
 GZFLAGS		:=-9
 #CFLAGS		+=-pipe
 
-CFLAGS		:=$(CFLAGS:-O2=-Os)
-
 ifeq ($(CONFIG_FRAME_POINTER),y)
 CFLAGS		+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
--- linux-2.6.0-test4/arch/h8300/Makefile.old	2003-08-24 14:59:42.000000000 +0200
+++ linux-2.6.0-test4/arch/h8300/Makefile	2003-08-24 15:00:18.000000000 +0200
@@ -34,7 +34,7 @@
 ldflags-$(CONFIG_CPU_H8S)	:= -mh8300self
 
 CFLAGS += $(cflags-y)
-CFLAGS += -mint32 -fno-builtin -Os
+CFLAGS += -mint32 -fno-builtin
 CFLAGS += -g
 CFLAGS += -D__linux__
 CFLAGS += -DUTS_SYSNAME=\"uClinux\"

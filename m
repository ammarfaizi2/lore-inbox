Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTINMRI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 08:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTINMRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 08:17:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22750 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262397AbTINMRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 08:17:01 -0400
Date: Sun, 14 Sep 2003 14:16:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add a config option for -Os compilation
Message-ID: <20030914121655.GS27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds a config option OPTIMIZE_FOR_SIZE for telling gcc 
to use -Os instead of -O2. Besides this, it removes constructs on 
architectures that had a -Os hardcoded in their Makefiles.

It works for me, I'm currently running a 2.6.0-test5 compild with this 
option enabled and there are no obvious problems.

The last time I sent this to linux-kernel there were one positive and 
zero negative reactions.

diffstat output:

 Makefile            |    8 +++++++-
 arch/arm/Makefile   |    2 --
 arch/h8300/Makefile |    2 +-
 init/Kconfig        |    9 +++++++++
 4 files changed, 17 insertions(+), 4 deletions(-)

Please apply
Adrian

--- linux-2.6.0-test5-Os/init/Kconfig.old	2003-09-13 17:30:50.000000000 +0200
+++ linux-2.6.0-test5-Os/init/Kconfig	2003-09-13 17:30:59.000000000 +0200
@@ -65,6 +65,15 @@
 
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
--- linux-2.6.0-test5-Os/Makefile.old	2003-09-13 17:30:50.000000000 +0200
+++ linux-2.6.0-test5-Os/Makefile	2003-09-13 17:30:59.000000000 +0200
@@ -223,7 +223,7 @@
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
 
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
@@ -370,6 +370,12 @@
 # ---------------------------------------------------------------------------
 
 
+ifdef CONFIG_OPTIMIZE_FOR_SIZE
+CFLAGS		+= -Os
+else
+CFLAGS		+= -O2
+endif
+
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
 endif
--- linux-2.6.0-test5-Os/arch/arm/Makefile.old	2003-09-13 17:30:50.000000000 +0200
+++ linux-2.6.0-test5-Os/arch/arm/Makefile	2003-09-13 17:30:59.000000000 +0200
@@ -14,8 +14,6 @@
 GZFLAGS		:=-9
 #CFLAGS		+=-pipe
 
-CFLAGS		:=$(CFLAGS:-O2=-Os)
-
 ifeq ($(CONFIG_FRAME_POINTER),y)
 CFLAGS		+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
--- linux-2.6.0-test5-Os/arch/h8300/Makefile.old	2003-09-13 17:30:50.000000000 +0200
+++ linux-2.6.0-test5-Os/arch/h8300/Makefile	2003-09-13 17:30:59.000000000 +0200
@@ -34,7 +34,7 @@
 ldflags-$(CONFIG_CPU_H8S)	:= -mh8300self
 
 CFLAGS += $(cflags-y)
-CFLAGS += -mint32 -fno-builtin -Os
+CFLAGS += -mint32 -fno-builtin
 CFLAGS += -g
 CFLAGS += -D__linux__
 CFLAGS += -DUTS_SYSNAME=\"uClinux\"

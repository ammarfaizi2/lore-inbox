Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTJOWvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 18:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTJOWvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 18:51:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48092 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262030AbTJOWvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 18:51:04 -0400
Date: Thu, 16 Oct 2003 00:50:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add a config option for -Os compilation
Message-ID: <20031015225055.GS17986@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the patch below adds a configuration option for -Os (the H8300 symbol is
similar to the symbols on other architectures). It includes the results
of all detail discussions and applies, compiles and works with
2.6.0-test7-mm1.

Could you add it to -mm?

diffstat output:

 Makefile            |    8 +++++++-
 arch/arm/Makefile   |    2 --
 arch/h8300/Kconfig  |    4 ++++
 arch/h8300/Makefile |    3 +--
 init/Kconfig        |   10 ++++++++++
 5 files changed, 22 insertions(+), 5 deletions(-)


TIA
Adrian


--- linux-2.6.0-test5-mm4/init/Kconfig.old	2003-09-25 14:38:18.000000000 +0200
+++ linux-2.6.0-test5-mm4/init/Kconfig	2003-09-25 14:47:12.000000000 +0200
@@ -65,6 +65,16 @@
 
 menu "General setup"
 
+config CC_OPTIMIZE_FOR_SIZE
+	bool "Optimize for size" if EXPERIMENTAL
+	default y if ARM || H8300
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
--- linux-2.6.0-test5-mm4/Makefile.old	2003-09-25 14:38:18.000000000 +0200
+++ linux-2.6.0-test5-mm4/Makefile	2003-09-25 14:40:26.000000000 +0200
@@ -274,7 +274,7 @@
 CPPFLAGS        := -D__KERNEL__ -Iinclude \
 		   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
 
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
@@ -421,6 +421,12 @@
 # ---------------------------------------------------------------------------
 
 
+ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
+CFLAGS		+= -Os
+else
+CFLAGS		+= -O2
+endif
+
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
 endif
--- linux-2.6.0-test5-mm4/arch/arm/Makefile.old	2003-09-25 14:38:18.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/arm/Makefile	2003-09-25 14:40:47.000000000 +0200
@@ -14,8 +14,6 @@
 GZFLAGS		:=-9
 #CFLAGS		+=-pipe
 
-CFLAGS		:=$(CFLAGS:-O2=-Os)
-
 ifeq ($(CONFIG_FRAME_POINTER),y)
 CFLAGS		+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
--- linux-2.6.0-test5-mm4/arch/h8300/Kconfig.old	2003-09-25 14:43:27.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/h8300/Kconfig	2003-09-25 14:43:44.000000000 +0200
@@ -5,6 +5,10 @@
 
 mainmenu "uClinux/h8300 (w/o MMU) Kernel Configuration"
 
+config H8300
+	bool
+	default y
+
 config MMU
 	bool
 	default n
--- linux-2.6.0-test5-mm4/arch/h8300/Makefile.old	2003-09-25 14:38:18.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/h8300/Makefile	2003-09-25 14:38:24.000000000 +0200
@@ -34,7 +34,7 @@
 ldflags-$(CONFIG_CPU_H8S)	:= -mh8300self
 
 CFLAGS += $(cflags-y)
-CFLAGS += -mint32 -fno-builtin -Os
+CFLAGS += -mint32 -fno-builtin
 CFLAGS += -g
 CFLAGS += -D__linux__
 CFLAGS += -DUTS_SYSNAME=\"uClinux\"

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTIYOjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 10:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTIYOjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 10:39:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38341 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261250AbTIYOi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 10:38:59 -0400
Date: Thu, 25 Sep 2003 16:38:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20030925143844.GY15696@fs.tum.de>
References: <20030914121655.GS27368@fs.tum.de> <20030914133349.A27870@flint.arm.linux.org.uk> <20030914132143.GT27368@fs.tum.de> <20030914155245.A675@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914155245.A675@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 03:52:45PM +0100, Russell King wrote:
> 
> But it doesn't make sense - you include a generic configuration option
> which people will see, yet it makes no effect on ARM - seems to be rather
> silly putting it there in the first place.
> 
> Also, do users particularly care what -Os and -O2 mean?

The "If unsure, say N." should take care of it. People who really need 
small kernels usually know what -Os means.

> Maybe you need to change init/Kconfig to be something like the following,
> and reinstate the change to the ARM makefile:
> 
> config OPTIMIZE_FOR_SIZE
> 	bool "Optimize for size" if EXPERIMENTAL
> 	default n if !ARM
> 	default y if ARM

That's a good idea.

The patch below does this for ARM and H8300.
Since there was no H8300 symbol, I added it to arch/h8300/Kconfig 
similar to the symbols on other architectures.

> 	help
> 	  Enabling this option will cause the compiler to reduce the code
> 	  size of the kernel by disabling certain optimisations.  However,
> 	  the resulting kernel may run faster due to more efficient
> 	  cache utilisation.
>...

I don't like this part, it would cause confusion. -O2 is more widely
tested, and though if there might be small improvements on some CPUs
with some compiler versions, it's untested whether -Os might cause worse
performance of some fast path code in any area of the kernel.
OPTIMIZE_FOR_SIZE should, although of low risk, be an "only use it if
you know what you are doing" option.


diffstat output for the patch below:

 Makefile            |    8 +++++++-
 arch/arm/Makefile   |    2 --
 arch/h8300/Kconfig  |    4 ++++
 arch/h8300/Makefile |    2 +-
 init/Kconfig        |   10 ++++++++++
 5 files changed, 22 insertions(+), 4 deletions(-)


cu
Adrian

--- linux-2.6.0-test5-mm4/init/Kconfig.old	2003-09-25 14:38:18.000000000 +0200
+++ linux-2.6.0-test5-mm4/init/Kconfig	2003-09-25 14:47:12.000000000 +0200
@@ -65,6 +65,16 @@
 
 menu "General setup"
 
+config OPTIMIZE_FOR_SIZE
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
 
 
+ifdef CONFIG_OPTIMIZE_FOR_SIZE
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

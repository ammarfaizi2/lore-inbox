Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTJZL5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTJZL5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:57:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46790 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263107AbTJZL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:57:25 -0500
Date: Sun, 26 Oct 2003 12:57:19 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, daniel@osdl.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIOtestingon2.6.0-test7-mm1)
Message-ID: <20031026115719.GA10333@fs.tum.de>
References: <1066693673.22983.10.camel@ibm-c.pdx.osdl.net> <20031021121113.GA4282@in.ibm.com> <1066869631.1963.46.camel@ibm-c.pdx.osdl.net> <20031023104923.GA11543@in.ibm.com> <20031023135030.GA11807@in.ibm.com> <20031023155937.41b0eeda.akpm@osdl.org> <20031023232006.GH21490@fs.tum.de> <20031023162539.0051249d.akpm@osdl.org> <20031023233700.GJ21490@fs.tum.de> <20031023164638.5c32b80f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023164638.5c32b80f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 04:46:38PM -0700, Andrew Morton wrote:
>...
> > -Os has it's benefits on some systems, so it shouldn't be totally hidden 
> > under EMBEDDED. OTOH, it's less tested, so only people who know what 
> > they are doing should use it (EXPERIMENTAL plus help text).
> 
> It causes kernels to crash on a major linux distribution.  We need to
> either make it very hard to turn on, or just forget it altogether.

The -Os patch with a dependency on EMBEDDED is below.

diffstat output:

 arch/arm/Makefile   |    2 --
 arch/h8300/Kconfig  |    4 ++++
 arch/h8300/Makefile |    2 +-
 Makefile            |    8 +++++++-
 init/Kconfig        |   10 ++++++++++
 5 files changed, 22 insertions(+), 4 deletions(-)


cu
Adrian


--- linux-2.6.0-test9/init/Kconfig.old	2003-10-26 12:48:21.000000000 +0100
+++ linux-2.6.0-test9/init/Kconfig	2003-10-26 12:49:56.000000000 +0100
@@ -196,6 +196,16 @@
 
 source "drivers/block/Kconfig.iosched"
 
+config CC_OPTIMIZE_FOR_SIZE
+	bool "Optimize for size" if EMBEDDED
+	default y if ARM || H8300
+	default n
+	help
+	  Enabling this option will pass "-Os" instead of "-O2" to gcc
+	  resulting in a smaller kernel.
+
+	  If unsure, say N.
+
 endmenu		# General setup
 
 
--- linux-2.6.0-test9/Makefile.old	2003-10-26 12:48:15.000000000 +0100
+++ linux-2.6.0-test9/Makefile	2003-10-26 12:48:32.000000000 +0100
@@ -275,7 +275,7 @@
 CPPFLAGS        := -D__KERNEL__ -Iinclude \
 		   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
 
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
@@ -431,6 +431,12 @@
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


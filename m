Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTIZWgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTIZWgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:36:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5112 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261678AbTIZWgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:36:21 -0400
Date: Sat, 27 Sep 2003 00:36:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20030926223612.GF2881@fs.tum.de>
References: <20030914121655.GS27368@fs.tum.de> <20030914133349.A27870@flint.arm.linux.org.uk> <20030914132143.GT27368@fs.tum.de> <20030914155245.A675@flint.arm.linux.org.uk> <20030925143844.GY15696@fs.tum.de> <20030925181127.GB2089@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925181127.GB2089@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 08:11:27PM +0200, Sam Ravnborg wrote:
> On Thu, Sep 25, 2003 at 04:38:45PM +0200, Adrian Bunk wrote:
> > --- linux-2.6.0-test5-mm4/init/Kconfig.old	2003-09-25 14:38:18.000000000 +0200
> > +++ linux-2.6.0-test5-mm4/init/Kconfig	2003-09-25 14:47:12.000000000 +0200
> > @@ -65,6 +65,16 @@
> >  
> >  menu "General setup"
> >  
> > +config OPTIMIZE_FOR_SIZE
> > +	bool "Optimize for size" if EXPERIMENTAL
> > +	default y if ARM || H8300
> > +	default n
> > +	help
> > +	  Enabling this option will pass "-Os" instead of "-O2" to gcc
> > +	  resulting in a smaller kernel.
> > +
> > +	  If unsure, say N.
> > +
> 
> This is a general file, and it is wrong to include architecture specific
> knowledge here.
> I recall that Roman Zippel introduced "enable" for exactly this purpose.
>...

I can't see how this would help in this situation, we need a default, 
not a dependency (OPTIMIZE_FOR_SIZE=n should be possible on ARM).

It's not the only option that sets defaults depending on the 
architecture and I can't see why it should be a bad thing.

> Another comment about the naming of the config symbol.
> We keep getting more config symbols controlling options to GCC.
> A naming scheme like: CONFIG_CC_OPTIMIZE_FOR_SIZE, CONFIG_CC_DEBUG_INFO
> is preferable since it give better context information.
> Let's start with this option, and rename the others later.

Below is the patch with CONFIG_CC_OPTIMIZE_FOR_SIZE.

> 	Sam

cu
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbTINNVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 09:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTINNVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 09:21:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48092 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262396AbTINNVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 09:21:49 -0400
Date: Sun, 14 Sep 2003 15:21:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20030914132143.GT27368@fs.tum.de>
References: <20030914121655.GS27368@fs.tum.de> <20030914133349.A27870@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914133349.A27870@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 01:33:49PM +0100, Russell King wrote:
> On Sun, Sep 14, 2003 at 02:16:56PM +0200, Adrian Bunk wrote:
> > The patch below adds a config option OPTIMIZE_FOR_SIZE for telling gcc 
> > to use -Os instead of -O2. Besides this, it removes constructs on 
> > architectures that had a -Os hardcoded in their Makefiles.
> 
> I'd rather retain the -Os default for ARM please.  (The init/Kconfig
> defaults it to 'n' for everything.)

Below is the patch with the ARM part omitted.

cu
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbTCPFoz>; Sun, 16 Mar 2003 00:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTCPFoy>; Sun, 16 Mar 2003 00:44:54 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:64961 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262421AbTCPFox>; Sun, 16 Mar 2003 00:44:53 -0500
Date: Sat, 15 Mar 2003 23:55:41 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <colpatch@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NUMAQ subarchification
In-Reply-To: <1047791157.1963.212.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0303152353520.10374-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Mar 2003, James Bottomley wrote:

> On Sat, 2003-03-15 at 20:53, Kai Germaschewski wrote:
> > I think VPATH has never been meant to be used for anything like this, it 
> > could be make to work, though it would interfere with the separate src/obj 
> > thing. But I don't think it's a good idea, we'll have object files 
> > magically appear without any visible source file, that's just too obscure.
> 
> Well...There is a slightly different solution.
> 
> What if the summit/numaq setup.c simply contained 
> 
> #include "../mach-default/setup.c"
> 
> ?
> 
> Not that I like doing this, but it solves the "magic" appearace of the
> object file and it's perfectly clear to anyone editing the file where it
> really comes from.

Yes, that'd work as well. Just for reference, my suggestion: - Take
whatever you like best ;)

--Kai


===== arch/i386/Kconfig 1.48 vs edited =====
--- 1.48/arch/i386/Kconfig	Sat Mar  8 16:50:37 2003
+++ edited/arch/i386/Kconfig	Sat Mar 15 23:00:18 2003
@@ -97,6 +97,16 @@
 
 endchoice
 
+config X86_DEFAULT_SETUP
+	bool
+	default y
+	depends on X86_PC || X86_NUMAQ || X86_SUMMIT || X86_BIGSMP
+
+config X86_DEFAULT_TOPOLOGY
+	bool
+	default y
+	depends on X86_PC || X86_NUMAQ || X86_SUMMIT || X86_BIGSMP
+
 
 choice
 	prompt "Processor family"
===== arch/i386/Makefile 1.48 vs edited =====
--- 1.48/arch/i386/Makefile	Tue Mar  4 17:09:44 2003
+++ edited/arch/i386/Makefile	Sat Mar 15 23:29:32 2003
@@ -50,38 +50,33 @@
 
 CFLAGS += $(cflags-y)
 
-# Default subarch .c files
-mcore-y  := mach-default
-
 # Voyager subarch support
 mflags-$(CONFIG_X86_VOYAGER)	:= -Iinclude/asm-i386/mach-voyager
-mcore-$(CONFIG_X86_VOYAGER)	:= mach-voyager
+mcore-$(CONFIG_X86_VOYAGER)	:= arch/i386/mach-voyager/
 
 # VISWS subarch support
 mflags-$(CONFIG_X86_VISWS)	:= -Iinclude/asm-i386/mach-visws
-mcore-$(CONFIG_X86_VISWS)	:= mach-visws
+mcore-$(CONFIG_X86_VISWS)	:= arch/i386/mach-visws/
 
 # NUMAQ subarch support
 mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
-mcore-$(CONFIG_X86_NUMAQ)	:= mach-default
 
 # BIGSMP subarch support
 mflags-$(CONFIG_X86_BIGSMP)	:= -Iinclude/asm-i386/mach-bigsmp
-mcore-$(CONFIG_X86_BIGSMP)	:= mach-default
 
-#Summit subarch support
-mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
-mcore-$(CONFIG_X86_SUMMIT)  := mach-default
+# Summit subarch support
+mflags-$(CONFIG_X86_SUMMIT)	:= -Iinclude/asm-i386/mach-summit
 
 # default subarch .h files
-mflags-y += -Iinclude/asm-i386/mach-default
+mflags-y 			+= -Iinclude/asm-i386/mach-default
 
 head-y := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
-					   arch/i386/$(mcore-y)/
+					   arch/i386/mach-default/ \
+					   $(mcore-y)
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
 # FIXME: is drivers- right ?
===== arch/i386/mach-default/Makefile 1.8 vs edited =====
--- 1.8/arch/i386/mach-default/Makefile	Sun Dec 22 06:08:42 2002
+++ edited/arch/i386/mach-default/Makefile	Sat Mar 15 22:57:13 2003
@@ -4,4 +4,5 @@
 
 EXTRA_CFLAGS	+= -I../kernel
 
-obj-y				:= setup.o topology.o
+obj-$(CONFIG_X86_DEFAULT_SETUP)		+= setup.o
+obj-$(CONFIG_X86_DEFAULT_TOPOLOGY)	+= topology.o



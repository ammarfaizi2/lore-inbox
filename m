Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267888AbUHET1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267888AbUHET1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267884AbUHESay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:30:54 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:27593 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S267870AbUHESO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:14:28 -0400
Date: Thu, 5 Aug 2004 11:14:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Giuliano Pochini <pochini@shiny.it>, kumar.gala@freescale.com,
       tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040805181425.GD555@smtp.west.cox.net>
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it> <20040730190731.GQ16468@smtp.west.cox.net> <20040730224828.0f06e37a.pochini@shiny.it> <20040730210318.GS16468@smtp.west.cox.net> <20040805141257.GA14826@suse.de> <20040805165410.GA555@smtp.west.cox.net> <20040805180025.GA20390@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805180025.GA20390@suse.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 08:00:25PM +0200, Olaf Hering wrote:
>  On Thu, Aug 05, Tom Rini wrote:
> 
> > On Thu, Aug 05, 2004 at 04:12:57PM +0200, Olaf Hering wrote:
> > >  On Fri, Jul 30, Tom Rini wrote:
> > > 
> > > > 
> > > > +aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
> > > 
> > > this should be -Wa,-mppc64bridge for some reasons.
> > 
> > That, er, doesn't make sense.  The assembler needs -Wa,?
> 
> This makes g5 32bit happy. aflags- is used with 'gcc $options', not for as
> I'm not sure if the other aflags- should stay.

I mistook AFLAGS for being always invoked with gas, which is not the
case.  Lets do the following:

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.58/arch/ppc/Makefile	2004-07-31 12:16:29 -07:00
+++ edited/arch/ppc/Makefile	2004-08-05 11:13:05 -07:00
@@ -22,28 +22,25 @@
 
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
 CPPFLAGS	+= -Iarch/$(ARCH)
-aflags-y	+= -Iarch/$(ARCH)
-cflags-y	+= -Iarch/$(ARCH) -msoft-float -pipe \
+AFLAGS		+= -Iarch/$(ARCH)
+CFLAGS		+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -Wno-uninitialized -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
 
 CHECK		:= $(CHECK) -D__powerpc__=1
 
 ifndef CONFIG_E500
-cflags-y	+= -mstring
+CFLAGS		+= -mstring
 endif
 
-aflags-$(CONFIG_4xx)		+= -m405
-cflags-$(CONFIG_4xx)		+= -Wa,-m405
-aflags-$(CONFIG_6xx)		+= -maltivec
-cflags-$(CONFIG_6xx)		+= -Wa,-maltivec
-aflags-$(CONFIG_E500)		+= -me500
-cflags-$(CONFIG_E500)		+= -Wa,-me500
-aflags-$(CONFIG_PPC64BRIDGE)	+= -mppc64bridge
-cflags-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
+cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
+cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
+cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
+cpu-as-$(CONFIG_E500)		+= -Wa,-me500
+cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
 
-AFLAGS += $(aflags-y)
-CFLAGS += $(cflags-y)
+AFLAGS += $(cpu-as-y)
+CFLAGS += $(cpu-as-y)
 
 head-y				:= arch/ppc/kernel/head.o
 head-$(CONFIG_8xx)		:= arch/ppc/kernel/head_8xx.o
--- 1.47/arch/ppc/kernel/Makefile	2004-06-17 23:41:08 -07:00
+++ edited/arch/ppc/kernel/Makefile	2004-08-05 11:10:48 -07:00
@@ -2,16 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-ifdef CONFIG_4xx
-EXTRA_AFLAGS		:= -Wa,-m405
-endif
-ifdef CONFIG_E500
-EXTRA_AFLAGS		:= -Wa,-me500
-endif
-
 extra-$(CONFIG_PPC_STD_MMU)	:= head.o
 extra-$(CONFIG_40x)		:= head_4xx.o
 extra-$(CONFIG_44x)		:= head_44x.o
--- 1.17/arch/ppc/mm/Makefile	2004-06-17 23:41:08 -07:00
+++ edited/arch/ppc/mm/Makefile	2004-08-02 12:08:32 -07:00
@@ -2,10 +2,6 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #
 
-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-
 obj-y				:= fault.o init.o mem_pieces.o \
 					mmu_context.o pgtable.o
 
--- 1.33/arch/ppc/platforms/Makefile	2004-07-29 07:39:02 -07:00
+++ edited/arch/ppc/platforms/Makefile	2004-08-05 11:11:06 -07:00
@@ -2,13 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-ifdef CONFIG_40x
-EXTRA_AFLAGS		:= -Wa,-m405
-endif
-
 # Extra CFLAGS so we don't have to do relative includes
 CFLAGS_pmac_setup.o	+= -Iarch/$(ARCH)/mm
 
--- 1.31/arch/ppc/syslib/Makefile	2004-08-02 01:00:42 -07:00
+++ edited/arch/ppc/syslib/Makefile	2004-08-05 11:11:14 -07:00
@@ -2,16 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-ifdef CONFIG_PPC64BRIDGE
-EXTRA_AFLAGS		:= -Wa,-mppc64bridge
-endif
-ifdef CONFIG_4xx
-EXTRA_AFLAGS		:= -Wa,-m405
-endif
-ifdef CONFIG_E500
-EXTRA_AFLAGS		:= -Wa,-me500
-endif
-
 CFLAGS_prom_init.o      += -fPIC
 CFLAGS_btext.o          += -fPIC
 
-- 
Tom Rini
http://gate.crashing.org/~trini/

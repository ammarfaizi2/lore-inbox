Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUEQPZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUEQPZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUEQPZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:25:58 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:4149 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261654AbUEQPXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:23:51 -0400
Date: Mon, 17 May 2004 11:23:11 -0400
From: Mathieu Chouquet-Stringer <mchouque@online.fr>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: Re: [PATCH] Fix for 2.6.6 Makefiles to get KBUILD_OUTPUT working
In-reply-to: <20040516203322.GA4784@mars.ravnborg.org>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, linux-alpha@vger.kernel.org,
       ralf@gnu.org, linux-mips@linux-mips.org, akpm@osdl.org, bjornw@axis.com,
       dev-etrax@axis.com, mikael.starvik@axis.com, sam@ravnborg.org
Mail-followup-to: Mathieu Chouquet-Stringer <mchouque@online.fr>,
 linux-kernel@vger.kernel.org, rth@twiddle.net, linux-alpha@vger.kernel.org,
 ralf@gnu.org, linux-mips@linux-mips.org, akpm@osdl.org, bjornw@axis.com,
 dev-etrax@axis.com, mikael.starvik@axis.com, sam@ravnborg.org
Message-id: <20040517152311.GA29999@localhost>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.1i
References: <20040516012245.GA11733@localhost>
 <20040516203322.GA4784@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 10:33:22PM +0200, Sam Ravnborg wrote:
> > --- arch/mips/Makefile.orig	2004-05-15 20:48:52.000000000 -0400
> > +++ arch/mips/Makefile	2004-05-15 20:49:58.000000000 -0400
> >  
> > -makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/mips/boot $(1)
> > +makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot $(1)
> 
> Please get rid of makeboot. Use $(Q)$(MAKE) ... instead.
> Hereby the '+' sign is no longer needed (used today where makeboot is used.

Ok, I applied the changes you requested, please check the diff for mips as
I had to modify some other lines too.

--- arch/alpha/Makefile.orig	2004-05-15 20:46:06.000000000 -0400
+++ arch/alpha/Makefile	2004-05-15 20:47:52.000000000 -0400
@@ -106,10 +106,10 @@ boot := arch/alpha/boot
 all boot: $(boot)/vmlinux.gz
 
 $(boot)/vmlinux.gz: vmlinux
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $@
+	$(Q)$(MAKE) $(build)=$(boot) $@
 
 bootimage bootpfile bootpzfile: vmlinux
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(boot) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 
 prepare: include/asm-$(ARCH)/asm_offsets.h
@@ -121,8 +121,8 @@ include/asm-$(ARCH)/asm_offsets.h: arch/
 	$(call filechk,gen-asm-offsets)
 
 archclean:
-	$(Q)$(MAKE) -f scripts/Makefile.clean obj=$(boot)
+	$(Q)$(MAKE) $(clean)=$(boot)
 
 CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
 
--- arch/mips/Makefile.orig	2004-05-15 20:48:52.000000000 -0400
+++ arch/mips/Makefile	2004-05-17 11:11:57.000000000 -0400
@@ -686,8 +686,6 @@ vmlinux.64: vmlinux
 		--change-addresses=0xa800000080000000 $< $@
 endif
 
-makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/mips/boot $(1)
-
 ifdef CONFIG_SGI_IP27
 all:	vmlinux.64
 endif
@@ -697,10 +695,10 @@ all:	vmlinux.ecoff
 endif
 
 vmlinux.ecoff vmlinux.rm200: vmlinux
-	+@$(call makeboot,$@)
+	$(Q)$(MAKE) $(build)=arch/mips/boot $@
 
 vmlinux.srec: vmlinux
-	+@$(call makeboot,$@)
+	$(Q)$(MAKE) $(build)=arch/mips/boot $@
 
 CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.srec \
@@ -708,10 +706,10 @@ CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.rm200
 
 archclean:
-	@$(MAKE) -f scripts/Makefile.clean obj=arch/mips/boot
-	@$(MAKE) -f scripts/Makefile.clean obj=arch/mips/baget
-	@$(MAKE) -f scripts/Makefile.clean obj=arch/mips/lasat
+	$(Q)$(MAKE) $(clean)=arch/mips/boot
+	$(Q)$(MAKE) $(clean)=arch/mips/baget
+	$(Q)$(MAKE) $(clean)=arch/mips/lasat
 
 # Generate <asm/offset.h 
 #
--- arch/sh/boot/Makefile.orig	2004-05-15 20:50:11.000000000 -0400
+++ arch/sh/boot/Makefile	2004-05-15 20:50:41.000000000 -0400
@@ -16,5 +16,5 @@ $(obj)/zImage: $(obj)/compressed/vmlinux
 	@echo 'Kernel: $@ is ready'
 
 $(obj)/compressed/vmlinux: FORCE
-	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed $@
+	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
--- arch/cris/Makefile.orig	2004-05-15 20:59:49.000000000 -0400
+++ arch/cris/Makefile	2004-05-15 21:00:36.000000000 -0400
@@ -81,7 +81,7 @@ compressed: zImage
 
 archmrproper:
 archclean:
-	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/$(ARCH)/boot	
+	$(Q)$(MAKE) $(clean)=arch/$(ARCH)/boot	
 	rm -f timage vmlinux.bin cramfs.img
 	rm -rf $(LD_SCRIPT).tmp
 

-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --

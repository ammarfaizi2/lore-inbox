Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263476AbUJ2Twt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263476AbUJ2Twt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263499AbUJ2TvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:51:16 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:30348 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262204AbUJ2T2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:28:18 -0400
Date: Fri, 29 Oct 2004 23:28:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: kbuild/all archs: Sanitize creating offsets.h
Message-ID: <20041029212852.GA16634@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028204430.C11436@flint.arm.linux.org.uk> <20041028215959.GA17314@mars.ravnborg.org> <20041028220024.D11436@flint.arm.linux.org.uk> <20041028234549.GB17314@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028234549.GB17314@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:45:49AM +0200, Sam Ravnborg wrote:
> On Thu, Oct 28, 2004 at 10:00:24PM +0100, Russell King wrote:
> > > Did you apply the patch that enabled kbuild files to be named Kbuild?
> > > It looks like this patch is missing.
> > 
> > I applied three patches.  The first was "kbuild: Prefer Kbuild as name of
> > the kbuild files"
> > 
> > > If you did apply the patch could you please check if the asm->asm-arm
> > > symlink exists when the error happens and that a file named Kbuild is
> > > located in the directory: include/asm-arm/
> 
> OK - I see it now.
> It's in i386 also - I will have a fix ready tomorrow. Thanks for testing!

Fix attached - next time I better check O= support myself.
Russell - I would be glad if you could test this version. There is 
some symlink handling for arm I like to see tested.

	Sam


===== Makefile 1.546 vs edited =====
--- 1.546/Makefile	2004-10-27 23:00:25 +02:00
+++ edited/Makefile	2004-10-29 23:05:42 +02:00
@@ -761,7 +761,7 @@
 prepare1: prepare2 outputmakefile
 
 prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
-	$(Q)$(MAKE) $(build)=$(srctree)/include/asm
+	$(Q)$(MAKE) $(build)=include/asm-$(ARCH)
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
===== include/asm-i386/Kbuild 1.1 vs edited =====
--- 1.1/include/asm-i386/Kbuild	2004-10-27 23:06:50 +02:00
+++ edited/include/asm-i386/Kbuild	2004-10-29 01:44:08 +02:00
@@ -11,7 +11,7 @@
 always  := offsets.h
 targets := offsets.s
 
-CFLAGS_offsets.o := -I arch/i386/kernel
+CFLAGS_offsets.o := -Iarch/i386/kernel
 
 $(obj)/offsets.h: $(obj)/offsets.s FORCE
 	$(call filechk,gen-asm-offsets, < $<)
===== scripts/Makefile.build 1.51 vs edited =====
--- 1.51/scripts/Makefile.build	2004-10-27 22:49:53 +02:00
+++ edited/scripts/Makefile.build	2004-10-29 23:04:40 +02:00
@@ -10,7 +10,7 @@
 # Read .config if it exist, otherwise ignore
 -include .config
 
-include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
+include $(if $(wildcard $(srctree)/$(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
 
 include scripts/Makefile.lib
 
===== scripts/Makefile.clean 1.17 vs edited =====
--- 1.17/scripts/Makefile.clean	2004-10-27 22:49:53 +02:00
+++ edited/scripts/Makefile.clean	2004-10-29 23:22:26 +02:00
@@ -7,7 +7,7 @@
 .PHONY: __clean
 __clean:
 
-include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
+include $(if $(wildcard $(srctree)/$(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
 
 # Figure out what we need to build from the various variables
 # ==========================================================================

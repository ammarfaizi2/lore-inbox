Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUIQRjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUIQRjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUIQRjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:39:08 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:42638 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S268911AbUIQRix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:38:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make make install install modules too
Date: Fri, 17 Sep 2004 13:38:51 -0400
User-Agent: KMail/1.7
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>
References: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409171338.51924.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.58.242] at Fri, 17 Sep 2004 12:38:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2004 13:00, Matthew Wilcox wrote:
>I keep forgetting to run 'make modules_install' after make install. 
> Since make now compiles modules too and there's no separate make
> modules step, it seems to make sense that make install should also
> install modules.

This is not a good patch IMO.  Many of us do things with scripts to 
drive the compile process, either in the name of repeatability or 
consistency.   These scripts may step out of the src tree and go make 
something else (lm_sensors comes to mind when it wasn't part of the 
kernel) whose output goes into the /lib/modules/version/ directory so 
that by the time the make modules_install runs, everything is already 
in place for the automatic depmod the modules_install does.  We 
*could* work around it by re-adding the depmod lines to our scripts, 
but it seems that might be called a kludge too.

>Index: linux-2.6/arch/i386/Makefile
>===================================================================
>RCS file: /var/cvs/linux-2.6/arch/i386/Makefile,v
>retrieving revision 1.11
>diff -u -p -r1.11 Makefile
>--- linux-2.6/arch/i386/Makefile 13 Sep 2004 15:22:09 -0000 1.11
>+++ linux-2.6/arch/i386/Makefile 17 Sep 2004 16:57:03 -0000
>@@ -117,7 +117,7 @@ AFLAGS += $(mflags-y)
> boot := arch/i386/boot
>
> .PHONY: zImage bzImage compressed zlilo bzlilo \
>- zdisk bzdisk fdimage fdimage144 fdimage288 install
>+ zdisk bzdisk fdimage fdimage144 fdimage288 install kernel_install
>
> all: bzImage
>
>@@ -136,8 +136,10 @@ zlilo bzlilo: vmlinux
> zdisk bzdisk: vmlinux
> 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) zdisk
>
>-install fdimage fdimage144 fdimage288: vmlinux
>+kernel_install fdimage fdimage144 fdimage288: vmlinux
> 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
>+
>+install: kernel_install modules_install
>
> prepare: include/asm-$(ARCH)/asm_offsets.h
> CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
>Index: linux-2.6/arch/i386/boot/Makefile
>===================================================================
>RCS file: /var/cvs/linux-2.6/arch/i386/boot/Makefile,v
>retrieving revision 1.5
>diff -u -p -r1.5 Makefile
>--- linux-2.6/arch/i386/boot/Makefile	13 Sep 2004 15:22:09 -0000	1.5
>+++ linux-2.6/arch/i386/boot/Makefile	17 Sep 2004 16:57:03 -0000
>@@ -100,5 +100,5 @@ zlilo: $(BOOTIMAGE)
> 	cp System.map $(INSTALL_PATH)/
> 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
>
>-install: $(BOOTIMAGE)
>+kernel_install: $(BOOTIMAGE)
> 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map
> "$(INSTALL_PATH)"

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

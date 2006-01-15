Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751891AbWAOKFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWAOKFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 05:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWAOKFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 05:05:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:26380 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751891AbWAOKFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 05:05:38 -0500
Date: Sun, 15 Jan 2006 11:05:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ren? Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Message-ID: <20060115100530.GB8195@mars.ravnborg.org>
References: <200601151051.14827.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601151051.14827.rene@exactcode.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 10:51:14AM +0100, Ren? Rebe wrote:
> Hi all,
> 
> with at least 2.6.15-mm{2,3,4} untaring the kernel and running make menuconfig
> (or most other favourite config tools) do not display a version anymore since
> .kernelrelease it not build as dependecy.
> 
> I only noticed this because my build scripts grab the version before the build for
> later file names on installations and leave this string empty after configuration of
> latest linux kernels.

It is correct that "make kernelrelease" does not display correct info
until you have done a proper build of the kernel or at least the prepare
step.

The issue here is that we shall avoid sideeffects when running "make
kernelrelease" so it does not trigger all sorts of commands when running
as root for instance.

So the real fix is to error out when .kernelrelease does not exists.
See attached patch.

	Sam

diff --git a/Makefile b/Makefile
index deedaf7..19a37a2 100644
--- a/Makefile
+++ b/Makefile
@@ -1301,7 +1301,8 @@ checkstack:
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
 
 kernelrelease:
-	@echo $(KERNELRELEASE)
+	$(if $(wildcard .kernelrelease), $(Q)echo $(KERNELRELEASE), \
+	$(error kernelrelease not valid - run 'make prepare' to update it))
 kernelversion:
 	@echo $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 

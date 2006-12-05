Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968558AbWLESOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968558AbWLESOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968556AbWLESOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:14:16 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:51671 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968558AbWLESOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:14:15 -0500
Date: Tue, 5 Dec 2006 13:10:17 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: `make checkstack' and cross-compilation
Message-ID: <20061205181017.GA5666@ccure.user-mode-linux.org>
References: <Pine.LNX.4.62.0612011455040.19178@pademelon.sonytel.be> <20061201153021.GA4332@ccure.user-mode-linux.org> <Pine.LNX.4.62.0612011708550.30940@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0612011708550.30940@pademelon.sonytel.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 05:09:17PM +0100, Geert Uytterhoeven wrote:
> On Fri, 1 Dec 2006, Jeff Dike wrote:
> > And, do you have a cross-compilation environment which tests this?
> 
> Yes :-)

Can you test this patch?  It works for UML and native x86_64 - if it works
for your cross-build, I'll send it in.

				Jeff

Index: linux-2.6.18-mm/Makefile
===================================================================
--- linux-2.6.18-mm.orig/Makefile	2006-11-24 14:36:32.000000000 -0500
+++ linux-2.6.18-mm/Makefile	2006-12-05 13:08:20.000000000 -0500
@@ -1390,12 +1390,18 @@ endif #ifeq ($(mixed-targets),1)
 
 PHONY += checkstack kernelrelease kernelversion
 
-# Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
-# In the UML case, $(SUBARCH) is the name of the underlying
-# architecture, while for all other arches, it is the same as $(ARCH).
+# UML needs a little special treatment here.  It wants to use the host
+# toolchain, so needs $(SUBARCH) passed to checkstack.pl.  Everyone
+# else wants $(ARCH), including people doing cross-builds, which means
+# that $(SUBARCH) doesn't work here.
+ifeq ($(ARCH), um)
+CHECKSTACK_ARCH := $(SUBARCH)
+else
+CHECKSTACK_ARCH := $(ARCH)
+endif
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
-	$(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
+	$(PERL) $(src)/scripts/checkstack.pl $(CHECKSTACK_ARCH)
 
 kernelrelease:
 	$(if $(wildcard include/config/kernel.release), $(Q)echo $(KERNELRELEASE), \


-- 
Work email - jdike at linux dot intel dot com

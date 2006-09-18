Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWIRHus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWIRHus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 03:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWIRHur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 03:50:47 -0400
Received: from mx1.suse.de ([195.135.220.2]:59863 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964937AbWIRHur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 03:50:47 -0400
To: Robin Lee Powell <rlpowell@digitalkingdom.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM
References: <20060912223258.GM4612@chain.digitalkingdom.org>
From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 09:50:41 +0200
In-Reply-To: <20060912223258.GM4612@chain.digitalkingdom.org>
Message-ID: <p73bqpd62b2.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Lee Powell <rlpowell@digitalkingdom.org> writes:
> 
> This version is rather different, as it ends in:
> 
>     HARDWARE ERROR
>     CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
>     RIP 10:<ffffffff80446e3e> {pci_conf1_read+0xbe/0xf0}
>     TSC 2e7932dbf8 ADDR fdfc000cfc
>     This is not a software problem!
>     Run through mcelog --ascii to decode and contact your hardware vendor
>     Kernel panic - not syncing: Uncorrected machine check

Decoded it gives

..
  bus error 'local node origin, request didn't time out
      data read mem transaction
      i/o access, level generic'
..

It will probably boot with mce=off acpi=off pci=conf1 

You got some buggy device that causes a bus timeout when its config space
is read. The old kernel most likely didn't touch it by luck.

Please add the following patch and send the whole log.
This will tell us which device has this problem.

-Andi

diff -u linux-2.6.17-hack/arch/i386/pci/direct.c-o linux-2.6.17-hack/arch/i386/pci/direct.c
--- linux-2.6.17-hack/arch/i386/pci/direct.c-o	2006-04-20 02:17:33.000000000 +0200
+++ linux-2.6.17-hack/arch/i386/pci/direct.c	2006-09-18 09:48:46.000000000 +0200
@@ -19,6 +19,9 @@
 {
 	unsigned long flags;
 
+	printk("conf1 read bus %x devfn %x reg %x len %u\n",
+	       bus, devfn, reg, len);
+
 	if ((bus > 255) || (devfn > 255) || (reg > 255)) {
 		*value = -1;
 		return -EINVAL;

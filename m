Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVBQSM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVBQSM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVBQSM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:12:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32275 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262287AbVBQSMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:12:44 -0500
Date: Thu, 17 Feb 2005 18:12:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Frank Buss <fb@frank-buss.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with dma_mmap_writecombine on mach-pxa
Message-ID: <20050217181241.A22752@flint.arm.linux.org.uk>
Mail-Followup-To: Frank Buss <fb@frank-buss.de>,
	linux-kernel@vger.kernel.org
References: <20050217175150.D8E015B874@frankbuss.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050217175150.D8E015B874@frankbuss.de>; from fb@frank-buss.de on Thu, Feb 17, 2005 at 06:51:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 06:51:49PM +0100, Frank Buss wrote:
> I'm trying to use the pxafb driver on mach-pxa, but I can't mmap the
> framebuffer memory. I can access it from the driver, filling the entire
> screen, but when I access the pointer returned from mmap from a user space
> program, the following two things happens:
> 
> - the vm_pgoff is ignored and I get the start of the internal buffer, which
> caused writing to the palette and DMA descriptors
> 
> - when I change the location of the framebuffer to the start of the internal
> buffer, I can write to the screen, but only to the first 4 k; any write
> after this address is ignored, but no segfault is generated.
> 
> Any ideas what I can do to find the reason? I don't think that it is a
> kernel bug, but perhaps a wrong configuration for my platform.

Please try this (and revert your changes):

===== arch/arm/mm/consistent.c 1.27 vs edited =====
--- 1.27/arch/arm/mm/consistent.c	2005-01-21 05:02:14 +00:00
+++ edited/arch/arm/mm/consistent.c	2005-02-17 18:11:50 +00:00
@@ -284,13 +284,15 @@
 	spin_unlock_irqrestore(&consistent_lock, flags);
 
 	if (c) {
+		unsigned long off = vma->vm_pgoff;
+
 		kern_size = (c->vm_end - c->vm_start) >> PAGE_SHIFT;
 
-		if (vma->vm_pgoff < kern_size &&
-		    user_size <= (kern_size - vma->vm_pgoff)) {
+		if (off < kern_size &&
+		    user_size <= (kern_size - off)) {
 			vma->vm_flags |= VM_RESERVED;
 			ret = remap_pfn_range(vma, vma->vm_start,
-					      page_to_pfn(c->vm_pages),
+					      page_to_pfn(c->vm_pages) + off,
 					      user_size, vma->vm_page_prot);
 		}
 	}


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

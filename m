Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUF2K6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUF2K6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 06:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbUF2K6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 06:58:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3336 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265545AbUF2K6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 06:58:36 -0400
Date: Tue, 29 Jun 2004 11:58:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG FIX] [PATCH] fork_init() max_low_pfn fixes potential OOM bug on big highmem machine
Message-ID: <20040629115830.A24951@flint.arm.linux.org.uk>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@greatcn.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <40E03F71.8010902@greatcn.org> <20040628175325.B9214@flint.arm.linux.org.uk> <40E148EE.1090207@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40E148EE.1090207@greatcn.org>; from coywolf@greatcn.org on Tue, Jun 29, 2004 at 06:48:14PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 06:48:14PM +0800, Coywolf Qi Hunt wrote:
> Russell King wrote:
> Actually there's physical DRAM offset: PHY_OFFSET, defined on ARM only. 
> max_low_pfn happens to be the same as `num_lowpages'.
> These assignments seems illogical in naming. But just happen to let this 
> patch work.  Other platforms may still break.

That may be a bug actually.  Looking at ll_rw_blk.c:

        unsigned long bounce_pfn = dma_addr >> PAGE_SHIFT;
        if (bounce_pfn < blk_max_low_pfn) {

        blk_max_low_pfn = max_low_pfn;

dma_addr are physical addresses, so bounce_pfn is referenced to a PFN0
equal to physical address 0.  This implies that blk_max_low_pfn is
likewise, as is max_low_pfn.

> [coywolf@everest ~/linux-2.6.7/arch]$ grep max_low_pfn arm* -rn
> arm/mm/init.c:235:      max_low_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);

However, here, max_low_pfn of zero corresponds with the PFN of
PHYS_OFFSET.  We have something with two different origins being
compared, which is nonsense.  So something is wrong somewhere,
and my money is on max_low_pfn.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

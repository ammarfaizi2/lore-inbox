Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWGKCvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWGKCvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 22:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWGKCvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 22:51:44 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:38086 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S965090AbWGKCvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 22:51:43 -0400
Date: Mon, 10 Jul 2006 19:51:43 -0700
From: Marc Singer <elf@buici.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: DMA memory, split_page, BUG_ON(PageCompound()), sound
Message-ID: <20060711025142.GB31463@buici.com>
References: <20060709000703.GA9806@cerise.buici.com> <44B0774E.5010103@yahoo.com.au> <20060710025103.GC28166@cerise.buici.com> <44B1FAE4.9070903@yahoo.com.au> <20060710162600.GB18728@flint.arm.linux.org.uk> <44B28F93.9020304@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B28F93.9020304@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 03:34:11AM +1000, Nick Piggin wrote:
> >So I'll mask off __GFP_COMP for the time being in the ARM dma allocator
> >with a note to this effect?
> 
> I believe that should do the trick, yes (AFAIK, nobody yet is
> explicitly relying on a compound page from the dma allocator).
> 
> Marc can hopefully confim the fix.

The patch, attached, works in that there is no BUG_ON() trap.

>From c13ac90b1dd6e5fab63182ce323673cdffb0b55f Mon Sep 17 00:00:00 2001
Date: Mon, 10 Jul 2006 19:38:47 -0700
Subject: [PATCH] Drop __GFP_COMP for DMA memory allocations
---
 arch/arm/mm/consistent.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

Hack for incompatible __GFP_COMP flag making its way into the ARM DMA
consistent memory allocator.

Signed-off-by: Marc Singer <elf@buici.com>

diff --git a/arch/arm/mm/consistent.c b/arch/arm/mm/consistent.c
index 50e6b6b..7b7cc4e 100644
--- a/arch/arm/mm/consistent.c
+++ b/arch/arm/mm/consistent.c
@@ -153,6 +153,13 @@ __dma_alloc(struct device *dev, size_t s
 	unsigned long order;
 	u64 mask = ISA_DMA_THRESHOLD, limit;
 
+	/* Following is a work-around (a.k.a. hack) to prevent pages
+	 * with __GFP_COMP being passed to split_page() which cannot
+	 * handle them.  The real problem is that this flag probably
+	 * should be 0 on ARM as it is not supported on this
+	 * platform--see CONFIG_HUGETLB_PAGE. */
+	gfp &= ~(__GFP_COMP);
+
 	if (!consistent_pte[0]) {
 		printk(KERN_ERR "%s: not initialised\n", __func__);
 		dump_stack();
-- 
1.4.0



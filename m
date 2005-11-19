Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVKSUPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVKSUPE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVKSUPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:15:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:48694 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750793AbVKSUPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:15:02 -0500
Date: Sat, 19 Nov 2005 20:15:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>,
       William Irwin <wli@holomorphy.com>
cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] unpaged: unifdefed PageCompound
In-Reply-To: <20051117.154323.10862063.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0511192003060.2846@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511171931400.4563@goblin.wat.veritas.com>
 <20051117.154323.10862063.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Nov 2005 20:15:02.0030 (UTC) FILETIME=[EC24FAE0:01C5ED45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005, David S. Miller wrote:
> From: Hugh Dickins <hugh@veritas.com>
> Date: Thu, 17 Nov 2005 19:32:40 +0000 (GMT)
> 
> > That's just what PageCompound is designed for, but it's been kept under
> > CONFIG_HUGETLB_PAGE.  Remove the #ifdefs: which saves some space (out-
> > of-line put_page), doesn't slow down what most needs to be fast (already
> > using hugetlb), and unifies the way we handle high-order pages.
> > 
> > Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> I think this is a good change regardless of the VM_RESERVED issues.
> 
> I've been wanting to use this facility in some sparc64 bits in
> the past, for example.  But since it was HUGETLB guarded that
> wasn't possible.

I've only just found that we have to supply the __GFP_COMP flag to get
this working.  And one of the routes through snd_dma_alloc_pages goes
to sbus_alloc_consistent.  Would you be happy for me to send Andrew a
patch with sparc and sparc64 sbus_alloc_consistent including __GFP_COMP?
Ought I to do the same in the sparc and sparc64 pci_alloc_consistent??

Thanks,
Hugh

--- 2.6.15-rc1-mm2/arch/sparc/kernel/ioport.c	2005-06-17 20:48:29.000000000 +0100
+++ linux/arch/sparc/kernel/ioport.c	2005-11-19 19:11:04.000000000 +0000
@@ -252,7 +252,7 @@ void *sbus_alloc_consistent(struct sbus_
 	}
 
 	order = get_order(len_total);
-	if ((va = __get_free_pages(GFP_KERNEL, order)) == 0)
+	if ((va = __get_free_pages(GFP_KERNEL|__GFP_COMP, order)) == 0)
 		goto err_nopages;
 
 	if ((res = kmalloc(sizeof(struct resource), GFP_KERNEL)) == NULL)
--- 2.6.15-rc1-mm2/arch/sparc64/kernel/sbus.c	2005-11-12 09:00:36.000000000 +0000
+++ linux/arch/sparc64/kernel/sbus.c	2005-11-19 19:12:53.000000000 +0000
@@ -327,7 +327,7 @@ void *sbus_alloc_consistent(struct sbus_
 	order = get_order(size);
 	if (order >= 10)
 		return NULL;
-	first_page = __get_free_pages(GFP_KERNEL, order);
+	first_page = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
 	if (first_page == 0UL)
 		return NULL;
 	memset((char *)first_page, 0, PAGE_SIZE << order);

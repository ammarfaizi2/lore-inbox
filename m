Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVKKPDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVKKPDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVKKPDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:03:45 -0500
Received: from gold.veritas.com ([143.127.12.110]:40000 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750797AbVKKPDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:03:44 -0500
Date: Fri, 11 Nov 2005 15:02:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <20051110114950.03a5946b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511111458030.16832@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
 <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
 <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu>
 <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
 <20051110045144.40751a42.akpm@osdl.org> <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
 <20051110114950.03a5946b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Nov 2005 15:03:44.0305 (UTC) FILETIME=[1C0C5210:01C5E6D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >  On Thu, 10 Nov 2005, Andrew Morton wrote:
> >  > Isn't it going to overrun page.lru with CONFIG_DEBUG_SPINLOCK?
> > 
> >  No.
> 
> !no, methinks.
> 
> On 32-bit architectures with CONFIG_PREEMPT, CONFIG_DEBUG_SPINLOCK,
> CONFIG_NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS we have a 32-byte page, a
> 20-byte spinlock and offsetof(page, private) == 12.
> 
> IOW we're assuming that no 32-bit architectures will obtain pagetables from
> slab?

Sorry, I misunderstood "overrun".  Yes, you're right, the 32-bit
DEBUG_SPINLOCK spinlock_t runs into page.lru but does not run beyond it.
Here's what I already said about that in the comment on the patch:

The previous attempt at this patch broke ppc64, which uses slab for its
page tables - and slab saves vital info in page->lru: but no config of
spinlock_t needs to overwrite lru on 64-bit anyway; and the only 32-bit
user of slab for page tables is arm26, which is never SMP i.e. all the
problems came from the "safety" checks, not from what's actually needed.
So previous checks refined with #ifdefs, and a BUG_ON(PageSlab) added.

Hugh

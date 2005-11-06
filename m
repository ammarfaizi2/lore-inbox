Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVKFW70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVKFW70 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVKFW70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:59:26 -0500
Received: from silver.veritas.com ([143.127.12.111]:16958 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750801AbVKFW7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:59:25 -0500
Date: Sun, 6 Nov 2005 22:58:00 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
In-Reply-To: <20051106112838.0d524f65.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511062245240.29625@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
 <20051106112838.0d524f65.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Nov 2005 22:59:20.0940 (UTC) FILETIME=[B92482C0:01C5E325]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2005, Andrew Morton wrote:
> 
> This patch makes the ppc64 crash.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02976.jpg
> 
> I don't know what the access address was (ia32 nicely tells you), but if
> it's `DAR' then we have LIST_POISON1.  Which would indicate that the slab
> page which backs the mm_struct itself is getting freed-up-pte-page
> treatment, which is deeply screwed up.
> 
> I'll try it on x86_64 and ia64, see if it's specific to ppc64.

I think it'll turn out to be (my patch, yes, but) the way mm/slab.c does

#define	SET_PAGE_CACHE(pg,x)  ((pg)->lru.next = (struct list_head *)(x))
#define	GET_PAGE_CACHE(pg)    ((kmem_cache_t *)(pg)->lru.next)
#define	SET_PAGE_SLAB(pg,x)   ((pg)->lru.prev = (struct list_head *)(x))
#define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->lru.prev)

and needs those fields preserved while that page is in the slab.
Though I've not tried to work out why it crashes on an mm_struct.

I'd checked that none of the architectures were using those page fields
of a page table page, but never considered that slab was using them: my
patch probably breaks all those which use slab for their page tables.

Drat.  I'm trying to think of the best way to retrieve the situation.
The priority must be for you to get 2.6.14-mm1 out: is the easiest for
now simply to revert my patch (and the _private one(s) you added on top)?

Well, at least that patch has told us something we needed to know:
sorry for wasting _your_ time with it.  I'll try to dream up some other
way (or config restriction) to avoid enlarging struct page for ptlock.

Or am I jumping to conclusions and on the wrong track?

Hugh

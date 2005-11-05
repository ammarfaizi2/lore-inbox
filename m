Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVKEGlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVKEGlq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 01:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVKEGlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 01:41:46 -0500
Received: from silver.veritas.com ([143.127.12.111]:42589 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751266AbVKEGlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 01:41:45 -0500
Date: Sat, 5 Nov 2005 06:40:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
In-Reply-To: <20051104213225.39d4c2a3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511050604040.26716@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
 <20051104213225.39d4c2a3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Nov 2005 06:41:41.0033 (UTC) FILETIME=[FAB34990:01C5E1D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > While leaving most of the page_private() mods in place for the moment,
> > could we please try this patch, or something like it?  Again to overlay
> > the spinlock_t from &page->private onwards, with corrected BUILD_BUG_ON
> > that we don't go beyond ->lru; with poisoning of the fields overlaid,
> > and unsplit config verifying that the split config is safe to use them.
> 
> Does your family know you do this sort of thing?

They are beginning to suspect it, so I've made sure they're still asleep.

> What happened to my suggestion that we use anonymous structs here, and
> abandon gcc-2.9x?

Much as I'd hate split ptlock to enlarge struct page, I'd hate it to be
the last straw that forced you off gcc-2.9x: it does not deserve that.

But also, I just misunderstood you until now: I'd been stupidly thinking
you meant an anonymous union in place of your current u there; whereas
you meant extending the union to cover mapping, index, lru.   Hmm.

Well, if you're actively seeking a excuse to abandon gcc-2.9x?  But
although you're its best-known advocate, I think you're not alone.
Shall we wait for a more pressing reason?

> > -#define page_private(page)		((page)->u.private)
> > -#define set_page_private(page, v)	((page)->u.private = (v))
> > +#define page_private(page)		((page)->private)
> > +#define set_page_private(page, v)	((page)->private = (v))
> 
> Need to rename ->private to ->_private here, otherwise people will start
> using page->private again.

I'm happy for people to use page->private again.  I thought we
ought to try out this minimal patch first, for reassurance that the
arches are not using those fields of a pagetable struct page; but that
once it's had some exposure, we'd revert the page_private mods elsewhere.
There's no point to that wrapper with the union gone, is there?

Hugh

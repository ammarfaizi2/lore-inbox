Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVKJCKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVKJCKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbVKJCKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:10:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751436AbVKJCKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:10:37 -0500
Date: Wed, 9 Nov 2005 18:10:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-Id: <20051109181022.71c347d4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>  The split ptlock patch enlarged the default SMP PREEMPT struct page from
>  32 to 36 bytes on most 32-bit platforms, from 32 to 44 bytes on PA-RISC
>  7xxx (without PREEMPT).  That was not my intention, and I don't believe
>  that split ptlock deserves any such slice of the user's memory.
> 
>  Could we please try this patch, or something like it?  Again to overlay
>  the spinlock_t from &page->private onwards, with corrected BUILD_BUG_ON
>  that we don't go too far; with poisoning of the fields overlaid, and
>  unsplit SMP config verifying that the split config is safe to use them.
> 
>  The previous attempt at this patch broke ppc64, which uses slab for its
>  page tables - and slab saves vital info in page->lru: but no config of
>  spinlock_t needs to overwrite lru on 64-bit anyway; and the only 32-bit
>  user of slab for page tables is arm26, which is never SMP i.e. all the
>  problems came from the "safety" checks, not from what's actually needed.
>  So previous checks refined with #ifdefs, and a BUG_ON(PageSlab) added.
> 
>  This overlaying is unlikely to be portable forever: but the added checks
>  should warn developers when it's going to break, long before any users.

argh.

Really, I'd prefer to abandon gcc-2.95.x rather than this.  Look:

struct a
{
	union {
		struct {
			int b;
			int c;
		};
		int d;
	};
} z;

main()
{
	z.b = 1;
	z.d = 1;
}

It does everything we want.

Of course, it would be nice to retain 2.95.x support.  The reviled
page_private(() would help us do that.  But the now-to-be-reviled
page_mapping() does extraneous stuff, and we'd need a ton of page_lru()'s.

So it'd be a big patch, converting page->lru to page->u.s.lru in lots of
places.

But I think either a big patch or 2.95.x abandonment is preferable to this
approach.

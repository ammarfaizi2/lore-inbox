Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVKOStj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVKOStj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbVKOStj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:49:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964967AbVKOSti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:49:38 -0500
Date: Tue, 15 Nov 2005 10:49:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: hugh@veritas.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-Id: <20051115104916.353e7ade.akpm@osdl.org>
In-Reply-To: <20051109181022.71c347d4.akpm@osdl.org>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
	<20051109181022.71c347d4.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> >  The split ptlock patch enlarged the default SMP PREEMPT struct page from
> >  32 to 36 bytes on most 32-bit platforms, from 32 to 44 bytes on PA-RISC
> >  7xxx (without PREEMPT).  That was not my intention, and I don't believe
> >  that split ptlock deserves any such slice of the user's memory.
> > 
> >  Could we please try this patch, or something like it?  Again to overlay
> >  the spinlock_t from &page->private onwards, with corrected BUILD_BUG_ON
> >  that we don't go too far; with poisoning of the fields overlaid, and
> >  unsplit SMP config verifying that the split config is safe to use them.
> > 
> >  The previous attempt at this patch broke ppc64, which uses slab for its
> >  page tables - and slab saves vital info in page->lru: but no config of
> >  spinlock_t needs to overwrite lru on 64-bit anyway; and the only 32-bit
> >  user of slab for page tables is arm26, which is never SMP i.e. all the
> >  problems came from the "safety" checks, not from what's actually needed.
> >  So previous checks refined with #ifdefs, and a BUG_ON(PageSlab) added.
> > 
> >  This overlaying is unlikely to be portable forever: but the added checks
> >  should warn developers when it's going to break, long before any users.
> 
> argh.
> 
> Really, I'd prefer to abandon gcc-2.95.x rather than this.  Look:
> 
> struct a
> {
> 	union {
> 		struct {
> 			int b;
> 			int c;
> 		};
> 		int d;
> 	};
> } z;
> 
> main()
> {
> 	z.b = 1;
> 	z.d = 1;
> }
> 
> It does everything we want.

It occurs to me that we can do the above if (__GNUC__ > 2), or whatever.

That way, the only people who have a 4-byte-larger pageframe are those who
use CONFIG_PREEMPT, NR_CPUS>=4 and gcc-2.x.y.  An acceptably small
community, I suspect.



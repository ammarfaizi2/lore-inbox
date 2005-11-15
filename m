Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVKOUFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVKOUFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVKOUFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:05:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965024AbVKOUFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:05:34 -0500
Date: Tue, 15 Nov 2005 12:05:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-Id: <20051115120509.0de0cd85.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511151947010.7872@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
	<20051109181022.71c347d4.akpm@osdl.org>
	<20051115104916.353e7ade.akpm@osdl.org>
	<Pine.LNX.4.61.0511151947010.7872@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Tue, 15 Nov 2005, Andrew Morton wrote:
> > 
> > It occurs to me that we can do the above if (__GNUC__ > 2), or whatever.
> > 
> > That way, the only people who have a 4-byte-larger pageframe are those who
> > use CONFIG_PREEMPT, NR_CPUS>=4 and gcc-2.x.y.  An acceptably small
> > community, I suspect.
> 
> I can't really think of this at the moment (though the PageReserved
> fixups going smoother this evening).  Acceptably small community, yes.
> But wouldn't it plunge us into the very mess of wrappers we were trying
> to avoid with anony structunions, to handle the __GNUC__ differences?

Nope, all the changes would be constrained to the definition of struct
page, and struct page is special.

struct page {
	...
#if __GNUC__ > 2
	union {
		spinlock_t ptl;
		struct {
			unsigned long private;
			struct address_space *mapping;
		}
	}
#else
	union {
		unsigned long private;
		spinlock_t ptl;
	} u;
	struct address_space *mapping;
#endif


and

#if __GNUC__ > 2
#define page_private(page)		((page)->private)
#define set_page_private(page, v)	((page)->private = (v))
#else
#define page_private(page)		((page)->u.private)
#define set_page_private(page, v)	((page)->u.private = (v))
#endif

Of course, adding "u." and "u.s." all over the place would be a sane
solution, but we can do that later - I'm sure we'll be changing struct page
again.

View the above as "a space optimisation made possible by gcc-3.x".

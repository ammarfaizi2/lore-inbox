Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSHKRWq>; Sun, 11 Aug 2002 13:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSHKRWq>; Sun, 11 Aug 2002 13:22:46 -0400
Received: from dsl-213-023-020-163.arcor-ip.net ([213.23.20.163]:34463 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313571AbSHKRWp>;
	Sun, 11 Aug 2002 13:22:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch 15/21] multiple pte pointers per pte_chain
Date: Sun, 11 Aug 2002 19:27:02 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <3D5614BC.EB0629B6@zip.com.au> <20020811155122.B2513@kushida.apsleyroad.org>
In-Reply-To: <20020811155122.B2513@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dwUZ-0001hK-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 August 2002 16:51, Jamie Lokier wrote:
> Andrew Morton wrote:
> > Pages which are mapped by only a single process continue to not have a
> > pte_chain.  The pointer in struct page points directly at the mapping
> > pte (a "PageDirect" pte pointer).  Once the page is shared a pte_chain
> > is allocated and both the new and old pte pointers are moved into it.
> 
> May I suggest that the final pte in the list of ptes for a page is
> _always_ pointed to directly?
> 
> In other words, a pte_chain looks like this:
> 
>       struct page -> pte_chain -> pte_chain -> pte_chain -> pte
>                           |           |            |
>                           v           v            v
>                           pte         pte          pte
> 
> pte_chain vs. pte would be distinguished by the least significant bit of
> the pointer, or something similar.
> 
> This adds a special case in the list walker -- on the other hand, it
> also removes two special cases ("PageDirect" is no longer required, and
> there is no 0 to indicate end-of-list).  But the best part is: it saves
> more memory, has no cache line cost, and reduces the amount of work
> needed to share a page :-)

I think you need to read this thread:

   http://marc.theaimsgroup.com/?t=102623997700002&r=1&w=2

Starting from here:

   http://marc.theaimsgroup.com/?l=linux-mm&m=102656598902124&w=2

The whole direct pte pointer thing is an ugly hack, and that is no
reflection on Dave, who a nice a job of implementing it.  It does save
a lot of memory and a little speed.

Flagging the list links with the low bit of the address actually
makes the code cleaner, faster and saves even more memory.  That said,
I just removed the whole thing from the tree I'm hacking on because
I'm after a much bigger optimization and the direct pointer was really
getting in the way.  I suppose it will eventually go back in: ugly as
it is, the savings are compelling.

-- 
Daniel

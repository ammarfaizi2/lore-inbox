Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289291AbSA2JwP>; Tue, 29 Jan 2002 04:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSA2JwG>; Tue, 29 Jan 2002 04:52:06 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:10114 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289291AbSA2JwA>;
	Tue, 29 Jan 2002 04:52:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 10:55:24 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Momchil Velikov <velco@fadata.bg>, Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org> <E16VU2h-00009Y-00@starship.berlin> <20020129012007.H899@holomorphy.com>
In-Reply-To: <20020129012007.H899@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VUz6-00009h-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 10:20 am, William Lee Irwin III wrote:
> On Tue, Jan 29, 2002 at 09:55:02AM +0100, Daniel Phillips wrote:
> > It's only touching the ptes on tables that are actually used, so if a parent
> > with a massive amount of mapped memory forks a child that only instantiates
> > a small portion of it (common situation) then the saving is pretty big.
> 
> Please correct my attempt at clarifying this:

Sorry, it's my fault, my explanation above is ambiguous, or even incorrect.

> The COW markings are done at the next higher level of hierarchy above
> the pte's themselves, and so experience the radix tree branch factor
> reduction in the amount of work done at fork-time in comparison to a
> full pagetable copy on fork.

The CoW markings are done at the same level they always have been - directly
in the ptes (the 4 byte thingies, please don't get confused by the unfortunate
overloading of 'pte' to mean 'page table' in some contexts, e.g.,
zap_pte_range).  But the CoW marking only has to be done for page tables
that have use count == 1 at the time of fork.  So if the parent inherited
some page tables then these already have use count > 1, i.e., are shared,
and they don't have to be set up for CoW again when the child forks.  Only
page tables that the parent instantiated for itself have to be re-marked
for CoW.

Wow, this is getting subtle, isn't it?

> On Tue, Jan 29, 2002 at 09:55:02AM +0100, Daniel Phillips wrote:
> > Note that I'm not counting on this to be a huge performance win, except in
> > the specific case that that is bothering rmap.  This is already worth the
> > price of admission.
> 
> It is an overall throughput loss in the cases where the majority of the
> page table entries are in fact referenced by the child, and this is
> more than acceptable because it is more incremental, reference-all is
> an uncommon case, and once all the page table entries are referenced,
> there are no longer any penalties. Defeating this scheme would truly
> require a contrived application, and penalizes only that application.

True.  Also, since the child is doing all that work anyway, the cost of
instantiating one page table (and extending the pte_chains) per 1K
referenced pages will get lost in the noise.

-- 
Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbUCPIDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbUCPIB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:01:58 -0500
Received: from mail.cyclades.com ([64.186.161.6]:26858 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263506AbUCPIAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:00:39 -0500
Date: Tue, 16 Mar 2004 03:31:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, <marcelo.tosatti@cyclades.com>,
       <j-nomura@ce.jp.nec.com>, <linux-kernel@vger.kernel.org>,
       <riel@redhat.com>, <torvalds@osdl.org>
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040314152253.05c58ecc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0403160326360.1667-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Mar 2004, Andrew Morton wrote:

> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > 
> > > Having a magic knob is a weak solution: the majority of people who are
> > > affected by this problem won't know to turn it on.
> > 
> > that's why I turned it _on_ by default in my tree ;)
> 
> So maybe Marcelo should apply this patch, and also turn it on by default.

Hhhmm, not so easy I guess. What about the added overhead of 
lru_cache_add() for every anonymous page created? 

I bet this will cause problems for users which are happy with the current 
behaviour. Wont it?

Andrea, do you have any numbers (or at least estimates) for the added
overhead of instantly addition of anon pages to the LRU? That would be
cool to know.

> > There are workloads where adding anonymous pages to the lru is
> > suboptimal for both the vm (cache shrinking) and the fast path too
> > (lru_cache_add), not sure how 2.6 optimizes those bits, since with 2.6
> > you're forced to add those pages to the lru somehow and that implies
> > some form of locking.
> 
> Basically a bunch of tweeaks:
> 
> - Per-zone lru locks (which implicitly made them per-node)
> 
> - Adding/removing sixteen pages for one taking of the lock.
> 
> - Making the lock irq-safe (it had to be done for other reasons, but
>   reduced contention by 30% on 4-way due to not having a CPU wander off to
>   service an interrupt while holding a critical lock).
> 
> - In page reclaim, snip 32 pages off the lru completely and drop the
>   lock while we go off and process them.

Obviously we dont have, and dont want to, such things in 2.4.

Anyway, it seems this discussion is being productive. Glad!


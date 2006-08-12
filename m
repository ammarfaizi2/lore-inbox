Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWHLReZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWHLReZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWHLReZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:34:25 -0400
Received: from [213.46.243.16] ([213.46.243.16]:11084 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932296AbWHLReY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:34:24 -0400
Subject: Re: [RFC][PATCH 0/4] VM deadlock prevention -v4
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
In-Reply-To: <33471.81.207.0.53.1155401489.squirrel@81.207.0.53>
References: <20060812141415.30842.78695.sendpatchset@lappy>
	 <33471.81.207.0.53.1155401489.squirrel@81.207.0.53>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 19:33:34 +0200
Message-Id: <1155404014.13508.72.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 18:51 +0200, Indan Zupancic wrote:
> On Sat, August 12, 2006 16:14, Peter Zijlstra said:
> > Hi,
> >
> > here the latest effort, it includes a whole new trivial allocator with a
> > horrid name and an almost full rewrite of the deadlock prevention core.
> > This version does not do anything per device and hence does not depend
> > on the new netdev_alloc_skb() API.
> >
> > The reason to add a second allocator to the receive side is twofold:
> > 1) it allows easy detection of the memory pressure / OOM situation;
> > 2) it allows the receive path to be unbounded and go at full speed when
> >    resources permit.
> >
> > The choice of using the global memalloc reserve as a mempool makes that
> > the new allocator has to release pages as soon as possible; if we were
> > to hoard pages in the allocator the memalloc reserve would not get
> > replenished readily.
> 
> Version 2 had about 250 new lines of code, while v3 has close to 600, when
> including the SROG code. And that while things should have become simpler.
> So why use SROG instead of the old alloc_pages() based code? And why couldn't
> you use a slightly modified SLOB instead of writing a new allocator?
> It looks like overkill to me.

Of the 611 new lines about 150 are new comments.

Simpler yes, but also more complete; the old patches had serious issues
with the alternative allocation scheme.

As for why SROG, because trying to stick all the semantics needed for
all skb operations into the old approach was nasty, I had it almost
complete but it was horror (and more code than the SROG approach).

Why not SLOB, well, I mistakenly assumed that it was a simpler SLAB
allocator, my bad. However after having had a quick peek at it; whereas
it seems similar in intent it does not provide the things I look for.
Making it so and keep the old semantics and make it compile along side
of SLAB will take quite some effort.






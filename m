Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVBUHL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVBUHL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 02:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVBUHL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 02:11:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:27339 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261909AbVBUHKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 02:10:14 -0500
Subject: Re: [PATCH 2/2] page table iterators
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, nickpiggin@yahoo.com.au,
       Andi Kleen <ak@suse.de>, davem@davemloft.net,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050220224022.5b5c4a09.akpm@osdl.org>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>
	 <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>
	 <20050217230342.GA3115@wotan.suse.de>
	 <20050217153031.011f873f.davem@davemloft.net>
	 <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>
	 <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
	 <20050220224022.5b5c4a09.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 18:09:43 +1100
Message-Id: <1108969783.5411.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-20 at 22:40 -0800, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > My opinion FWIW: I'm all for regularizing the pagetable loops to
> >  work the same way, changing their variables to use the same names,
> >  improving their efficiency; but I do like to see what a loop is up to.
> > 
> >  list_for_each and friends are very widely used, they're fine, and I'm
> >  quite glad to have their prefetching hidden away from me; but usually
> >  I groan, grin and bear it, each time someone devises a clever new
> >  for_each macro concealing half the details of some specialist loop.
> > 
> >  In a minority?
> 
> Of two.

Well, we basically have that bunch of loops that all do the same thing
to iterate the page tables. Only the inner part is different (that is
what is done on each PTE).

All of them are slightly differently implemented, some check overflow,
some don't, some have redudant checking, some aren't even consistent
between all 3/4 loops of a given walk routine set, and we have seen the
tendency to introduce subtle bugs in one of them when they all have to
be changed for some reason.

I'm all for turning them into something more consistent, and I like the
for_each_* idea...

It also allows to completely remove the code of the unused levels on 2
and 3 level page tables easily, regaining some of the perfs lost by the
move to 4 levels.

Now, we also need, in the long run, to improve perfs of walking the page
tables, especially PTEs, for things like tearing down processes or fork,
for example via a bitmap of used PGD entries etc... 

With proper iterators, such a thing could be implemented just by
modifying the iterator, and all loops would benefit from it.

I think that is enough to justify the move.

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVEMOgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVEMOgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVEMOgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:36:23 -0400
Received: from mail.suse.de ([195.135.220.2]:64980 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262388AbVEMOf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:35:58 -0400
Date: Fri, 13 May 2005 16:35:48 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tripperda@nvidia.com
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050513143548.GF16088@wotan.suse.de>
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <20050513132945.GB16088@wotan.suse.de> <1115994262.7129.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115994262.7129.22.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 07:24:22AM -0700, Dave Hansen wrote:
> On Fri, 2005-05-13 at 15:29 +0200, Andi Kleen wrote:
> > > : x86-64 will need updating to also take advantage of this.
> > >   It may be able to just copy the i386 includes as-is, I've
> > >   not looked closely at the PAT related changes on x86-64 yet. Andi?
> > > 
> > > : The list manipulation macros in mm/cachemap.c are a little fugly.
> > > 
> > > Anything else ?
> > 
> > For memory (pfn_valid == 1) it would be more memory efficient to use a few bits
> > in struct page->flags
> 
> I think page->flags use should be limited to things that are relatively
> performance-sensitive and arch-independent, mostly because we're running
> out of them on 32-bit platforms, fast.

That is mostly because we encode the zone number in there, which
never seemed like a particularly useful optimization to me (because
zone is not that expensive to recompute using a small hash table)
If the zone number was removed there would be plenty of bits.

There are 12 bits left  then, which is plenty.

In fact one bit is already reserved for PAT like this (PG_uncached),
PAT would probably only need another one so that write combining
can be expressed too. That could be even done without getting rid of the 
zone number.

> Each incremental use of page flags doesn't have any immediate storage
> cost, but it's a serious pain when we run out, and having to bloat it to
> a 64-bit value on 32-bit platforms wouldn't be very memory efficient,
> either. :)
> 
> > In general because there are lots of uses of "range lists" it would be better
> > to put it as a library into lib.
> 
> Either that, or something like "Dynamically allocated pageflags" would
> be nice.
> 
> 	http://lwn.net/Articles/124332/

Looks quite ugly and overkill.

-Andi

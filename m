Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSHGUdL>; Wed, 7 Aug 2002 16:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSHGUdJ>; Wed, 7 Aug 2002 16:33:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26888 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317347AbSHGUdB>;
	Wed, 7 Aug 2002 16:33:01 -0400
Message-ID: <3D518451.812ED63F@zip.com.au>
Date: Wed, 07 Aug 2002 13:34:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship> <E17cW1O-0003Tm-00@starship> <3D5177CB.D8CA77C2@zip.com.au> <E17cXFM-0004si-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Wednesday 07 August 2002 21:40, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > > What stands out for me is that rmap is now apparently at parity with
> > > (virtual scanning) 2.4.19 for a real application, i.e., parallel make.
> > > I'm sure we'll still see the raw setup/teardown overhead if we make a
> > > point of going looking for it, but it would be weird if we didn't.
> > >
> > > So can we tentatively declare victory of the execution overhead issue?
> >
> > err, no.  It's still adding half a millisecond or so to each fork/exec/exit
> > cycle.  And that is arising from, apparently, an extra two cache misses
> > per page.  Doubt if we can take this much further.
> 
> But that overhead did not show up in the kernel build timings you posted,
> which do a realistic amount of forking.  So what is the worry, exactly?

Compilation is compute-intensive, not fork-intensive.  Think shell
scripts, arch, forking servers, ...

> > > ...
> > > Vectoring up the pte chain nodes as
> > > you do here doesn't help much because the internal fragmentation
> > > roughly equals the reduction in link fields.
> >
> > Are you sure about that?  The vectoring is only a loss for very low
> > sharing levels, at which the space consumption isn't a problem anyway.
> > At high levels of sharing it's almost a halving.
> 
> Your vector will only be half full on average.

The vector at the head of the list is half full on average.  All the
other vectors in the chain are 100% full.  For the single-pte nodes,
Bill reported "the mean pte_chain length for chains of length > 1 is
around 6, and the std. dev. is around 12, and the distribution is *very*
long-tailed".   This is a good fit.

> ...
> > Is it useful to instantiate the swapped-in page into everyone's
> > pagetables, save some minor faults?
> 
> That's what I was thinking, then we just have to figure out how to find
> all those swapped-out ptes efficiently.

page->pte?

It may be a net loss for high sharing levels.  Dunno.

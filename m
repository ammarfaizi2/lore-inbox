Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284954AbRLMTUU>; Thu, 13 Dec 2001 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284967AbRLMTUK>; Thu, 13 Dec 2001 14:20:10 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:23053 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284954AbRLMTUA>; Thu, 13 Dec 2001 14:20:00 -0500
Message-ID: <3C18FF28.A531BDC4@zip.com.au>
Date: Thu, 13 Dec 2001 11:19:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Over-enthusiastic OOM killer.
In-Reply-To: <200112130734.fBD7YXU01306@penguin.transmeta.com> <Pine.LNX.4.33.0112131407250.28164-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Wed, 12 Dec 2001, Linus Torvalds wrote:
> 
> > >The oom killer just killed a bunch of processes on my workstation.
> > >What I don't understand, is why this was deemed necessary, when
> > >there was 400MB of buffer cache sitting around in memory, and 175MB
> > >of free swap space unused. (66mb of swap was used)
> >
> > Ehh.. I bet you didn't have free swap.
> 
> Difficult to say after the killing, but even if that were the case,
> why wasn't buffer cache pruned before the more drastic action ?
> 
> After the killing, there was 400MB of real memory, doing absolutely
> nothing but holding cached data.
> 

It's a well-known (?) bug in 2.4.17-pre VM.  Anon allocations are
going onto the inactive list, so the inactive list is hugely larger
than the active list.  So this expression in shrink_caches:

	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);	

Evaluates to sero all the time, so we never move any of the buffercache
pages onto the inactive list from where they can be freed.

It can be fixed with

	if (ratio == 0)
		ratio = nr_pages;

It can be fixed by putting anon pages onto the active list in
do_anonymous_page.

It can probably be fixed with Rik's remove-use-once patch.  I
haven't tested that.

It is fixed in the latest -aa patch.

The remaining minor detail is that it isn't fixed in Linux :(

-

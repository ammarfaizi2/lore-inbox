Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318308AbSGRT3D>; Thu, 18 Jul 2002 15:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318315AbSGRT3D>; Thu, 18 Jul 2002 15:29:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46978 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318308AbSGRT3C>; Thu, 18 Jul 2002 15:29:02 -0400
Date: Thu, 18 Jul 2002 15:35:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: Szakacsits Szabolcs <szaka@sienet.hu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027019414.1085.143.camel@sinai>
Message-ID: <Pine.LNX.3.95.1020718152142.1373B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2002, Robert Love wrote:

> On Thu, 2002-07-18 at 11:56, Richard B. Johnson wrote:
> 
> > What should have happened is each of the tasks need only about
> > 4k until they actually access something. Since they can't possibly
> > access everything at once, we need to fault in pages as needed,
> > not all at once. This is what 'overcomit' is, and it is necessary.
> 
> I should also mention this is demand paging, not overcommit.
> 
> Overcommit is the property of succeeded more allocations than their is
> memory in the address space.  The idea being that allocations are lazy,
> things often do not use their full allocations, etc. etc. as you
> mentioned.
> 
> It is typical a good thing since it lowers VM pressure.
> 
> It is not always a good thing, for numerous reasons, and it becomes
> important in those scenarios to ensure that all allocations can be met
> by the backing store and consequently we never find ourselves with more
> memory committed than available and thus never OOM.
> 
> This has nothing to do with paging and resource limits as you say.  Btw,
> without this it is possible to OOM any machine.  OOM is a by-product of
> allowing overcommit and poor accounting (and perhaps poor
> software/users), not an incorrectly configured machine.

It has everything to do with demand-paging. Since on single CPU
machines, there is only one task executing at any one time, that
single task can own and use every bit of RAM on the whole machine
is virtual memory works correctly. For performance reasons, it
may not actually use all the RAM but, in principle, it is possible.

If you don't allow that, the single task can use only the RAM that
was not allocated to other tasks. At the time an allocation is made,
the kernel cannot know what resources may be available when the task
requesting the allocation actually starts to use those allocated
resources. Instead, the kernel allocates resources based upon what
it 'knows' at the present time. Since it can't see the future anymore
than you or I, the fact that N processes just called exit() before
the requesting task touched a single page can't be known.

FYI multiple CPU machines have compounded the problems because there
can be several things happening at the same time. Although the MM
is locked so it's single-threaded, you have a before/after resource 
history condition that can't be anticipated.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbSLRVmg>; Wed, 18 Dec 2002 16:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbSLRVmg>; Wed, 18 Dec 2002 16:42:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60655 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267352AbSLRVme>;
	Wed, 18 Dec 2002 16:42:34 -0500
Message-ID: <3E00ED8A.B63B8A9D@mvista.com>
Date: Wed, 18 Dec 2002 13:50:02 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Korty <joe.korty@ccur.com>
CC: akpm@digeo.com, torvalds@transmeta.com, jim.houston@ccur.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] An O1, nonrecursive ID allocator for Posix timers
References: <200212181553.PAA04992@rudolph.ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> 
> Hi George, Andrew, Linus, Jim, Everyone,
> 
> This is a drop-in replacement for the ID allocator that Jim Houston
> wrote to support posix timers.  The inspiration for this came from
> Andrew Morton's desire for a recursion-free allocator; in addition I
> have made it O(1) while preserving the no-upper-limits-except-memory
> attribute of the original.
> 
> I (actually Jim) spot-tested this with Jim's posix timers patch as
> the base.  It passed a run of George's timers test suite
> (http://sourceforge.net/projects/high-res-timers) and the timer
> portion of the posix test suite (http://posixtest.sourceforge.net/).
> 
> To play with, apply Jim's posix timer patch to 2.5.51 and then delete
> 
>     kernel/id2ptr.c
>     include/linux/id2ptr.h
> 
> then apply this patch.
> 
> This procedure might also work against George's timers patch, as he is
> using the same ID allocator as Jim.
> 
> Jim's timer patch may be found at:
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=104006731324824&q=raw
> 
> George's timer patch may be found at:
>     http://sourceforge.net/projects/high-res-timers
> 
A few comments:

I have found that the locking needs on lookup require that
the object be locked before the id-look-up is unlocked. 
With out this it is possible to find an object and have it
"removed" by another prior to getting it locked.  This is
why, in my version, the lock is exported.  I am considering
removing the locking from the id code entirely.  The
radix-tree code does it this way.  Another issue with
locking is the irq required or not thing.  Irq locking is
VERY expensive and getting more so as cpu speeds go up and
I/O speeds stay the same.  If it is not needed, it is best
not to use it.  Again, exporting the locking to the caller
seems the best answer.

I would much prefer to return memory on release.  In my code
I currently only return the leaf nodes, but I consider this
something to be fixed rather than a feature.

While the code is order 1 it does do a divide which, as I
understand it, is rather expensive (risc machines do them
with subroutines).  It is rather easy to eliminate the
recursion in an radix-tree AND avoid the div at the same
time.

I would consider moving the "ctr" member to the root of the
tree and using the same one for all allocations.  I may be
wrong here, but I think it gives a better cycle time for the
bits used.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTDXS6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTDXS6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:58:50 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:1161 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S263802AbTDXS6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:58:48 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Apr 2003 15:10:09 -0400 (EDT)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: bob <bob@watson.ibm.com>, linux-kernel@vger.kernel.org
Subject: RE: [patch] printk subsystems
In-Reply-To: <3EA8336F.2000609@colorfullife.com>
References: <3EA8336F.2000609@colorfullife.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16040.13839.811454.16308@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul writes:
 > Robert wrote:
 > 
 > >There is both a qualitative difference and quantitative difference in a
 > >lockless algorithm as described versus one that uses locking.  Most
 > >importantly for Linux, these algorithms in practice have better performance
 > >characteristics.
 > >
 > Do you have benchmark numbers that compare "lockless" and locking 
 > algorithms on large MP systems?
 > 
 > For example, how much faster is one 'lock;cmpxchg' compared to 
 > 'spin_lock();if (x==var) var = y;spin_unlock();'.
 > 
 > So far I assumed that for spinlock that are only held for a few cycles, 
 > the cacheline trashing dominates, and not the spinning.
 > I've avoided to replace spin_lock+inc+spin_unlock with atomic_inc(). 
 > (Just look at the needed memory barriers: smp_mb__after_clear_bit & friends)
 > 
 > RCU uses per-cpu queues that are really lockless and avoid the cache 
 > trashing, that is a real win.
 > 
 > --
 >     Manfred
 > 

You're right in the common case - cache thrashing is definitely dominant
(though in K42 we've tried to be very careful to design code and data so
the last acquisition is almost always on the same processor).  The problem
arises is the process ever gets interrupted after spin_lock.  Then
performance falls of a cliff because everyone backs up for the lock.
That's what I had meant by in practice it works better.  From my experience
the OS likes to interrupt you in the place you least want :-).  I certainly
could point to lots of preemption numbers (which motivated the comment),
and though I'm sure there's the other, I don't know where offhand.

In some specific places it's probably all right to go with a spin lock, for
the logging/tracing code (which started this thread) that will be used
generically throughout the kernel by many callers, lockless is the way to
go.

-bob

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

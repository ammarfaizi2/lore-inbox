Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264621AbSIVXpM>; Sun, 22 Sep 2002 19:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264623AbSIVXpM>; Sun, 22 Sep 2002 19:45:12 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:58327 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S264621AbSIVXpL>; Sun, 22 Sep 2002 19:45:11 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Sep 2002 19:50:01 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: bob <bob@watson.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209230115270.3792-100000@localhost.localdomain>
References: <15758.19140.200081.346286@k42.watson.ibm.com>
	<Pine.LNX.4.44.0209230115270.3792-100000@localhost.localdomain>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15758.22032.784938.43647@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > On Sun, 22 Sep 2002, bob wrote:
 > 
 > > However, for sake of argument, the above is still not true.  A global
 > > lock has a different (worse) performance problem then the lock-free
 > > atomic operation even given a global queue.  The difference is 1) the
 > > Linux global lock is very expensive [... and interacts with potential
 > > other processes, [...]
 > 
 > huh? what is 'the Linux global lock'?

sorry - LTT just uses a global lock - but to do so it must disable
interrupts.  This is not a cheap operation.  With lockless code you do not
need to disable interrrupts (or grab a lock) -> many less cycles.

 > 
 > > [...] and 2) you have to hold the lock for the entire duration of
 > > logging the event; with the atomic operation you are finished once
 > > you've reserved you space. [...]
 > 
 > you dont have to hold the lock for the duration of saving the event, the
 > lock could as well protect a 'current entry' index. (Not that those 2-3
 > cycles saving off the event into a single cacheline counts that much ...)
 > 
 > the tail-atomic method is precisely equivalent to a global spinlock. The
 > tail of a global event buffer acts precisely as a global spinlock: if one
 > CPU writes to it in a stream then it performs okay, if two CPUs trace in
 > parallel then it causes cachelines to bounce like crazy.

If 2 cpus ping-pong back and forth there will be significant cache cost -
true, but the cost of having to acquire the lock (which also ping-pongs)
and disabling the interrupts, adds even more.  The additional cache line
ping pong for the lock (latency probably won't be hidden in fetching the
trace buffer data) plus the disabling interrupts still more than doubles
the cost.

-bob

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

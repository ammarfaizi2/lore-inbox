Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271235AbUJVLu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271235AbUJVLu1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271238AbUJVLu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:50:27 -0400
Received: from [213.85.13.118] ([213.85.13.118]:58496 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S271235AbUJVLuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:50:23 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16760.62448.307737.588876@gargle.gargle.HOWL>
Date: Fri, 22 Oct 2004 15:50:08 +0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
In-Reply-To: <20041022102210.GA21734@elte.hu>
References: <20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041021132717.GA29153@elte.hu>
	<4177FAB0.6090406@spymac.com>
	<20041021164018.GA11560@elte.hu>
	<16759.63466.507400.649099@thebsh.namesys.com>
	<20041022102210.GA21734@elte.hu>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > * Nikita Danilov <nikita@clusterfs.com> wrote:
 > 
 > >  > look but it doesnt seem simple to convert it. Reiserfs should really use
 > >  > a normal Linux waitqueue and nothing more...
 > > 
 > > Why? Condition variable is very well known and widely used concept. In
 > > the area of their applicability (where predicate whose change is
 > > waited upon is protected by a single lock) they provide clean and
 > > easily recognizable synchronization device.
 > 
 > sorry, but just look at the kcond code and compare the 'fastpath' with
 > say the fastpath of Linux semaphores or waitqueue handling.

Agree completely. kcond implementation is very inefficient. But it's
"obviously correct" at that. Idea was to optimize it later, when we
would have time for this. Didn't happen so far.
 
 > 
 > condition variables (here i dont mean your code specifically, but the
 > general pthread concept) are simply trying to achieve too much via a
 > single object, which increases their complexity quite significantly.

This is quite questionable. Where is this complexity? Standard condition
variable usage looks like

    spin_lock(&lock);
    while (!predicate)
        kcond_wait(&cond_var, &lock);
    /*
     * at this point predicate is true and @lock is held
     */

This can, of course, be implemented with wait-queues, but:

 - condition variables are used idiomatically, and hence, contain strong
   hint about what code tries to achieve.

 - their API is designed to match their (rather narrow) usage. For
   example, kcond_wait() takes lock as an argument and can (given proper
   debugging support in the spin-lock implementation) check that this lock
   is actually locked by the calling thread.

 > 
 > Separating out a few select atomic synchronization primitives that can
 > be used for each appropriate purpose does the job equally well.

Difference between a condition variable and "atomic synchronization
primitives" is like difference between a spin-lock and open-coded Dekker
algorithm: both provide you with mutual exclusion, but the former gives
one distinct clue about what is going on.

Umm... I have better example: every algorithm can be coded without loop
statements, with goto-s only. And (given proper programmer) goto
produces better assembly than while(). Does this constitutes an argument
in favor of throwing away all these wimpy loops that no Real Programmer
should use?

 > 
 > condition variables are fine if you 1) already know them from userspace
 > and 2) want to use a single locking abstraction for everything. It is
 > thus also a kitchen-sink primitive that is inevitably slow and complex.
 > I still have to see a locking problem where condvars are the
 > cleanest/simplest answer, and i've yet to see a locking problem where
 > condvars are not the slowest answer ;)

A kernel daemon that waits for some work to do is an example.

(And just to fight what seems to be common misconception: condition
variables were not introduced by POSIX committee, they are much older
than that. As all synchronization primitives they originate from the
kernel land.)

 > 
 > of course this too is valid kernel 

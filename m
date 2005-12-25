Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVLYXF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVLYXF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 18:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVLYXF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 18:05:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750966AbVLYXF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 18:05:59 -0500
Date: Sun, 25 Dec 2005 15:04:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: hch@infradead.org, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       arjanv@infradead.org, nico@cam.org, jes@trained-monkey.org,
       zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
       bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051225150445.0eae9dd7.akpm@osdl.org>
In-Reply-To: <200512251708.16483.zippel@linux-m68k.org>
References: <20051222114147.GA18878@elte.hu>
	<20051222153014.22f07e60.akpm@osdl.org>
	<20051222233416.GA14182@infradead.org>
	<200512251708.16483.zippel@linux-m68k.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> IMO there are still too many questions open, so I can understand Andrew. We 
> may only cover up the problem instead of fixing it. I understand that mutexes 
> have advantages, but if we compare them to semaphores it should be a fair 
> comparison, otherwise people start to think semaphores are something bad. The 
> majority of the discussion has been about microoptimisation, but on some 
> archs non-debug mutexes and semaphores may very well be the same thing.

Ingo has told me offline that he thinks that we can indeed remove the
current semaphore implementation.

90% of existing semaphore users get migrated to mutexes.

9% of current semaphore users get migrated to completions.

The remaining 1% of semaphore users are using the counting feature.  We
reimplement that in a mostly-arch-independent fashion and then remove the
current semaphore implementation.  Note that there are no sequencing
dependencies in all the above.

It's a lot of churn, but we'll end up with a better end result and a
somewhat-net-simpler kernel, so I'm happy.


One side point on semaphores and mutexes: the so-called "fast path" is
generally not performance-critical, because we just don't take them at high
frequencies.  Any workload which involves taking a semaphore at more than
50,000-100,000 times/second tends to have ghastly overscheduling failure
scenarios on SMP.  So people hit those scenarios and the code gets
converted to a lockless algorithm or to use spinlocking.

For example, for a while ext3/JBD was doing 200,000 context-switches per
second due to taking lock_super() at high frequencies.  When I converted
the whole fs to use spin locking throughout the performance in some
workloads went up by 1000%.

Another example: Ingo's VFS stresstest which is hitting i_sem hard: it only
does ~8000 ops/sec on an 8-way, and it's an artificial microbenchmark which
is _designed_ to hit that lock hard.  So if/when i_sem is converted to a
mutex, I figure that the benefits to ARM in that workload will be about a
0.01% performance increase.  ie: about two hours' worth of Moore's law in a
dopey microbenchmark.

For these reasons, I think that with sleeping locks, the fastpath is
realtively unimportant.  What _is_ important is not screwing up the
slowpath and not taking the lock at too high a frequency.  Because either
one will cause overscheduling which is a grossly worse problem.

Also, there's very little point in adding lots of tricky arch-dependent
code and generally mucking up the kernel source to squeeze the last drop of
performance out of the sleeping lock fastpath.  Because if those changes
actually make a difference, we've already lost - the code needs to be
changed to use spinlocking.

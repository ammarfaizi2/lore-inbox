Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVLZKhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVLZKhC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 05:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVLZKhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 05:37:02 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751016AbVLZKhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 05:37:00 -0500
Date: Mon, 26 Dec 2005 02:35:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: zippel@linux-m68k.org, hch@infradead.org, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       arjanv@infradead.org, nico@cam.org, jes@trained-monkey.org,
       zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
       bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051226023549.f46add77.akpm@osdl.org>
In-Reply-To: <20051225232222.GA11828@elte.hu>
References: <20051222114147.GA18878@elte.hu>
	<20051222153014.22f07e60.akpm@osdl.org>
	<20051222233416.GA14182@infradead.org>
	<200512251708.16483.zippel@linux-m68k.org>
	<20051225150445.0eae9dd7.akpm@osdl.org>
	<20051225232222.GA11828@elte.hu>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > One side point on semaphores and mutexes: the so-called "fast path" is 
> > generally not performance-critical, because we just don't take them at 
> > high frequencies.  Any workload which involves taking a semaphore at 
> > more than 50,000-100,000 times/second tends to have ghastly 
> > overscheduling failure scenarios on SMP.  So people hit those 
> > scenarios and the code gets converted to a lockless algorithm or to 
> > use spinlocking.
> > 
> > For example, for a while ext3/JBD was doing 200,000 context-switches 
> > per second due to taking lock_super() at high frequencies.  When I 
> > converted the whole fs to use spin locking throughout the performance 
> > in some workloads went up by 1000%.
> 
> actually, i'm 99.9% certain [ ;-) ] that all that ext3 spinlock 
> conversion pain could have been avoided by converting ext3 to the mutex 
> code. Mutexes definitely do not overschedule, even in very high 
> frequency lock/unlock scenarios. They behave and perform quite close to 
> spinlocks. (which property is obviously a must for the -rt kernel, where 
> all spinlocks, rwlocks, seqlocks, rwsems and semaphores are mutexes - 
> providing a big playground for locking constructs)

hm.  16 CPUs hitting the same semaphore at great arrival rates.  The cost
of a short spin is much less than the cost of a sleep/wakeup.  The machine
was doing 100,000 - 200,000 context switches per second.

> hm, can you see any easy way for me to test my bold assertion on ext3, 
> by somehow moving/hacking it back to semaphores?

Not really.  The problem was most apparent after the lock_kernel() removal
patches.  The first thing a CPU hit when it entered the fs was previously
lock_kernel().  That became lock_super() and performance went down the
tubes.  From memory, the bad kernel was tip-of-tree as of Memorial Weekend
2003 ;)

I guess you could re-add all the lock_super()s as per 2.5.x's ext3/jbd,
check that it sucks running SDET on 8-way then implement the lock_super()s
via a mutex.

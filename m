Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVLYXXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVLYXXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 18:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVLYXXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 18:23:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:19402 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750971AbVLYXXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 18:23:16 -0500
Date: Mon, 26 Dec 2005 00:22:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051225232222.GA11828@elte.hu>
References: <20051222114147.GA18878@elte.hu> <20051222153014.22f07e60.akpm@osdl.org> <20051222233416.GA14182@infradead.org> <200512251708.16483.zippel@linux-m68k.org> <20051225150445.0eae9dd7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225150445.0eae9dd7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> One side point on semaphores and mutexes: the so-called "fast path" is 
> generally not performance-critical, because we just don't take them at 
> high frequencies.  Any workload which involves taking a semaphore at 
> more than 50,000-100,000 times/second tends to have ghastly 
> overscheduling failure scenarios on SMP.  So people hit those 
> scenarios and the code gets converted to a lockless algorithm or to 
> use spinlocking.
> 
> For example, for a while ext3/JBD was doing 200,000 context-switches 
> per second due to taking lock_super() at high frequencies.  When I 
> converted the whole fs to use spin locking throughout the performance 
> in some workloads went up by 1000%.

actually, i'm 99.9% certain [ ;-) ] that all that ext3 spinlock 
conversion pain could have been avoided by converting ext3 to the mutex 
code. Mutexes definitely do not overschedule, even in very high 
frequency lock/unlock scenarios. They behave and perform quite close to 
spinlocks. (which property is obviously a must for the -rt kernel, where 
all spinlocks, rwlocks, seqlocks, rwsems and semaphores are mutexes - 
providing a big playground for locking constructs)

hm, can you see any easy way for me to test my bold assertion on ext3, 
by somehow moving/hacking it back to semaphores? I could then apply the 
MUTEX_DEBUG_FULL mechanism to it and redo those ext3 semaphore vs.  
spinlock benchmarks on a couple of boxes, and add a mutex column to the 
table of numbers.

also, often it's simpler to use a sleeping lock than to use a spinlock 
for something, so we want to have that option open.

	Ingo

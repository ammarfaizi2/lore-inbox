Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266826AbSKHRcO>; Fri, 8 Nov 2002 12:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266829AbSKHRcN>; Fri, 8 Nov 2002 12:32:13 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:17935
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S266826AbSKHRbp>; Fri, 8 Nov 2002 12:31:45 -0500
Subject: Re: [Linux-ia64] reader-writer livelock problem
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       linux-ia64@linuxia64.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au,
       dhowells@redhat.com, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.44.0211080918220.4298-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211080918220.4298-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1036777105.13021.13.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.90 (Preview Release)
Date: 08 Nov 2002 09:38:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-08 at 09:25, Linus Torvalds wrote:
> There's another reason for not doing it that way: allowing readers to keep 
> interrupts on even in the presense of interrupt uses of readers.
> 
> If you do the "pending writes stop readers" approach, you get
> 
> 		cpu1			cpu2
> 
> 		read_lock() - get
> 
> 					write_lock_irq() - pending
> 
> 		irq happens
> 		 - read_lock() - deadlock
> 
> and that means that you need to make readers protect against interrupts 
> even if the interrupts only read themselves.

Even without interrupts that would be a bug.  It isn't ever safe to
attempt to retake a read lock if you already hold it, because you may
deadlock with a pending writer.  Fair multi-reader locks aren't
recursive locks.

> NOTE! I'm not saying the existing practice is necessarily a good tradeoff,
> and maybe we should just make sure to find all such cases and turn the
> read_lock() calls into read_lock_irqsave() and then make the rw-locks
> block readers on pending writers. But it's certainly more work and cause
> for subtler problems than just naively changing the rw implementation.

Yes, I'd agree.  It would definitely be a behavioural change with
respect to the legality of retaking a lock for reading, which would
probably be quite irritating to find (since they'd only cause a problem
if they actually coincide with an attempted write lock).

> Actually, giving this som emore thought, I really suspect that the
> simplest solution is to alloc a separate "fair_read_lock()", and paths
> that need to care about fairness (and know they don't have the irq
> issue)  
> can use that, slowly porting users over one by one...

Do you mean have a separate lock type, or have two different read_lock
operations on the current type?

	J


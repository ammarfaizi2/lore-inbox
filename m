Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266816AbSKHRTg>; Fri, 8 Nov 2002 12:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266817AbSKHRTg>; Fri, 8 Nov 2002 12:19:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14596 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266816AbSKHRTf>; Fri, 8 Nov 2002 12:19:35 -0500
Date: Fri, 8 Nov 2002 09:25:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       <linux-ia64@linuxia64.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       <rusty@rustcorp.com.au>, <dhowells@redhat.com>, <mingo@elte.hu>
Subject: Re: [Linux-ia64] reader-writer livelock problem
In-Reply-To: <1036775624.13021.3.camel@ixodes.goop.org>
Message-ID: <Pine.LNX.4.44.0211080918220.4298-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Nov 2002, Jeremy Fitzhardinge wrote:
> 
> The normal way of solving this fairness problem is to make pending write
> locks block read lock attempts, so that the reader count is guaranteed
> to drop to zero as read locks are released.  I haven't looked at the
> Linux implementation of rwlocks, so I don't know how hard this is to
> do.  Or perhaps there's some other reason for not implementing it this
> way?

There's another reason for not doing it that way: allowing readers to keep 
interrupts on even in the presense of interrupt uses of readers.

If you do the "pending writes stop readers" approach, you get

		cpu1			cpu2

		read_lock() - get

					write_lock_irq() - pending

		irq happens
		 - read_lock() - deadlock

and that means that you need to make readers protect against interrupts 
even if the interrupts only read themselves.

NOTE! I'm not saying the existing practice is necessarily a good tradeoff,
and maybe we should just make sure to find all such cases and turn the
read_lock() calls into read_lock_irqsave() and then make the rw-locks
block readers on pending writers. But it's certainly more work and cause
for subtler problems than just naively changing the rw implementation.

		Linus


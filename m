Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264261AbSIQQM5>; Tue, 17 Sep 2002 12:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264297AbSIQQM5>; Tue, 17 Sep 2002 12:12:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264261AbSIQQM4>; Tue, 17 Sep 2002 12:12:56 -0400
Date: Tue, 17 Sep 2002 09:18:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <Pine.LNX.4.44.0209171750140.4094-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209170911230.4253-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Sep 2002, Ingo Molnar wrote:
> 
> this test is cheaper than a function call.

Ehh.. On most architectures an unconditional direct function call is
_faster_ than a conditional test that does not predict all that well. So
the "test is faster than a function call" is not a very good optimization,
I suspect.

In fact, we'd probably be better off trying to factor out more out of 
schedule() rather than making it even bigger. We've done that before: the 
timeout stuff was done that way, and meant that normal reschedules no 
longer need to care about timeouts. That made things simpler.

On the other hand, we do have other ways to test the preempt count inside
the scheduler. In particular, we might just move the "in_atomic()" check a
few lines downwards, at which point we've released the kernel lock and
explicitly disabled preemption, so at that point the test should be even
simpler with fewer conditionals..

		Linus


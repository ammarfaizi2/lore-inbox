Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263649AbSIQFub>; Tue, 17 Sep 2002 01:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263658AbSIQFub>; Tue, 17 Sep 2002 01:50:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263649AbSIQFua>; Tue, 17 Sep 2002 01:50:30 -0400
Date: Mon, 16 Sep 2002 22:56:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032220689.1203.85.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209162250170.3443-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Sep 2002, Robert Love wrote:
> 
> I was this -> <- close to celebrating.  Not so fast, smarty.

You forget - I'm not only a smarty, I'm sick and twisted too.

> What about release_kernel_lock() ?
> 
> It sees task->lock_depth>=0 and calls spin_unlock() on a lock that it
> does not hold.

We have a simple rule:
 - task->lock_depth = -1 means "no lock held"
 - task->lock_depth >= 0 means "BKL really held"

... but what does "task->lock_depth < -1" mean?

Yup: "validly nonpreemptable".

So then you have:

	#define kernel_locked()	(current->lock_depth >= 0)

	#define in_atomic() (preempt_count() & ~PREEMPT_ACTIVE) != (current->lock_depth != -1))

and you're all set - just set lock_depth to -2 when you exit to show that
you don't hold the BKL, but that you are validly not preemtable.

I get the award for having the most disgusting ideas.

		Linus "but it works and is efficient" Torvalds


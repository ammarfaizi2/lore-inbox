Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264363AbRFGIMr>; Thu, 7 Jun 2001 04:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264364AbRFGIM2>; Thu, 7 Jun 2001 04:12:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22021 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264363AbRFGIMR>; Thu, 7 Jun 2001 04:12:17 -0400
Date: Thu, 7 Jun 2001 01:11:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <m13d9c68j5.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.21.0106070109210.5128-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Jun 2001, Eric W. Biederman wrote:

> torvalds@transmeta.com (Linus Torvalds) writes:
> > 
> > Somebody interested in trying the above add? And looking for other more
> > obvious bandaid fixes.  It won't "fix" swapoff per se, but it might make
> > it bearable and bring it to the 2.2.x levels. 
> 
> At little bit.  The one really bad behavior of not letting any other
> processes run seems to be fixed with an explicit:
> if (need_resched) {
>         schedule();
> }
> 
> What I can't figure out is why this is necessary.  Because we should
> be sleeping in alloc_pages if nowhere else.

No - I suspect that we're not actually doing all that much IO at all, and
the real reason for the lock-up is just that the current algorithm is so
bad that when it starts to act exponentially worse it really _is_ taking
minutes of CPU time following pointers and generally not being very nice
on the CPU cache etc..

The bulk of the work is walking the process page tables thousands and
thousands of times. Expensive.

> If this is going on I think we need to look at our delayed
> deallocation policy a little more carefully.

Agreed. I already talked in private with some people about just
re-visiting the issue of the lazy de-allocation. It has nice properties,
but it certainly appears as if the nasty cases just plain outweigh the
advantages.

		Linus


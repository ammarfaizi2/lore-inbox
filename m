Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263569AbTIBHv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 03:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbTIBHv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 03:51:59 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:22401 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S263599AbTIBHv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 03:51:56 -0400
Date: Tue, 2 Sep 2003 16:54:24 +0900
From: Tejun Huh <tejun@aratech.co.kr>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tejun Huh <tejun@aratech.co.kr>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Race condition in del_timer_sync (2.5)
Message-ID: <20030902075423.GA4640@atj.dyndns.org>
References: <20030902025927.GA12121@atj.dyndns.org> <Pine.LNX.4.56.0309020820330.3654@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0309020820330.3654@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 08:33:50AM +0200, Ingo Molnar wrote:
> 
> On Tue, 2 Sep 2003, Tejun Huh wrote:
> 
> >  This patch fixes a race between del_timer_sync and recursive timers.
> > Current implementation allows the value of timer->base that is used for
> > timer_pending test to be fetched before finishing running_timer test, so
> > it's possible for a recursive time to be pending after del_timer_sync.  
> > Adding smp_rmb before timer_pending removes the race.
> 
> good catch. Have you ever trigger this bug, or did you find it via code
> review?

 I found it via code review.  Actually, I haven't succeeded to boot
even once with 2.5 on my test box.  It prints a lot of messages about
scheduling while atomic and eventually panics.  I'm trying to identify
what's causing the problem.  Wish me luck. :-)

> just to explore the scope of this problem a bit more: at first glance all
> other timer_pending() uses seem to be safe. del_timer_sync()'s
> timer_pending() use is special, because it's next to the ->running_timer
> check without any barriers inbetween - so we could indeed in theory end up
> with having the two reads reordered and a freshly added timer (on another
> CPU) not being recognized properly. Also, this is the only timer API call
> that guarantees the complete stopping of a timer.
> 
> 	Ingo

 Yeap, in other cases, when timer_pending() fails to see timer->base,
it can be thought as the test took place before the timer is added,
and leaving pending timer behind is semantically ok.  But because a
recusive timer without some other entity trying to add it should
actually be removed by timer_del_sync(), timer_pending() test should
be barriered from running_timer test.

 I'll submit the patch to Linus soon.

-- 
tejun


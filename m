Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbRFGQq6>; Thu, 7 Jun 2001 12:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261969AbRFGQqs>; Thu, 7 Jun 2001 12:46:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14637 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261968AbRFGQqj>; Thu, 7 Jun 2001 12:46:39 -0400
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
	<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com>
	<m1wv6p5uqp.fsf@frodo.biederman.org> <3B1EA748.6B9C1194@sgi.com>
	<m1g0dc6blz.fsf@frodo.biederman.org> <3B1F9CEC.928C8E66@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2001 10:42:55 -0600
In-Reply-To: <3B1F9CEC.928C8E66@sgi.com>
Message-ID: <m1ofs044xc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh <law@sgi.com> writes:

>     Now for whatever reason, since 2.4, I consistently use at least
> a few Mb of swap -- stands at 5Meg now.  Weird -- but I notice things
> like nscd running 7 copies that take 72M.  Seems like overkill for
> a laptop.

So the question becomes why you are seeing an increased swap usage.
Currently there are two canidates in the 2.4.x code path.

1) Delayed swap deallocation, when a program exits after it
   has gone into swap it's swap usage is not freed. Ouch.

2) Increased tenacity of swap caching.  In particular in 2.2.x if a page
   that was in the swap cache was written to the the page in the swap
   space would be removed.  In 2.4.x the location in swap space is
   retained with the goal of getting more efficient swap-ins.

Neither of the known canidates from increasing the swap load applies
when you aren't swapping in the first place.  They may aggrevate the
usage of swap when you are already swapping but they do not cause
swapping themselves.  This is why the intial recommendation for
increased swap space size was made.  If you are swapping we will use
more swap.

However what pushes your laptop over the edge into swapping is an
entirely different question.  And probably what should be solved.

>     I think that is the point -- it was supported in 2.2, it is, IMO,
> a serious regression that it is not supported in 2.4.

The problem with this general line of arguing is that it lumps a whole
bunch of real issues/regressions into one over all perception.  Since
there are multiple reasons people are seeing problems, they need to be
tracked down with specifics.

The swapoff case comes down to dead swap pages in the swap cache.
Which greatly increases the number of swap pages slows the system
down, but since these pages are trivial to free we don't generate any
I/O so don't wait for I/O and thus never enter the scheduler.  Making
nothing else in the system runnable.

Your case is significantly different.  I don't know if you are seeing 
any issues with swapping at all.  With a 5M usage it may simply be
totally unused pages being pushed out to the swap space.

Eric

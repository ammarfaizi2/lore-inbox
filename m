Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbRFGUuD>; Thu, 7 Jun 2001 16:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263127AbRFGUtx>; Thu, 7 Jun 2001 16:49:53 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:7713 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S263123AbRFGUtm>; Thu, 7 Jun 2001 16:49:42 -0400
Message-ID: <3B1FE85D.F7BE88F4@sgi.com>
Date: Thu, 07 Jun 2001 13:47:25 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
		<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com>
		<m1wv6p5uqp.fsf@frodo.biederman.org> <3B1EA748.6B9C1194@sgi.com>
		<m1g0dc6blz.fsf@frodo.biederman.org> <3B1F9CEC.928C8E66@sgi.com> <m1ofs044xc.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> LA Walsh <law@sgi.com> writes:
>
> >     Now for whatever reason, since 2.4, I consistently use at least
> > a few Mb of swap -- stands at 5Meg now.  Weird -- but I notice things
> > like nscd running 7 copies that take 72M.  Seems like overkill for
> > a laptop.
>
> So the question becomes why you are seeing an increased swap usage.
> Currently there are two canidates in the 2.4.x code path.
>
> 1) Delayed swap deallocation, when a program exits after it
>    has gone into swap it's swap usage is not freed. Ouch.

---
    Double ouch.  Swap is backing a non-existent program?

>
>
> 2) Increased tenacity of swap caching.  In particular in 2.2.x if a page
>    that was in the swap cache was written to the the page in the swap
>    space would be removed.  In 2.4.x the location in swap space is
>    retained with the goal of getting more efficient swap-ins.

----
    But if the page in memory is 'dirty', you can't be efficient with swapping
*in* the page.  The page on disk is invalid and should be released, or am I
missing something?

> Neither of the known canidates from increasing the swap load applies
> when you aren't swapping in the first place.  They may aggrevate the
> usage of swap when you are already swapping but they do not cause
> swapping themselves.  This is why the intial recommendation for
> increased swap space size was made.  If you are swapping we will use
> more swap.
>
> However what pushes your laptop over the edge into swapping is an
> entirely different question.  And probably what should be solved.

----
    On my laptop, it is insignificant and to my knowledge has no measurable
impact.  It seems like there is always 3-5 Meg used in swap no matter what's
running (or not) on the system.

> >     I think that is the point -- it was supported in 2.2, it is, IMO,
> > a serious regression that it is not supported in 2.4.
>
> The problem with this general line of arguing is that it lumps a whole
> bunch of real issues/regressions into one over all perception.  Since
> there are multiple reasons people are seeing problems, they need to be
> tracked down with specifics.

---
    Uhhh, yeah, sorta -- it's addressing the statement that a "new requirement of
2.4 is to have double the swap space".  If everyone agrees that's a problem, then
yes, we can go into specifics of what is causing or contributing to the problem.
It's getting past the attitude of some people that 2xMem for swap is somehow
'normal and acceptable -- deal with it".  In my case, seems like 10Mb of swap would
be all that would generally be used (I don't think I've ever seen swap usage over 7Mb)
on a 512M system.  To be told "oh, your wrong, you *should* have 1Gig or you are
operating in an 'unsupported' or non-standard configuration".  I find that very
user-unfriendly.


>
> The swapoff case comes down to dead swap pages in the swap cache.
> Which greatly increases the number of swap pages slows the system
> down, but since these pages are trivial to free we don't generate any
> I/O so don't wait for I/O and thus never enter the scheduler.  Making
> nothing else in the system runnable.

---
    I haven't ever *noticed* this on my machine but that could be
because there isn't much in swap to begin with?  Could be I was
just blissfully ignorant of the time it took to do a swapoff.
Hmmm....let's see...  Just tried it.  I didn't get a total lock up,
but cursor movement was definitely jerky:
> time sudo swapoff -a

real    0m10.577s
user    0m0.000s
sys     0m9.430s

Looking at vmstat, the needed space was taken mostly out of the
page cache (86M->81.8M) and about 700K each out of free and buff.


> Your case is significantly different.  I don't know if you are seeing
> any issues with swapping at all.  With a 5M usage it may simply be
> totally unused pages being pushed out to the swap space.

---
    Probably -- I guess the page cache and disk buffers put enough pressure to
push some things off to swap.

-linda
--
The above thoughts and       | They may have nothing to do with
writings are my own.         | the opinions of my employer. :-)
L A Walsh                    | Senior MTS, Trust Tech, Core Linux, SGI
law@sgi.com                  | Voice: (650) 933-5338



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVLHPq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVLHPq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVLHPq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:46:26 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:4994 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751194AbVLHPqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:46:25 -0500
Message-ID: <4398548F.3050308@andrew.cmu.edu>
Date: Thu, 08 Dec 2005 10:43:11 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: David Lang <david.lang@digitalinsight.com>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz> <Pine.LNX.4.61.0512021124360.1609@scrub.home> <4396ACF5.3050204@andrew.cmu.edu> <Pine.LNX.4.61.0512071319320.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0512071319320.1609@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> You analogy is wrong: Thomas and Ingo spread flyer for "free food", above 
> is my frustration about all the people wanting free food.

New features or functionality have to be motivated by looking at the 
benefits vs cost.  I thought Thomas laid out a pretty good argument in 
his first email, and I don't believe either he or Ingo are claiming 
their approach is completely without cost.  Those of us who are "wanting 
free food" mostly just want a clean and acceptable hrtimer implementation.

Hrtimers is a feature that has been a very long time in coming; I first 
needed to make an application that ran at a fixed 30Hz in 1999, which 
was only possible with high variance per frame due to the 10 msec sleep 
resolution.  That mostly went away with HZ=1000 in 2.6, but is now back 
again since a given linux kernel can choose HZ={100,250} (across arches, 
one could never assume HZ=1000 anyway).  I find it unfortunate that in 
2005, it is still more accurate to sleep on Linux using serial port 
writes and flushes than with nanosleep.  Yes, there is rtc on some 
machines, but many distributions don't allow users to access it by 
default (I'm guessing they have a reason for that).  So, the benefit is 
clear for anyone doing media programming or emulating media devices. 
That leaves the technical side, which is making sure the implementation 
is right.

The discussion on ktimers unfortunately strayed from the technical very 
early on, and I think that has left people in bad moods all the way 
until now.  To the extent that the discussion was technical however, I 
think it has been worthwhile.  The implementation continues to improve.

>>You've brought up the fact that networking shouldn't use lots of timers
>>several times in the overall discussion.  If you know how to do this, I'm sure
>>you can start sending patches to netdev and show them all how stupid they've
>>been all along.  However, more likely you'll just find out that just maybe the
>>networking people really *have* thought about the problem, and the solution
>>they came up with is actually a pretty good one.
>>
>>At any rate, while you fix up all those "timer-abusing" subsystems throughout
>>the kernel, can we just try to improve the timer system in the meantime?
> 
> James, after giving me a rhetoric lesson you maybe should be a bit more
> careful with your own rhetoric. What kind of answer do you expect after 
> insulting me?

It's not an insult if you truly believe you are right, and 30 years of 
unix network stack designs are wrong.  Please consider that your 
comments might be insulting the people who worked for years to get the 
Linux network stack to the point where it was able to saturate GbE 
cards.  I'd imagine there isn't too much low-hanging fruit left, and to 
assume they are being wasteful with resources comes across as a little 
arrogant.  But again, if they are wrong, by all means demonstrate it 
with concrete examples and patches, and we will all benefit in the end.

> The short version is that I didn't bring up the network timer problem, I 
> only made a suggestions how it could be solved, but nobody followed me up 
> on it, so I guess the problem wasn't really that big. Please check the 
> archives for details.

I was reading then.  Your solution, IIRC, was to use a coarse periodic 
timer to handle multiple network timeouts together.  I'd expect we'd end 
up keeping track of the separate events somehow, probably on a list.  In 
that case I don't see the advantage compared to using the timer wheel, 
which is also just list manipulation in the common case, as you have 
already pointed out.  The coarse periodic timer would get the benefit of 
better batching though; Right now the timer wheel already batches, but 
based on jiffy resolution.  Realistically though, the networking people 
have RFCs to follow, hardware timing, and many other constraints to 
worry about, so we are just hand-waving without knowing more.

One of the things that ktimers enables is moving timers with sub-10ms 
resolution requirements off of the wheel, which would allow us to make 
the timer wheel coarser, saving either memory or processing time.  This 
would get the benefits of a specialized coarse network timer such as the 
approach you proposed, but without requiring the networking code to 
reimplement the timer wheel.  The coarse timer wheel for the 
low-resolution timers may even make up for the extra processing overhead 
of putting hrtimers on an rbtree; On a typical system I would expect 
coarse timers (timeouts) to far outnumber hrtimers.  Time will tell I guess.

So, let's try to keep focused on the real technical impediments, and 
we'll achieve the best end result.

  - Jim Bruce

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030695AbWHILaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030695AbWHILaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030696AbWHILaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:30:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14725 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030695AbWHILaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:30:06 -0400
Date: Wed, 9 Aug 2006 13:29:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Steven Rostedt <rostedt@goodmis.org>
cc: David Miller <davem@davemloft.net>, tytso@mit.edu, mchan@broadcom.com,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
In-Reply-To: <Pine.LNX.4.58.0608081819300.18586@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0608091252190.6762@scrub.home>
References: <Pine.LNX.4.58.0608070124340.15870@gandalf.stny.rr.com>
 <20060806.231846.71090637.davem@davemloft.net> <Pine.LNX.4.58.0608080819080.7917@gandalf.stny.rr.com>
 <20060808.150006.48399434.davem@davemloft.net>
 <Pine.LNX.4.58.0608081819300.18586@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Aug 2006, Steven Rostedt wrote:

> OK, but still, if it is expected to expire, which this one is, then it
> should be converted to a hrtimer, instead of a normal timer.  The hrtimers
> were introduced to make it more efficient for expiring timers.  Well, they
> really were introduced for high resolution, but in order to do that the
> expiring timer implementation needed to be improved.  The timer wheel is
> most efficient for those timers that are not expected to time out
> (probably what a watchdog timer would actually do, so my terminology was
> really incorrect).
> 
> The timer wheel is O(1) in removing and adding a timer, but can be O(n)
> if the timers cascade (which would happen when a timer moves to expire).
> 
> The hrtimers are O(1) in expiring but O(log n) on adding and removing. So
> they are better to use when you know that the timer will expire.

Can we please, please, please stop with this? While this is correct, it's 
only rarely relevant for most users. The cascading is really not as bad 
it's always represented here.
You need a huge amount of timers pending to run into trouble and at this 
point hrtimers won't behave much better. In this case it's better to do 
what Dave suggested - use a single continous timer and vector off the 
needed work from there.
The primary reason to use hrtimers should only be whether or not the high 
resolution is needed. hrtimer can have a significant higher fixed cost 
(due to a possibly expensive get_time() operation), so one should be a 
little careful with them. Possible problems in any of the timer systems 
should hardly be a concern for most users of it, at the point the timer 
system can't handle this many timers, we should rather look at the user 
and fix the problem there.

bye, Roman

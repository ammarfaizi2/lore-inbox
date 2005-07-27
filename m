Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVG0WbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVG0WbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVG0WbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:31:04 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:25305 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261202AbVG0W3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:29:25 -0400
Date: Wed, 27 Jul 2005 15:29:14 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
Message-ID: <20050727222914.GB3291@us.ibm.com>
References: <1122078715.5734.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain> <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain> <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507232151150.3743@scrub.home>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2005 [22:12:30 +0200], Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Jul 2005, Nishanth Aravamudan wrote:
> 
> > > Jiffies are the basic time unit for kernel timers, hiding that fact gives 
> > > users only wrong expectations about them.
> > 
> > We already have msleep() and msleep_interruptible(), which hide jiffies
> > in milliseconds. These interfaces are their parallel in the wait-queue
> > case. If you don't want to use them, or their use is not appropriate,
> > then the callers won't be changed.
> 
> I'm not exactly impressed with their implementation, it's completely silly 
> that there is no such convience function based on jiffies, e.g. if you 
> look at the msleep_interruptible(), you'll find quite a few 
> "msleep_interruptible(jiffies_to_msecs())".

Patches are welcome, I guess :)

> msleep_interruptible() is especially bad as there are a few users who 
> check the return value and since it adds one to the timeout, you can 
> create loops which may never timeout (as e.g. in drivers/w1/w1_therm.c: 
> w1_therm_read_bin()), this is nice example of a bad interface.
> 
> These two function should actually look like this:
> 
> static inline void msleep(unsigned int msecs)
> {
> 	sleep(msecs_to_jiffies(msecs));
> }
> 
> static inline int msleep_interruptible(unsigned int msecs)
> {   
> 	sleep_interruptible(msecs_to_jiffies(msecs)) != 0;
> }

Where are sleep() and sleep_interruptible() defined? And this basically
pushes down the identical implementation a layer, correct? Finally, you
cannot simply do msecs_to_jiffies() in the caller of
sleep{,_interruptible()}, unless sleep{,_interruptible()} add 1 to every
request themselves. The basic issue is that with jiffies and ticks being
identical, there is no concept of the inter-tick position (i.e., a
sub-jiffy value), and the callers of these conversion functions *must*
assume they are going to be added to the timer subsystem immediately
before a timer interrupt occurs. An entire tick has not elapsed, but if
the caller had not added 1, then we could potentially go off almost an
entire tick early. The +1 is basically specifying we are asking to add
our delay to the *next* tick.

> > My goal is to distinguish between these cases in sleeping-logic:
> > 
> > 1) tick-oriented
> > 	use schedule_timeout(), add_timer(), etc.
> > 
> > 2) time-oriented
> > 	use schedule_timeout_msecs()
> 
> There is _no_ difference, the scheduler is based on ticks. Even if we soon 
> have different time sources, the scheduler will continue to measure the 
> time in ticks and for a simple reason - portability. Jiffies _are_ simple, 
> don't throw that away.

I agree that from an internal perspective there is no difference, but
from an *interface* perspective they are hugely different, simply on the
basis that one uses human-time units and one does not.

I guess we must continue to agree to disagree.

I am still waiting for some feedback from Andrew if he would prefer a
jiffy-only version or both the jiffy and msec version.

Thanks,
Nish

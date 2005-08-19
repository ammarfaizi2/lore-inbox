Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVHSA2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVHSA2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 20:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVHSA2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 20:28:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65423 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932391AbVHSA2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 20:28:31 -0400
Date: Fri, 19 Aug 2005 02:27:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124241449.8630.137.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508182213100.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508162337130.3728@scrub.home>
 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Aug 2005, john stultz wrote:

> If they are private clock variables, why are they in the generic
> timer.c? Everyone is using it in exactly the same way, no?  Why do you
> oppose having the adjustment and phase values behind an ntp_function()
> interface?

These values belong to the clock, NTP specifies the speed of the clock via 
tick/frequency, these variables specify the current state of the clock. If 
we assume there is only one system clock, we need only one set of those, 
so leaving them in timer.c doesn't really hurt. How these variables are 
updated depends on the clock, so separating them doesn't make much sense.

> Maybe to focus this productively, I'll try to step back and outline the
> goals at a high level and you can address those. 
> 
> My Assumptions:
> 1. adjtimex() sets/gets NTP state values
> 2. Every tick we adjust those state values
> 3. Every tick we use those values to make a nanosecond adjustment to
> time.
> 4. Those state values are otherwise unused.
> 
> Goals:
> 1. Isolate NTP code to clean up the tick based timekeeping, reducing the
> spaghetti-like code interactions.
> 2. Add interfaces to allow for continuous, rather then tick based,
> adjustments (much how ppc64 does currently, only shareable).

Cleaning up the code would be nice, but that shouldn't be the priority 
right now, first we should get the math right.
I looked a bit more on this aspect of your patch and I think it's overly 
complex even for continuous time sources. You can reduce the complexity 
by updating the clock in more regular intervals. 

What basically is needed to update in constant intervals (n cycles) a 
reference time controlled via NTP and the system time. The difference 
between those two can be used to adjust the cycle multiplier for the next 
n cycles to speed up or slow down the system clock.
Calculating the offset in constant intervals makes the math a lot simpler, 
basically the current code is just a special case of that, where it 
directly updates the system time from the reference time at every tick.
(In the end the differences between tick based and continuous sources may 
be even smaller than your current patches suggest. :) )

bye, Roman

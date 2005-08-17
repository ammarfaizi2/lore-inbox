Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVHQBRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVHQBRe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 21:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVHQBRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 21:17:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59790 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750762AbVHQBRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 21:17:33 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0508162337130.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 18:17:28 -0700
Message-Id: <1124241449.8630.137.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 02:28 +0200, Roman Zippel wrote:

> Let's look at the example patch below. I played a little with some code 
> and this just demonstrates an accurate conversion of the tick/freq values 
> into the internal values in ns resolution. It does a little more work 
> ahead, but the interrupt code becomes simpler and most important it 
> doesn't require any expensive 64bit math and you can't get it much more 
> accurate than that. The current gettimeofday code for tick based sources 
> is really cheap and I'd like to keep that (i.e. free of 64bit math). The 
> accuracy can and should be fixed (the change to timespec wasn't really a 
> major improvement, as it introduced new rounding errors).

Hmm. It could really use some comments, but it looks interesting. Let me
continue reading it and play around with it some more. 

> The other thing the example demonstrates is the interface from NTP to 
> timer code. The NTP code provides the basic parameters and then leaves it 
> to the clock implementation how they apply. The adjustment and phase 
> variables are really private variables. 

If they are private clock variables, why are they in the generic
timer.c? Everyone is using it in exactly the same way, no?  Why do you
oppose having the adjustment and phase values behind an ntp_function()
interface?

Maybe to focus this productively, I'll try to step back and outline the
goals at a high level and you can address those. 

My Assumptions:
1. adjtimex() sets/gets NTP state values
2. Every tick we adjust those state values
3. Every tick we use those values to make a nanosecond adjustment to
time.
4. Those state values are otherwise unused.

Goals:
1. Isolate NTP code to clean up the tick based timekeeping, reducing the
spaghetti-like code interactions.
2. Add interfaces to allow for continuous, rather then tick based,
adjustments (much how ppc64 does currently, only shareable).


thanks
-john



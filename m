Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVHUXTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVHUXTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 19:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVHUXTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 19:19:40 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:41124 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751124AbVHUXTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 19:19:39 -0400
Date: Mon, 22 Aug 2005 01:19:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124505151.22195.78.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508202204240.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508162337130.3728@scrub.home>
  <1124241449.8630.137.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0508182213100.3728@scrub.home> <1124505151.22195.78.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 19 Aug 2005, john stultz wrote:

> timekeeping_perioidic_hook():
> 
> 	/* get ntp adjusted interval length*/
> 	interval_length = get_timesource_interval(ppm)

Here starts the problem, this requires more expensive math than necessary, 
as every time you first have to scale the values.

Let's take a standard PIT timer as an example. With HZ=100 we program it 
with 11932, for simplicity let's assume this corresponds to 10^7ns and 
scale this by 2^8. This means the timer multiplier is initially 214549, 
this updates the system time by 214549*11932 and the reference time by 
10^7*2^8 every tick. We can now just ignore the error or as soon as it 
exceeds 11932/2 we increase/decrease the mutiplier. The error calculation 
is rather simple, usually just adds and shifts, only if the error exceeds 
2*11932 it gets a little more complicated, but even here the possible 
divide is avoidable.
The gettimeofday would then basically be "xtime + (cycle_offset * mult + 
error_offset) / 2^8". Depending on the update frequency and the required 
precision it's even possible to keep this within 32bit. The ntp part stays 
pretty much the same and the time source can add anything it wants on top 
of that. The basic math is also pretty much the same so we can generate 
most of the code depending on various parameters.

bye, Roman

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbVI0V5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbVI0V5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVI0V5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:57:24 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:47795
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965181AbVI0V5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:57:23 -0400
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1127852362.8195.215.camel@cog.beaverton.ibm.com>
References: <1127419120.8195.7.camel@cog.beaverton.ibm.com>
	 <1127419198.8195.10.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0509271809460.3728@scrub.home>
	 <1127852362.8195.215.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 27 Sep 2005 23:57:57 +0200
Message-Id: <1127858277.15115.197.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 13:19 -0700, john stultz wrote:
> Yea. I had spent some time implementing your idea about having a
> reference xtime that is only NTP adjusted, then timesource based
> system_time which adjusts the frequency of time timesource when
> system_time and the ntp adjusted xtime drift apart. 
> 
> The biggest concern was having duplicate timekeeping subsystems in play
> at once. 

Which would be wrong IMNSHO.

Please keep the current xtime centric implementation out of your mind. 

As I pointed out in the ktimers thread already the  correct chain of
processing is

raw timesource 
	-> freqency adjustment (== CLOCK_MONOTONIC) 
		-> wall time adjustment (== CLOCK_REALTIME)

This is the way all real world time sources work. Nobody screws on an
atomic clock because the earth rotation is not constant. Why should
Linux be different ? For historic reasons - because it was that way
since v0.95 ?

There is no performance penalty involved doing it this way. It just
changes the order of corrections. The performance critical stuff is a
question of implementation details not of processing order.

> Which isn't all that different from the existing:
> 	usec = mach_gettimeoffset();
<SNIP>
> 	sec = xtime.tv_sec;
> 	usec += xtime.tv_nsec/1000;
> 
> Logic seen in the m68k time.c

Same code in most other archs.

tglx


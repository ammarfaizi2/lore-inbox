Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTFYXeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTFYXeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:34:15 -0400
Received: from gw.aurema.com ([203.31.96.1]:11179 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S265229AbTFYXc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:32:57 -0400
Date: Thu, 26 Jun 2003 09:47:02 +1000
From: Kingsley Cheung <kingsley@aurema.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 764] New: btime in /proc/stat wobbles (even over 30 seconds)
Message-ID: <20030626094702.J15047@aurema.com>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <205830000.1054566142@[10.10.2.4]> <20030612112011.C29095@aurema.com> <1056155679.1028.22.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056155679.1028.22.camel@w-jstultz2.beaverton.ibm.com>; from johnstul@us.ibm.com on Fri, Jun 20, 2003 at 05:34:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 05:34:39PM -0700, john stultz wrote:
> On Wed, 2003-06-11 at 18:20, Kingsley Cheung wrote:
> 
> > I see that there has been a fix made for this since 2.5.70-bk13 or
> > 2.5.70-bk14 that solves this problem by using the seqlock to ensure
> > that the jiffies and time of day are atomically read.
> 
> And further then that, we loose less precision in some of the math so we
> don't have the single second wobbles that were initially seen. 
> 
> 
> > However, wouldn't it be better to have the boottime calculated only
> > once so that it is independent of changes in the system time that may
> > occur later?  Even with the fix with seqlock, the boottime can still
> > change back or forwards whenever the system time is set back or
> > forwards.  IMHO an unchanging boottime that is independent of the time
> > of day is the best approach.  Maybe something like the patch against
> > 2.5.70-bk14 that I've attached.
> > 
> > What do people think?
> 
> Really, I'm fine with the current semantics. At boot time the system
> clock may not have been correct, and was corrected only after NTP
> started up later in the boot sequence. So you could have some very funky
> btimes. 
> 

I guess that one of the tradeoffs to be considered for having a fixed
boottime.  If after boot time NTP corrects the system time, then the
boot time would not change in accordance with NTP's correction.

> Even the current definition of btime = now - uptime has its own quirks
> (when systems are suspended uptime doesn't increment, etc) but I think
> its more likely to be correct then any other method (assuming the time
> now is more accurate then time at boot thanks to ntp or whatnot). 
> 

When you mention that quirk above, wouldn't that mean then that the
boottime would be off by the amount of time the system is suspended?
If uptime or jiffies is not updated but 'now' (the system time) is,
then btime would be pushed forward...

> I'm curious, how are people using the btime value? I'd think uptime and
> gettimeofday would be more useful bits of info, so I'd like to hear
> more.

Yes, that would be interesting to know.

Personally, I have been using it to determine when processes started.
Starttime, and some other process data that is recorded and presented
in /proc in jiffies.  So to determine when a process started I took
that value, converted to seconds, and added it to btime.  I was a bit
surpised to find that btime changed, however.  And the way it is now
it'll still change whenever the system time is changed.  However, at
least with the fix from 2.5.70, it doesn't wobble anymore due to loss
of precision.

-- 
		Kingsley

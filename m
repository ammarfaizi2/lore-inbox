Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268403AbUHQUIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268403AbUHQUIX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268401AbUHQUIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:08:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:25531 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268403AbUHQUID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:08:03 -0400
Subject: Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
In-Reply-To: <Pine.LNX.4.53.0408170851020.15157@gockel.physik3.uni-rostock.de>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
	 <412151CA.4060902@mvista.com>
	 <Pine.LNX.4.53.0408170851020.15157@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1092773244.2429.170.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Aug 2004 13:07:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 23:56, Tim Schmielau wrote:
> On Tue, 16 Aug 2004, Albert Cahalan wrote:
> 
> > If you're interested in reducing (not solving)
> > the problem for the 2.6.x series, you might change
> > HZ to something that works better with the PIT.
> 
> No, that's not needed anymore. We've already started to account for the
> difference, e.g. by using TICK_NSEC in jiffies64_to_clock_t().

Well, unfortunately TICK_NSEC just gives the *current* tick length as
requested by ntpd. So it won't work over an long interval of jiffies
where TICK_NSEC might have changed.

> Problem is, we are only halfway through the attempt to remove the use
> of "jiffies" as a clock, so currently to incompatible time sources get 
> mixed
> up.
> 
> The other problem seems to be that this move away from "jiffies" seems to
> happen on an ad-hoc basis whenever we encounter a problem, rather than
> with a big picture in mind.

Indeed you are correct. Since timer interrupts are not precisely or
accurately delivered, a timer interrupt counter (jiffies), cannot be
used as a reliable time source (except where there is not other time
source). The problem is that it is difficult to discern where jiffies is
just being used as a timer subsystem counter, or where its being used as
a time of day time source.

Even worse, this is a userspace visible usage of jiffies as a time
stamp, so in this case we have to preserve the interface and find a way
to emulate it. So proc_pid_stats() may need to do the reverse of what
procps is doing. 

> John Stultz once laid out a concept for a (coordinated) rewrite in 2.7,
> and I think this still is a good idea.

Yep, I've been working like crazy on just this (well, when my work isn't
swamping me). Unfortunately it is a major overhaul and causes cascading
changes (removal of xtime), so its not going as quickly as I'd like.
However I feel the design is quite good and I will attach a copy of it
and the first pass of the code in a reply to this email.

thanks
-john


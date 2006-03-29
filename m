Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWC2RdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWC2RdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWC2RdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:33:04 -0500
Received: from adsl-64-171-19-66.dsl.sntc01.pacbell.net ([64.171.19.66]:13066
	"EHLO giraffe.giraffe-data.com") by vger.kernel.org with ESMTP
	id S1750897AbWC2RdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:33:03 -0500
Message-ID: <52304.bryanh@giraffe-data.com>
Date: 29 Mar 2006 16:49:41 +0000
From: bryanh@giraffe-data.com (Bryan Henderson)
To: alessandro.zummo@towertech.it
CC: mpm@selenic.com, benh@kernel.crashing.org, ak@muc.de, akpm@osdl.org,
       torvalds@osdl.org, davem@davemloft.net, kkojima@rr.iij4u.or.jp,
       lethal@linux-sh.org, paulus@samba.org, ralf@linux-mips.org,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, smurf@debian.org,
       stenn@whimsy.udel.edu, bunk@stusta.de, lamont@debian.org
In-reply-to: <20060329034555.11785044@inspiron>
	(alessandro.zummo@towertech.it)
Subject: Re: 11 minute RTC update (was Re: Remove RTC UIP)
References: <200603270920.k2R9KYYx007214@shell0.pdx.osdl.net>
	<20060327111836.GA79131@muc.de>
	<20060327163218.GD3642@waste.org>
	<20060327190037.GB27030@muc.de>
	<20060327211143.55ef7c4e@inspiron>
	<1143512075.2284.2.camel@localhost.localdomain>
	<20060329000215.683eb2d5@inspiron>
	<20060329000345.GZ3642@waste.org>
	<20060329031102.0e056d85@inspiron>
	<20060329012137.GB3642@waste.org> <20060329034555.11785044@inspiron>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it isn't. Ideally ntpd should open /dev/rtcX and write the
> time, but I'm not sure if it belongs to it or if a simple
> hwclock --systohc /dev/rtcX should be used.

It makes a lot more sense to use hwclock than to duplicate its
function in ntpd.  Besides the downside of having to maintain two
programs that do the same thing, it creates a difficult interaction
problem if a user uses both, because hwclock tries to work with the
systematic drift rate of the clock, and if hwclock is not the only
thing setting it, it can get all messed up.  hwclock contains special
code today to notice that the kernel is interfering (adjtimex()
reports that information), but it really would rather not, and I think
it would be even messier if the interference came from outside the
kernel.

I'm not sure ntpd even should be involved with this.  It seems to me
cleaner to keep maintaining of the Linux clock and maintaining of the
hardware clock separate.  On my own system, I simply have cron do a
hwclock --systohc once a week, independent of what keeps the system
clock accurate.  Some people do it at shutdown time as well.  (You
don't have to set the clock every 11 minutes if you're keeping track
of systematic drift like hwclock does).

Concerning migration: ntpd presently tells the kernel to go into 11
minute mode (I think technically, it tells the kernel that it is
keeping the system time accurate and based on that information, the
kernel takes the opportunity to keep the hardware clock accurate as
well, but I think it's practically equivalent).  So that suggests a
migration path: Step 1: ntpd stops using that flag; Step 2: kernel
issues warning if someone uses the flag; Step 3: kernel ignores the
flag.  For 1), ntpd issues a warning that nobody's minding the
hardware clock unless you pass an option telling it to do hwclock
--systohc or that you're handling the issue and ntpd needn't warn you
about it.  I like the latter better.


BTW, I am the maintainer of hwclock.  This is the first I've heard of
this discussion, but I have always been a supporter of the kernel
getting out of the hardware clock maintenance business.  What's this
about multiple RTC's?

-- 
Bryan Henderson                                    Phone 408-621-2000
San Jose, California

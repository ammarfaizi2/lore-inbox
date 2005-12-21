Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVLUVTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVLUVTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLUVTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:19:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49937 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750745AbVLUVTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:19:21 -0500
Date: Wed, 21 Dec 2005 21:19:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: gene.heskett@verizononline.net
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Another casualty of -rc6
Message-ID: <20051221211915.GI1736@flint.arm.linux.org.uk>
Mail-Followup-To: gene.heskett@verizononline.net,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <200512211039.25449.gene.heskett@verizon.net> <20051221155012.GG1736@flint.arm.linux.org.uk> <200512211543.51702.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512211543.51702.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 03:43:51PM -0500, Gene Heskett wrote:
> On Wednesday 21 December 2005 10:50, Russell King wrote:
> >in your ntp.conf, right?  I bet if you comment out those two lines
> > ntp will start behaving.
> >
> They are, or were, in there, and its running just fine under -rc5, 
> its -rc6 that blew up and got off by 45 minutes in 27 hours of uptime.

An early 2.6 kernel "blew up" in precisely the same manner as you're
describing here for me back in the early 2.6 days.

As I explained in my first reply, I was led to believe that it is
wrong to have the local clock in the configuration.  Since then
I've been running ntp without the local clock line, and it's been
fine since.

I'm not saying that this is your problem, but I suspect that this
may not be helping the situation - especially since it appears that
ntpd has ruled out the other peers as possible synchronisation
sources.

> it out now, and ntpd restarted.  We'll see if it (ntpq -p) even bothers to 
> report LOCAL now.  Nope.

It won't do.  ntpq -p reports the _peers_ known to the server.
Obviously, if you remove the local peer, it won't be shown in that
output anymore.  Moreover, think whether it is correct to setup a
peering between your local clock and your local clock.

> But the status is presently 0041, whatever that
> indicates, from the ntp.log:

0040, 0041 and 0001 are the values of the timex.status field.  See
include/linux/timex.h for details.  The relevant ones are:

#define STA_PLL         0x0001  /* enable PLL updates (rw) */
#define STA_UNSYNC      0x0040  /* clock unsynchronized (rw) */

> 21 Dec 15:22:47 ntpd[9198]: logging to file /var/log/ntp.log
> 21 Dec 15:22:47 ntpd[9198]: ntpd 4.2.0a@1.1190-r Fri Aug 26 04:27:20 EDT 2005 (1)
> 21 Dec 15:22:47 ntpd[9198]: precision = 1.000 usec
> 21 Dec 15:22:47 ntpd[9198]: Listening on interface wildcard, 0.0.0.0#123
> 21 Dec 15:22:47 ntpd[9198]: Listening on interface lo, 127.0.0.1#123
> 21 Dec 15:22:47 ntpd[9198]: Listening on interface eth0, 192.168.71.3#123
> 21 Dec 15:22:47 ntpd[9198]: kernel time sync status 0040
> 21 Dec 15:22:47 ntpd[9198]: frequency initialized 3.712 PPM from /var/lib/ntp/drift
> 21 Dec 15:27:06 ntpd[9198]: synchronized to 128.6.213.15, stratum 3
> 21 Dec 15:27:06 ntpd[9198]: kernel time sync disabled 0041
> 21 Dec 15:31:21 ntpd[9198]: synchronized to 192.36.143.151, stratum 1
> 21 Dec 15:32:29 ntpd[9198]: kernel time sync enabled 0001

So the kernel's timekeeping transitioned from unsynchronised to
PLL mode, to PLL + synchronised.  Great, ntpd has adjusted the
kernels timekeeping in an attempt to keep it synchronised.

> Neither of those are in an ntpq -p report?

Are you using the pooled servers?  They resolve to _many_ addresses.

> When I had -rc6 running it was spitting out some sort
> of code at about 1 second intervals to the vt's:
> 
> Dec 21 10:29:23 coyote last message repeated 12 times
> Dec 21 10:29:29 coyote kernel: set_rtc_mmss: can't update from 14 to 59

This is a different problem.  This triggers:

        if (abs(real_minutes - cmos_minutes) < 30) {
...
        } else {
                printk(KERN_WARNING
                       "set_rtc_mmss: can't update from %d to %d\n",
                       cmos_minutes, real_minutes);
                retval = -1;
        }

so the time is more than 30 minutes out.  What happens if you ensure
that the correct time is set, then start ntpd with this configuration?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

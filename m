Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVLUVx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVLUVx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVLUVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:53:56 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:13600 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750996AbVLUVxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:53:55 -0500
Date: Wed, 21 Dec 2005 16:53:53 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Another casualty of -rc6
In-reply-to: <20051221211915.GI1736@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Reply-to: gene.heskett@verizononline.net
Message-id: <200512211653.53462.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512211039.25449.gene.heskett@verizon.net>
 <200512211543.51702.gene.heskett@verizon.net>
 <20051221211915.GI1736@flint.arm.linux.org.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 December 2005 16:19, Russell King wrote:
>On Wed, Dec 21, 2005 at 03:43:51PM -0500, Gene Heskett wrote:
>> On Wednesday 21 December 2005 10:50, Russell King wrote:
>> >in your ntp.conf, right?  I bet if you comment out those two lines
>> > ntp will start behaving.
>>
>> They are, or were, in there, and its running just fine under -rc5,
>> its -rc6 that blew up and got off by 45 minutes in 27 hours of
>> uptime.
>
>An early 2.6 kernel "blew up" in precisely the same manner as you're
>describing here for me back in the early 2.6 days.
>
>As I explained in my first reply, I was led to believe that it is
>wrong to have the local clock in the configuration.  Since then
>I've been running ntp without the local clock line, and it's been
>fine since.
>
>I'm not saying that this is your problem, but I suspect that this
>may not be helping the situation - especially since it appears that
>ntpd has ruled out the other peers as possible synchronisation
>sources.
>
>> it out now, and ntpd restarted.  We'll see if it (ntpq -p) even
>> bothers to report LOCAL now.  Nope.
>
>It won't do.  ntpq -p reports the _peers_ known to the server.
>Obviously, if you remove the local peer, it won't be shown in that
>output anymore.  Moreover, think whether it is correct to setup a
>peering between your local clock and your local clock.
>
>> But the status is presently 0041, whatever that
>> indicates, from the ntp.log:
>
>0040, 0041 and 0001 are the values of the timex.status field.  See
>include/linux/timex.h for details.  The relevant ones are:
>
>#define STA_PLL         0x0001  /* enable PLL updates (rw) */
>#define STA_UNSYNC      0x0040  /* clock unsynchronized (rw) */
>
>> 21 Dec 15:22:47 ntpd[9198]: logging to file /var/log/ntp.log
>> 21 Dec 15:22:47 ntpd[9198]: ntpd 4.2.0a@1.1190-r Fri Aug 26
>> 04:27:20 EDT 2005 (1) 21 Dec 15:22:47 ntpd[9198]: precision = 1.000
>> usec
>> 21 Dec 15:22:47 ntpd[9198]: Listening on interface wildcard,
>> 0.0.0.0#123 21 Dec 15:22:47 ntpd[9198]: Listening on interface lo,
>> 127.0.0.1#123 21 Dec 15:22:47 ntpd[9198]: Listening on interface
>> eth0, 192.168.71.3#123 21 Dec 15:22:47 ntpd[9198]: kernel time sync
>> status 0040
>> 21 Dec 15:22:47 ntpd[9198]: frequency initialized 3.712 PPM from
>> /var/lib/ntp/drift 21 Dec 15:27:06 ntpd[9198]: synchronized to
>> 128.6.213.15, stratum 3 21 Dec 15:27:06 ntpd[9198]: kernel time
>> sync disabled 0041 21 Dec 15:31:21 ntpd[9198]: synchronized to
>> 192.36.143.151, stratum 1 21 Dec 15:32:29 ntpd[9198]: kernel time
>> sync enabled 0001
>
>So the kernel's timekeeping transitioned from unsynchronised to
>PLL mode, to PLL + synchronised.  Great, ntpd has adjusted the
>kernels timekeeping in an attempt to keep it synchronised.
>
>> Neither of those are in an ntpq -p report?
>
>Are you using the pooled servers?  They resolve to _many_ addresses.

I have several instances of pool.ntp.org scattered thru the timeservers list I use, so there is a fairly good chance it will catch at least one of them in the randomization choice routine of /etc/init.d/ntpd.

>> When I had -rc6 running it was spitting out some sort
>> of code at about 1 second intervals to the vt's:
>>
>> Dec 21 10:29:23 coyote last message repeated 12 times
>> Dec 21 10:29:29 coyote kernel: set_rtc_mmss: can't update from 14
>> to 59
>
>This is a different problem.  This triggers:
>
>        if (abs(real_minutes - cmos_minutes) < 30) {
>...
>        } else {
>                printk(KERN_WARNING
>                       "set_rtc_mmss: can't update from %d to %d\n",
>                       cmos_minutes, real_minutes);
>                retval = -1;
>        }
>
>so the time is more than 30 minutes out.  What happens if you ensure
>that the correct time is set, then start ntpd with this
> configuration?

Its still there if I reboot to 2.6.15-rc6.  And the initial
startup of ntpd does do a crash set to the correct time using 
ntpdate, so it assureadly did start out in reasonable synch.
FWIW, I keep the hdwr clock on Grenwich time.

Let me go back into the log and see how long it had been booted
before those messages started.

During the reboot at about 6pm on the 19th, this is seen:

Dec 19 18:07:03 coyote kernel: kjournald starting.  Commit interval 5 seconds
Dec 19 17:56:14 coyote ntpdate[1963]: step time server 128.208.109.7 offset -648.721376 sec

So it backed up 8 minutes there.  Then a few seconds later:
Dec 19 17:56:35 coyote kernel: usbcore: registered new driver pl2303
Dec 19 17:56:35 coyote kernel: drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
Dec 19 17:56:35 coyote kernel: set_rtc_mmss: can't update from 7 to 56

Then as rc.local was being executed:
Dec 19 17:56:39 coyote kernel: DVB: registering frontend 0 (Oren OR51132 VSB/QAM Frontend)...
Dec 19 17:56:40 coyote kernel: set_rtc_mmss: can't update from 7 to 56
Dec 19 17:56:41 coyote heyu_relay: relay setting up-
Dec 19 17:56:41 coyote kernel: set_rtc_mmss: can't update from 7 to 56
Dec 19 17:56:49 coyote last message repeated 4 times
Dec 19 17:56:52 coyote rc: Starting webmin:  succeeded
Dec 19 17:56:53 coyote kernel: set_rtc_mmss: can't update from 7 to 56
Dec 19 17:56:56 coyote last message repeated 3 times

And it kept up till I rebooted to rc5 a short time later.  
And I'd rebuilt -rc6 and tried it again, and it was about 10:25
this morning when I noted the clock was way fast and did a
service ntpd restart, which logged this:
The first line is a cron job that shuts off the nighttime 
outside motion detectors.  The system was quiet then until I found
the clock fubared.  So the next line is my restart of ntpd.

Dec 21 06:30:02 coyote heyu_relay: relay setting up-
Dec 21 11:06:49 coyote ntpd: ntpd shutdown succeeded
Dec 21 10:22:14 coyote ntpdate[6357]: step time server 80.163.145.206 offset -2679.594276 sec
Dec 21 10:22:14 coyote ntpd:  succeeded
Dec 21 10:22:14 coyote ntpd: logging to file /var/log/ntp.log
Dec 21 10:22:14 coyote ntpd: ntpd startup succeeded
Dec 21 10:22:16 coyote kernel: set_rtc_mmss: can't update from 6 to 52
Dec 21 10:22:18 coyote last message repeated 2 times
Dec 21 10:22:23 coyote kernel: set_rtc_mmss: can't update from 7 to 52
Dec 21 10:22:56 coyote last message repeated 15 times
Dec 21 10:22:59 coyote last message repeated 3 times
Dec 21 10:23:03 coyote kernel: set_rtc_mmss: can't update from 7 to 53
Dec 21 10:23:19 coyote last message repeated 9 times
Dec 21 10:23:23 coyote kernel: set_rtc_mmss: can't update from 8 to 53
Dec 21 10:23:57 coyote last message repeated 18 times

These last times are correct as I keep my watch on local time
plus or minus a couple of seconds.
And I eventually rebooted to -rc5, which was, and is now, 
running fine.  And now without a localhost entry in ntp.conf, 
thanks for the hint.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVLUUny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVLUUny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVLUUny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:43:54 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:46413 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S964821AbVLUUnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:43:53 -0500
Date: Wed, 21 Dec 2005 15:43:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Another casualty of -rc6
In-reply-to: <20051221155012.GG1736@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Cc: Russel King <rmk+lkml@arm.linux.org.uk>
Reply-to: gene.heskett@verizononline.net
Message-id: <200512211543.51702.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512211039.25449.gene.heskett@verizon.net>
 <20051221155012.GG1736@flint.arm.linux.org.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 December 2005 10:50, Russell King wrote:
>On Wed, Dec 21, 2005 at 10:39:25AM -0500, Gene Heskett wrote:
>>      remote           refid      st t when poll reach   delay  
>> offset  jitter
>> ===================================================================
>>=========== ntp2.usv.ro     80.96.120.253    2 u   59   64  377 
>> 180.742  -260483 5112.35 210.118.170.59  211.115.194.21   3 u   24 
>>  64  377  248.620  -260423 6261.15 ns1.dns.pciwest 204.123.2.5     
>> 2 u   48   64  377  126.289  -261067 4127.39 *LOCAL(0)       
>> LOCAL(0)        10 l   57   64  377    0.000    0.000   0.001
>> drift=3.720
>
>You have:
>
>server 127.127.1.0     # local clock
>fudge  127.127.1.0 stratum 10
>
>in your ntp.conf, right?  I bet if you comment out those two lines
> ntp will start behaving.
>
They are, or were, in there, and its running just fine under -rc5, 
its -rc6 that blew up and got off by 45 minutes in 27 hours of uptime.
Thats way an gone many times my normal clock drift here Russell.
That (the drift file) stays around 4 ppm, as shown here, after a
reboot to 2.6.15-rc5:
----------------
==============================================================================
+152.Red-80-33-1 150.214.94.5     2 u  437 1024  377  205.716    7.214   0.178
+mx1.gs.washingt 140.142.1.8      3 u  477 1024  377  115.473   -0.795   0.475
*ntp3.usv.ro     192.53.103.103   2 u  491 1024  377  181.308    2.771   1.007
 LOCAL(0)        LOCAL(0)        10 l   25   64  377    0.000    0.000   0.001
drift=3.712
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
+152.Red-80-33-1 150.214.94.5     2 u  183 1024  377  206.155    6.608   0.438
+mx1.gs.washingt 140.142.1.8      3 u  225 1024  377  116.734   -0.497   0.091
*ntp3.usv.ro     192.53.103.103   2 u  238 1024  377  179.751    2.590   1.465
 LOCAL(0)        LOCAL(0)        10 l   18   64  377    0.000    0.000   0.001
drift=3.712

>(I had to comment them out long ago, and I have been lead to believe
> that it is wrong to include them in a configuration which is only
> supposed to synchronnise to external time sources.)

it out now, and ntpd restarted.  We'll see if it (ntpq -p) even bothers to 
report LOCAL now.  Nope. But the status is presently 0041, whatever that
indicates, from the ntp.log:
21 Dec 15:22:47 ntpd[9198]: logging to file /var/log/ntp.log
21 Dec 15:22:47 ntpd[9198]: ntpd 4.2.0a@1.1190-r Fri Aug 26 04:27:20 EDT 2005 (1)
21 Dec 15:22:47 ntpd[9198]: precision = 1.000 usec
21 Dec 15:22:47 ntpd[9198]: Listening on interface wildcard, 0.0.0.0#123
21 Dec 15:22:47 ntpd[9198]: Listening on interface lo, 127.0.0.1#123
21 Dec 15:22:47 ntpd[9198]: Listening on interface eth0, 192.168.71.3#123
21 Dec 15:22:47 ntpd[9198]: kernel time sync status 0040
21 Dec 15:22:47 ntpd[9198]: frequency initialized 3.712 PPM from /var/lib/ntp/drift
21 Dec 15:27:06 ntpd[9198]: synchronized to 128.6.213.15, stratum 3
21 Dec 15:27:06 ntpd[9198]: kernel time sync disabled 0041
21 Dec 15:31:21 ntpd[9198]: synchronized to 192.36.143.151, stratum 1
21 Dec 15:32:29 ntpd[9198]: kernel time sync enabled 0001

Neither of those are in an ntpq -p report?

When I had -rc6 running it was spitting out some sort
of code at about 1 second intervals to the vt's:

Dec 21 10:29:23 coyote last message repeated 12 times
Dec 21 10:29:29 coyote kernel: set_rtc_mmss: can't update from 14 to 59

That was from /var/log/messages while it was running the small code 
option kernel.  Without that option set, it throws the same message
out on all vt's at ~1 second intervals.

So I think this one might be a legit problem.  I haven't tested
it without the apic enabled in the bios though.  Recall that this
didn't work with apic on at all in the previous bios flash. No
messages, but no work either.  Nforce2 chipset FWTW.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbUK3P2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUK3P2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUK3P21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:28:27 -0500
Received: from mail4.utc.com ([192.249.46.193]:14056 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262118AbUK3P0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:26:39 -0500
Message-ID: <41AC9121.8020001@cybsft.com>
Date: Tue, 30 Nov 2004 09:26:25 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <200411291816.43591.gene.heskett@verizon.net> <41ABD1CE.1010004@cybsft.com> <200411292354.05995.gene.heskett@verizon.net>
In-Reply-To: <200411292354.05995.gene.heskett@verizon.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Monday 29 November 2004 20:50, K.R. Foley wrote:
> 
>>Gene Heskett wrote:
> 
> 
>>>>make that -31-13 (or later). Earlier kernels had a bug in where
> 
> 
> [...]
> 
> 
>>Is this all that is in the log? For some reason there are 820
>>samples not represented in the output above. The ms+ hits would
>>have been represented by something like:
>>
>>Nov 29 18:05:45 coyote kernel: 9999 4
> 
> 
> Ok, I finally got -13 to run (typo in grub), and you are now correct 
> in that the final entry in the log after I shut tvtime down is like 
> this:
> 
> Nov 29 23:43:40 coyote kernel: rtc latency histogram of {tvtime/3911, 
> 10430 samples}:
> Nov 29 23:43:40 coyote kernel: 4 51
> Nov 29 23:43:40 coyote kernel: 5 2058
> Nov 29 23:43:40 coyote kernel: 6 3594
> Nov 29 23:43:40 coyote kernel: 7 1270
> Nov 29 23:43:40 coyote kernel: 8 473
> Nov 29 23:43:40 coyote kernel: 9 299
> Nov 29 23:43:40 coyote kernel: 10 252
> Nov 29 23:43:40 coyote kernel: 11 209
> Nov 29 23:43:40 coyote kernel: 12 215
> Nov 29 23:43:40 coyote kernel: 13 345
> Nov 29 23:43:40 coyote kernel: 14 391
> Nov 29 23:43:40 coyote kernel: 15 248
> Nov 29 23:43:40 coyote kernel: 16 113
> Nov 29 23:43:40 coyote kernel: 17 55
> Nov 29 23:43:40 coyote kernel: 18 17
> Nov 29 23:43:40 coyote kernel: 19 11
> Nov 29 23:43:40 coyote kernel: 20 4
> Nov 29 23:43:40 coyote kernel: 21 1
> Nov 29 23:43:40 coyote kernel: 23 2
> Nov 29 23:43:40 coyote kernel: 28 1
> Nov 29 23:43:40 coyote kernel: 4612 1
> Nov 29 23:43:40 coyote kernel: 9999 820
> 
> What does this tell you now?  The last 2 lines look a bit strange to
> me.  Particularly since the runtime was random enough that your 
> previous comment about the number 820 was a mssing count, and what 
> came out of a seperate run IS an 820.
> 
> I find that a bit hard to believe that I timed those two runs 
> identically.
> 

When I mentioned 820 that was just what was missing from the histogram 
data vs. the total samples. As for why this number showed up again, dumb 
luck? What the histogram represents is usecs (left column) between 
interrupt and read. The right column is the number of occurrences. What 
this tells me is that you had 820 samples that were greater than 9.999ms.

I took a brief look at the tvtime code. I noticed several things:
1) tvtime sets the interrupt frequency for the rtc to 1024 Hz which 
would imply that you should have had roughly 30000 samples in a 30 
second run, minus initial setup time. The histogram only shows 10430 
samples. I have no way of knowing if the setup time is really that long 
or if you are missing some interrupts. Unfortunately the rtc histogram 
stuff doesn't currently track missed interrupts except to print out the 
messages you were seeing

"<some process> is being piggy... Read missed before next interrupt"

2) tvtime is probably running at a RT priority of 99. The IRQ handler 
for the rtc defaults to 48-49 (I think). If you didn't already do so, 
you should bump the priority up as in:

chrt -f -p 99 `/sbin/pidof 'IRQ 8'`

Try that and see if it helps at all.

kr

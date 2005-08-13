Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVHNAla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVHNAla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 20:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVHNAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 20:41:30 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:35756 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751361AbVHNAla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 20:41:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: Slow sync in Interbench: anticipatory starves writes?
Date: Sun, 14 Aug 2005 09:08:04 +1000
User-Agent: KMail/1.8.2
Cc: "Indan Zupancic" <indan@nul.nu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <45213.81.207.0.53.1123974374.squirrel@81.207.0.53>
In-Reply-To: <45213.81.207.0.53.1123974374.squirrel@81.207.0.53>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508140908.05287.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 09:06, Indan Zupancic wrote:
> Hello,

Hi.

Interesting find. I'm forwarding this on to lkml and Nick so they can peruse 
your findings and see what needs to be done.

Thanks,
Con

> Short version:
> With the anticipatory IO scheduler it's possible to cause extreme long
> delays so that sync() calls can take minutes. Isn't this a potential DOS?
>
> Long version:
> Running interbench took often much longer than expected. As the early
> versions were buggy I thought it was an interbench bug. But now, with
> interbench 0.29, the problem is still there. So I tried pinning it down
> and found out that it isn't an interbench bug at all, but that sync() is
> taking so long.
>
> All test results and data can be found at http://nul.nu/~indan/synctest/
> If no interval is given then it's 2 seconds.
>
> The testcase I used most is running a modified interbench which only
> tests X with the options -w Compile -c -t 10, so that only the X
> simulation under the Compile load is run without causing extra hd
> activity. All changes can be found in the file named "diff". This seemed
> the minimal test which reliably caused sync to be slow often. It may be
> that the full interbench run causes worse conditions, as some normal runs
> took 53 minutes (see 2.6.13-rc6-hg.log1).
>
> test1/ and test2/ dirs have earlier tests without sync timing. test3/ has
> sync timing added and is probably the most useful. Normally the X+Compile
> simulation takes about 15 to 20 seconds, but often 30 seconds or more,
> and once in a while more than one minute. test1/ was slowest with almost
> 4 minutes.
>
> At the end of the Compile test interbench stops the burn, write and read
> thread, in that order. Because stopping the write thread causes a sync
> which takes very long, the read thread keeps running, as can be seen in
> the vmstat output. A good log is
> http://nul.nu/~indan/synctest/test3/log9. There can also be seen that
> while interbench is waiting for the sync, almost no writing happens at
> all.
>
> Another good log with also meminfo output is
> http://nul.nu/~indan/synctest/test3/log2. There can be seen that even
> when there is no dirty or writeback data sync still doesn't return but
> keeps going.
>
> While writing this mail I tried other IO schedulers, and none have slow
> syncs except anticipatory. The others don't take more than one second for
> the sync.
>
> Funny that a cpu scheduler test finds IO scheduler problems. :-)
>
> Greetings,
>
> Indan

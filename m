Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310774AbSCHSbf>; Fri, 8 Mar 2002 13:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310800AbSCHSb0>; Fri, 8 Mar 2002 13:31:26 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:13214 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S310774AbSCHSbR>; Fri, 8 Mar 2002 13:31:17 -0500
Date: Fri, 8 Mar 2002 18:30:49 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        george anzinger <george@mvista.com>
Subject: gettimeofday() system call timing curiosity
Message-ID: <20020308183049.A18247@kushida.apsleyroad.org>
In-Reply-To: <E16iz57-0002SW-00@the-village.bc.nu> <1015515815.4373.61.camel@pc-16.office.scali.no> <a68bo4$b18$1@cesium.transmeta.com> <20020308013222.B14779@kushida.apsleyroad.org> <3C88157E.5010106@zytor.com> <20020308015701.C14779@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020308015701.C14779@kushida.apsleyroad.org>; from lk@tantalophile.demon.co.uk on Fri, Mar 08, 2002 at 01:57:01AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> It takes the median of 1000 samples of the TSC time taken to do a
> rdtsc/gettimeofday/rdtsc measurement, then uses that as the threshold
> for deciding which of the subsequent 1000000 measurements are accepted.
> Then linear regression through the accepted points.
> 
> I see a couple of results there which suggests a probable fault in the
> filtering algorithm.  Perhaps it should simply use the smallest TSC time
> taken as the threshold.

I've looked more closely.  Of all the machines I have access to, only my
laptop shows the anomolous measurements.

It turns out that the median of "time in TSC cycles to do a
rdtsc+gettimeofday+rdtsc measurement" varies from run to run.  It only
varies between two values, though.

On my laptop, the median of rdtsc+gettimeofday+rdtsc times is 470 cycles
for most runs of 1000, but is occasionally 453 cycles.

Over runs of approx. 10^6 samples, about 1% of the samples take 453
cycles to executre and about 60% take 470 cycles to execute.  I have no
idea why the smallest is so rare!

This explains the anomalous measurement on my laptop: the quickest
samples of 453 cycles are quite rare (1-2%, not measured accurately),
over runs of 10^6 samples.  Nevertheless, occasionally over a run of
1000 samples, the median comes out as 453.  When that happens, over 10^6
samples only about 1-2% are considered valid, and this is not good
enough to get an accurate calibration method.

On all machines except my laptop, the percentage of samples over large
runs which execute in the minimum number of cycles is somewhat larger
(35-60% - it varies between runs), and that is enough that whether the
median selects the minimum or the next value up, the calibration
estimate is good.  On one PC, the two median measurement times are 461
and 479 cycles.

On the FreeBSD box I noticed a very curious effect.  The median
measurement time comes out as 695 or 712 cycles.  (Btw, showing Linux
has faster gettimeofday calls :-).  The curiousity is that if I
repeatedly run the program, I see something like 30 consecutive results
where the median came out at 695 cycles, then 50 consecutive results at
712 cycles, then another 30 or so at 695 cycles.

That shows there is something stateful going on - I would guess
something connected with the processor caches (but it's just a guess),
and doing 1000 iterations in a loop doesn't cause the timing to settle
down to the minimum time.

So there are: two oddities: why does my laptop have only a small
proportion of rdtsc+gettimeofday+rdtsc calls executing in the minimum
number of clock cycles, and why does FreeBSD show long runs with one
value alternating with long runs of another.

cheers,
-- Jamie

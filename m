Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310140AbSCHURM>; Fri, 8 Mar 2002 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310998AbSCHURF>; Fri, 8 Mar 2002 15:17:05 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:41886 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S310140AbSCHUQq>; Fri, 8 Mar 2002 15:16:46 -0500
Date: Fri, 8 Mar 2002 20:16:33 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        george anzinger <george@mvista.com>
Subject: Re: gettimeofday() system call timing curiosity
Message-ID: <20020308201633.C18247@kushida.apsleyroad.org>
In-Reply-To: <E16iz57-0002SW-00@the-village.bc.nu> <1015515815.4373.61.camel@pc-16.office.scali.no> <a68bo4$b18$1@cesium.transmeta.com> <20020308013222.B14779@kushida.apsleyroad.org> <3C88157E.5010106@zytor.com> <20020308015701.C14779@kushida.apsleyroad.org> <20020308183049.A18247@kushida.apsleyroad.org> <3C89080D.8060503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C89080D.8060503@zytor.com>; from hpa@zytor.com on Fri, Mar 08, 2002 at 10:50:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> > On my laptop, the median of rdtsc+gettimeofday+rdtsc times is 470 cycles
> > for most runs of 1000, but is occasionally 453 cycles.
> 
> What that indicates to me is that 1000 is way too small of a sample. 
> You're only talking a difference of 17,000 cycles, which could -- 
> especially with cache effects -- easily be the time spent in an 
> interrupt handler.

No, interrupt handlers don't (or shouldn't) affect the measurement.

It's the _median_ that varies from 453 to 470, not the _mean_, so the
accumulation to 17000 cycles doesn't apply.

I do rdtsc, then gettimeofday(), then rdtsc.  I record (a) the actual
time values, and (b) the difference between the two rdtsc measurements.

First I store 1000 of the difference measurements -- those are the "time
taken to do measurement in TSC cycles".  I don't want to store a very
large number of these measurements because of the memory it takes, but
perhaps 1000 isn't quite enough (it isn't on the laptop, and is fine on
all the other machines).

Then I sort those and take the 499'th to get the median.

Assuming that at least 50% of the calls don't receive an interrupt or
reschedule in the middle (a reasonable assumption), then that median
gives me a good idea of how long a measurement takes _when there is no
interrupt or reschedule_.

Then I take approx. 1000000 measurements using the same code, and
discard all those that took longer than the median threshold determined
earlier.

This means that whenever an interrupt happened, that sample is discarded.

Finally, I do a simple least-squares linear regression through the
remaining samples (normally 400000-600000 or so) to calculate the slope.

The slope is what's printed.

cheers,
-- Jamie

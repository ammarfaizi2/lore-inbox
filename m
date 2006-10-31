Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423448AbWJaPfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423448AbWJaPfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423492AbWJaPfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:35:13 -0500
Received: from 1wt.eu ([62.212.114.60]:41476 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1423448AbWJaPfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:35:11 -0500
Date: Tue, 31 Oct 2006 16:31:16 +0100
From: Willy Tarreau <w@1wt.eu>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       thockin@hockin.org, Luca Tettamanti <kronos.it@gmail.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061031153116.GA19704@1wt.eu>
References: <1161969308.27225.120.camel@mindpipe> <20061027201820.GA8394@dreamland.darkstar.lan> <20061027230458.GA27976@hockin.org> <200610271804.52727.ak@suse.de> <1162006081.27225.257.camel@mindpipe> <20061028052837.GC1709@1wt.eu> <45472FAF.6080704@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45472FAF.6080704@draigBrady.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 11:12:47AM +0000, Pádraig Brady wrote:
> Willy Tarreau wrote:
> > On Fri, Oct 27, 2006 at 11:28:00PM -0400, Lee Revell wrote:
> > 
> >>On Fri, 2006-10-27 at 18:04 -0700, Andi Kleen wrote:
> >>
> >>>I don't think it makes too much sense to hack on pure RDTSC when 
> >>>gtod is fast enough -- RDTSC will be always icky and hard to use.
> >>
> >>I agree FWIW, our application would be happy to just use gtod if it
> >>wasn't so slow on these machines.
> > 
> > 
> > Agreed, I had to turn about 20 dual-core servers to single core because
> > the only way to get a monotonic gtod made it so slow that it was not
> > worth using a dual-core. I initially considered buying one dual-core
> > AMD for my own use, but after seeing this, I'm definitely sure I won't
> > ever buy one as long as this problem is not fixed, as it causes too
> > many problems.
> 
> For the record, in my previous job we were implementing
> a very fast packet sniffer/timestamper using 2x3.2GHz P4 Xeons + linux 2.4.20 (with gtod)
> Very rarely we would see inter packet times jump by (2^32)/CPU_Hz seconds,
> when sniffing about 1.2 million packets per second on 2 e1000 links,
> which suggested a wrap around of a 32 bit comparison somewhere.

Interesting, as in my case I was jumps of about +/- 2s on a 2.2 GHz box, which
also suggests a wrap around.

> This lead to the fix below which was never picked up
> (I guessed because it was addressed elsewhere?).
> Note we were only interested in millisecond resolution for the timestamps,
> but the approximation is very good in general as you know the TSCs are very
> close to each other when this condition happens.

100% agreed.

> Note power management was not used on our systems.
> 
> Pádraig.
> 
> diff -Naru linux-2.4.20/arch/i386/kernel/time.c linux-2.4.20-corvil/arch/i386/kernel/time.c
> --- linux-2.4.20/arch/i386/kernel/time.c    2002-11-28 23:53:09.000000000 +0000
> +++ linux-2.4.20-pb/arch/i386/kernel/time.c 2005-07-07 10:32:34.000000000 +0100
> @@ -94,6 +94,9 @@
> 
>         /* .. relative to previous jiffy (32 bits is enough) */
>         eax -= last_tsc_low;    /* tsc_low delta */
> +        if ((signed)eax < 0) { /* workaround for drifting TSCs */
> +            eax = 0;
> +            printk(KERN_INFO "tsc wrap around applied\n"); /* rare */
> +        }
> 
>         /*
>           * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient

Cheers,
Willy


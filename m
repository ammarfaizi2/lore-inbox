Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268907AbSIRTdK>; Wed, 18 Sep 2002 15:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268915AbSIRTdK>; Wed, 18 Sep 2002 15:33:10 -0400
Received: from h00010256f583.ne.client2.attbi.com ([66.30.243.14]:34789 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S268907AbSIRTdG>; Wed, 18 Sep 2002 15:33:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Lev Makhlis <mlev@despammed.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
Date: Wed, 18 Sep 2002 15:43:09 -0400
User-Agent: KMail/1.4.2
Cc: <ricklind@us.ibm.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0209181052360.19972-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0209181052360.19972-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209181543.09111.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 September 2002 01:54 pm, Randy.Dunlap wrote:
> On Sat, 14 Sep 2002, Lev Makhlis wrote:
> | > +#define MSEC(x) ((x) * 1000 / HZ)
> |
> | Perhaps it would be better to report the times in ticks using
> | jiffies_to_clock_t(), and let the userland do further conversions?
> | The macro above has an overflow problem, it creates a counter
> | that wraps at 2^32 / HZ (instead of 2^32), and theoretically, the
> | userland doesn't even know what the internal HZ is.  The overflow
> | can be avoided with something like
> | #define MSEC(x) (((x) / HZ) * 1000 + ((x) % HZ) * 1000 / HZ)
> | but I think it would be cleaner just to change the units to ticks,
> | especially if we're moving it to a different file and procps will
> | need to be changed anyway.
>
> Thanks for pointing this out.
>
> I'd rather not expose more ticks in /proc, so for now
> I'll ask Rick to use this #define for MSEC, which does
> indeed work nicely.

In that case, I also suggest manual optimization for "convenient"
values of HZ, because from what I've seen, GCC can't figure this
out on its own:

#if 1000 % HZ == 0
#define MSEC(x) ((x) * (1000 / HZ))
#elif HZ % 1000 == 0
#define MSEC(x) ((x) / (HZ / 1000))
#else
#define MSEC(x) (((x) / HZ) * 1000 + ((x) % HZ) * 1000 / HZ)
#endif

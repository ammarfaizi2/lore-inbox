Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266317AbRGFJD2>; Fri, 6 Jul 2001 05:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbRGFJDS>; Fri, 6 Jul 2001 05:03:18 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:5904 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S266317AbRGFJDG>;
	Fri, 6 Jul 2001 05:03:06 -0400
Message-ID: <005601c105fa$8be41cb0$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru> <20010704114530.A1030@twiddle.net> <003e01c10522$1c9cf580$4d28d0c3@jscc.ru> <20010705134306.A2071@jurassic.park.msu.ru>
Subject: Re: [patch] Re: alpha - generic_init_pit - why using RTC for calibration?
Date: Fri, 6 Jul 2001 13:03:38 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With both variants even on a 166MHz CPU you'll get above 1e-7 precision,
> which is way above accuracy of any crystal oscillator.
    No, this is not so - this line

return ((long)cc * 1000000) / CALIBRATE_TIME;

    truncates the result to the MHZ because of the '* 1000000' statement (cc
is an int value, so you just loose the precision). This works ok for x86,
because x86 uses this value with an accuracy to MHz, but this is not enough
for Alphas (see gettimeofday - we're relies rpcc for calculation). Try to
pass 'cycle=666000000' to your kernel and when run ntp - you're out of luck
for clock sync.

    But the most innacuracy comes from

#define CALIBRATE_TIME (5 * 1000020/HZ)

    1000020 != CLOCK_TICK_RATE - why? So, with this stuff we're loosing more
than 100 KHz (again, this ok for x86) ....

>
> > has cc's type changed to 'unsigned int' to prevent problems when rpcc
> > overflows.
>
> The only difference is that you'll have extra 'zap' instruction converting
> 'unsigned int' to 'unsigned long'.
    No, this is not so. The problem is with the sign bit of int, so,

    (long)(int)0x80000000 != (long)(unsigned int)0x80000000, and
(long)(int)0x80000000 < 0 and you will get negative frequency value (yes we
current boxes we're not overflowing, but let's look for the future). Funny?
;-))

Oleg.

P.S. Ivan, you can reach me by dialing 938-6412 in Moscow.



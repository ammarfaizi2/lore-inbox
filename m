Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271629AbRHUKGt>; Tue, 21 Aug 2001 06:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271630AbRHUKGc>; Tue, 21 Aug 2001 06:06:32 -0400
Received: from miranda.axis.se ([193.13.178.2]:9155 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S271629AbRHUKGP>;
	Tue, 21 Aug 2001 06:06:15 -0400
Message-ID: <256901c12a29$03e30580$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk>,
        "David Lang" <david.lang@digitalinsight.com>
Cc: "David Schwartz" <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108210042520.32719-100000@dlang.diginsite.com> <608038730.998389316@[169.254.45.213]>
Subject: Re: Entropy from net devices - keyboard & IDE just as 'bad' (better timing in random.c)
Date: Tue, 21 Aug 2001 12:06:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alex Bligh - linux-kernel <linux-kernel@alex.org.uk> wrote:

> Well, I was arguing that network traffic was sufficiently unobservable
> that it constitutes valid entropy under some circumstances, until I went
> and read the code. It is so (it seems to me) on some i386 versions, where
> the cycle clock is used. It is definitely not (and neither are any of
> the other interrupt timings) where jiffies are used, for a start
> because /proc/interrupts gives you the jiffie count (timer interrupts)
> and the other interrupt counters simultaneously. So my argument is
> that in some situations (where you know are happy with the extent
> to which there is no observation of your wire locally), net IRQs
> are no worse than the other sources of entropy, and sometimes they
> are better (consider keyboards connected by radio). Obviously, in
> cases like 802.11, they are substantially worse (and, no doubt, we
> could omit Robert's patch from things like 802.11 drivers which
> are obvious 'don't do that' cases).

How about improving that with something like this (not test compiled)

static void add_timer_randomness(struct timer_rand_state *state, unsigned
num)
{
 __u32  time;
 __s32  delta, delta2, delta3;
 int  entropy = 0;

#if defined (__i386__)
 if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) {
  __u32 high;
  __asm__(".byte 0x0f,0x31"
   :"=a" (time), "=d" (high));
  num ^= high;
 } else {
  time = jiffies;
 }
#else
+ struct timeval tv;
+ do_gettimeofday(&tv);
+ num ^= tv.tv_usec;
 time = jiffies;
#endif

Of course do_gettimeofday() is probably a little to heavyweigt for doing
this,
so how about adding an arch specific macro:
GET_JIFFIES_USEC()
that returns the number of microseconds in the current jiffie and simply
use that to modify the num?

/Johan



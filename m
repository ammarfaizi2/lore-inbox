Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319185AbSHTQXv>; Tue, 20 Aug 2002 12:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319186AbSHTQXv>; Tue, 20 Aug 2002 12:23:51 -0400
Received: from miranda.axis.se ([193.13.178.2]:4016 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S319185AbSHTQXu>;
	Tue, 20 Aug 2002 12:23:50 -0400
From: johan.adolfsson@axis.com
Message-ID: <03f401c24867$2d5260c0$b9b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Oliver Xymoron" <oxymoron@waste.org>, <johan.adolfsson@axis.com>
Cc: <linux-kernel@vger.kernel.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org>
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Date: Tue, 20 Aug 2002 18:32:29 +0200
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


From: "Oliver Xymoron" <oxymoron@waste.org>
> On Tue, Aug 20, 2002 at 11:31:10AM +0200, johan.adolfsson@axis.com wrote:
> > The cris architecture don't have any tsc, but it has a couple of
> > timer registers that can be used to get better than jiffie resolution.
> >
> > I set the time to a 40 us resolution counter with a slight
> > "jump" since lower 8 bit only counts from 0 to 249,
> > the patch does not take wrapping of the register into account either
> > to save some cycles, is that a problem or a good thing?
> 
> That should be fine. More important is actually scaling the entropy
> count based on the timing granularity of the source. Keyboards and
> mice tend to have a granularity of about 1khz so timestamps better
> than milliseconds 'invent' entropy in the current code.

The ETRAX chips where the cris architecture is used is typically used in
headless embedded devices connected to a network. Currently I don't think 
we use SA_RANDOM anywhere in our device drivers although it would be
nice to be able to use network and other interfaces as entropy/randomness
source (serial, parallel etc.) without to much concerns.

> > The num is xor:d with the value from 2 timer registers,
> > which in turn contains different fields breifly described below.
> > 
> > Does the patch below look sane?
> 
> Looks fine, but I think we want to come up with a cleaner scheme of
> having per-arch high-res timestamps. I'd hate to have that grow to
> several pages of ifdefs and not have it available anywhere else. 

Yes, I've seen the discussion before.
Any idea of how such a solution should look like?
Put an inline function or macro in asm/timex.h (?) together with an
ARCH_HAS_RANDOM_TIMESTAMP define?

E.g. like this for i386:
#define ARCH_HAS_RANDOM_TIMESTAMP
#define RANDOM_TIMESTAMP(time, num) do{\
 if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) { \
  __u32 high; \
  rdtsc(time, high); \
  num ^= high; \
 } else { \
  time = jiffies; \
 } \
}while(0)
 
And then in random.c:
ifdef ARCH_HAS_RANDOM_TIMESTAMP
  RANDOM_TIMESTAMP(time, num);
#else
  time = jiffies;
#endif

/Johan



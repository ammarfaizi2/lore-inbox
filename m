Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319199AbSHTRCH>; Tue, 20 Aug 2002 13:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319200AbSHTRCH>; Tue, 20 Aug 2002 13:02:07 -0400
Received: from waste.org ([209.173.204.2]:22484 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319199AbSHTRCG>;
	Tue, 20 Aug 2002 13:02:06 -0400
Date: Tue, 20 Aug 2002 12:06:01 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: johan.adolfsson@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Message-ID: <20020820170601.GD19225@waste.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org> <03f401c24867$2d5260c0$b9b270d5@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f401c24867$2d5260c0$b9b270d5@homeip.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 06:32:29PM +0200, johan.adolfsson@axis.com wrote:
> 
> From: "Oliver Xymoron" <oxymoron@waste.org>
> > On Tue, Aug 20, 2002 at 11:31:10AM +0200, johan.adolfsson@axis.com wrote:
> > > The cris architecture don't have any tsc, but it has a couple of
> > > timer registers that can be used to get better than jiffie resolution.
> > >
> > > I set the time to a 40 us resolution counter with a slight
> > > "jump" since lower 8 bit only counts from 0 to 249,
> > > the patch does not take wrapping of the register into account either
> > > to save some cycles, is that a problem or a good thing?
> > 
> > That should be fine. More important is actually scaling the entropy
> > count based on the timing granularity of the source. Keyboards and
> > mice tend to have a granularity of about 1khz so timestamps better
> > than milliseconds 'invent' entropy in the current code.
> 
> The ETRAX chips where the cris architecture is used is typically used in
> headless embedded devices connected to a network. Currently I don't think 
> we use SA_RANDOM anywhere in our device drivers although it would be
> nice to be able to use network and other interfaces as entropy/randomness
> source (serial, parallel etc.) without to much concerns.

See my recent (lengthy) posts on this subject.
 
> > > The num is xor:d with the value from 2 timer registers,
> > > which in turn contains different fields breifly described below.
> > > 
> > > Does the patch below look sane?
> > 
> > Looks fine, but I think we want to come up with a cleaner scheme of
> > having per-arch high-res timestamps. I'd hate to have that grow to
> > several pages of ifdefs and not have it available anywhere else. 
> 
> Yes, I've seen the discussion before.
> Any idea of how such a solution should look like?
> Put an inline function or macro in asm/timex.h (?) together with an
> ARCH_HAS_RANDOM_TIMESTAMP define?

I don't think we want to make it specific to random. I think we just
want to call it hires. 

> E.g. like this for i386:
> #define ARCH_HAS_RANDOM_TIMESTAMP
> #define RANDOM_TIMESTAMP(time, num) do{\
>  if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) { \
>   __u32 high; \
>   rdtsc(time, high); \
>   num ^= high; \
>  } else { \
>   time = jiffies; \
>  } \
> }while(0)
>  
> And then in random.c:
> ifdef ARCH_HAS_RANDOM_TIMESTAMP
>   RANDOM_TIMESTAMP(time, num);
> #else
>   time = jiffies;
> #endif

Again, too random-specific. And we need a way to get the timescale.
Perhaps something like:

speed=get_timestamp_khz;
lowbits=get_hires_timestamp();

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbTCGBXd>; Thu, 6 Mar 2003 20:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbTCGBXc>; Thu, 6 Mar 2003 20:23:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25592 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261327AbTCGBXV>;
	Thu, 6 Mar 2003 20:23:21 -0500
Message-ID: <3E67F6C6.6090708@mvista.com>
Date: Thu, 06 Mar 2003 17:32:54 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Joel.Becker@oracle.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, wim.coekaerts@oracle.com
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A0
References: <1046996126.16608.509.camel@w-jstultz2.beaverton.ibm.com>
In-Reply-To: <1046996126.16608.509.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> All,
> 	Recently I've been working with Joel Becker, author of the
> hangcheck-timer code (already accepted into 2.5) to resolve issues when
> running his code on systems without synced TSCs. 
> 
> The basic problem is that the hangcheck-timer code (Required for Oracle)
> needs a accurate hard clock which can be used to detect OS stalls (due
> to udelay() or pci bus hangs) that would cause system time to skew (its
> sort of a sanity check that insures the system's notion of time is
> accurate). However, currently they are using get_cycles() to fetch the
> cpu's TSC register, thus this does not work on systems w/o a synced TSC.
> As suggested by Andi Kleen (see thread here:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0302.0/1234.html ) I've
> worked with Joel and others to implement the monotonic_clock()
> interface.
> 
> This interface returns a unsigned long long representing the number of
> nanoseconds that has passed since time_init(). 
> 
> Since we're dealing with 64bit values the cost of the math required to
> do the cycles->ns conversion is a big concern. I'd be very happy if
> someone could suggest a faster way. 

IMHO I solved this problem in the high-res timers patch.  I have 
posted the core of the conversion stuff as a path (last night at 
23:24) with this subject "[PATCH] Functions to do easy scaled math." 
It consists of a header file containing a handful of inline asm code 
to do the messy stuff (i.e. the stuff C can't do due to standard 
restrictions).  I also provided an asm-generic version to fill the gap 
on other archs.  Oh, and there is even a text file to explain it all.

-g

> 
> Future plans to the interface include properly handling cpu_freq changes
> and porting to the different arches.
> 
> Comments and suggestions requested, flames expected :)
> 
> thanks
> -john
> 
> diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> --- a/arch/i386/kernel/time.c	Thu Mar  6 16:12:27 2003
> +++ b/arch/i386/kernel/time.c	Thu Mar  6 16:12:27 2003
> @@ -138,6 +138,19 @@
>  	clock_was_set();
>  }
>  
> +unsigned long long monotonic_clock(void)
> +{
> +	unsigned long long ret;
> +	unsigned long seq;
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		ret = timer->monotonic_clock();
> +	} while (read_seqretry(&xtime_lock, seq));
> +	return ret;
> +}
> +EXPORT_SYMBOL(monotonic_clock);
> +
> +
>  /*
>   * In order to set the CMOS clock precisely, set_rtc_mmss has to be
>   * called 500 ms after the second nowtime has started, because when
> diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
> --- a/arch/i386/kernel/timers/timer_cyclone.c	Thu Mar  6 16:12:27 2003
> +++ b/arch/i386/kernel/timers/timer_cyclone.c	Thu Mar  6 16:12:27 2003
> @@ -27,19 +27,24 @@
>  #define CYCLONE_MPMC_OFFSET 0x51D0
>  #define CYCLONE_MPCS_OFFSET 0x51A8
>  #define CYCLONE_TIMER_FREQ 100000000
> -
> +#define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /*40 bit mask*/
>  int use_cyclone = 0;
>  
>  static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
> -static u32 last_cyclone_timer;
> +static u32 last_cyclone_low;
> +static u32 last_cyclone_high;
> +static unsigned long long monotonic_base;
>  
>  static void mark_offset_cyclone(void)
>  {
>  	int count;
> +	unsigned long long this_offset, last_offset;
> +	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
> +	
>  	spin_lock(&i8253_lock);
>  	/* quickly read the cyclone timer */
> -	if(cyclone_timer)
> -		last_cyclone_timer = cyclone_timer[0];
> +	last_cyclone_high = cyclone_timer[1];
> +	last_cyclone_low = cyclone_timer[0];
>  
>  	/* calculate delay_at_last_interrupt */
>  	outb_p(0x00, 0x43);     /* latch the count ASAP */
> @@ -50,6 +55,10 @@
>  
>  	count = ((LATCH-1) - count) * TICK_SIZE;
>  	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
> +
> +	/* update the monotonic base value */
> +	this_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
> +	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
>  }
>  
>  static unsigned long get_offset_cyclone(void)
> @@ -63,7 +72,7 @@
>  	offset = cyclone_timer[0];
>  
>  	/* .. relative to previous jiffy */
> -	offset = offset - last_cyclone_timer;
> +	offset = offset - last_cyclone_low;
>  
>  	/* convert cyclone ticks to microseconds */	
>  	/* XXX slow, can we speed this up? */
> @@ -73,6 +82,21 @@
>  	return delay_at_last_interrupt + offset;
>  }
>  
> +static unsigned long long monotonic_clock_cyclone(void)
> +{
> +	
> +	u32 now_low = cyclone_timer[0];
> +	u32 now_high = cyclone_timer[1];
> +	unsigned long long last_offset, this_offset;
> +	unsigned long long ret;
> +	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
> +	this_offset = ((unsigned long long)now_high<<32)|now_low;
> +	
> +	ret = monotonic_base + ((this_offset - last_offset)&CYCLONE_TIMER_MASK);
> +	ret = ret * (1000000000 / CYCLONE_TIMER_FREQ);
> +	return ret;
> +}
> +
>  static int init_cyclone(void)
>  {
>  	u32* reg;	
> @@ -190,5 +214,6 @@
>  	.init = init_cyclone, 
>  	.mark_offset = mark_offset_cyclone, 
>  	.get_offset = get_offset_cyclone,
> +	.monotonic_clock =	monotonic_clock_cyclone,
>  	.delay = delay_cyclone,
>  };
> diff -Nru a/arch/i386/kernel/timers/timer_none.c b/arch/i386/kernel/timers/timer_none.c
> --- a/arch/i386/kernel/timers/timer_none.c	Thu Mar  6 16:12:27 2003
> +++ b/arch/i386/kernel/timers/timer_none.c	Thu Mar  6 16:12:27 2003
> @@ -15,6 +15,11 @@
>  	return 0;
>  }
>  
> +static unsigned long long monotonic_clock_none(void)
> +{
> +	return 0;
> +}
> +
>  static void delay_none(unsigned long loops)
>  {
>  	int d0;
> @@ -33,5 +38,6 @@
>  	.init =		init_none, 
>  	.mark_offset =	mark_offset_none, 
>  	.get_offset =	get_offset_none,
> +	.monotonic_clock =	monotonic_clock_none,
>  	.delay = delay_none,
>  };
> diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
> --- a/arch/i386/kernel/timers/timer_pit.c	Thu Mar  6 16:12:27 2003
> +++ b/arch/i386/kernel/timers/timer_pit.c	Thu Mar  6 16:12:27 2003
> @@ -27,6 +27,11 @@
>  	/* nothing needed */
>  }
>  
> +static unsigned long long monotonic_clock_pit(void)
> +{
> +	return 0;
> +}
> +
>  static void delay_pit(unsigned long loops)
>  {
>  	int d0;
> @@ -141,5 +146,6 @@
>  	.init =		init_pit, 
>  	.mark_offset =	mark_offset_pit, 
>  	.get_offset =	get_offset_pit,
> +	.monotonic_clock = monotonic_clock_pit,
>  	.delay = delay_pit,
>  };
> diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
> --- a/arch/i386/kernel/timers/timer_tsc.c	Thu Mar  6 16:12:27 2003
> +++ b/arch/i386/kernel/timers/timer_tsc.c	Thu Mar  6 16:12:27 2003
> @@ -23,6 +23,45 @@
>  static int delay_at_last_interrupt;
>  
>  static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
> +static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
> +static unsigned long long monotonic_base;
> +
> +
> +/*
> + * accurate 64-bit/32-bit division, stolen from smpboot.c
> + */
> +unsigned long long div64 (unsigned long long a, unsigned long b0)
> +{
> +	unsigned int a1, a2;
> +	unsigned long long res;
> +
> +	a1 = ((unsigned int*)&a)[0];
> +	a2 = ((unsigned int*)&a)[1];
> +
> +	res = a1/b0 +
> +		(unsigned long long)a2 * (unsigned long long)(0xffffffff/b0) +
> +		a2 / b0 +
> +		(a2 * (0xffffffff % b0)) / b0;
> +
> +	return res;
> +}
> +
> +static inline unsigned long long cycles_2_ns(unsigned long long cyc)
> +{
> +	unsigned long long ret;
> +	unsigned long cpu_mhz = cpu_khz/1000;
> +
> +	/* convert from cycles(64bits) => nanoseconds (64bits)
> +	 *  basic equation:
> +	 *    cycles / ((cycles / sec) * (1sec / 10^9ns)) = ns
> +	 *    cycles / ((cpu_mhz * 1000000) / 10^9)) = ns
> +	 *    cycles / (cpu_mhz / 10^3) = ns
> +	 *    cycles * 10^3 / cpu_mhz = ns
> +	 */
> +	ret = cyc * 1000;
> +	ret = div64(ret,cpu_mhz);
> +	return ret;
> +}
>  
>  /* Cached *multiplier* to convert TSC counts to microseconds.
>   * (see the equation below).
> @@ -60,11 +99,25 @@
>  	return delay_at_last_interrupt + edx;
>  }
>  
> +static unsigned long long monotonic_clock_tsc(void)
> +{
> +	unsigned long long last_offset, this_offset;
> +	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
> +
> +	/* Read the Time Stamp Counter */
> +	rdtscll(this_offset);
> +
> +	/* return the value in ns */
> +	return  monotonic_base + cycles_2_ns(this_offset - last_offset);
> +}
> +
>  static void mark_offset_tsc(void)
>  {
>  	int count;
>  	int countmp;
>  	static int count1=0, count2=LATCH;
> +	unsigned long long this_offset, last_offset;
> +	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
>  	/*
>  	 * It is important that these two operations happen almost at
>  	 * the same time. We do the RDTSC stuff first, since it's
> @@ -79,7 +132,7 @@
>  	
>  	/* read Pentium cycle counter */
>  
> -	rdtscl(last_tsc_low);
> +	rdtsc(last_tsc_low, last_tsc_high);
>  
>  	spin_lock(&i8253_lock);
>  	outb_p(0x00, 0x43);     /* latch the count ASAP */
> @@ -104,6 +157,11 @@
>  
>  	count = ((LATCH-1) - count) * TICK_SIZE;
>  	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
> +	
> +	/* update the monotonic base value */
> +	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
> +	monotonic_base += cycles_2_ns(this_offset - last_offset);
> +
>  }
>  
>  static void delay_tsc(unsigned long loops)
> @@ -326,5 +384,6 @@
>  	.init =		init_tsc,
>  	.mark_offset =	mark_offset_tsc, 
>  	.get_offset =	get_offset_tsc,
> +	.monotonic_clock =	monotonic_clock_tsc,
>  	.delay = delay_tsc,
>  };
> diff -Nru a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
> --- a/drivers/char/hangcheck-timer.c	Thu Mar  6 16:12:27 2003
> +++ b/drivers/char/hangcheck-timer.c	Thu Mar  6 16:12:27 2003
> @@ -78,11 +78,13 @@
>  static struct timer_list hangcheck_ticktock =
>  		TIMER_INITIALIZER(hangcheck_fire, 0, 0);
>  
> +extern unsigned long long monotonic_clock(void);
> +
>  static void hangcheck_fire(unsigned long data)
>  {
>  	unsigned long long cur_tsc, tsc_diff;
>  
> -	cur_tsc = get_cycles();
> +	cur_tsc = monotonic_clock();
>  
>  	if (cur_tsc > hangcheck_tsc)
>  		tsc_diff = cur_tsc - hangcheck_tsc;
> @@ -98,7 +100,7 @@
>  		}
>  	}
>  	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
> -	hangcheck_tsc = get_cycles();
> +	hangcheck_tsc = monotonic_clock();
>  }
>  
>  
> @@ -108,10 +110,10 @@
>  	       VERSION_STR, hangcheck_tick, hangcheck_margin);
>  
>  	hangcheck_tsc_margin = hangcheck_margin + hangcheck_tick;
> -	hangcheck_tsc_margin *= HZ;
> -	hangcheck_tsc_margin *= current_cpu_data.loops_per_jiffy;
> +	hangcheck_tsc_margin *= 1000000000;
> +
>  
> -	hangcheck_tsc = get_cycles();
> +	hangcheck_tsc = monotonic_clock();
>  	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
>  
>  	return 0;
> diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
> --- a/include/asm-i386/timer.h	Thu Mar  6 16:12:27 2003
> +++ b/include/asm-i386/timer.h	Thu Mar  6 16:12:27 2003
> @@ -14,6 +14,7 @@
>  	int (*init)(void);
>  	void (*mark_offset)(void);
>  	unsigned long (*get_offset)(void);
> +	unsigned long long (*monotonic_clock)(void);
>  	void (*delay)(unsigned long);
>  };
>  
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261620AbTCKViH>; Tue, 11 Mar 2003 16:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261621AbTCKViH>; Tue, 11 Mar 2003 16:38:07 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:4086 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261620AbTCKViB>;
	Tue, 11 Mar 2003 16:38:01 -0500
Message-ID: <3E6E5989.6060301@mvista.com>
Date: Tue, 11 Mar 2003 13:47:53 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Joel.Becker@oracle.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, wim.coekaerts@oracle.com
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A1
References: <1047411561.16614.684.camel@w-jstultz2.beaverton.ibm.com> <1047411650.16613.687.camel@w-jstultz2.beaverton.ibm.com>
In-Reply-To: <1047411650.16613.687.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john,

Some comments below on the scaling.

On a related note, I would like to extend the CLOCK_MONOTONIC code to 
the same res as CLOCK_REALTIME in the POSIX clocks and timers patch. 
The patch uses jiffies_64 for CLOCK_MONOTONIC, so what I would like to 
do is use get_offset() to fill in the sub_jiffies part. Is this 
function available (i.e. timer->get_offset()) on all archs?

It seems to me that the lost jiffies should be rolled into 
get_offset().  Have you considered doing this?

-g

john stultz wrote:
> <sigh> Patch below.
> 
> thanks
> -john
> 
> 
> diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> --- a/arch/i386/kernel/time.c	Tue Mar 11 11:24:04 2003
> +++ b/arch/i386/kernel/time.c	Tue Mar 11 11:24:04 2003
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
> --- a/arch/i386/kernel/timers/timer_cyclone.c	Tue Mar 11 11:24:04 2003
> +++ b/arch/i386/kernel/timers/timer_cyclone.c	Tue Mar 11 11:24:04 2003
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
> --- a/arch/i386/kernel/timers/timer_none.c	Tue Mar 11 11:24:04 2003
> +++ b/arch/i386/kernel/timers/timer_none.c	Tue Mar 11 11:24:04 2003
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
> --- a/arch/i386/kernel/timers/timer_pit.c	Tue Mar 11 11:24:04 2003
> +++ b/arch/i386/kernel/timers/timer_pit.c	Tue Mar 11 11:24:04 2003
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
> --- a/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 11 11:24:04 2003
> +++ b/arch/i386/kernel/timers/timer_tsc.c	Tue Mar 11 11:24:04 2003
> @@ -23,6 +23,38 @@
>  static int delay_at_last_interrupt;
>  
>  static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
> +static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
> +static unsigned long long monotonic_base;
> +
> +
> +/* convert from cycles(64bits) => nanoseconds (64bits)
> + *  basic equation:
> + *		ns = cycles / (freq / ns_per_sec)
> + *		ns = cycles * (ns_per_sec / freq)
> + *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
> + *		ns = cycles * (10^3 / cpu_mhz)
> + *
> + *	Then we use scaling math (suggested by george@mvista.com) to get:
> + *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
> + *		ns = cycles * cyc2ns_scale / SC
> + *
> + *	And since SC is a constant power of two, we can convert the div
> + *  into a shift.   
> + *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
> + */
> +static unsigned long cyc2ns_scale; 
> +#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen*/
> +
> +static inline set_cyc2ns_scale(unsigned long cpu_mhz)
> +{
> +	cyc2ns_scale = (1000 * (1<<CYC2NS_SCALE_FACTOR))/cpu_mhz;
The function would be:
div_sc_n(const N, unsigned long a, unsigned long b);
returns (a << N) / b

The only advantage to this would be the ability to handle a u64 as a 
result of the (a<<b) (assumes the div moves all significant bits to a 
u32).
+
> +}
> +
> +static inline unsigned long long cycles_2_ns(unsigned long long cyc)
> +{
> +	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;

I think this is a problem.  cyc is u64 so you are doing a 64 bit mpy 
which C will do by draging in the 64-bit math lib, something we don't 
want in the kernel.

Since you want u64=u64*u32 the best the package can do is:
mpy_ll_X_l_ll(unsigned long long  mpy1, unsigned long mpy2);
returns (unsigned long long)(mpy1 * mpy2)

This requires two mpy in the best of cases.  The actual code leans on 
the mpy_l_X_l_ll() which does u64=u32*u32.  Here is what it looks like 
in sc_math.h:
mpy_ll_X_l_ll(unsigned long long  mpy1, unsigned long mpy2)
{
	unsigned long long result = mpy_l_X_l_ll((unsigned long)mpy1, mpy2);
	result +=  (mpy_l_X_l_ll((long)(mpy1 >> 32), mpy2) << 32);
	return result;
}



> +}
> +
>  
>  /* Cached *multiplier* to convert TSC counts to microseconds.
>   * (see the equation below).
> @@ -60,11 +92,25 @@
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
> @@ -79,7 +125,7 @@
>  	
>  	/* read Pentium cycle counter */
>  
> -	rdtscl(last_tsc_low);
> +	rdtsc(last_tsc_low, last_tsc_high);
>  
>  	spin_lock(&i8253_lock);
>  	outb_p(0x00, 0x43);     /* latch the count ASAP */
> @@ -104,6 +150,11 @@
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
> @@ -293,6 +344,7 @@
>  	                	"0" (eax), "1" (edx));
>  				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
>  			}
> +			set_cyc2ns_scale(cpu_khz/1000);
>  			return 0;
>  		}
>  	}
> @@ -326,5 +378,6 @@
>  	.init =		init_tsc,
>  	.mark_offset =	mark_offset_tsc, 
>  	.get_offset =	get_offset_tsc,
> +	.monotonic_clock =	monotonic_clock_tsc,
>  	.delay = delay_tsc,
>  };
> diff -Nru a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
> --- a/drivers/char/hangcheck-timer.c	Tue Mar 11 11:24:04 2003
> +++ b/drivers/char/hangcheck-timer.c	Tue Mar 11 11:24:04 2003
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
> --- a/include/asm-i386/timer.h	Tue Mar 11 11:24:04 2003
> +++ b/include/asm-i386/timer.h	Tue Mar 11 11:24:04 2003
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
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


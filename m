Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <972010-26836>; Mon, 13 Jul 1998 16:20:54 -0400
Received: from val5-237.abo.wanadoo.fr ([193.252.200.237]:62209 "EHLO lw2l.bnc.interdrome.fr" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <972134-26836>; Mon, 13 Jul 1998 15:54:38 -0400
From: Andrew Derrick Balsa <andrebalsa@altern.org>
Reply-To: andrebalsa@altern.org
To: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
Subject: Re: new version of time.c
Date: Mon, 13 Jul 1998 22:50:25 +0200
X-Mailer: KMail [version 0.7.9]
Content-Type: Multipart/Mixed; boundary="Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd"
Cc: linux-kernel@vger.rutgers.edu, Philip Gladstone <philip@raptor.com>
References: <Pine.GSO.3.96.980713150837.8292B-100000@miris.lcs.mit.edu>
MIME-Version: 1.0
Message-Id: <98071323124800.00482@lw2l.bnc.interdrome.fr>
Sender: owner-linux-kernel@vger.rutgers.edu


--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi Scott, Philip,

On Mon, 13 Jul 1998, C. Scott Ananian wrote:
>On Mon, 13 Jul 1998, Philip Gladstone wrote:
>
>> Actually, I'm now getting concerned about interrupts happening
>> between doing the LATCH and the RDTSC. [pause to try an experiment]
>> 
>> Yup -- adding a cli() / restore pair around the crucial code
>> in pentium_timer_interrupt helps a lot.
>
>Makes sense.  Now we ought to start integrating/cleaning all these
>patches, test suites, and ideas.

Good Idea. :-)

So I integrated Philip's code with the new time.c code for 2.0.x. Recompiled the
kernel and am running it right now. So far so good, whether I turn on the Cyrix
suspend-on-halt feature or not. :-)

And tested it using Philip's pent_time.c test code.

If I test it with suspend-on-halt ON, I get a quotient value of zero, hence a
division by zero and of course the seg fault and core dump. This was expected,
since it's exactly what the "old" time.c code did. :-)

If I test with suspend-on-halt OFF, I get the attached sample output. (all
tests made from within an xterm, on a relatively idle box). 

I am also attaching the "new" time.c. It's a drop-in replacement for the
/arch/i386/kernel/time.c in 2.0.32, 2.0.33 and 2.0.34.

Finally, I am attaching my /proc/cpuinfo; needs a small patch to setup.c...
once you install the new time.c code, obviously ;-)

Cheers,
---------------------
Andrew D. Balsa
andrebalsa@altern.org


--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: text/x-c;
  name="time.c"
Content-Transfer-Encoding: 8bit
Content-Description: A drop-in replacement for /arch/i386/kernel/time.c
Content-Disposition: attachment; filename="time.c"

/*
 *  linux/arch/i386/kernel/time.c
 *
 *  Copyright (C) 1991, 1992, 1995  Linus Torvalds
 *
 * This file contains the PC-specific time handling details:
 * reading the RTC at bootup, etc..
 * 1994-07-02   Alan Modra
 *		fixed set_rtc_mmss, fixed time.year for >= 2000, new mktime
 * 1995-03-26   Markus Kuhn
 *      	fixed 500 ms bug at call to set_rtc_mmss, fixed DS12887
 *      	precision CMOS clock update
 * 1996-05-03   Ingo Molnar
 *      	fixed time warps in do_[slow|fast]_gettimeoffset()
 * 1997-09-10	Updated NTP code according to technical memorandum Jan '96
 *		"A Kernel Model for Precision Timekeeping" by Dave Mills
 * 1998-05-23	C. Scott Ananian & Andrew D. Balsa
 *		More robust do_fast_gettimeoffset() algorithm implemented
 *		(works with APM, Cyrix 6x86MX and Centaur C6),
 *		drift-proof precision TSC calibration on boot.
 */

#include <linux/errno.h>
#include <linux/sched.h>
#include <linux/kernel.h>
#include <linux/param.h>
#include <linux/string.h>
#include <linux/mm.h>
#include <linux/interrupt.h>
#include <linux/time.h>
#include <linux/delay.h>

#include <asm/segment.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/delay.h>

#include <linux/mc146818rtc.h>
#include <linux/timex.h>
#include <linux/config.h>

extern int setup_x86_irq(int, struct irqaction *);

unsigned long cpu_hz;	/* Detected as we calibrate the TSC */

/* Number of usecs that the last interrupt was delayed */
static int delay_at_last_interrupt;

static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */

/* Cached *multiplier* to convert TSC counts to microseconds.
 * (see the equation below).
 * Equal to 2^32 * (1 / (clocks per usec) ).
 * Initialized in time_init.
 */
static unsigned long fast_gettimeoffset_quotient=0;

static unsigned long do_fast_gettimeoffset(void)
{
	register unsigned long eax asm("ax");
	register unsigned long edx asm("dx");

	/* Read the Time Stamp Counter */
	__asm__(".byte 0x0f,0x31"
		:"=a" (eax), "=d" (edx));

	/* .. relative to previous jiffy (32 bits is enough) */
	edx = 0;
	eax -= last_tsc_low;	/* tsc_low delta */

	/*
         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient.
         *             = (tsc_low delta) / (clocks_per_usec)
         *             = (tsc_low delta) / (clocks_per_jiffy / usecs_per_jiffy)
	 *
	 * Using a mull instead of a divl saves up to 31 clock cycles
	 * in the critical path.
         */

	__asm__("mull %2"
		:"=a" (eax), "=d" (edx)
		:"r" (fast_gettimeoffset_quotient),
		 "0" (eax), "1" (edx));

	/*
 	 * Due to rounding errors (and jiffies inconsistencies),
	 * we need to check the result so that we'll get a timer
	 * that is monotonic.
	 *
	 * We have a problem here, because this should _never_
	 * happen: we read the TSC at each timer interrupt in
	 * the interrupt handler (see pentium_timer_interrupt below),
	 * not in the bottom half handler.
	 * The problem is that some drivers may disable interrupts,
	 * then do all their I/O stuff which takes some time,
	 * and then call gettimeofday() without restoring the 
	 * interrupts status again.
	 */
	if (edx >= 1000020/HZ)
		edx = 1000020/HZ-1;
	/* At this point we hope that gettimeofday()
	 * isn't called again before the next
	 * timer interrupt updates last_timer_cc
	 * (we would get twice the same timestamp).
	 */

	return edx + delay_at_last_interrupt; /* our time offset in microseconds */
}

/* This function must be called with interrupts disabled 
 * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
 * 
 * However, the pc-audio speaker driver changes the divisor so that
 * it gets interrupted rather more often - it loads 64 into the
 * counter rather than 11932! This has an adverse impact on
 * do_gettimeoffset() -- it stops working! What is also not
 * good is that the interval that our timer function gets called
 * is no longer 10.0002 ms, but 9.9767 ms. To get around this
 * would require using a different timing source. Maybe someone
 * could use the RTC - I know that this can interrupt at frequencies
 * ranging from 8192Hz to 2Hz. If I had the energy, I'd somehow fix
 * it so that at startup, the timer code in sched.c would select
 * using either the RTC or the 8253 timer. The decision would be
 * based on whether there was any other device around that needed
 * to trample on the 8253. I'd set up the RTC to interrupt at 1024 Hz,
 * and then do some jiggery to have a version of do_timer that 
 * advanced the clock by 1/1024 s. Every time that reached over 1/100
 * of a second, then do all the old code. If the time was kept correct
 * then do_gettimeoffset could just return 0 - there is no low order
 * divider that can be accessed.
 *
 * Ideally, you would be able to use the RTC for the speaker driver,
 * but it appears that the speaker driver really needs interrupt more
 * often than every 120 us or so.
 *
 * Anyway, this needs more thought....		pjsg (1993-08-28)
 * 
 * If you are really that interested, you should be reading
 * comp.protocols.time.ntp!
 */

#define TICK_SIZE tick

static unsigned long do_slow_gettimeoffset(void)
{
	int count;
	static int count_p = 0;
	unsigned long offset = 0;
	static unsigned long jiffies_p = 0;

	/*
	 * cache volatile jiffies temporarily; we have IRQs turned off. 
	 */
	unsigned long jiffies_t;

	/* timer count may underflow right here */
	outb_p(0x00, 0x43);	/* latch the count ASAP */
	count = inb_p(0x40);	/* read the latched count */
	count |= inb(0x40) << 8;

 	jiffies_t = jiffies;

	/*
	 * avoiding timer inconsistencies (they are rare, but they happen)...
	 * there are three kinds of problems that must be avoided here:
	 *  1. the timer counter underflows
	 *  2. hardware problem with the timer, not giving us continuous time,
	 *     the counter does small "jumps" upwards on some Pentium systems,
	 *     thus causes time warps
	 *  3. we are after the timer interrupt, but the bottom half handler
	 *     hasn't executed yet.
	 */
	if( count > count_p ) {
		if( jiffies_t == jiffies_p ) {
			if( count > LATCH-LATCH/100 )
				offset = TICK_SIZE;
			else
				/*
				 * argh, the timer is bugging we cant do nothing 
				 * but to give the previous clock value.
				 */
				count = count_p;
		} else {
			if( test_bit(TIMER_BH, &bh_active) ) {
				/*
				 * we have detected a counter underflow.
			 	 */
				offset = TICK_SIZE;
				count_p = count;		
			} else {
				count_p = count;
				jiffies_p = jiffies_t;
			}
		}
	} else {
		count_p = count;
		jiffies_p = jiffies_t;
 	}


	count = ((LATCH-1) - count) * TICK_SIZE;
	count = (count + LATCH/2) / LATCH;

	return offset + count;
}

static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;

/*
 * This version of gettimeofday has microsecond resolution
 * and better than microsecond precision on fast x86 machines with TSC.
 */
void do_gettimeofday(struct timeval *tv)
{
	unsigned long flags;

	save_flags(flags);
	cli();
	*tv = xtime;
	tv->tv_usec += do_gettimeoffset();
	if (tv->tv_usec >= 1000000) {
		tv->tv_usec -= 1000000;
		tv->tv_sec++;
	}
	restore_flags(flags);
}

void do_settimeofday(struct timeval *tv)
{
	cli();
	/* This is revolting. We need to set the xtime.tv_usec
	 * correctly. However, the value in this location is
	 * is value at the last tick.
	 * Discover what correction gettimeofday
	 * would have done, and then undo it!
	 */
	tv->tv_usec -= do_gettimeoffset();

	if (tv->tv_usec < 0) {
		tv->tv_usec += 1000000;
		tv->tv_sec--;
	}

	xtime = *tv;
	time_adjust = 0;		/* stop active adjtime() */
	time_status |= STA_UNSYNC;
	time_state = TIME_ERROR;	/* p. 24, (a) */
	time_maxerror = NTP_PHASE_LIMIT;
	time_esterror = NTP_PHASE_LIMIT;
	sti();
}


/*
 * In order to set the CMOS clock precisely, set_rtc_mmss has to be
 * called 500 ms after the second nowtime has started, because when
 * nowtime is written into the registers of the CMOS clock, it will
 * jump to the next second precisely 500 ms later. Check the Motorola
 * MC146818A or Dallas DS12887 data sheet for details.
 *
 * BUG: This routine does not handle hour overflow properly; it just
 *      sets the minutes. Usually you'll only notice that after reboot!
 */
static int set_rtc_mmss(unsigned long nowtime)
{
	int retval = 0;
	int real_seconds, real_minutes, cmos_minutes;
	unsigned char save_control, save_freq_select;

	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);

	save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset prescaler */
	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);

	cmos_minutes = CMOS_READ(RTC_MINUTES);
	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
		BCD_TO_BIN(cmos_minutes);

	/*
	 * since we're only adjusting minutes and seconds,
	 * don't interfere with hour overflow. This avoids
	 * messing with unknown time zones but requires your
	 * RTC not to be off by more than 15 minutes
	 */
	real_seconds = nowtime % 60;
	real_minutes = nowtime / 60;
	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
		real_minutes += 30;		/* correct for half hour time zone */
	real_minutes %= 60;

	if (abs(real_minutes - cmos_minutes) < 30) {
		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
			BIN_TO_BCD(real_seconds);
			BIN_TO_BCD(real_minutes);
		}
		CMOS_WRITE(real_seconds,RTC_SECONDS);
		CMOS_WRITE(real_minutes,RTC_MINUTES);
	} else {
		printk(KERN_WARNING
		       "set_rtc_mmss: can't update from %d to %d\n",
		       cmos_minutes, real_minutes);
		retval = -1;
	}

	/* The following flags have to be released exactly in this order,
	 * otherwise the DS12887 (popular MC146818A clone with integrated
	 * battery and quartz) will not reset the oscillator and will not
	 * update precisely 500 ms later. You won't find this mentioned in
	 * the Dallas Semiconductor data sheets, but who believes data
	 * sheets anyway ...                           -- Markus Kuhn
	 */
	CMOS_WRITE(save_control, RTC_CONTROL);
	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);

	return retval;
}

/* last time the cmos clock got updated */
static long last_rtc_update = 0;

/*
 * timer_interrupt() needs to keep up the real-time clock,
 * as well as call the "do_timer()" routine every clocktick
 */
static inline void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	do_timer(regs);

	/*
	 * If we have an externally synchronized Linux clock, then update
	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
	 * called as close as possible to 500 ms before the new second starts.
	 */
	if ((time_status & STA_UNSYNC) == 0 &&
	    xtime.tv_sec > last_rtc_update + 660 &&
	    xtime.tv_usec > 500000 - (tick >> 1) &&
	    xtime.tv_usec < 500000 + (tick >> 1))
	  if (set_rtc_mmss(xtime.tv_sec) == 0)
	    last_rtc_update = xtime.tv_sec;
	  else
	    last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
	/* As we return to user mode fire off the other CPU schedulers.. this is 
	   basically because we don't yet share IRQ's around. This message is
	   rigged to be safe on the 386 - basically it's a hack, so don't look
	   closely for now.. */
	/*smp_message_pass(MSG_ALL_BUT_SELF, MSG_RESCHEDULE, 0L, 0); */
	    
}

/*
 * This is the same as the above, except we _also_ save the current
 * Time Stamp Counter value at the time of the timer interrupt, so that
 * we later on can estimate the time of day more exactly.
 */
static void pentium_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
	register unsigned long edx asm("dx");
        int count, flags;

        /* It is important that these two operations happen almost at the
         * same time. We do the RDTSC stuff first, since it's faster. To
         * avoid any inconsistencies, we disable interrupts.
         */
	
	save_flags(flags);
	cli(); 
	/* read Pentium cycle counter */
	__asm__(".byte 0x0f,0x31"
		:"=a" (last_tsc_low),
		 "=d" (edx));

        outb_p(0x00, 0x43);     /* latch the count ASAP */
        restore_flags(flags);

        count = inb_p(0x40);    /* read the latched count */
        count |= inb(0x40) << 8;

        count = ((LATCH-1) - count) * TICK_SIZE;
        delay_at_last_interrupt = (count + LATCH/2) / LATCH;
       
	timer_interrupt(irq, NULL, regs);
}

/* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
 * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
 * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
 *
 * [For the Julian calendar (which was used in Russia before 1917,
 * Britain & colonies before 1752, anywhere else before 1582,
 * and is still in use by some communities) leave out the
 * -year/100+year/400 terms, and add 10.]
 *
 * This algorithm was first published by Gauss (I think).
 *
 * WARNING: this function will overflow on 2106-02-07 06:28:16 on
 * machines were long is 32-bit! (However, as time_t is signed, we
 * will already get problems at other places on 2038-01-19 03:14:08)
 */
static inline unsigned long mktime(unsigned int year, unsigned int mon,
	unsigned int day, unsigned int hour,
	unsigned int min, unsigned int sec)
{
	if (0 >= (int) (mon -= 2)) {	/* 1..12 -> 11,12,1..10 */
		mon += 12;	/* Puts Feb last since it has leap day */
		year -= 1;
	}
	return (((
	    (unsigned long)(year/4 - year/100 + year/400 + 367*mon/12 + day) +
	      year*365 - 719499
	    )*24 + hour /* now have hours */
	   )*60 + min /* now have minutes */
	  )*60 + sec; /* finally seconds */
}

unsigned long get_cmos_time(void)
{
	unsigned int year, mon, day, hour, min, sec;
	int i;

	/* The Linux interpretation of the CMOS clock register contents:
	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
	 * RTC registers show the second which has precisely just started.
	 * Let's hope other operating systems interpret the RTC the same way.
	 */
	/* read RTC exactly on falling edge of update flag */
	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
			break;
	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
			break;
	do { /* Isn't this overkill ? UIP above should guarantee consistency */
		sec = CMOS_READ(RTC_SECONDS);
		min = CMOS_READ(RTC_MINUTES);
		hour = CMOS_READ(RTC_HOURS);
		day = CMOS_READ(RTC_DAY_OF_MONTH);
		mon = CMOS_READ(RTC_MONTH);
		year = CMOS_READ(RTC_YEAR);
	} while (sec != CMOS_READ(RTC_SECONDS));
	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
	  {
	    BCD_TO_BIN(sec);
	    BCD_TO_BIN(min);
	    BCD_TO_BIN(hour);
	    BCD_TO_BIN(day);
	    BCD_TO_BIN(mon);
	    BCD_TO_BIN(year);
	  }
	if ((year += 1900) < 1970)
		year += 100;
	return mktime(year, mon, day, hour, min, sec);
}

static struct irqaction irq0  = { timer_interrupt, 0, 0, "timer", NULL, NULL};

/* ------ Calibrate the TSC ------- 
 * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
 * Too much 64-bit arithmetic here to do this cleanly in C, and for
 * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
 * output busy loop as low as possible. We avoid reading the CTC registers
 * directly because of the awkward 8-bit access mechanism of the 82C54
 * device.
 */

static unsigned long calibrate_tsc(void)
{
       unsigned long retval;

       __asm__( /* set the Gate high, program CTC channel 2 for mode 0
		 * (interrupt on terminal count mode), binary count, 
		 * load 5 * LATCH count, (LSB and MSB)
		 * to begin countdown, read the TSC and busy wait.
		 * BTW LATCH is calculated in timex.h from the HZ value
		 */

	       /* Set the Gate high, disable speaker */
	       "inb  $0x61, %%al\n\t" /* Read port */
	       "andb $0xfd, %%al\n\t" /* Turn off speaker Data */
	       "orb  $0x01, %%al\n\t" /* Set Gate high */
	       "outb %%al, $0x61\n\t" /* Write port */

	       /* Now let's take care of CTC channel 2 */
	       "movb $0xb0, %%al\n\t" /* binary, mode 0, LSB/MSB, ch 2*/
	       "outb %%al, $0x43\n\t" /* Write to CTC command port */
	       "movb $0x0c, %%al\n\t"
	       "outb %%al, $0x42\n\t" /* LSB of count */
	       "movb $0xe9, %%al\n\t"
	       "outb %%al, $0x42\n\t" /* MSB of count */

               /* Read the TSC; counting has just started */
               "rdtsc\n\t"
               /* Move the value for safe-keeping. */
               "movl %%eax, %%ebx\n\t"
               "movl %%edx, %%ecx\n\t"

	       /* Busy wait. Only 50 ms wasted at boot time. */
               "0: inb $0x61, %%al\n\t" /* Read Speaker Output Port */
	       "testb $0x20, %%al\n\t" /* Check CTC channel 2 output (bit 5) */
               "jz 0b\n\t"

               /* And read the TSC.  5 jiffies (50.00077ms) have elapsed. */
               "rdtsc\n\t"

               /* Great.  So far so good.  Store last TSC reading in
                * last_tsc_low (only 32 lsb bits needed) */
               "movl %%eax, last_tsc_low\n\t"
               /* And now calculate the difference between the readings. */
               "subl %%ebx, %%eax\n\t"
               "sbbl %%ecx, %%edx\n\t" /* 64-bit subtract */
	       /* but probably edx = 0 at this point (see below). */
               /* Now we have 5 * (TSC counts per jiffy) in eax.  We want
                * to calculate TSC->microsecond conversion factor. */

               /* Note that edx (high 32-bits of difference) will now be 
                * zero iff CPU clock speed is less than 85 GHz.  Moore's
                * law says that this is likely to be true for the next
                * 12 years or so.  You will have to change this code to
                * do a real 64-by-64 divide before that time's up. */
               "movl %%eax, %%ecx\n\t"
               "xorl %%eax, %%eax\n\t"
               "movl %1, %%edx\n\t"
               "divl %%ecx\n\t" /* eax= 2^32 / (1 * TSC counts per microsecond) */
	       /* Return eax for the use of fast_gettimeoffset */
               "movl %%eax, %0\n\t"
               : "=r" (retval)
               : "r" (5 * 1000020/HZ)
               : /* we clobber: */ "ax", "bx", "cx", "dx", "cc", "memory");
       return retval;
}

void time_init(void)
{
	xtime.tv_sec = get_cmos_time();
	xtime.tv_usec = 0;

/*
 * If we have APM enabled or the CPU clock speed is variable
 * (CPU stops clock on HLT or slows clock to save power)
 * then the TSC timestamps may diverge by up to 1 jiffy from
 * 'real time' but nothing will break.
 * The most frequent case is that the CPU is "woken" from a halt
 * state by the timer interrupt itself, so we get 0 error. In the
 * rare cases where a driver would "wake" the CPU and request a
 * timestamp, the maximum error is < 1 jiffy. But timestamps are
 * still perfectly ordered.
 * Note that the TSC counter will be reset if APM suspends
 * to disk; this won't break the kernel, though, 'cuz we're
 * smart.  See devices/char/apm_bios.c.
 */
	if (x86_capability & 16) {
		do_gettimeoffset = do_fast_gettimeoffset;
		irq0.handler = pentium_timer_interrupt;
		fast_gettimeoffset_quotient = calibrate_tsc();
		
		/* report CPU clock rate in Hz.
		 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
		 * clock/second. Our precision is about 100 ppm.
		 */
		{	unsigned long eax=0, edx=1000000;
			__asm__("divl %2"
	       		:"=a" (cpu_hz), "=d" (edx)
               		:"r" (fast_gettimeoffset_quotient),
                	"0" (eax), "1" (edx));
			printk("Detected %ld Hz processor.\n", cpu_hz);
		}
	}
	setup_x86_irq(0, &irq0);	
}

--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: text/plain;
  name="mycpu1b.txt"
Content-Transfer-Encoding: 8bit
Content-Description: /proc/cpuinfo with a new look
Content-Disposition: attachment; filename="mycpu1b.txt"

processor	: 0
cpu		: 686
model		: M II @ 233.86MHz +/- 0.01MHz
vendor_id	: CyrixInstead
stepping	: 2.8, core/bus clock ratio: 3.5x
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid		: yes
wp		: yes
flags		: fpu de tsc msr cx8 pge cmov mmx
bogomips	: 233.47

--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd
Content-Type: text/plain;
  name="test_time.txt"
Content-Transfer-Encoding: 8bit
Content-Description: result of Philip's time test code
Content-Disposition: attachment; filename="test_time.txt"

user->900362911.587306500, sys->900362911.587311, diff=4500 nsecs, cps=0
user->900362911.691335500, sys->900362911.691339, diff=3500 nsecs, cps=0
user->900362911.801316500, sys->900362911.801319, diff=2500 nsecs, cps=0
user->900362911.911326500, sys->900362911.911328, diff=1500 nsecs, cps=0
user->900362912.021315500, sys->900362912.021318, diff=2500 nsecs, cps=0
user->900362912.131381500, sys->900362912.131384, diff=2500 nsecs, cps=0
user->900362912.241317500, sys->900362912.241319, diff=1500 nsecs, cps=0
user->900362912.351328500, sys->900362912.351331, diff=2500 nsecs, cps=0
user->900362912.461314500, sys->900362912.461317, diff=2500 nsecs, cps=0
user->900362912.571326500, sys->900362912.571328, diff=1500 nsecs, cps=0
user->900362912.681368500, sys->900362912.681371, diff=2500 nsecs, cps=0
user->900362912.791330500, sys->900362912.791332, diff=1500 nsecs, cps=0
user->900362912.901317500, sys->900362912.901320, diff=2500 nsecs, cps=0
user->900362913.011326500, sys->900362913.011328, diff=1500 nsecs, cps=0
user->900362913.121316500, sys->900362913.121319, diff=2500 nsecs, cps=0
user->900362913.231380500, sys->900362913.231382, diff=1500 nsecs, cps=0
user->900362913.341325500, sys->900362913.341329, diff=3500 nsecs, cps=0
user->900362913.451335500, sys->900362913.451338, diff=2500 nsecs, cps=0
user->900362913.561317500, sys->900362913.561320, diff=2500 nsecs, cps=0
user->900362913.671325500, sys->900362913.671328, diff=2500 nsecs, cps=0
user->900362913.781381500, sys->900362913.781384, diff=2500 nsecs, cps=0
user->900362913.891424500, sys->900362913.891427, diff=2500 nsecs, cps=0
user->900362914.001318500, sys->900362914.001321, diff=2500 nsecs, cps=0
user->900362914.111328500, sys->900362914.111331, diff=2500 nsecs, cps=0
user->900362914.221315500, sys->900362914.221317, diff=1500 nsecs, cps=0
user->900362914.331379500, sys->900362914.331382, diff=2500 nsecs, cps=0
user->900362914.441316500, sys->900362914.441319, diff=2500 nsecs, cps=0
user->900362914.551332500, sys->900362914.551335, diff=2500 nsecs, cps=0
user->900362914.661315500, sys->900362914.661317, diff=1500 nsecs, cps=0
user->900362914.771325500, sys->900362914.771328, diff=2500 nsecs, cps=0
user->900362914.881372500, sys->900362914.881375, diff=2500 nsecs, cps=0
user->900362914.991331500, sys->900362914.991333, diff=1500 nsecs, cps=0
user->900362915.101316500, sys->900362915.101319, diff=2500 nsecs, cps=0
user->900362915.211325500, sys->900362915.211327, diff=1500 nsecs, cps=0
user->900362915.321314500, sys->900362915.321317, diff=2500 nsecs, cps=0
user->900362915.431379500, sys->900362915.431382, diff=2500 nsecs, cps=0
user->900362915.541400500, sys->900362915.541404, diff=3500 nsecs, cps=0
user->900362915.651328500, sys->900362915.651331, diff=2500 nsecs, cps=0
user->900362915.761315500, sys->900362915.761318, diff=2500 nsecs, cps=0
user->900362915.871327500, sys->900362915.871330, diff=2500 nsecs, cps=0
user->900362915.981369500, sys->900362915.981372, diff=2500 nsecs, cps=0
user->900362916.091329500, sys->900362916.091332, diff=2500 nsecs, cps=0
user->900362916.201314500, sys->900362916.201317, diff=2500 nsecs, cps=0
user->900362916.311325500, sys->900362916.311328, diff=2500 nsecs, cps=0
user->900362916.421317500, sys->900362916.421321, diff=3500 nsecs, cps=0
user->900362916.531379500, sys->900362916.531382, diff=2500 nsecs, cps=0
user->900362916.641317500, sys->900362916.641320, diff=2500 nsecs, cps=0
user->900362916.751328500, sys->900362916.751331, diff=2500 nsecs, cps=233867292
user->900362916.861315380, sys->900362916.861318, diff=2620 nsecs, cps=233867292
user->900362916.971324880, sys->900362916.971326, diff=1120 nsecs, cps=233867292
user->900362917.081374850, sys->900362917.081376, diff=1150 nsecs, cps=233867292
user->900362917.191327500, sys->900362917.191328, diff=500 nsecs, cps=233867292
user->900362917.301313690, sys->900362917.301315, diff=1310 nsecs, cps=233867292
user->900362917.411324060, sys->900362917.411325, diff=940 nsecs, cps=233867292
user->900362917.521316900, sys->900362917.521319, diff=2100 nsecs, cps=233867292
user->900362917.631379740, sys->900362917.631382, diff=2260 nsecs, cps=233867292
user->900362917.741315510, sys->900362917.741318, diff=2490 nsecs, cps=233867292
user->900362917.851331500, sys->900362917.851336, diff=4500 nsecs, cps=233867247
user->900362917.961319410, sys->900362917.961320, diff=590 nsecs, cps=233867247
user->900362918.071325760, sys->900362918.071326, diff=240 nsecs, cps=233867247
user->900362918.181368620, sys->900362918.181369, diff=380 nsecs, cps=233867247
user->900362918.291328280, sys->900362918.291328, diff=-280 nsecs, cps=233867247
user->900362918.401314700, sys->900362918.401315, diff=300 nsecs, cps=233867247
user->900362918.511325730, sys->900362918.511326, diff=270 nsecs, cps=233867247
user->900362918.621315970, sys->900362918.621316, diff=30 nsecs, cps=233867247
user->900362918.731379590, sys->900362918.731380, diff=410 nsecs, cps=233867247
user->900362918.841316750, sys->900362918.841318, diff=1250 nsecs, cps=233867247
user->900362918.951330500, sys->900362918.951333, diff=2500 nsecs, cps=233867257
user->900362919.061316370, sys->900362919.061317, diff=630 nsecs, cps=233867257
user->900362919.171324760, sys->900362919.171325, diff=240 nsecs, cps=233867257
user->900362919.281367880, sys->900362919.281368, diff=120 nsecs, cps=233867257
user->900362919.391328770, sys->900362919.391330, diff=1230 nsecs, cps=233867257
user->900362919.501317110, sys->900362919.501319, diff=1890 nsecs, cps=233867257
user->900362919.611325770, sys->900362919.611327, diff=1230 nsecs, cps=233867257
user->900362919.721314010, sys->900362919.721315, diff=990 nsecs, cps=233867257
user->900362919.831442500, sys->900362919.831444, diff=1500 nsecs, cps=233867257
user->900362919.941315480, sys->900362919.941317, diff=1520 nsecs, cps=233867257
user->900362920.051333500, sys->900362920.051337, diff=3500 nsecs, cps=233867244
user->900362920.161314310, sys->900362920.161315, diff=690 nsecs, cps=233867244
user->900362920.271325220, sys->900362920.271326, diff=780 nsecs, cps=233867244
user->900362920.381368640, sys->900362920.381369, diff=360 nsecs, cps=233867244
user->900362920.491328470, sys->900362920.491330, diff=1530 nsecs, cps=233867244
user->900362920.601315490, sys->900362920.601316, diff=510 nsecs, cps=233867244
user->900362920.711324720, sys->900362920.711325, diff=280 nsecs, cps=233867244
user->900362920.821315490, sys->900362920.821317, diff=1510 nsecs, cps=233867244
user->900362920.931381710, sys->900362920.931383, diff=1290 nsecs, cps=233867244
user->900362921.041397330, sys->900362921.041398, diff=670 nsecs, cps=233867244
user->900362921.151328500, sys->900362921.151331, diff=2500 nsecs, cps=233867241
user->900362921.261315060, sys->900362921.261315, diff=-60 nsecs, cps=233867241
user->900362921.371517590, sys->900362921.371519, diff=1410 nsecs, cps=233867241
user->900362921.481417750, sys->900362921.481421, diff=3250 nsecs, cps=233867241
user->900362921.591328820, sys->900362921.591330, diff=1180 nsecs, cps=233867241
user->900362921.701314220, sys->900362921.701315, diff=780 nsecs, cps=233867241
user->900362921.811325540, sys->900362921.811326, diff=460 nsecs, cps=233867241
user->900362921.921315590, sys->900362921.921316, diff=410 nsecs, cps=233867241
user->900362922.031379110, sys->900362922.031380, diff=890 nsecs, cps=233867241
user->900362922.141315640, sys->900362922.141317, diff=1360 nsecs, cps=233867241
user->900362922.251328500, sys->900362922.251333, diff=4500 nsecs, cps=233867247
user->900362922.361314710, sys->900362922.361315, diff=290 nsecs, cps=233867247
user->900362922.471324770, sys->900362922.471326, diff=1230 nsecs, cps=233867247
Cached quotient = 627254613, our quotient = 1836497992
Difference amounts to 43ns per second
..................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
k after u: 900362941.261318999 before 900362941.261319050 (50 nsecs)
k after u: 900362941.261354999 before 900362941.261355110 (110 nsecs)
k after u: 900362941.261390999 before 900362941.261391170 (170 nsecs).
k after u: 900362941.281413999 before 900362941.281414200 (200 nsecs)
k after u: 900362941.281644999 before 900362941.281645210 (210 nsecs)
k after u: 900362941.281680999 before 900362941.281681230 (230 nsecs)
k after u: 900362941.282035999 before 900362941.282036240 (240 nsecs).
k after u: 900362941.321705999 before 900362941.321706250 (250 nsecs)
k after u: 900362941.321752999 before 900362941.321753270 (270 nsecs)
k after u: 900362941.321782999 before 900362941.321783290 (290 nsecs).
k after u: 900362941.361327999 before 900362941.361328300 (300 nsecs)
k after u: 900362941.361545999 before 900362941.361546310 (310 nsecs)
k after u: 900362941.361603999 before 900362941.361604320 (320 nsecs)..
k after u: 900362941.421416999 before 900362941.421417330 (330 nsecs).....
k after u: 900362941.561335999 before 900362941.561336400 (400 nsecs)...................
k after u: 900362942.161420999 before 900362942.161421410 (410 nsecs)..........................................................................................................................................................................................................................................................................................................................................................................................
The largest error was 410nsecs (which seems OK)
Cycle limit for system gettimeofday = 648
final cq=627254613

--Boundary-=_XrJmOWFrxsjyBldbEFSArCBynEcd--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html

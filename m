Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314380AbSE0Hi5>; Mon, 27 May 2002 03:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSE0Hi4>; Mon, 27 May 2002 03:38:56 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:1968 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S314380AbSE0Hiw>; Mon, 27 May 2002 03:38:52 -0400
Message-ID: <3CF1E296.41228517@cisco.com>
Date: Mon, 27 May 2002 13:09:02 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.51C-CISCOENG [en] (X11; I; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add i8253 spinlocks where needed.
In-Reply-To: <20020526142142.A17042@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi Vojtech,

	i8253_lock seems to be defined only if __i386__ is defined
	but is accessed in drivers/char/vt.c where we could attempt
	to lock i8253_lock even though __i386__ is not defined.

 	The preprocessor check there seems to be 

#if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
    || (defined(__mips__) && defined(CONFIG_ISA)) \
    || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE)) \
    || defined(__x86_64__)

	Won't this cause a build break on alpha ?
	Am i missing something ?
	
	thanks for your time,
	regards
	Manik
	
Vojtech Pavlik wrote:
> 
> Hi!
> 
> ChangeSet@1.584, 2002-05-26 14:17:40+02:00, vojtech@twilight.ucw.cz
>   This changeset hopefully fixes all the instances (at least on i386
>   arch and arch-nonspecific drivers) where there the i8253 chip is
>   accessed - to use a spinlock to serialize the multi-byte accesses.
>   This should allow us to understand the timer problems that are
>   happening now and then better.
> 
> ChangeSet@1.583, 2002-05-26 10:30:46+02:00, vojtech@twilight.ucw.cz
>   This cset fixes timestamp generation in ftape-calibr.c, which was
>   missing a lock for accessing the i8253 timer. This module running
>   together with i386/kernel/time.c could result in the timer registers
>   losing sync with software and reporting swapped values. There was
>   an workaround for this in ftape-calibr.c, but could never completely
>   fix the problem. Also, there still remains a race (now commented
>   in ftape-calibr.c), with jiffies and the i8253 timer register. This
>   cannot be fixed easily. Last, but not least, this converts ftape
>   timestamps on x86_64 to use TSC timer solely, because it's always
>   present there and doesn't have all the problems with the i8253 timer.
> 
>   Now there shouldn't be any code accessing the i8253 timer without
>   a spinlock held. Finally!
> 
>  arch/i386/kernel/apm.c                     |   15 +---
>  arch/i386/kernel/i8259.c                   |    4 +
>  arch/i386/kernel/time.c                    |    4 +
>  drivers/char/ftape/lowlevel/ftape-calibr.c |   97 +++++++++++++----------------
>  drivers/char/vt.c                          |    3
>  drivers/ide/hd.c                           |   10 +-
>  drivers/input/gameport/gameport.c          |   28 +++++++-
>  7 files changed, 91 insertions(+), 70 deletions(-)
> 
> diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
> --- a/arch/i386/kernel/apm.c    Sun May 26 14:18:40 2002
> +++ b/arch/i386/kernel/apm.c    Sun May 26 14:18:40 2002
> @@ -1170,17 +1170,14 @@
>  {
>  #ifdef INIT_TIMER_AFTER_SUSPEND
>         unsigned long   flags;
> +       extern spinlock_t i8253_lock;
> 
> -       save_flags(flags);
> -       cli();
> +       spin_lock_irqsave(&i8253_lock, flags);
>         /* set the clock to 100 Hz */
> -       outb_p(0x34,0x43);              /* binary, mode 2, LSB/MSB, ch 0 */
> -       udelay(10);
> -       outb_p(LATCH & 0xff , 0x40);    /* LSB */
> -       udelay(10);
> -       outb(LATCH >> 8 , 0x40);        /* MSB */
> -       udelay(10);
> -       restore_flags(flags);
> +       outb_p(0x34, 0x43);             /* binary, mode 2, LSB/MSB, ch 0 */
> +       outb_p(LATCH & 0xff, 0x40);     /* LSB */
> +       outb_p(LATCH >> 8, 0x40);       /* MSB */
> +       spin_unlock_irqrestore(&i8253_lock, flags);
>  #endif
>  }
> 
> diff -Nru a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
> --- a/arch/i386/kernel/i8259.c  Sun May 26 14:18:40 2002
> +++ b/arch/i386/kernel/i8259.c  Sun May 26 14:18:40 2002
> @@ -360,6 +360,8 @@
>  void __init init_IRQ(void)
>  {
>         int i;
> +       extern spinlock_t i8253_lock;
> +       unsigned long flags;
> 
>  #ifndef CONFIG_X86_VISWS_APIC
>         init_ISA_irqs();
> @@ -415,9 +417,11 @@
>          * Set the clock to HZ Hz, we already have a valid
>          * vector now:
>          */
> +       spin_lock_irqsave(&i8253_lock, flags);
>         outb_p(0x34,0x43);              /* binary, mode 2, LSB/MSB, ch 0 */
>         outb_p(LATCH & 0xff , 0x40);    /* LSB */
>         outb(LATCH >> 8 , 0x40);        /* MSB */
> +       spin_unlock_irqrestore(&i8253_lock, flags);
> 
>  #ifndef CONFIG_VISWS
>         setup_irq(2, &irq2);
> diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> --- a/arch/i386/kernel/time.c   Sun May 26 14:18:40 2002
> +++ b/arch/i386/kernel/time.c   Sun May 26 14:18:40 2002
> @@ -574,6 +574,8 @@
> 
>  static unsigned long __init calibrate_tsc(void)
>  {
> +       unsigned long flags;
> +
>         /* Set the Gate high, disable speaker */
>         outb((inb(0x61) & ~0x02) | 0x01, 0x61);
> 
> @@ -584,9 +586,11 @@
>          * (interrupt on terminal count mode), binary count,
>          * load 5 * LATCH count, (LSB and MSB) to begin countdown.
>          */
> +       spin_lock_irqsave(&i8253_lock, flags);
>         outb(0xb0, 0x43);                       /* binary, mode 0, LSB/MSB, Ch 2 */
>         outb(CALIBRATE_LATCH & 0xff, 0x42);     /* LSB of count */
>         outb(CALIBRATE_LATCH >> 8, 0x42);       /* MSB of count */
> +       spin_unlock_irqrestore(&i8253_lock, flags);
> 
>         {
>                 unsigned long startlow, starthigh;
> diff -Nru a/drivers/char/ftape/lowlevel/ftape-calibr.c b/drivers/char/ftape/lowlevel/ftape-calibr.c
> --- a/drivers/char/ftape/lowlevel/ftape-calibr.c        Sun May 26 14:18:40 2002
> +++ b/drivers/char/ftape/lowlevel/ftape-calibr.c        Sun May 26 14:18:40 2002
> @@ -31,7 +31,10 @@
>  #include <asm/io.h>
>  #if defined(__alpha__)
>  # include <asm/hwrpb.h>
> -#elif defined(__i386__) || defined(__x86_64__)
> +#elif defined(__x86_64__)
> +# include <asm/msr.h>
> +# include <asm/timex.h>
> +#elif defined(__i386__)
>  # include <linux/timex.h>
>  #endif
>  #include <linux/ftape.h>
> @@ -45,10 +48,14 @@
>  # error Ftape is not implemented for this architecture!
>  #endif
> 
> -#if defined(__alpha__)
> +#if defined(__alpha__) || defined(__x86_64__)
>  static unsigned long ps_per_cycle = 0;
>  #endif
> 
> +#if defined(__i386__)
> +extern spinlock_t i8253_lock;
> +#endif
> +
>  /*
>   * Note: On Intel PCs, the clock ticks at 100 Hz (HZ==100) which is
>   * too slow for certain timeouts (and that clock doesn't even tick
> @@ -67,48 +74,58 @@
>  {
>  #if defined(__alpha__)
>         unsigned long r;
> -
>         asm volatile ("rpcc %0" : "=r" (r));
>         return r;
> -#elif defined(__i386__) || defined(__x86_64__)
> +#elif defined(__x86_64__)
> +       unsigned long r;
> +       rdtscl(r);
> +       return r;
> +#elif defined(__i386__)
> +
> +/*
> + * Note that there is some time between counter underflowing and jiffies
> + * increasing, so the code below won't always give correct output.
> + * -Vojtech
> + */
> +
>         unsigned long flags;
>         __u16 lo;
>         __u16 hi;
> 
> -       save_flags(flags);
> -       cli();
> +       spin_lock_irqsave(&i8253_lock, flags);
>         outb_p(0x00, 0x43);     /* latch the count ASAP */
>         lo = inb_p(0x40);       /* read the latched count */
>         lo |= inb(0x40) << 8;
>         hi = jiffies;
> -       restore_flags(flags);
> +       spin_unlock_irqrestore(&i8253_lock, flags);
> +
>         return ((hi + 1) * (unsigned int) LATCH) - lo;  /* downcounter ! */
>  #endif
>  }
> 
>  static unsigned int short_ftape_timestamp(void)
>  {
> -#if defined(__alpha__)
> +#if defined(__alpha__) || defined(__x86_64__)
>         return ftape_timestamp();
> -#elif defined(__i386__) || defined(__x86_64__)
> +#elif defined(__i386__)
>         unsigned int count;
>         unsigned long flags;
> -
> -       save_flags(flags);
> -       cli();
> +
> +       spin_lock_irqsave(&i8253_lock, flags);
>         outb_p(0x00, 0x43);     /* latch the count ASAP */
>         count = inb_p(0x40);    /* read the latched count */
>         count |= inb(0x40) << 8;
> -       restore_flags(flags);
> +       spin_unlock_irqrestore(&i8253_lock, flags);
> +
>         return (LATCH - count); /* normal: downcounter */
>  #endif
>  }
> 
>  static unsigned int diff(unsigned int t0, unsigned int t1)
>  {
> -#if defined(__alpha__)
> -       return (t1 <= t0) ? t1 + (1UL << 32) - t0 : t1 - t0;
> -#elif defined(__i386__) || defined(__x86_64__)
> +#if defined(__alpha__) || defined(__x86_64__)
> +       return (t1 - t0);
> +#elif defined(__i386__)
>         /*
>          * This is tricky: to work for both short and full ftape_timestamps
>          * we'll have to discriminate between these.
> @@ -122,9 +139,9 @@
> 
>  static unsigned int usecs(unsigned int count)
>  {
> -#if defined(__alpha__)
> +#if defined(__alpha__) || defined(__x86_64__)
>         return (ps_per_cycle * count) / 1000000UL;
> -#elif defined(__i386__) || defined(__x86_64__)
> +#elif defined(__i386__)
>         return (10000 * count) / ((CLOCK_TICK_RATE + 50) / 100);
>  #endif
>  }
> @@ -153,49 +170,24 @@
>         save_flags(flags);
>         cli();
>         t0 = short_ftape_timestamp();
> -       for (i = 0; i < 1000; ++i) {
> +       for (i = 0; i < 1000; ++i)
>                 status = inb(fdc.msr);
> -       }
>         t1 = short_ftape_timestamp();
>         restore_flags(flags);
> +
>         TRACE(ft_t_info, "inb() duration: %d nsec", ftape_timediff(t0, t1));
>         TRACE_EXIT;
>  }
> 
>  static void init_clock(void)
>  {
> -#if defined(__i386__) || defined(__x86_64__)
> -       unsigned int t;
> -       int i;
>         TRACE_FUN(ft_t_any);
> 
> -       /*  Haven't studied on why, but there sometimes is a problem
> -        *  with the tick timer readout. The two bytes get swapped.
> -        *  This hack solves that problem by doing one extra input.
> -        */
> -       for (i = 0; i < 1000; ++i) {
> -               t = short_ftape_timestamp();
> -               if (t > LATCH) {
> -                       inb_p(0x40);    /* get in sync again */
> -                       TRACE(ft_t_warn, "clock counter fixed");
> -                       break;
> -               }
> -       }
> +#if defined(__x86_64__)
> +       ps_per_cycle = 1000000000UL / cpu_khz;
>  #elif defined(__alpha__)
> -#if CONFIG_FT_ALPHA_CLOCK == 0
> -#error You must define and set CONFIG_FT_ALPHA_CLOCK in 'make config' !
> -#endif
>         extern struct hwrpb_struct *hwrpb;
> -       TRACE_FUN(ft_t_any);
> -
> -       if (hwrpb->cycle_freq != 0) {
> -               ps_per_cycle = (1000*1000*1000*1000UL) / hwrpb->cycle_freq;
> -       } else {
> -               /*
> -                * HELP:  Linux 2.0.x doesn't set cycle_freq on my noname !
> -                */
> -               ps_per_cycle = (1000*1000*1000*1000UL) / CONFIG_FT_ALPHA_CLOCK;
> -       }
> +       ps_per_cycle = (1000*1000*1000*1000UL) / hwrpb->cycle_freq;
>  #endif
>         TRACE_EXIT;
>  }
> @@ -214,7 +206,7 @@
>         unsigned int tc = 0;
>         unsigned int count;
>         unsigned int time;
> -#if defined(__i386__) || defined(__x86_64__)
> +#if defined(__i386__)
>         unsigned int old_tc = 0;
>         unsigned int old_count = 1;
>         unsigned int old_time = 1;
> @@ -257,15 +249,14 @@
>                 tc = (1000 * time) / (count - 1);
>                 TRACE(ft_t_any, "once:%3d us,%6d times:%6d us, TC:%5d ns",
>                         usecs(once), count - 1, usecs(multiple), tc);
> -#if defined(__alpha__)
> +#if defined(__alpha__) || defined(__x86_64__)
>                 /*
>                  * Increase the calibration count exponentially until the
>                  * calibration time exceeds 100 ms.
>                  */
> -               if (time >= 100*1000) {
> +               if (time >= 100*1000)
>                         break;
> -               }
> -#elif defined(__i386__) || defined(__x86_64__)
> +#elif defined(__i386__)
>                 /*
>                  * increase the count until the resulting time nears 2/HZ,
>                  * then the tc will drop sharply because we lose LATCH counts.
> diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
> --- a/drivers/char/vt.c Sun May 26 14:18:40 2002
> +++ b/drivers/char/vt.c Sun May 26 14:18:40 2002
> @@ -107,6 +107,7 @@
>  _kd_mksound(unsigned int hz, unsigned int ticks)
>  {
>         static struct timer_list sound_timer = { function: kd_nosound };
> +        extern spinlock_t i8253_lock;
>         unsigned int count = 0;
>         unsigned long flags;
> 
> @@ -120,10 +121,12 @@
>                 /* enable counter 2 */
>                 outb_p(inb_p(0x61)|3, 0x61);
>                 /* set command for counter 2, 2 byte write */
> +               spin_lock(&i8253_lock);
>                 outb_p(0xB6, 0x43);
>                 /* select desired HZ */
>                 outb_p(count & 0xff, 0x42);
>                 outb((count >> 8) & 0xff, 0x42);
> +               spin_unlock(&i8253_lock);
> 
>                 if (ticks) {
>                         sound_timer.expires = jiffies+ticks;
> diff -Nru a/drivers/ide/hd.c b/drivers/ide/hd.c
> --- a/drivers/ide/hd.c  Sun May 26 14:18:40 2002
> +++ b/drivers/ide/hd.c  Sun May 26 14:18:40 2002
> @@ -110,6 +110,8 @@
> 
>  static struct timer_list device_timer;
> 
> +#define TIMEOUT_VALUE  (6*HZ)
> +
>  #define SET_TIMER                                                      \
>         do {                                                            \
>                 mod_timer(&device_timer, jiffies + TIMEOUT_VALUE);      \
> @@ -131,16 +133,16 @@
> 
>  unsigned long read_timer(void)
>  {
> +        extern spinlock_t i8253_lock;
>         unsigned long t, flags;
>         int i;
> 
> -       save_flags(flags);
> -       cli();
> +       spin_lock_irqsave(&i8253_lock, flags);
>         t = jiffies * 11932;
>         outb_p(0, 0x43);
>         i = inb_p(0x40);
>         i |= inb(0x40) << 8;
> -       restore_flags(flags);
> +       spin_unlock_irqrestore(&i8253_lock, flags);
>         return(t - i);
>  }
>  #endif
> @@ -831,7 +833,7 @@
>                 printk("hd: unable to get major %d for hard disk\n",MAJOR_NR);
>                 return -1;
>         }
> -       blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &hd_lock);
> +       blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_hd_request, &hd_lock);
>         blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 255);
>         add_gendisk(&hd_gendisk);
>         init_timer(&device_timer);
> diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
> --- a/drivers/input/gameport/gameport.c Sun May 26 14:18:40 2002
> +++ b/drivers/input/gameport/gameport.c Sun May 26 14:18:40 2002
> @@ -54,16 +54,36 @@
>  static struct gameport *gameport_list;
>  static struct gameport_dev *gameport_dev;
> 
> +
> +#ifdef __i386__
> +
> +#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193180/HZ:0))
> +#define GET_TIME(x)     do { x = get_time_pit(); } while (0)
> +
> +static unsigned int get_time_pit(void)
> +{
> +       extern spinlock_t i8253_lock;
> +       unsigned long flags;
> +       unsigned int count;
> +
> +       spin_lock_irqsave(&i8253_lock, flags);
> +       outb_p(0x00, 0x43);
> +       count = inb_p(0x40);
> +       count |= inb_p(0x40) << 8;
> +       spin_unlock_irqrestore(&i8253_lock, flags);
> +
> +       return count;
> +}
> +
> +#endif
> +
>  /*
>   * gameport_measure_speed() measures the gameport i/o speed.
>   */
> 
>  static int gameport_measure_speed(struct gameport *gameport)
>  {
> -#if defined(__i386__) || defined(__x86_64__)
> -
> -#define GET_TIME(x)     do { outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } while (0)
> -#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193180L/HZ:0))
> +#ifdef __i386__
> 
>         unsigned int i, t, t1, t2, t3, tx;
>         unsigned long flags;
> 
> ===================================================================
> 
> This BitKeeper patch contains the following changesets:
> 1.582..1.584
> ## Wrapped with gzip_uu ##
> 
> begin 664 bkpatch17031
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
> 3FK[V>!@X^#KL_P!<D_!-'2P`````
> `
> end
> 
> --
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319222AbSH2PPS>; Thu, 29 Aug 2002 11:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319224AbSH2PPS>; Thu, 29 Aug 2002 11:15:18 -0400
Received: from spirit.qbfox.com ([212.67.200.51]:28687 "EHLO spirit.qbfox.com")
	by vger.kernel.org with ESMTP id <S319222AbSH2PPQ>;
	Thu, 29 Aug 2002 11:15:16 -0400
Message-Id: <200208291519.QAA08062@spirit.qbfox.com>
From: Per Gregers Bilse <bilse@qbfox.com>
Date: Thu, 29 Aug 2002 16:19:34 +0100
In-Reply-To: <200207311122.MAA23973@spirit.qbfox.com>
Organization: qbfox
X-Mailer: Mail User's Shell (7.2.2 4/12/91)
To: george anzinger <george@mvista.com>
Subject: Re: 2.4.18 clock warps 4294 seconds
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

I've been away for a couple of weeks due to family illness.

Quick recap:

On Jul 31, 12:22pm, Per Gregers Bilse <bilse@qbfox.com> wrote:
> Subject: Re: 2.4.18 clock warps 4294 seconds
> On Jul 29, 11:39am, george anzinger <george@mvista.com> wrote:
> > > The "if (count > LATCH)" block has been taken out of the 2.4.18
> > 
> > I am not sure it was ever in the kernel in that form.  Are
> > you sure you did not put some patch in here?
> 
> I've never deliberately touched anything in there.  Everything
> will have come from RedHat (7.2 CDs) or kernel.org, and I'm
> pretty sure I didn't install any interim and/or experimental
> versions or patches.
> 
> > I wish I knew more about this hardware bug.  The test
> > suggests that the chip is not resetting the latch on
> > interrupt, but rather that it just rolls over (or under). 
> > This would cause the count to, again, reach zero (and,
> > hopefully interrupt) in about 50 ms.  On the other hand, the
> > chip could be switching modes and only the "0X34" mode will
> > continue to interrupt with out the chip being reprogrammed. 
> > In this case, it is hard to understand how the system keeps
> > ANY time at all.  
> 
> Both machines generally seem to keep time just fine, apart
> from the bumps.  But then, there were only a few of the
> hardware bug warning messages in the logs, so it didn't
> manifest itself very often.
> 
> Anyway, nothing caught over the weekend, unfortunately.  The trap
> in do_fast_gettimeoffset() reads:
> 
>         if ( eax > 100000000 ) {
>                 glob_eax = eax;
>                 return delay_at_last_interrupt;
>         }
> 
> Then a check and printk() in do_gettimeofday().  The machine
> has lost NTP synch somewhat sporadically, but not as regularly
> as before.  Sigh.  Maybe it's the weather, we've been having a
> heatwave since Friday, and everybody and everything in the office
> is roasting.
> 
> I'm going to try to fiddle around some more, also with the other
> machine.
> 
>   -- Per
>-- End of excerpt from Per Gregers Bilse


I made a new trap, much simpler and well focused, here's the full
function:

/*
 * This version of gettimeofday has microsecond resolution
 * and better than microsecond precision on fast x86 machines with TSC.
 */
void do_gettimeofday(struct timeval *tv)
{
        unsigned long flags;
        unsigned long usec, sec;
        unsigned long offusec;

        read_lock_irqsave(&xtime_lock, flags);
        offusec = usec = do_gettimeoffset();
        {
                unsigned long lost = jiffies - wall_jiffies;
                if (lost)
                        usec += lost * (1000000 / HZ);
        }
        sec = xtime.tv_sec;
        usec += xtime.tv_usec;
        read_unlock_irqrestore(&xtime_lock, flags);

        if ( offusec > 2000000 )
                printk("do_gettimeofday offusec %lu\n",offusec);

        if ( usec > 2000000 )
                printk("do_gettimeofday usec %lu\n",usec);

        while (usec >= 1000000) {
                usec -= 1000000;
                sec++;
        }

        tv->tv_sec = sec;
        tv->tv_usec = usec;

}

It's basically the addition of 'offusec' to check the offset value.

Nothing happened for a week or so after I'd booted the machine, then
suddenly in the middle of the night:

Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294939478
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294939498
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294939849
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294939957
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294939997
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294940016
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294940037
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294940056
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294940077
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294940094
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294940115
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294940133
Aug 28 01:05:03 vulpes kernel: do_gettimeofday offusec 4294940154

On and on it went, until I woke up in the morning and rebooted the
machine:

Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294951722
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294953414
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294953450
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294955967
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294956001
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294957942
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294957978
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294951303
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294951339
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294953107
Aug 28 05:51:23 vulpes kernel: do_gettimeofday offusec 4294953143

As you can see the incorrect offset increases by one second every
second, so I figure it must be the global delay_at_last_interrupt
which gets clobbered at some point.  This is added to the return
value in do_fast_gettimeoffset(), and looks like the only thing
(apart from a permanently clobbered hardware TSC) which could cause
do_fast_gettimeoffset() to repeatedly return a bad value, increasing by
one second per second.  In turn, delay_at_last_interrupt is only
set to anything in timer_interrupt(), where there once was code
to deal with buggy VIA686a motherboards -- you may recall this:

> Both machines indeed have identical VIA686a motherboards.  The messages
> come from code in timer_interrupt() in time.c:
> 
>                 /* read Pentium cycle counter */
> 
>                 rdtscl(last_tsc_low);
> 
>                 spin_lock(&i8253_lock);
>                 outb_p(0x00, 0x43);     /* latch the count ASAP */
> 
>                 count = inb_p(0x40);    /* read the latched count */
>                 count |= inb(0x40) << 8;
> 
>                 /* VIA686a test code... reset the latch if count > max */
>                 if (count > LATCH) {
>                         static int last_whine;
>                         outb_p(0x34, 0x43);
>                         outb_p(LATCH & 0xff, 0x40);
>                         outb(LATCH >> 8, 0x40);
>                         count = LATCH - 1;
>                         if(time_after(jiffies, last_whine))
>                         {
>                                 printk(KERN_WARNING "probable hardware bug: clock timer configuration lost - probably a VIA686a motherboard.\n");
>                                 printk(KERN_WARNING "probable hardware bug: restoring chip configuration.\n");
>                                 last_whine = jiffies + HZ;
>                         }
>                 }
> 
>                 spin_unlock(&i8253_lock);
> 
> The "if (count > LATCH)" block has been taken out of the 2.4.18
> kernel, while similar code is in do_slow_gettimeoffset() in both
> the 2.4.7-10 and 2.4.18 kernels.  I'm not sufficiently familiar
> with the hardware and the code to know if this is significant,
> but it does seem that there are some known hardware bugs which
> the earlier kernel tried to address (but with limited or no success).

So I'll try to put the recovery code shown above back in, and see
if I catch something.

BTW, if y'all are tired of this, let me know.  I've only got two of
the VIA686a boards, and I can live with them as is.  It's more a case
of contributing to the kernel if I can.  Not sure how many VIA686a
boards are in use, but I guess it could be some hundred thousand.

  -- Per


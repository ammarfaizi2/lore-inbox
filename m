Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSG2TzN>; Mon, 29 Jul 2002 15:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSG2TzN>; Mon, 29 Jul 2002 15:55:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33006 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317606AbSG2TzM>;
	Mon, 29 Jul 2002 15:55:12 -0400
Message-ID: <3D458BE4.60C7FB77@mvista.com>
Date: Mon, 29 Jul 2002 11:39:32 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Per Gregers Bilse <bilse@qbfox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 clock warps 4294 seconds
References: <200207261022.LAA08395@spirit.qbfox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Gregers Bilse wrote:
> 
> On Jul 25, 10:34am, george anzinger <george@mvista.com> wrote:
> > You have the number a bit low.  If I recall, this is an 800
> 
> Yes, I figured that, and bumped it up a lot (to 1e9).  Of course, since
> setting the trap, things have been fine, including no loss of NTP synch.-/
> Let's see over the weekend.
> 
> > The first thing I would check is that you are using DMA for
> > you disc transfers.  To the best of my knowledge, the
> 
> Yes, both machines and both disks use DMA, and also allow interrupts
> ("unmaskirq" option) during disk transfers, here's from hdparm(8):
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 2434/255/63, sectors = 39102336, start = 0
> 
> The only slightly unusual thing is that both machines use soft RAID,
> I don't know if that code might be doing something.  But the problem
> occurred at the same time as I made an application change (debug/logging)
> that vastly -reduced- disk I/O.
> 
> Anyway, I've been looking through archived log files, and found a few
> entries from the 2.4.7-10 kernel that looked interesting, here's a pair:
> 
> Feb 23 04:07:52 vulpes kernel: probable hardware bug: clock timer configuration lost - probably a VIA686a motherboard.
> Feb 23 04:07:52 vulpes kernel: probable hardware bug: restoring chip configuration.
> 
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

I am not sure it was ever in the kernel in that form.  Are
you sure you did not put some patch in here?

> kernel, while similar code is in do_slow_gettimeoffset() in both
> the 2.4.7-10 and 2.4.18 kernels.  I'm not sufficiently familiar
> with the hardware and the code to know if this is significant,
> but it does seem that there are some known hardware bugs which
> the earlier kernel tried to address (but with limited or no success).

I wish I knew more about this hardware bug.  The test
suggests that the chip is not resetting the latch on
interrupt, but rather that it just rolls over (or under). 
This would cause the count to, again, reach zero (and,
hopefully interrupt) in about 50 ms.  On the other hand, the
chip could be switching modes and only the "0X34" mode will
continue to interrupt with out the chip being reprogrammed. 
In this case, it is hard to understand how the system keeps
ANY time at all.  

The above "fix" detects the count not being reset and
reprograms the chip, it does not attempt to correct for any
lost time.
> 
> Anyway, let's see what happens over the weekend.
> 
> Thanks.
> 
>   -- Per

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

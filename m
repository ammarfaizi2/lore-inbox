Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318860AbSH1QUf>; Wed, 28 Aug 2002 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318891AbSH1QUf>; Wed, 28 Aug 2002 12:20:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20215 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S318860AbSH1QUe>;
	Wed, 28 Aug 2002 12:20:34 -0400
Message-ID: <3D6CF932.7D7C95F1@mvista.com>
Date: Wed, 28 Aug 2002 09:24:18 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Volker Kuhlmann <hidden@paradise.net.nz>
CC: Richard Zidlicky <rz@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel losing time
References: <20020825105500.GE11740@paradise.net.nz> <Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm> <20020825215515.GA2965@debill.org> <1030320314.16766.25.camel@irongate.swansea.linux.org.uk> <20020826011332.GA8440@paradise.net.nz> <1030356936.16651.37.camel@irongate.swansea.linux.org.uk> <20020826122752.A1547@linux-m68k.org> <20020828013236.GA13595@paradise.net.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bit of code was in 2.4.19 in
.../arch/i386/kernel/time.c

The suggestion (from the code) is that the PIT does not
reset to the proper value and that reprogramming it fixes
the problem.  At the same time, this being in the interrupt
handler, it does generate at least one interrupt at or after
it fails to do the right thing.

Notes:  1.) This fix, each time it reprograms the PIT, will
loose (leak) a bit of time.
        2.) The three I/O instructions to read the latch are
slow, AND this is done each interrupt.
        3.) This version does not have a way to eliminate
the code on machines that don't have the problem.
        4.) I reserve judgment on the comment that the spin
lock is not needed.  It, I think, assumes that the PIT is
only accessed from the timer code, but this is not really
true (it ought to be true but is not :()


#if 0 /*
       * SUBTLE: this is not necessary from here because
it's implicit in the
       * write xtime_lock.
       */
		spin_lock(&i8253_lock);
#endif
		outb_p(0x00, 0x43);     /* latch the count ASAP */

		count = inb_p(0x40);    /* read the latched count */
		count |= inb(0x40) << 8;

		/* VIA686a test code... reset the latch if count > max */
		if (count > LATCH-1) {
			static int last_whine;
			outb_p(0x34, 0x43);
			outb_p(LATCH & 0xff, 0x40);
			outb(LATCH >> 8, 0x40);
			count = LATCH - 1;
			if(time_after(jiffies, last_whine))
			{
				printk(KERN_WARNING "probable hardware bug: clock timer
configuration lost - probably a VIA686a.\n");
				printk(KERN_WARNING "probable hardware bug: restoring
chip configuration.\n");
				last_whine = jiffies + HZ;
			}			
		}	

#if 0
		spin_unlock(&i8253_lock);
#endif

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

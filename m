Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVLaStL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVLaStL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 13:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVLaStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 13:49:10 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:55954 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965035AbVLaStJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 13:49:09 -0500
Subject: Re: 2.6.15-rc7-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1136051113.6039.109.camel@localhost.localdomain>
References: <20051228172643.GA26741@elte.hu>
	 <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
	 <1136051113.6039.109.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 13:48:56 -0500
Message-Id: <1136054936.6039.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 12:45 -0500, Steven Rostedt wrote:

> [...]
> >  [<df111b4f>] rtc_ioctl+0xf/0x20 [rtc] (8)
> 
> Hmm, which rtc_ioctl?

Never mind, I figured out that this is the generic rtc.  (late night
last night -pre-New-Years-, so I'm not thinking all that well today).

> 
> >  [<c0170e68>] do_ioctl+0x78/0x90 (28)
> >  [<c0171017>] vfs_ioctl+0x57/0x1f0 (32)
> >  [<c01711e9>] sys_ioctl+0x39/0x60 (28)
> >  [<c01031b5>] syscall_call+0x7/0xb (-8116)
> > Code: 00 e9 30 ff ff ff e8 fe d7 19 e1 eb 8c be 53 00 00 00 bb f4 25 11 df 89
> > 74 24 08 89 5c 24 04 c7 04 24 0a 26 11 df e8 de 9c 00 e1 <0f> 0b 53 00 f4 25 11
> > df e9 73 ff ff ff e8 cc d7 19 e1 e9 63 f9
> >  Segmentation fault
> > 
> > This looks like it's due to some timer - mplayer opens /dev/rtc if you want 
> > to know. A second invocation of mplayer went fine, I guess due to 
> > /dev/rtc still having a refcount of >0 and therefore not able to be opened 
> > again.
> > 
> > AFA-IIRC this did not happen with (my own portage of) 2.6.15-rc5-rt4 into 
> > 2.6.15-rc7 (on the very day that rc7 was released).
> > If you need config.gz/.config or other info, please let me know.
> 
> Yeah, could you send it. If anything, just so I know which rtc_ioctl is
> used.

Don't bother.

> 
> > 
> > 
> > I also notice that mplayer uses approximately a lot more CPU, as shown in 
> > top when CONFIG_HIGH_RES_TIMERS=y. That is, without highres timers, mplayer 
> > uses less than 1%, with hrt it's somewhere between 10% and 18%.
> > I practically just ran the decoding routine:
> >   `mplayer -ao null sometrack.ogg`.

I haven't gotten around to the CPU usage part (maybe Thomas has time for
that).

But, is the BUG easily reproducible?  I believe I found the race.

In drivers/char/rtc.c: searching for rtc_irq_timer

The places that rtc_irq_timer is used:

rtc_interrupt:
	mod = 0;

// below the add timer can change the rtc_status and then call mod_timer
// which can activate it.

	if (rtc_status & RTC_TIMER_ON)
		mod = 1;

	spin_unlock (&rtc_lock);
	if (mod)
		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);

rtc_do_ioctl:
	case RTC_PIE_OFF:	/* Mask periodic int. enab. bit	*/
	{
		unsigned long flags; /* can be called from isr via rtc_control() */
		int del = 0;

		spin_lock_irqsave (&rtc_lock, flags);
		mask_rtc_irq_bit_locked(RTC_PIE);
		if (rtc_status & RTC_TIMER_ON) {
			rtc_status &= ~RTC_TIMER_ON;
			del = 1;
		}
		spin_unlock_irqrestore (&rtc_lock, flags);

// if we are preempted here, we can also go and add the timer before
// we delete it.

		if (del)
			del_timer(&rtc_irq_timer);
		return 0;
	}
	case RTC_PIE_ON:	/* Allow periodic ints		*/
	{
		unsigned long flags; /* can be called from isr via rtc_control() */
		int add = 0;

		/*
		 * We don't really want Joe User enabling more
		 * than 64Hz of interrupts on a multi-user machine.
		 */
		if (!kernel && (rtc_freq > rtc_max_user_freq) &&
			(!capable(CAP_SYS_RESOURCE)))
			return -EACCES;

		spin_lock_irqsave (&rtc_lock, flags);
		if (!(rtc_status & RTC_TIMER_ON)) {
			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
			rtc_status |= RTC_TIMER_ON;
			add = 1;
		}
		set_rtc_irq_bit_locked(RTC_PIE);
		spin_unlock_irqrestore (&rtc_lock, flags);

// there's no protection between the above setting of rtc_status
// and this add_timer

		if (add)
			add_timer(&rtc_irq_timer);
		return 0;
	}


So you took the bug in include/linux/timer.h:83 

81:static inline void add_timer(struct timer_list *timer)
82:{
83:	BUG_ON(timer_pending(timer));
84:	__mod_timer(timer, timer->expires);
85:}


You can very well have a timer pending when calling add.

Looking at the vanilla kernel rtc.c, all these are protected by the
rtc_lock.  So this was changed by -rt.

So Ingo, Thomas or John, is it OK to put that back or what?

-- Steve



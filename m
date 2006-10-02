Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965511AbWJBXJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965511AbWJBXJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965512AbWJBXJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:09:19 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:26816 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965511AbWJBXJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:09:18 -0400
Subject: Re: [patch 03/23] GTOD: persistent clock support, i386
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <20061002154432.ed090fd9.akpm@osdl.org>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	 <20060929234439.158061000@cruncher.tec.linutronix.de>
	 <20060930013612.92e12313.akpm@osdl.org>
	 <1159826617.27968.22.camel@localhost.localdomain>
	 <20061002154432.ed090fd9.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 16:09:13 -0700
Message-Id: <1159830553.14515.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 15:44 -0700, Andrew Morton wrote:
> On Mon, 02 Oct 2006 15:03:37 -0700
> john stultz <johnstul@us.ibm.com> wrote:
> 
> >  static int timer_resume(struct sys_device *dev)
> >  {
> > -	unsigned long flags;
> > -	unsigned long sec;
> > -	unsigned long ctime = get_cmos_time();
> > -	long sleep_length = (ctime - sleep_start) * HZ;
> > -	struct timespec ts;
> > -
> > -	if (sleep_length < 0) {
> > -		printk(KERN_WARNING "CMOS clock skew detected in timer resume!\n");
> > -		/* The time after the resume must not be earlier than the time
> > -		 * before the suspend or some nasty things will happen
> > -		 */
> > -		sleep_length = 0;
> > -		ctime = sleep_start;
> > -	}
> >  #ifdef CONFIG_HPET_TIMER
> >  	if (is_hpet_enabled())
> >  		hpet_reenable();
> >  #endif
> >  	setup_pit_timer();
> > -
> > -	sec = ctime + clock_cmos_diff;
> > -	ts.tv_sec = sec;
> > -	ts.tv_nsec = 0;
> > -	do_settimeofday(&ts);
> > -	write_seqlock_irqsave(&xtime_lock, flags);
> > -	jiffies_64 += sleep_length;
> > -	write_sequnlock_irqrestore(&xtime_lock, flags);
> >  	touch_softlockup_watchdog();
> >  	return 0;
> >  }
> 
> In this version of the patch, you no longer remove the
> touch_softlockup_watchdog() call from timer_resume().

Yea. That removal was added by Thomas, and I didn't merge it into my
tree. 

> But clockevents-drivers-for-i386.patch deletes timer_resume()
> altogether.
> 
> Hence we might need to put that re-added touch_softlockup_watchdog() call
> into somewhere else now.

Yea. While my dropping the change wasn't intentional, it seems the
change isn't really part of the persistent_clock changes, so the removal
should be done in one of the clockevents patches.

But I'll have to defer to tglx as to which one.

thanks
-john


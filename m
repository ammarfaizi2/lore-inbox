Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUKAPVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUKAPVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUKAONA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:13:00 -0500
Received: from mx1.elte.hu ([157.181.1.137]:21903 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261789AbUKAOLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:11:12 -0500
Date: Mon, 1 Nov 2004 15:12:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101141210.GA21363@elte.hu>
References: <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101150356.4324c4c9@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101150356.4324c4c9@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > i'm seeing some weird traces, which show rtc_wakeup doing this cycle:
> > 
> > 	[~900 usecs pass]
> > 
> > 	hardirq 8 comes in, wakes IRQ 8 thread
> > 	IRQ 8 thread wakes up rtc_wakeup
> > 
> > 	rtc_wakeup fast-thread returns from sys_read()
> > 	rtc_wakeup fast-thread enters sys_poll() and returns immediately
> > 	rtc_wakeup fast-thread enters sys_read() and blocks
> 
> weird. why could poll return immeaditly? Only when data should be
> available right? Ahh, maybe there's less data available than which is
> needed by read(). I suppose i need to check if enough data is
> available. If not, repoll(), then generate the timestamp. Then read().
> I had the impression that this small amount of data which rtc delivers
> (4 bytes i think) would not be split into smaller parts.
> 
> It never occured to me that poll() could return with incomplete rtc
> data available..

this is how it works:

static unsigned int rtc_poll(struct file *file, poll_table *wait)
{
        unsigned long l;

        if (rtc_has_irq == 0)
                return 0;

        poll_wait(file, &rtc_wait, wait);

        spin_lock_irq (&rtc_lock);
        l = rtc_irq_data;
        spin_unlock_irq (&rtc_lock);

        if (l != 0)
                return POLLIN | POLLRDNORM;
        return 0;
}

it seems that it cannot return with incomplete data. rtc_has_irq is a
boot-time-only thing - either the RTC can generate interrupts or it
cannot. rtc_irq_data is updated atomically - either it's full with 4
bytes or it's completely empty.

safest would be to call the read() with O_NONBLOCK and figure out how
often -EAGAIN happens? (O_NONBLOCK is honored by /dev/rtc.)

but i could imagine that you could get into a 'wrong phase' if for
whatever reason an RTC interrupt slips in before the poll()?

	Ingo

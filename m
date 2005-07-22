Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVGVB2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVGVB2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 21:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVGVB2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 21:28:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3736 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261883AbVGVB2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 21:28:21 -0400
Date: Fri, 22 Jul 2005 03:28:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
       vojtech@suse.cz
Subject: Re: [patch,rfc] Support for touchscreen on sharp zaurus sl-5500
Message-ID: <20050722012814.GB6758@atrey.karlin.mff.cuni.cz>
References: <20050721052455.GB7849@elf.ucw.cz> <29495f1d05072117247817c5d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05072117247817c5d1@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +               set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> > +               schedule_timeout(HZ / 100);
> > +               if (signal_pending(tsk))
> > +                       break;
> 
> You specifically allow SIGKILL, but then sleep uninterruptibly? And
> then you check if signal_pending() :) I think you may want
> TASK_INTERRUPTIBLE? Or, go one better and use msleep_interruptible(),
> as I don't see any wait-queues in the immediate area of this code...

Okay, I think this should be uninterruptible. The signal can be
delivered during next interruptible sleep. Fixes.

> > +/**
> > + *     ucb1x00_adc_read - read the specified ADC channel
> > + *     @ucb: UCB1x00 structure describing chip
> > + *     @adc_channel: ADC channel mask
> > + *     @sync: wait for syncronisation pulse.
> > + *
> > + *     Start an ADC conversion and wait for the result.  Note that
> > + *     synchronised ADC conversions (via the ADCSYNC pin) must wait
> > + *     until the trigger is asserted and the conversion is finished.
> > + *
> > + *     This function currently spins waiting for the conversion to
> > + *     complete (2 frames max without sync).
> 
> You technically sleep (schedule_timeout()), not spin...

Well, it also spins :-).

> > +       for (;;) {
> > +               val = ucb1x00_reg_read(ucb, UCB_ADC_DATA);
> > +               if (val & UCB_ADC_DAT_VAL)
> > +                       break;
> > +               /* yield to other processes */
> > +               set_current_state(TASK_INTERRUPTIBLE);
> > +               schedule_timeout(1);
> > +       }
> 
> If I ever add a poll_event() interface to the kernel, this would be a
> good user. You don't check if signal_pending(), though, even though
> you are in INTERRUPTIBLE state... Maybe this case can use
> UNINTERRUPTIBLE?

Ok, UNINTERRUPTIBLE here...
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.

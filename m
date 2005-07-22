Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVGVAZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVGVAZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 20:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVGVAZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 20:25:27 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:58752 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261959AbVGVAZZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 20:25:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ly4BStgpSCcTBJovKFeK/JRKNz2520+FlZH6S0vUkhZnk6/GLICF+BFlxSJKIlyCFeGFWvgAf3fk8/v8Q5Thnf2wHoWj636Mejma2Xis4InJ9ICWTkQJUzJy3wUtO4/0KgqBGwRJcpaJ2/Au1Sovw8BYGTp6hHlFuGI5CkZHwlA=
Message-ID: <29495f1d05072117247817c5d1@mail.gmail.com>
Date: Thu, 21 Jul 2005 17:24:34 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch,rfc] Support for touchscreen on sharp zaurus sl-5500
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk,
       vojtech@suse.cz
In-Reply-To: <20050721052455.GB7849@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050721052455.GB7849@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> This adds support for touchscreen of sharp zaurus sl-5500. I got the
> patches from John Lenz <lenz@cs.wisc.edu>, but lots of copyrights are
> Russell King. To do so, it needs to add quite a bit of
> infrastructure. If there's better place for some code, please let me
> know (I already moved touchscreen parts to drivers/input).

<snip>

> diff --git a/drivers/input/touchscreen/collie_ts.c
> b/drivers/input/touchscreen/collie_ts.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/input/touchscreen/collie_ts.c

<snip>

> +static int ucb1x00_thread(void *_ts)
> +{
> +       struct ucb1x00_ts *ts = _ts;
> +       struct task_struct *tsk = current;
> +       int valid;
> +
> +       ts->rtask = tsk;
> +
> +       daemonize("ktsd");
> +       /* only want to receive SIGKILL */
> +       allow_signal(SIGKILL);
> +
> +       /*
> +        * We run as a real-time thread.  However, thus far
> +        * this doesn't seem to be necessary.
> +        */
> +       tsk->policy = SCHED_FIFO;
> +       tsk->rt_priority = 1;
> +
> +       complete(&ts->init_exit);
> +
> +       valid = 0;
> +
> +       for (;;) {
> +               unsigned int x, y, p, val;
> +
> +               ts->restart = 0;
> +
> +               ucb1x00_adc_enable(ts->ucb);
> +
> +               x = ucb1x00_ts_read_xpos(ts);
> +               y = ucb1x00_ts_read_ypos(ts);
> +               p = ucb1x00_ts_read_pressure(ts);
> +
> +               /*
> +                * Switch back to interrupt mode.
> +                */
> +               ucb1x00_ts_mode_int(ts);
> +               ucb1x00_adc_disable(ts->ucb);
> +
> +               set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> +               schedule_timeout(HZ / 100);
> +               if (signal_pending(tsk))
> +                       break;

You specifically allow SIGKILL, but then sleep uninterruptibly? And
then you check if signal_pending() :) I think you may want
TASK_INTERRUPTIBLE? Or, go one better and use msleep_interruptible(),
as I don't see any wait-queues in the immediate area of this code...

<snip>

> +                       set_task_state(tsk, TASK_INTERRUPTIBLE);
> +                       schedule_timeout(HZ / 100);
> +               }
> +
> +               if (signal_pending(tsk))
> +                       break;

Then you use INTERRUPTIBLE and check signal_pending() again, so I'm
pretty sure you wanted INTERRUPTIBLE above...But this sleep can be
msleep_interruptible(), as well?

<snip>

> diff --git a/drivers/misc/ucb1x00-core.c b/drivers/misc/ucb1x00-core.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/misc/ucb1x00-core.c

<snip>

> +/**
> + *     ucb1x00_adc_read - read the specified ADC channel
> + *     @ucb: UCB1x00 structure describing chip
> + *     @adc_channel: ADC channel mask
> + *     @sync: wait for syncronisation pulse.
> + *
> + *     Start an ADC conversion and wait for the result.  Note that
> + *     synchronised ADC conversions (via the ADCSYNC pin) must wait
> + *     until the trigger is asserted and the conversion is finished.
> + *
> + *     This function currently spins waiting for the conversion to
> + *     complete (2 frames max without sync).

You technically sleep (schedule_timeout()), not spin...

> + *
> + *     If called for a synchronised ADC conversion, it may sleep
> + *     with the ADC semaphore held.
> + */
> +unsigned int ucb1x00_adc_read(struct ucb1x00 *ucb, int adc_channel, int sync)
> +{
> +       unsigned int val;
> +
> +       if (sync)
> +               adc_channel |= UCB_ADC_SYNC_ENA;
> +
> +       ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr | adc_channel);
> +       ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr | adc_channel | UCB_ADC_START);
> +
> +       for (;;) {
> +               val = ucb1x00_reg_read(ucb, UCB_ADC_DATA);
> +               if (val & UCB_ADC_DAT_VAL)
> +                       break;
> +               /* yield to other processes */
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               schedule_timeout(1);
> +       }

If I ever add a poll_event() interface to the kernel, this would be a
good user. You don't check if signal_pending(), though, even though
you are in INTERRUPTIBLE state... Maybe this case can use
UNINTERRUPTIBLE?

Thanks,
Nish

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTLQPbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTLQPbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 10:31:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9618 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264429AbTLQPa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 10:30:57 -0500
Message-ID: <3FE076A2.9050406@pobox.com>
Date: Wed, 17 Dec 2003 10:30:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4] Wolfson AC97 touch screen driver - Input Event	interface
References: <1071672291.23686.2634.camel@cearnarfon>
In-Reply-To: <1071672291.23686.2634.camel@cearnarfon>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Girdwood wrote:
> This patch adds support for the kernel input event interface to the
> Wolfson WM9705/WM9712 touchscreen driver.
> 
> Patch is against 2.4.24-pre1
> 
> Changes:-
> 
> o Added Input event interface (Stanley Cai)
> o Improved driver CPU utilisation (Ian Molton)
> o Removed ADC source bits from output (me)
> o Added coordinate streaming mode on XScale (me) 
> o Removed old h3600 TS_EVENT interface (me)

Patches look mostly OK...  a few comments though.



> +/*
> + * Pen down detection
> + * 
> + * Pen down detection can either be via an interrupt (preferred) or
> + * by polling the PDEN bit. This is an option because some systems may
> + * not support the pen down interrupt.
> + *
> + * Set pen_int to 1 to enable interrupt driven pen down detection.
> + */
> +MODULE_PARM(pen_int,"i");
> +MODULE_PARM_DESC(pen_int, "Set pen down interrupt");
> +static int pen_int = 0;	

I wouldn't call this "detection"  ;-)

This module option is awful for users.  How do users know what to do? 
(rhetorical question...)   IMO this should be selected automatically on 
a per-chipset basis.  I'm sure there is _some_ way to notice 
programmatically, for instance selected by chipset or selecting by 
sending a test interrupt.

XScale PDA users just aren't going to know this kind of information off 
the top of their heads...


>  /*
>   * ADC sample delay times in uS
>   */
>  static const int delay_table[16] = {
> -	21,		// 1 AC97 Link frames
> -	42,		// 2
> -	84,		// 4
> -	167,		// 8
> -	333,		// 16
> -	667,		// 32
> -	1000,		// 48
> -	1333,		// 64
> -	2000,		// 96
> -	2667,		// 128
> -	3333,		// 160
> -	4000,		// 192
> -	4667,		// 224
> -	5333,		// 256
> -	6000,		// 288
> -	0 		// No delay, switch matrix always on
> +	21,// 1 AC97 Link frames
> +	42,// 2
> +	84,// 4
> +	167,// 8
> +	333,// 16
> +	667,// 32
> +	1000,// 48
> +	1333,// 64
> +	2000,// 96
> +	2667,// 128
> +	3333,// 160
> +	4000,// 192
> +	4667,// 224
> +	5333,// 256
> +	6000,// 288
> +	0 // No delay, switch matrix always on
>  };

is this a mistake?  You just made the code more difficult to read.

Also in general it would be nice to include whitespace (non-content) 
changes in a separate patch, for easier reviewing of your _real_ changes.


> +// Todo
> +static void wm97xx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	info("int recv");
> +}

hmmmm.

This change doesn't seem terribly appropriate for the 2.4.x stable series...



> +/*
> + * add a touch event
> + */
> +static int wm97xx_ts_evt_add(wm97xx_ts_t* ts, u16 pressure, u16 x, u16 y)
> +{
> +	/* add event and remove adc src bits */
> +	input_report_abs(ts->idev, ABS_X, x & 0xfff);
> +	input_report_abs(ts->idev, ABS_Y, y & 0xfff);
> +	input_report_abs(ts->idev, ABS_PRESSURE, pressure & 0xfff);
> +	return 0;
> +}
> +
> +/*
> + * add a pen up event
> + */
> +static int wm97xx_ts_evt_release(wm97xx_ts_t* ts)
> +{
> +//	dbg("release the stylus.\n");
> +	input_report_abs(ts->idev, ABS_PRESSURE, 0);
> +	return 0;
> +}
> +
> +/*
> + * The touchscreen sample reader thread
> + */
> +static int wm97xx_thread(void *_ts)
> +{
> +	wm97xx_ts_t *ts = (wm97xx_ts_t *)_ts;
> +	struct task_struct *tsk = current;
> +	int valid;
> +
> +	ts->rtask = tsk;
> +
> +	/* set up thread context */
> +	daemonize();
> +	reparent_to_init();
> +	strcpy(tsk->comm, "ktsd");
> +	tsk->tty = NULL;
> +
> +	/* we will die when we receive SIGKILL */
> +	spin_lock_irq(&tsk->sigmask_lock);
> +	siginitsetinv(&tsk->blocked, sigmask(SIGKILL));
> +	recalc_sigpending(tsk);
> +	spin_unlock_irq(&tsk->sigmask_lock);
> +
> +	/* init is complete */
> +	complete(&ts->init_exit);
> +	valid = 0;

(bookmark... will mention a bit lower down...)

> +	/* touch reader loop */
> +	for (;;) {
> +		ts->restart = 0;
> +		if( signal_pending(tsk))
> +			break;
> +
> +		if(pendown(ts)) {
> +			switch (mode) {
> +				case 0:
> +					wm97xx_poll_touch(ts);
> +					valid = 1;
> +					break;
> +				case 1:
> +					wm97xx_poll_coord_touch(ts);
> +					valid = 1;
> +					break;
> +				case 2:
> +					wm97xx_cont_touch(ts);
> +					valid = 1;
> +					break;
> +			}
> +		} else {
> +			if (valid) {
> +				valid = 0;
> +				wm97xx_ts_evt_release(ts);
> +			}
> +		}
> +
> +		set_task_state(tsk, TASK_INTERRUPTIBLE);
> +		schedule_timeout(HZ/100);

Hopefully this won't run on a machine with HZ < 100 ;-)


> +	}
> +	ts->rtask = NULL;
> +	complete_and_exit(&ts->init_exit, 0);

You don't want to use the _same_ completion to signal (a) thread init is 
complete and (b) thread has exited.  That's definitely an error.

For (a), just use a semaphore.  The completion should only be used once, 
at the end of the thread where you call complete_and_exit().



> +/*
> + * Start the touchscreen thread and 
> + * the touch digitiser.
> + */
> +static int wm97xx_ts_input_open(struct input_dev *idev)
> +{
> +	wm97xx_ts_t *ts = (wm97xx_ts_t *) &wm97xx_ts;
> +	u32 flags;
> +	int ret, val;
> +
> +	if ( ts->use_count++ != 0 ) 
> +		return 0;
> +
> +	/* start touchscreen thread */
> +	ts->idev = idev;
> +    init_completion(&ts->init_exit);
> +    ret = kernel_thread(wm97xx_thread, ts, 0);
> +    if (ret >= 0)
> +		wait_for_completion(&ts->init_exit); 
> +
> +	spin_lock_irqsave( &ts->lock, flags );
> +
> +    /* start digitiser */
> +    val = ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER2);
> +    ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER2,
> +                               val | WM97XX_PRP_DET_DIG);
> +
> +	spin_unlock_irqrestore( &ts->lock, flags );
> +
> +	return 0;
> +}
> +
> +/*
> + * Kill the touchscreen thread and stop
> + * the touch digitiser.
> + */
> +static void wm97xx_ts_input_close(struct input_dev *idev)
> +{
> +	wm97xx_ts_t *ts = (wm97xx_ts_t *) &wm97xx_ts;
> +	u32 flags;
> +	int val;
> +
> +	if (--ts->use_count == 0) {
> +		/* kill thread */
> +		if (ts->rtask) {
> +			send_sig(SIGKILL, ts->rtask, 1);
> +			wait_for_completion(&ts->init_exit);
> +		}
> +
> +		down(&ts->sem);
> +		spin_lock_irqsave(&ts->lock, flags);
> +
> +		/* stop digitiser */
> +		val = ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER2);
> +		ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER2,
> +				       val & ~WM97XX_PRP_DET_DIG);
> +		
> +		spin_unlock_irqrestore(&ts->lock, flags);
> +		up(&ts->sem);
> +	}
> +}

What lock or semaphore protects ts->use_count ?  That seems clearly 
non-atomic and potentially racy to me.


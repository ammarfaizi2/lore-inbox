Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVGUFub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVGUFub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVGUFub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:50:31 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:49537 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261638AbVGUFu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:50:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch,rfc] Support for touchscreen on sharp zaurus sl-5500
Date: Thu, 21 Jul 2005 00:50:25 -0500
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       rmk@arm.linux.org.uk, vojtech@suse.cz
References: <20050721052455.GB7849@elf.ucw.cz>
In-Reply-To: <20050721052455.GB7849@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507210050.26306.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 21 July 2005 00:24, Pavel Machek wrote:
>  
> +config TOUCHSCREEN_COLLIE
> +	tristate "Collie touchscreen (for Sharp SL-5500)"
> +	depends on MCP_UCB1200 && INPUT

I don't think you need && INPUT here.

>  
>  obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
>  obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_COLLIE)+= collie_ts.o

A tab would be nice.

> +
> +/*
> + * This is a RT kernel thread that handles the ADC accesses
> + * (mainly so we can use semaphores in the UCB1200 core code
> + * to serialise accesses to the ADC).  The UCB1400 access
> + * functions are expected to be able to sleep as well.
> + */
> +static int ucb1x00_thread(void *_ts)
> +{
> +	struct ucb1x00_ts *ts = _ts;
> +	struct task_struct *tsk = current;
> +	int valid;
> +
> +	ts->rtask = tsk;
> +
> +	daemonize("ktsd");
> +	/* only want to receive SIGKILL */
> +	allow_signal(SIGKILL);
> +

This should be converted to kthread interface.


> +static int ucb1x00_ts_open(struct input_dev *idev)
> +{
> +	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
> +	int ret = 0;
> +
> +	if (down_interruptible(&ts->sem))
> +		return -EINTR;
> +
> +	if (ts->use_count++ != 0)
> +		goto out;
> +

Please kill both ts->sem and ts->use_count - input core already serializes
input_open and input_close.

> +	if (ts->rtask)
> +		panic("ucb1x00: rtask running?");
> +
> +	sema_init(&ts->irq_wait, 0);
> +	ret = ucb1x00_hook_irq(ts->ucb, UCB_IRQ_TSPX, ucb1x00_ts_irq, ts);
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * If we do this at all, we should allow the user to
> +	 * measure and read the X and Y resistance at any time.
> +	 */
> +	ucb1x00_adc_enable(ts->ucb);
> +	ts->x_res = ucb1x00_ts_read_xres(ts);
> +	ts->y_res = ucb1x00_ts_read_yres(ts);
> +	ucb1x00_adc_disable(ts->ucb);
> +
> +	init_completion(&ts->init_exit);
> +	ret = kernel_thread(ucb1x00_thread, ts, CLONE_KERNEL);
> +	if (ret >= 0) {
> +		wait_for_completion(&ts->init_exit);
> +		ret = 0;
> +	} else {
> +		ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
> +	}

	kthread_run(ucb1x00_thread, ts, "ktsd")...

> +
> +MODULE_PARM(adcsync, "i");
> +MODULE_PARM_DESC(adcsync, "Enable use of ADCSYNC signal");

Die, MODULE_PARM, die!

-- 
Dmitry

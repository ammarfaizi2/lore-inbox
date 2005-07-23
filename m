Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVGWDvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVGWDvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVGWDvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:51:38 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:58481 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262328AbVGWDvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:51:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] Touchscreen support for sharp sl-5500
Date: Fri, 22 Jul 2005 22:51:31 -0500
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       rmk@arm.linux.org.uk, vojtech@suse.cz
References: <20050723002839.GA2077@elf.ucw.cz>
In-Reply-To: <20050723002839.GA2077@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507222251.31931.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 July 2005 19:28, Pavel Machek wrote:
> This adds support for touchscreen on Sharp Zaurus sl-5500. Vojtech,
> please apply,

I have couple more commnets...

> +static int ucb1x00_thread(void *_ts)
> +{
> +	struct ucb1x00_ts *ts = _ts;
> +	struct task_struct *tsk = current;
> +	int valid;
> +
> +	ts->rtask = tsk;
> +	allow_signal(SIGKILL);

This is not needed...

> +
> +	/*
> +	 * We run as a real-time thread.  However, thus far
> +	 * this doesn't seem to be necessary.
> +	 */
> +	tsk->policy = SCHED_FIFO;
> +	tsk->rt_priority = 1;
> +
> +	complete(&ts->init_exit);
> +

Neither this one - kthread_create does not return until thread is actually
created and started.

> +
> +		if (signal_pending(tsk))
> +			break;

if (kthread_should_stop(..))
	break;

> +	}
> +
> +	ts->rtask = NULL;
> +	complete_and_exit(&ts->init_exit, 0);

This is not needed.

> +static int ucb1x00_ts_open(struct input_dev *idev)
> +{
> +	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
> +	int ret = 0;
> +	struct task_struct *task;
> +
> +	if (ts->rtask)
> +		panic("ucb1x00: rtask running?");
> +

Do you really need to panic here???

> +
> +	init_completion(&ts->init_exit);
> +	task = kthread_run(ucb1x00_thread, ts, "ktsd");
> +	if (!IS_ERR(task)) {
> +		wait_for_completion(&ts->init_exit);

Just call kthread_run() and kill that init_exit completion. 

> +static void ucb1x00_ts_close(struct input_dev *idev)
> +{
> +	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
> +
> +	if (ts->rtask) {
> +		send_sig(SIGKILL, ts->rtask, 1);
> +		wait_for_completion(&ts->init_exit);

kthread_stop().

-- 
Dmitry

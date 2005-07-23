Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVGWNls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVGWNls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 09:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVGWNls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 09:41:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14478 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261703AbVGWNlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 09:41:47 -0400
Date: Sat, 23 Jul 2005 15:41:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       rmk@arm.linux.org.uk, vojtech@suse.cz
Subject: Re: [patch 2/2] Touchscreen support for sharp sl-5500
Message-ID: <20050723131745.GA1917@elf.ucw.cz>
References: <20050723002839.GA2077@elf.ucw.cz> <200507222251.31931.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507222251.31931.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This adds support for touchscreen on Sharp Zaurus sl-5500. Vojtech,
> > please apply,
> 
> I have couple more commnets...

Sorry, I never really worked with kthreads. Applied all those, 

> > +static int ucb1x00_ts_open(struct input_dev *idev)
> > +{
> > +	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
> > +	int ret = 0;
> > +	struct task_struct *task;
> > +
> > +	if (ts->rtask)
> > +		panic("ucb1x00: rtask running?");
> > +
> 
> Do you really need to panic here???

Does BUG_ON() seem better :-). We could also just return failure here,
but I do not see how it could happen => I guess I'd better catch it
with BUG().

Here's what I did, updated patch will follow.
								Pavel

diff --git a/drivers/input/touchscreen/collie_ts.c b/drivers/input/touchscreen/collie_ts.c
--- a/drivers/input/touchscreen/collie_ts.c
+++ b/drivers/input/touchscreen/collie_ts.c
@@ -41,7 +41,6 @@ struct ucb1x00_ts {
 	struct ucb1x00		*ucb;
 
 	struct semaphore	irq_wait;
-	struct completion	init_exit;
 	struct task_struct	*rtask;
 	u16			x_res;
 	u16			y_res;
@@ -160,7 +159,6 @@ static int ucb1x00_thread(void *_ts)
 	int valid;
 
 	ts->rtask = tsk;
-	allow_signal(SIGKILL);
 
 	/*
 	 * We run as a real-time thread.  However, thus far
@@ -169,10 +167,7 @@ static int ucb1x00_thread(void *_ts)
 	tsk->policy = SCHED_FIFO;
 	tsk->rt_priority = 1;
 
-	complete(&ts->init_exit);
-
 	valid = 0;
-
 	for (;;) {
 		unsigned int x, y, p, val;
 
@@ -237,12 +232,12 @@ static int ucb1x00_thread(void *_ts)
 			msleep_interruptible(10);
 		}
 
-		if (signal_pending(tsk))
+		if (kthread_should_stop())
 			break;
 	}
 
 	ts->rtask = NULL;
-	complete_and_exit(&ts->init_exit, 0);
+	return 0;
 }
 
 /*
@@ -262,8 +257,7 @@ static int ucb1x00_ts_open(struct input_
 	int ret = 0;
 	struct task_struct *task;
 
-	if (ts->rtask)
-		panic("ucb1x00: rtask running?");
+	BUG_ON(ts->rtask);
 
 	sema_init(&ts->irq_wait, 0);
 	ret = ucb1x00_hook_irq(ts->ucb, UCB_IRQ_TSPX, ucb1x00_ts_irq, ts);
@@ -279,10 +273,8 @@ static int ucb1x00_ts_open(struct input_
 	ts->y_res = ucb1x00_ts_read_yres(ts);
 	ucb1x00_adc_disable(ts->ucb);
 
-	init_completion(&ts->init_exit);
 	task = kthread_run(ucb1x00_thread, ts, "ktsd");
 	if (!IS_ERR(task)) {
-		wait_for_completion(&ts->init_exit);
 		ret = 0;
 	} else {
 		ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
@@ -300,10 +292,8 @@ static void ucb1x00_ts_close(struct inpu
 {
 	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
 
-	if (ts->rtask) {
-		send_sig(SIGKILL, ts->rtask, 1);
-		wait_for_completion(&ts->init_exit);
-	}
+	if (ts->rtask)
+		kthread_stop(ts->rtask);
 
 	ucb1x00_enable(ts->ucb);
 	ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);



-- 
teflon -- maybe it is a trademark, but it should not be.

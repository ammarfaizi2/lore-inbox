Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVGYVgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVGYVgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVGYVgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:36:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14213 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261505AbVGYVgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:36:18 -0400
Date: Mon, 25 Jul 2005 23:36:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050725213608.GB8684@elf.ucw.cz>
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz> <d120d500050725081664cd73fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050725081664cd73fe@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have made quite a lot of cleanups to touchscreen part, and it seems
> > to be acceptable by input people. I think it should go into
> > drivers/input/touchscreen/collie_ts.c... Also it looks to me like
> > mcp.h should go into asm/arch-sa1100, so that other drivers can use it...
> 
> I have couple of nitpicks (below) and one bigger concern - I am
> surprised that a driver for a physical device is implemented as an
> interface to a class device. This precludes implementing any kind of
> power management in the driver and pushes it into the parent and is
> generally speaking is a wrong thing to do (IMHO).

I'll port my changes to newer version of rmk's tree, that should solve
it.

> > +static int ucb1x00_thread(void *_ts)
> > +{
> > +       struct ucb1x00_ts *ts = _ts;
> > +       struct task_struct *tsk = current;
> > +       int valid;
> > +
> > +       ts->rtask = tsk;
> 
> Just move that assignment into ucb1x00_input_open and kill all this
> "current" stuff.

It will still want to set the priority, but yes, it cleaned it.

> > +       /*
> > +        * We run as a real-time thread.  However, thus far
> > +        * this doesn't seem to be necessary.
> > +        */
> > +       tsk->policy = SCHED_FIFO;
> > +       tsk->rt_priority = 1;
> > +
> > +       valid = 0;
> > +       for (;;) {
> 
> Can we change this to "while (!kthread_should_stop())" to make me
> completely happy?

:-) Ok.

[Just FYI, I'll post agregated patch when I solve file placement and
port to newer version.]

Cleanups suggested by Dmitri.

---
commit 60814924ed695d863fa226c24b3d4e96054c8b66
tree 0e88e8272c23926c5654ae10bfe14d4cb2af84ab
parent ff30d8505b88064a5f6e6e70bd42028150a864e2
author <pavel@amd.(none)> Mon, 25 Jul 2005 23:35:21 +0200
committer <pavel@amd.(none)> Mon, 25 Jul 2005 23:35:21 +0200

 drivers/input/touchscreen/collie_ts.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/collie_ts.c b/drivers/input/touchscreen/collie_ts.c
--- a/drivers/input/touchscreen/collie_ts.c
+++ b/drivers/input/touchscreen/collie_ts.c
@@ -158,8 +158,6 @@ static int ucb1x00_thread(void *_ts)
 	struct task_struct *tsk = current;
 	int valid;
 
-	ts->rtask = tsk;
-
 	/*
 	 * We run as a real-time thread.  However, thus far
 	 * this doesn't seem to be necessary.
@@ -168,7 +166,7 @@ static int ucb1x00_thread(void *_ts)
 	tsk->rt_priority = 1;
 
 	valid = 0;
-	for (;;) {
+	while (!kthread_should_stop()) {
 		unsigned int x, y, p, val;
 
 		ts->restart = 0;
@@ -231,9 +229,6 @@ static int ucb1x00_thread(void *_ts)
 
 			msleep_interruptible(10);
 		}
-
-		if (kthread_should_stop())
-			break;
 	}
 
 	ts->rtask = NULL;
@@ -273,11 +268,12 @@ static int ucb1x00_ts_open(struct input_
 	ts->y_res = ucb1x00_ts_read_yres(ts);
 	ucb1x00_adc_disable(ts->ucb);
 
-	task = kthread_run(ucb1x00_thread, ts, "ktsd");
-	if (!IS_ERR(task)) {
+	ts->rtask = kthread_run(ucb1x00_thread, ts, "ktsd");
+	if (!IS_ERR(ts->task)) {
 		ret = 0;
 	} else {
 		ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+		ts->rtask = NULL;
 		ret = -EFAULT;
 	}
 


-- 
teflon -- maybe it is a trademark, but it should not be.

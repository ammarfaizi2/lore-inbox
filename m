Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbRBSKR3>; Mon, 19 Feb 2001 05:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129358AbRBSKRT>; Mon, 19 Feb 2001 05:17:19 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:24593 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129355AbRBSKRM>; Mon, 19 Feb 2001 05:17:12 -0500
Date: Mon, 19 Feb 2001 04:17:06 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Kenn Humborg <kenn@linux.ie>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>, dwmw2@redhat.com
Subject: Re: kernel_thread() & thread starting
In-Reply-To: <20010218222416.D22176@excalibur.research.wombat.ie>
Message-ID: <Pine.LNX.3.96.1010219040821.16489E-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2001, Kenn Humborg wrote:
> in the .config, I can get schedule_task() to fail with:
> 
>    schedule_task(): keventd has not started

This shouldn't be a failure case, just a (bogus) printk.

> When starting bdflush and kupdated, bdflush_init() uses a semaphore to
> make sure that the threads have run before continuing.  Shouldn't
> start_context_thread() do something similar?

Why bother ?  It looks like a leftover debugging message which doesn't
make a lot of sense once the code is stable (what might make sense is
checking keventd is still around, but that's not what the code is doing).

Proposed patch:

--- linux-2.4/kernel/context.c	Fri Jan 12 18:52:41 2001
+++ linux-prumpf/kernel/context.c	Mon Feb 19 11:11:37 2001
@@ -26,19 +26,9 @@
 static int keventd_running;
 static struct task_struct *keventd_task;
 
-static int need_keventd(const char *who)
-{
-	if (keventd_running == 0)
-		printk(KERN_ERR "%s(): keventd has not started\n", who);
-	return keventd_running;
-}
-	
 int current_is_keventd(void)
 {
-	int ret = 0;
-	if (need_keventd(__FUNCTION__))
-		ret = (current == keventd_task);
-	return ret;
+	return current == keventd_task;
 }
 
 /**
@@ -57,7 +47,6 @@
 int schedule_task(struct tq_struct *task)
 {
 	int ret;
-	need_keventd(__FUNCTION__);
 	ret = queue_task(task, &tq_context);
 	wake_up(&context_task_wq);
 	return ret;

dwmw2 ?


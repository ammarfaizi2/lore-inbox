Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269628AbUJSQfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbUJSQfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269695AbUJSQbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:31:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15495 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269576AbUJSQZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:25:17 -0400
Date: Tue, 19 Oct 2004 18:26:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019162611.GA13232@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019144642.GA6512@elte.hu> <1098200916.12223.929.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098200916.12223.929.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 2004-10-19 at 16:46, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > i've re-released the patch because shortly after releasing it i found a
> > false-positive in the deadlock-detector that was triggering in oowriter. 
> 
> Hit and converted another one. There are more, but they need more
> modifications as they don't have a condition to wait for and therefor
> must be converted to use the completion API, which must be extended to
> provide completion_timemout() first.

thanks, i've applied your patch to my tree. Find below an untested
implementation of wait_for_completion_timeout().

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -3070,6 +3148,31 @@ void fastcall __sched wait_for_completio
 }
 EXPORT_SYMBOL(wait_for_completion);
 
+unsigned long fastcall __sched
+wait_for_completion_timeout(struct completion *x, unsigned long timeout)
+{
+	might_sleep();
+	spin_lock_irq(&x->wait.lock);
+	if (!x->done) {
+		DECLARE_WAITQUEUE(wait, current);
+
+		wait.flags |= WQ_FLAG_EXCLUSIVE;
+		__add_wait_queue_tail(&x->wait, &wait);
+		do {
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+			spin_unlock_irq(&x->wait.lock);
+			timeout = schedule_timeout(timeout);
+			spin_lock_irq(&x->wait.lock);
+		} while (!x->done);
+		__remove_wait_queue(&x->wait, &wait);
+	}
+	x->done--;
+	spin_unlock_irq(&x->wait.lock);
+
+	return timeout;
+}
+EXPORT_SYMBOL(wait_for_completion_timeout);
+
 #define	SLEEP_ON_VAR					\
 	unsigned long flags;				\
 	wait_queue_t wait;				\
--- linux/include/linux/completion.h.orig
+++ linux/include/linux/completion.h
@@ -28,6 +28,8 @@ static inline void init_completion(struc
 }
 
 extern void FASTCALL(wait_for_completion(struct completion *));
+extern unsigned long FASTCALL(wait_for_completion_timeout(struct completion *,
+							  unsigned long));
 extern void FASTCALL(complete(struct completion *));
 extern void FASTCALL(complete_all(struct completion *));
 

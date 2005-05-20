Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVETJ4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVETJ4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 05:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVETJ4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 05:56:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:24496 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261394AbVETJ4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 05:56:08 -0400
Date: Fri, 20 May 2005 11:49:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: chen Shang <shangcs@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       rml@tech9.net, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Message-ID: <20050520094909.GA16923@elte.hu>
References: <855e4e4605051909561f47351@mail.gmail.com> <428D58E6.8050001@yahoo.com.au> <855e4e460505192117155577e@mail.gmail.com> <428D71F9.10503@yahoo.com.au> <855e4e46050520001215be7cde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855e4e46050520001215be7cde@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* chen Shang <shangcs@gmail.com> wrote:

> I minimized my patch and against to 2.6.12-rc4 this time, see below.

looks good - i've done some small style/whitespace cleanups and renamed 
prio to old_prio, patch against -rc4 below.

	Ingo

From: Chen Shang <shangcs@gmail.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2613,7 +2613,7 @@ asmlinkage void __sched schedule(void)
 	struct list_head *queue;
 	unsigned long long now;
 	unsigned long run_time;
-	int cpu, idx;
+	int cpu, idx, old_prio;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2735,9 +2735,15 @@ go_idle:
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
 		array = next->array;
-		dequeue_task(next, array);
+		old_prio = next->prio;
+
 		recalc_task_prio(next, next->timestamp + delta);
-		enqueue_task(next, array);
+
+		if (unlikely(old_prio != next->prio)) {
+			dequeue_task(next, array);
+			enqueue_task(next, array);
+		} else
+			requeue_task(next, array);
 	}
 	next->activated = 0;
 switch_tasks:

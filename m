Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVETHMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVETHMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 03:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVETHMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 03:12:51 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:35348 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261367AbVETHMV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 03:12:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N5Rk1TNprEUJYIPAXWCNvhv24g0SUnxnCfW9SnCbJgpOznmue2cZ3B2HMZrNAJIeE1wyUYHvMUYWnfVjSvssHmyRHtT0RzeIpdVNfADHuSM7nnkHcmeLGgVb9mvNRctKQ6cK1VYnwzD4rM7eHKzRYvZ5sHsOVVJycNBhmAOLN8g=
Message-ID: <855e4e46050520001215be7cde@mail.gmail.com>
Date: Fri, 20 May 2005 00:12:18 -0700
From: chen Shang <shangcs@gmail.com>
Reply-To: chen Shang <shangcs@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Cc: linux-kernel@vger.kernel.org, rml@tech9.net
In-Reply-To: <428D71F9.10503@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <855e4e4605051909561f47351@mail.gmail.com>
	 <428D58E6.8050001@yahoo.com.au>
	 <855e4e460505192117155577e@mail.gmail.com>
	 <428D71F9.10503@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I minimized my patch and against to 2.6.12-rc4 this time, see below.

The new schedstat fields are for the test propose only, so I removed
them completedly from patch. Theoritically, requeue_task() is always
cheaper than dequeue_task() followed by enqueue_task(). So, if 99% of
priority recalculation trigger requeue_task(), it will save.

In addition, my load is to build the kernel, which took around 30
minutes with around 30% CPU usage on 2x2 processors (duel processors
with HT enable).
Here is the statistics:
         
CPU0: priority_changed (669 times), priority_unchanged(335,138 times)
CPU1: priority_changed (784 times), priority_unchanged(342,419 times)
CPU2: priority_changed (782 times), priority_unchanged(283,494 times)
CPU3: priority_changed (872 times), priority_unchanged(365,865 times)

Thanks,
-chen


/*=====Patch=====*/
--- linux-2.6.12-rc4.orig/kernel/sched.c	2005-05-19 14:57:55.000000000 -0700
+++ linux-2.6.12-rc4/kernel/sched.c	2005-05-19 23:47:22.000000000 -0700
@@ -2613,7 +2613,7 @@
 	struct list_head *queue;
 	unsigned long long now;
 	unsigned long run_time;
-	int cpu, idx;
+	int cpu, idx, prio;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2735,9 +2735,17 @@
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
 		array = next->array;
-		dequeue_task(next, array);
+		prio = next->prio;
+		
 		recalc_task_prio(next, next->timestamp + delta);
-		enqueue_task(next, array);
+
+		if (unlikely(prio != next->prio))
+		{
+			dequeue_task(next, array);
+			enqueue_task(next, array);
+		}
+		else
+			requeue_task(next, array);
 	}
 	next->activated = 0;
 switch_tasks:

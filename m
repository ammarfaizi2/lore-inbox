Return-Path: <linux-kernel-owner+w=401wt.eu-S1751281AbWLOIHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWLOIHQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWLOIHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:07:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44935 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbWLOIHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:07:14 -0500
Date: Fri, 15 Dec 2006 09:03:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [BUG -rt] scheduling in atomic.
Message-ID: <20061215080316.GA4213@elte.hu>
References: <1166154463.19210.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166154463.19210.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> I've hit this. I compiled the kernel as CONFIG_PREEMPT, and turned off
> IRQ's as threads.
> 
> BUG: scheduling while atomic: swapper/0x00000001/1, CPU#3

> int filevec_add_drain_all(void)
> {
> 	return schedule_on_each_cpu(filevec_add_drain_per_cpu, NULL);
> }
> 
> 
> And schedule_on_each_cpu is easily schedulable.
> 
> So it seems that it schedules while holding a spin lock.

hm, indeed. I've Cc:-ed Pete who wrote the file-lock scalability 
patchset. My quick impression is that taking the workqueue_mutex in 
schedule_on_each_cpu() is unwarranted - i.e. the patch below should fix 
it.

	Ingo

Index: linux/kernel/workqueue.c
===================================================================
--- linux.orig/kernel/workqueue.c
+++ linux/kernel/workqueue.c
@@ -564,15 +564,15 @@ int schedule_on_each_cpu(void (*func)(vo
 	if (!works)
 		return -ENOMEM;
 
-	mutex_lock(&workqueue_mutex);
 	for_each_online_cpu(cpu) {
 		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
 		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
 				per_cpu_ptr(works, cpu));
 	}
-	mutex_unlock(&workqueue_mutex);
 	flush_workqueue(keventd_wq);
+
 	free_percpu(works);
+
 	return 0;
 }
 

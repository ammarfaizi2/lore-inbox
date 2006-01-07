Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWAGBFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWAGBFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWAGBFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:05:46 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:61880 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932482AbWAGBFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:05:45 -0500
Subject: Re: sched.c:659 dec_rt_tasks BUG with patch-2.6.15-rt1
	(realtime-preempt)
From: Steven Rostedt <rostedt@goodmis.org>
To: Nedko Arnaudov <nedko@arnaudov.name>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <874q4ig0zj.fsf@arnaudov.name>
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
	 <20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
	 <87u0cj5riq.fsf_-_@arnaudov.name>
	 <1136436273.12468.113.camel@localhost.localdomain>
	 <87u0cj3saf.fsf@arnaudov.name>
	 <1136463552.12468.119.camel@localhost.localdomain>
	 <87k6deg2z6.fsf@arnaudov.name>
	 <Pine.LNX.4.58.0601050936340.10361@gandalf.stny.rr.com>
	 <874q4ig0zj.fsf@arnaudov.name>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 20:05:36 -0500
Message-Id: <1136595936.12468.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 17:15 +0200, Nedko Arnaudov wrote:
> Will try to crash SMP ASAP, I'm not able to do tests now.
> 
> I do erase/burn of 210 MiB rw disk. Erase is done without crash.
> I use version 2.01.01a03 of cdrecord.
> It crashes when burning:
> 
> http://nedko.arnaudov.name/tmp/rt-cdrecord-crash.jpg
> 
> Same crash occurs when I run oss2jack with -d option.
> It does not occur when running without -d option (daemonize).
> 

Nedko,

Could you try either the patch below, or the link
http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt2-sr2
which has the patch included, to see if this fixes your problem.

Thanks,

-- Steve

Index: linux-2.6.15-rt2/kernel/sched.c
===================================================================
--- linux-2.6.15-rt2.orig/kernel/sched.c	2006-01-06 17:49:41.000000000 -0500
+++ linux-2.6.15-rt2/kernel/sched.c	2006-01-06 19:36:17.000000000 -0500
@@ -783,7 +783,6 @@
 static inline void inc_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running++;
-	inc_rt_tasks(p, rq);
 }
 
 static inline void dec_nr_running(task_t *p, runqueue_t *rq)
@@ -921,11 +920,17 @@
 static inline
 void __activate_task_after(task_t *p, task_t *parent, runqueue_t *rq)
 {
+	trace_special_pid(p->pid, p->prio, rq->nr_running);
+	if (p->flags & PF_DEAD) {
+		printk("BUG: %s/%d: dead task enqueued!\n", p->comm, p->pid);
+		dump_stack();
+	}
+	sched_info_queued(p);
 	// FIXME: to head rather?
 	list_add_tail(&p->run_list, &parent->run_list);
 	p->array = parent->array;
 	p->array->nr_active++;
-
+	inc_rt_tasks(p, p->array->rq);
 	inc_nr_running(p, rq);
 }
 



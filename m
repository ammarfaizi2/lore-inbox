Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbTATWUQ>; Mon, 20 Jan 2003 17:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTATWUQ>; Mon, 20 Jan 2003 17:20:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:56000 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267141AbTATWUO>;
	Mon, 20 Jan 2003 17:20:14 -0500
Date: Mon, 20 Jan 2003 14:28:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: mbligh@aracnet.com, habanero@us.ibm.com, efocht@ess.nec.de,
       hohnbaum@us.ibm.com, colpatch@us.ibm.com, hch@infradead.org,
       rml@tech9.net, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, anton@samba.org, andrea@suse.de
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
Message-Id: <20030120142827.68c87059.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain>
References: <264880000.1043092340@flay>
	<Pine.LNX.4.44.0301202204210.18235-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2003 22:29:11.0007 (UTC) FILETIME=[5A93E6F0:01C2C0D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> the attached patch (against 2.5.59) is my current scheduler tree, it
> includes two main areas of changes:
> 
>  - interactivity improvements, mostly reworked bits from Andrea's tree and 
>    various tunings.
> 

Thanks for doing this.  Initial testing with one workload which is extremely
bad with 2.5.59: huge improvement.

The workload is:

workstation> ssh laptop
laptop> setenv DISPLAY workstation:0
laptop> make -j0 bzImage&
laptop> some-x-application &

For some reason, X-across-ethernet performs terribly when there's a kernel
compile on the client machine - lots of half-second lags.

All gone now.


wrt this:

	if (SMART_WAKE_CHILD) {
		if (unlikely(!current->array))
			__activate_task(p, rq);
		else {
			p->prio = current->prio;
			list_add_tail(&p->run_list, &current->run_list);
			p->array = current->array;
			p->array->nr_active++;
			nr_running_inc(rq);
		}

for some reason I decided that RT tasks need special handling here.  I
forget why though ;)  Please double-check that.


--- 25/kernel/sched.c~rcf-simple	Thu Dec 26 02:34:11 2002
+++ 25-akpm/kernel/sched.c	Thu Dec 26 02:34:40 2002
@@ -452,6 +452,8 @@ int wake_up_process(task_t * p)
 void wake_up_forked_process(task_t * p)
 {
 	runqueue_t *rq = this_rq_lock();
+	struct task_struct *this_task = current;
+	prio_array_t *array = this_task->array;
 
 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
@@ -467,6 +469,19 @@ void wake_up_forked_process(task_t * p)
 	set_task_cpu(p, smp_processor_id());
 	activate_task(p, rq);
 
+	/*
+	 * Take caller off the head of the runqueue, so child will run first.
+	 */
+	if (array) {
+		if (!rt_task(current)) {
+			dequeue_task(this_task, array);
+			enqueue_task(this_task, array);
+		} else {
+			list_del(&this_task->run_list);
+			list_add_tail(&this_task->run_list,
+					array->queue + this_task->prio);
+		}
+	}
 	rq_unlock(rq);
 }
 



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUCINja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 08:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUCINja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 08:39:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12489 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261924AbUCINj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 08:39:28 -0500
Date: Tue, 9 Mar 2004 19:10:29 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, rusty@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: more efficient current_is_keventd macro? [was Re: [lhcs-devel] Re: Kthread_create() never returns when called from worker_thread]
Message-ID: <20040309134028.GA26645@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040308123030.GA7428@in.ibm.com> <20040308143658.25c1d378.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308143658.25c1d378.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 02:36:58PM -0800, Andrew Morton wrote:
> Is racy in the presence of preemption.  Please replace smp_processor_id()
> with get_cpu(), stick a put_cpu() at the end, avoid having two function
> return points, test it and send me the diff?

Hi Andrew,
	I had considered preemption and had thought using just
smp_processor_id() should be safe, since anyway the per-cpu kevent
thread is bound to its cpu alone.

Patch below is booted/tested against 2.6.4-rc2-mm1 on a 4-way x86 SMP box.
For testing, I basically called call_usermodehelper from inside a 
work function (activated using schedule_work) and checked that 
current_is_keventd() macro was returning true.

--- workqueue.c.org	2004-03-09 11:34:30.000000000 +0530
+++ workqueue.c	2004-03-09 19:06:51.000000000 +0530
@@ -374,16 +374,17 @@
 int current_is_keventd(void)
 {
 	struct cpu_workqueue_struct *cwq;
-	int cpu;
+	int cpu = smp_processor_id();
+	int ret = 0;
 
 	BUG_ON(!keventd_wq);
 
-	for_each_cpu(cpu) {
-		cwq = keventd_wq->cpu_wq + cpu;
-		if (current == cwq->thread)
-			return 1;
-	}
-	return 0;
+	cwq = keventd_wq->cpu_wq + cpu;
+	if (current == cwq->thread)
+		ret = 1;
+	
+	return ret;
+
 }
 
 #ifdef CONFIG_HOTPLUG_CPU

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017

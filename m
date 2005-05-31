Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVEaJku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVEaJku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEaJku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:40:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61893 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261544AbVEaJkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:40:40 -0400
Date: Tue, 31 May 2005 15:10:45 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, ashok.raj@intel.com
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
Message-ID: <20050531094045.GA9884@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117524909.3820.11.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 07:29:39AM +0000, Shaohua Li wrote:
> Hi,
> There is a race condition at wake_up_new_task at CPU hotplug case.
> Say do_fork
>         copy_process (which sets new forked task's current cpu, cpu_allowed)
>                 <-------- the new forked task's current cpu is offline
>         wake_up_new_task
> wake_up_new_task will put the forked task into a dead cpu.

This was noticed/fixed long back. Apparently somebody has reintroduced
the bug. The simple fix for this race is:


--- kernel/fork.c.org	2005-05-31 14:57:15.000000000 +0530
+++ kernel/fork.c	2005-05-31 15:07:20.000000000 +0530
@@ -1024,8 +1024,7 @@ static task_t *copy_process(unsigned lon
 	 * parent's CPU). This avoids alot of nasty races.
 	 */
 	p->cpus_allowed = current->cpus_allowed;
-	if (unlikely(!cpu_isset(task_cpu(p), p->cpus_allowed)))
-		set_task_cpu(p, smp_processor_id());
+	set_task_cpu(p, smp_processor_id());
 
 	/*
 	 * Check for pending SIGKILL! The new thread should not be allowed

Could you test and check if it avoids whatever problem you are seeing?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017

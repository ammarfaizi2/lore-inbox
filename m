Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269886AbUH0B7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269886AbUH0B7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269942AbUH0Bzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:55:39 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:36313 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S269893AbUH0Bwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:52:50 -0400
Subject: Re: [PATCH 2/2] Hotplug CPU vs TASK_ZOMBIEs: The Sequel to Hotplug
	CPU vs TASK_DEAD
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <1093534187.4249.5.camel@biclops.private.network>
References: <20040822013402.5917b991.akpm@osdl.org>
	 <1093299523.5284.70.camel@pants.austin.ibm.com>
	 <1093475339.7056.6.camel@pants.austin.ibm.com>
	 <1093507097.29319.2510.camel@bach>
	 <1093534187.4249.5.camel@biclops.private.network>
Content-Type: text/plain
Message-Id: <1093568074.17652.1.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 11:38:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 01:29, Nathan Lynch wrote:
> On Thu, 2004-08-26 at 02:58, Rusty Russell wrote:
> > Name: Hotplug CPU vs TASK_ZOMBIEs: The Sequel to Hotplug CPU vs TASK_DEAD
> > Status: Tested on 2.6.8.1-mm4
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > Depends: Misc/stop_machine-nicksched-yield.patch.gz
> 
> Where can I get stop_machine-nicksched-yield.patch?  I assume this fixes
> the interaction between nicksched and stop_machine_run?

I posted it before: it's a one-liner.  Again, below.

Cheers,
Rusty.
Name: Fix stop_machine() For Nick Sched
Status: Tested on 2.6.8.1-mm4
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Version: -mm

With Nick's scheduler, yield() on a RT task does nothing unless it's
SCHED_RR.  But __stop_machine_run() yields for migration threads to
move the kstopmachine threads onto the other CPUs.  Change it from
SCHED_FIFO to SCHED_RR, and it yields correctly.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13565-linux-2.6.8.1-mm4/kernel/stop_machine.c .13565-linux-2.6.8.1-mm4.updated/kernel/stop_machine.c
--- .13565-linux-2.6.8.1-mm4/kernel/stop_machine.c	2004-05-10 15:13:59.000000000 +1000
+++ .13565-linux-2.6.8.1-mm4.updated/kernel/stop_machine.c	2004-08-26 16:24:56.000000000 +1000
@@ -82,7 +86,7 @@ static int stop_machine(void)
 	int i, ret = 0;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 
 	/* One high-prio thread per cpu.  We'll do this one. */
-	sys_sched_setscheduler(current->pid, SCHED_FIFO, &param);
+	sys_sched_setscheduler(current->pid, SCHED_RR, &param);
 
 	atomic_set(&stopmachine_thread_ack, 0);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


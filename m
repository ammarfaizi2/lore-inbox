Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSFQAPl>; Sun, 16 Jun 2002 20:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSFQAPk>; Sun, 16 Jun 2002 20:15:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19440 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316637AbSFQAPi>; Sun, 16 Jun 2002 20:15:38 -0400
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <1024271844.1476.26.camel@sinai>
References: <Pine.LNX.4.44.0206161809480.9633-200000@e2> 
	<1024271844.1476.26.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 16 Jun 2002 17:15:23 -0700
Message-Id: <1024272924.922.35.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-16 at 16:57, Robert Love wrote:

> Another case of 2.4-ac being right

Attached patch brings over the sane bits from 2.4-ac: i.e. if Linus
merges this and Alan merges your patch minus my complaints, the two
trees will be in sync...

	Robert Love

diff -urN linux-2.5.21/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.21/kernel/sched.c	Sat Jun  8 22:28:13 2002
+++ linux/kernel/sched.c	Sun Jun 16 17:14:31 2002
@@ -762,8 +762,8 @@
 	list_t *queue;
 	int idx;
 
-	if (unlikely(in_interrupt()))
-		BUG();
+	BUG_ON(in_interrupt());
+
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
 #endif
@@ -1147,7 +1147,7 @@
 
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_USER_RT_PRIO, valid priority for SCHED_OTHER is 0.
+	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_OTHER is 0.
 	 */
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
@@ -1710,15 +1710,15 @@
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 	/*
-	 * The first migration thread is started on CPU #0. This one can migrate
-	 * the other migration threads to their destination CPUs.
+	 * The first migration thread is started on CPU #0. This one can
+	 * migrate the other migration threads to their destination CPUs.
 	 */
 	if (cpu != 0) {
 		while (!cpu_rq(cpu_logical_map(0))->migration_thread)
 			yield();
 		set_cpus_allowed(current, 1UL << cpu);
 	}
-	printk("migration_task %d on cpu=%d\n",cpu,smp_processor_id());
+	printk("migration_task %d on cpu=%d\n", cpu, smp_processor_id());
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
 	rq = this_rq();
@@ -1790,4 +1790,4 @@
 		while (!cpu_rq(cpu_logical_map(cpu))->migration_thread)
 			schedule_timeout(2);
 }
-#endif
+#endif /* CONFIG_SMP */


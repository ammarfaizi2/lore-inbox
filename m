Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262018AbSI3LCV>; Mon, 30 Sep 2002 07:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262016AbSI3LCV>; Mon, 30 Sep 2002 07:02:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19353 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262015AbSI3LCU>; Mon, 30 Sep 2002 07:02:20 -0400
Date: Mon, 30 Sep 2002 16:43:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.39-mm1 fixes 1/3
Message-ID: <20020930164314.A27121@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

rcu_ltimer was used mostly for performance measurements and wasn't
completely preemption friendly. With this fix (against 2.5.39-mm1), 
it should be now.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


--- kernel/rcupdate.c.orig	Mon Sep 30 13:55:15 2002
+++ kernel/rcupdate.c	Mon Sep 30 13:55:29 2002
@@ -60,12 +60,13 @@
  */
 void call_rcu(struct rcu_head *head, void (*func)(void *arg), void *arg)
 {
-	int cpu = smp_processor_id();
+	int cpu;
 	unsigned long flags;
 
 	head->func = func;
 	head->arg = arg;
 	local_irq_save(flags);
+	cpu = smp_processor_id();
 	list_add_tail(&head->list, &RCU_nxtlist(cpu));
 	local_irq_restore(flags);
 }

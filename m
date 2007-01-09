Return-Path: <linux-kernel-owner+w=401wt.eu-S932131AbXAIPFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbXAIPFk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbXAIPFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:05:40 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:10976 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbXAIPFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:05:39 -0500
Date: Tue, 9 Jan 2007 16:05:29 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Benjamin Gilbert <bgilbert@cs.cmu.edu>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Gautham shenoy <ego@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch -mm] call cpu_chain with CPU_DOWN_FAILED if CPU_DOWN_PREPARE failed
Message-ID: <20070109150529.GE9563@osiris.boeblingen.de.ibm.com>
References: <20070108120719.16d4674e.bgilbert@cs.cmu.edu> <20070109121738.GC9563@osiris.boeblingen.de.ibm.com> <20070109122740.GC22080@in.ibm.com> <20070109150351.GD9563@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109150351.GD9563@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This makes cpu hotplug symmetrical: if CPU_UP_PREPARE fails we get
CPU_UP_CANCELED, so we can undo what ever happened on PREPARE.
The same should happen for CPU_DOWN_PREPARE.

Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Gautham Shenoy <ego@in.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 kernel/cpu.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

Index: linux-2.6.20-rc3-mm1/kernel/cpu.c
===================================================================
--- linux-2.6.20-rc3-mm1.orig/kernel/cpu.c
+++ linux-2.6.20-rc3-mm1/kernel/cpu.c
@@ -122,9 +122,10 @@ static int take_cpu_down(void *unused)
 /* Requires cpu_add_remove_lock to be held */
 static int _cpu_down(unsigned int cpu)
 {
-	int err;
+	int err, nr_calls = 0;
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
+	void *hcpu = (void *)(long)cpu;
 
 	if (num_online_cpus() == 1)
 		return -EBUSY;
@@ -132,11 +133,12 @@ static int _cpu_down(unsigned int cpu)
 	if (!cpu_online(cpu))
 		return -EINVAL;
 
-	raw_notifier_call_chain(&cpu_chain, CPU_LOCK_ACQUIRE,
-						(void *)(long)cpu);
-	err = raw_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
-						(void *)(long)cpu);
+	raw_notifier_call_chain(&cpu_chain, CPU_LOCK_ACQUIRE, hcpu);
+	err = __raw_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
+					hcpu, -1, &nr_calls);
 	if (err == NOTIFY_BAD) {
+		__raw_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED, hcpu,
+					  nr_calls, NULL);
 		printk("%s: attempt to take down CPU %u failed\n",
 				__FUNCTION__, cpu);
 		err = -EINVAL;
@@ -156,7 +158,7 @@ static int _cpu_down(unsigned int cpu)
 	if (IS_ERR(p) || cpu_online(cpu)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		if (raw_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
-				(void *)(long)cpu) == NOTIFY_BAD)
+					    hcpu) == NOTIFY_BAD)
 			BUG();
 
 		if (IS_ERR(p)) {
@@ -178,8 +180,7 @@ static int _cpu_down(unsigned int cpu)
 	put_cpu();
 
 	/* CPU is completely dead: tell everyone.  Too late to complain. */
-	if (raw_notifier_call_chain(&cpu_chain, CPU_DEAD,
-			(void *)(long)cpu) == NOTIFY_BAD)
+	if (raw_notifier_call_chain(&cpu_chain, CPU_DEAD, hcpu) == NOTIFY_BAD)
 		BUG();
 
 	check_for_tasks(cpu);

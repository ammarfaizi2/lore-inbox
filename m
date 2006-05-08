Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWEHFr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWEHFr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWEHFrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:47:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:43637 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932323AbWEHFrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:47:03 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948464:sNHT59478041"
Subject: [PATCH 4/10] make sched_domain_update friendly with cpu bulk
	removal
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:44 +0800
Message-Id: <1147067144.2760.82.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Say CPU 1 & CPU 2 are offlining, we will do in bulk cpu removal:
1. notifier callback (CPU_DOWN_PREPARE) on CPU 1
2. notifier callback (CPU_DOWN_PREPARE) on CPU 2
3. take_cpu_down CPU 1 & 2
4. notifier callback (CPU_DEAD) on CPU 1
5. notifier callback (CPU_DEAD) on CPU 2
The step 4 will settle down cpu domain according to new cpu_online_map. And
load balance could happen soon. Step 5 try to set this again and cause race.
This is a workaround for above issue.
Generally, this is because 'update_sched_domains' isn't a per-cpu callback, it
affects all cpus.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc3-root/kernel/sched.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~sched_domain_update_cpuhp kernel/sched.c
--- linux-2.6.17-rc3/kernel/sched.c~sched_domain_update_cpuhp	2006-05-07 07:45:32.000000000 +0800
+++ linux-2.6.17-rc3-root/kernel/sched.c	2006-05-07 07:45:32.000000000 +0800
@@ -6093,13 +6093,17 @@ void partition_sched_domains(cpumask_t *
  * code, so we temporarily attach all running cpus to the NULL domain
  * which will prevent rebalancing while the sched domains are recalculated.
  */
+static cpumask_t ready_sched_domains; /* FIXME: this is a hack */
 static int update_sched_domains(struct notifier_block *nfb,
 				unsigned long action, void *hcpu)
 {
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_DOWN_PREPARE:
-		detach_destroy_domains(&cpu_online_map);
+		if (!cpus_empty(ready_sched_domains)) {
+			detach_destroy_domains(&cpu_online_map);
+			cpus_clear(ready_sched_domains);
+		}
 		return NOTIFY_OK;
 
 	case CPU_UP_CANCELED:
@@ -6115,7 +6119,10 @@ static int update_sched_domains(struct n
 	}
 
 	/* The hotplug lock is already held by cpu_up/cpu_down */
-	arch_init_sched_domains(&cpu_online_map);
+	if (!cpus_equal(ready_sched_domains, cpu_online_map)) {
+		arch_init_sched_domains(&cpu_online_map);
+		ready_sched_domains = cpu_online_map;
+	}
 
 	return NOTIFY_OK;
 }
@@ -6125,6 +6132,9 @@ void __init sched_init_smp(void)
 {
 	lock_cpu_hotplug();
 	arch_init_sched_domains(&cpu_online_map);
+#ifdef CONFIG_HOTPLUG_CPU
+	ready_sched_domains = cpu_online_map;
+#endif
 	unlock_cpu_hotplug();
 	/* XXX: Theoretical race here - CPU may be hotplugged now */
 	hotcpu_notifier(update_sched_domains, 0);
_

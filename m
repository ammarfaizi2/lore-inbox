Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVKOImT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVKOImT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVKOImT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:42:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:29097 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751382AbVKOImT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:42:19 -0500
Date: Tue, 15 Nov 2005 09:42:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Subject: [patch] fix smp_processor_id() use in the cache-hot autodetector
Message-ID: <20051115084230.GA19472@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch fixes the DEBUG_PREEMPT warnings reported by Paul Jackson.  
The reason why raw_smp_processor_id() is fine here is that we dont care 
about the _precise_ CPU ID the boot process happens on, only about the 
quad. (the reason for this whole code is that NUMAQ doesnt like being 
migrated to a non-boot quad.) So we mark whatever CPU ID we happen to be 
on, and migrate back to it once calibration has finished.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/sched.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -5480,7 +5480,7 @@ __devinit static unsigned long long meas
 
 void __devinit calibrate_migration_costs(void)
 {
-	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = smp_processor_id();
+	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = raw_smp_processor_id();
 	struct sched_domain *sd;
 	unsigned long distance, max_distance = 0;
 	unsigned long long cost;
@@ -5567,7 +5567,7 @@ void __devinit calibrate_migration_costs
 	 * Move back to the original CPU. NUMA-Q gets confused
 	 * if we migrate to another quad during bootup.
 	 */
-	if (smp_processor_id() != orig_cpu) {
+	if (raw_smp_processor_id() != orig_cpu) {
 		cpumask_t mask = cpumask_of_cpu(orig_cpu),
 			saved_mask = current->cpus_allowed;
 

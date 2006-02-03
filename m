Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWBCMDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWBCMDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWBCMDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:03:00 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:33725 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750718AbWBCMC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:02:59 -0500
Date: Fri, 3 Feb 2006 02:09:27 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch -mm4] sched: only print migration_cost once
To: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602030212_MC3-1-B773-7D06@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

migration_cost prints after every CPU hotplug event.  Make it
print only once at boot.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm4-386.orig/kernel/sched.c
+++ 2.6.16-rc1-mm4-386/kernel/sched.c
@@ -5656,6 +5656,7 @@ static void calibrate_migration_costs(co
 	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = raw_smp_processor_id();
 	unsigned long j0, j1, distance, max_distance = 0;
 	struct sched_domain *sd;
+	static int printed_cost = 0; /* has cost already been printed? */
 
 	j0 = jiffies;
 
@@ -5699,13 +5700,16 @@ static void calibrate_migration_costs(co
 			-1
 #endif
 		);
-	printk("migration_cost=");
-	for (distance = 0; distance <= max_distance; distance++) {
-		if (distance)
-			printk(",");
-		printk("%ld", (long)migration_cost[distance] / 1000);
+	if (!printed_cost) {
+		printed_cost++;
+		printk("migration_cost=");
+		for (distance = 0; distance <= max_distance; distance++) {
+			if (distance)
+				printk(",");
+			printk("%ld", (long)migration_cost[distance] / 1000);
+		}
+		printk("\n");
 	}
-	printk("\n");
 	j1 = jiffies;
 	if (migration_debug)
 		printk("migration: %ld seconds\n", (j1-j0)/HZ);
-- 
Chuck

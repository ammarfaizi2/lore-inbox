Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbTIDDca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264626AbTIDDan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:30:43 -0400
Received: from dp.samba.org ([66.70.73.150]:12992 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264605AbTIDDaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:30:17 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] rediffed chatty printk running SMP kernel with 1 CPU
Date: Thu, 04 Sep 2003 13:23:01 +1000
Message-Id: <20030904033017.269412C06F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Nick Piggin <piggin@cyberone.com.au>

  This removes the reporting of the "error", and makes the output
  consistent with running the same kernel on an SMP box.
  
  Against test4
  

--- trivial-2.6.0-test4-bk5/arch/i386/kernel/smpboot.c.orig	2003-09-04 13:01:54.000000000 +1000
+++ trivial-2.6.0-test4-bk5/arch/i386/kernel/smpboot.c	2003-09-04 13:01:54.000000000 +1000
@@ -937,6 +937,7 @@
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit, kicked;
+	unsigned long bogosum = 0;
 
 	/*
 	 * Setup boot CPU information
@@ -1048,26 +1049,25 @@
 	/*
 	 * Allow the user to impress friends.
 	 */
-
 	Dprintk("Before bogomips.\n");
-	if (!cpucount) {
-		printk(KERN_ERR "Error: only one processor found.\n");
-	} else {
-		unsigned long bogosum = 0;
-		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			if (cpu_isset(cpu, cpu_callout_map))
-				bogosum += cpu_data[cpu].loops_per_jiffy;
-		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
-			cpucount+1,
-			bogosum/(500000/HZ),
-			(bogosum/(5000/HZ))%100);
-		Dprintk("Before bogocount - setting activated=1.\n");
-	}
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		if (cpu_isset(cpu, cpu_callout_map))
+			bogosum += cpu_data[cpu].loops_per_jiffy;
+	printk(KERN_INFO
+		"Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
+		cpucount+1,
+		bogosum/(500000/HZ),
+		(bogosum/(5000/HZ))%100);
+	
+	Dprintk("Before bogocount - setting activated=1.\n");
 
 	if (smp_b_stepping)
 		printk(KERN_WARNING "WARNING: SMP operation may be unreliable with B stepping processors.\n");
 
-	/* Don't taint if we are running SMP kernel on a single non-MP approved Athlon  */
+	/*
+	 * Don't taint if we are running SMP kernel on a single non-MP
+	 * approved Athlon
+	 */
 	if (tainted & TAINT_UNSAFE_SMP) {
 		if (cpucount)
 			printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Nick Piggin <piggin@cyberone.com.au>: [PATCH] rediffed chatty printk running SMP kernel with 1 CPU

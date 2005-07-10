Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVGJWJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVGJWJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVGJWJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 18:09:14 -0400
Received: from fsmlabs.com ([168.103.115.128]:32190 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262125AbVGJWI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 18:08:59 -0400
Date: Sun, 10 Jul 2005 16:13:37 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove preempt_disable from powernow-k8
Message-ID: <Pine.LNX.4.61.0507101600560.16055@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From reading the code, my understanding is that powernow-k8 uses 
preempt_disable to ensure that driver->target doesn't migrate across cpus 
whilst it's accessing per processor registers, however set_cpus_allowed 
will provide this for us. Additionally, remove schedule() calls from 
set_cpus_allowed as set_cpus_allowed ensures that you're executing on the 
target processor on return.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.13-rc1-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc1-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 powernow-k8.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	3 Jul 2005 13:20:44 -0000	1.1.1.1
+++ linux-2.6.13-rc1-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	10 Jul 2005 22:03:51 -0000
@@ -453,7 +453,6 @@ static int check_supported_cpu(unsigned 
 
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
-	schedule();
 
 	if (smp_processor_id() != cpu) {
 		printk(KERN_ERR "limiting to cpu %u failed\n", cpu);
@@ -488,7 +487,6 @@ static int check_supported_cpu(unsigned 
 
 out:
 	set_cpus_allowed(current, oldmask);
-	schedule();
 	return rc;
 
 }
@@ -895,7 +893,6 @@ static int powernowk8_target(struct cpuf
 	/* only run on specific CPU from here on */
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));
-	schedule();
 
 	if (smp_processor_id() != pol->cpu) {
 		printk(KERN_ERR "limiting to cpu %u failed\n", pol->cpu);
@@ -959,8 +956,6 @@ static int powernowk8_target(struct cpuf
 
 err_out:
 	set_cpus_allowed(current, oldmask);
-	schedule();
-
 	return ret;
 }
 
@@ -1017,7 +1012,6 @@ static int __init powernowk8_cpu_init(st
 	/* only run on specific CPU from here on */
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));
-	schedule();
 
 	if (smp_processor_id() != pol->cpu) {
 		printk(KERN_ERR "limiting to cpu %u failed\n", pol->cpu);
@@ -1036,7 +1030,6 @@ static int __init powernowk8_cpu_init(st
 
 	/* run on any CPU again */
 	set_cpus_allowed(current, oldmask);
-	schedule();
 
 	pol->governor = CPUFREQ_DEFAULT_GOVERNOR;
 	pol->cpus = cpu_core_map[pol->cpu];
@@ -1069,7 +1062,6 @@ static int __init powernowk8_cpu_init(st
 
 err_out:
 	set_cpus_allowed(current, oldmask);
-	schedule();
 	powernow_k8_cpu_exit_acpi(data);
 
 	kfree(data);
@@ -1105,7 +1097,6 @@ static unsigned int powernowk8_get (unsi
 		set_cpus_allowed(current, oldmask);
 		return 0;
 	}
-	preempt_disable();
 	
 	if (query_current_values_with_pending_wait(data))
 		goto out;
@@ -1113,7 +1104,6 @@ static unsigned int powernowk8_get (unsi
 	khz = find_khz_freq_from_fid(data->currfid);
 
  out:
-	preempt_enable_no_resched();
 	set_cpus_allowed(current, oldmask);
 
 	return khz;

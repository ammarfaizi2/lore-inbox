Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVKFBHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVKFBHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 20:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKFBHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 20:07:18 -0500
Received: from fsmlabs.com ([168.103.115.128]:47801 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932251AbVKFBHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 20:07:16 -0500
X-ASG-Debug-ID: 1131239228-14418-0-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sat, 5 Nov 2005 17:13:07 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
X-ASG-Orig-Subj: Re: powernow-k8 schedules in atomic since sunday :-(
Subject: Re: powernow-k8 schedules in atomic since sunday :-(
In-Reply-To: <20051103124916.A29900@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0511051643520.1526@montezuma.fsmlabs.com>
References: <436A34C5.2060108@vc.cvut.cz> <20051103124916.A29900@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5077
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Ashok Raj wrote:

> On Thu, Nov 03, 2005 at 05:03:17PM +0100, Petr Vandrovec wrote:
> > Hello Ashok,
> >    your change '[PATCH] create and destroy cpufreq sysfs entries based on cpu 
> > notifiers' causes problems with powernow-k8 driver.  powernow-k8 uses 
> > set_cpus_allowed() (it even calls schedule() explicitly for no reason), and when 
> > you've changed code from lock_cpu_hotplug() to preempt_disable() 
> > set_cpus_allowed() now complains that schedule() is not allowed while preemption 
> > is disabled...

Hmm i submitted a patch 
(http://groups.google.ca/group/fa.linux.kernel/browse_frm/thread/ec079d77dc1f6e80/edf10a39eede6246?tvc=1&q=Remove+p$ 
to remove those superfluous schedules, but perhaps it hasn't hit Linus' 
tree yet via Davej.

> Rafael noticed this, please use the new patch 
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113087258615780&w=2
> 
> He confirmed it works for him now.

Perhaps we need something like the following (untested), basically allow a 
small window and if we migrate within that window, simply fail. This 
should be fine as during hotplug notification that processor won't be 
going offline as we hold the cpucontrol semaphore and during normal 
operation without hotplug cpu the processor won't be going offline anyway. 
Have i missed a special case? One thing i don't like about this approach 
is that it relies on the driver writer to get this logic correct, higher 
up might be better.

	Zwane

Index: linux-2.6.14-rc5-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.14-rc5-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 powernow-k8.c
--- linux-2.6.14-rc5-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	24 Oct 2005 15:38:38 -0000	1.1.1.1
+++ linux-2.6.14-rc5-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	6 Nov 2005 01:10:34 -0000
@@ -463,6 +463,7 @@ static int check_supported_cpu(unsigned 
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 
+	preempt_disable();
 	if (smp_processor_id() != cpu) {
 		printk(KERN_ERR "limiting to cpu %u failed\n", cpu);
 		goto out;
@@ -495,6 +496,7 @@ static int check_supported_cpu(unsigned 
 	rc = 1;
 
 out:
+	preempt_enable();
 	set_cpus_allowed(current, oldmask);
 	return rc;
 }
@@ -911,6 +913,7 @@ static int powernowk8_target(struct cpuf
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));
 
+	preempt_disable();
 	if (smp_processor_id() != pol->cpu) {
 		printk(KERN_ERR "limiting to cpu %u failed\n", pol->cpu);
 		goto err_out;
@@ -941,6 +944,7 @@ static int powernowk8_target(struct cpuf
 	if (cpufreq_frequency_table_target(pol, data->powernow_table, targfreq, relation, &newstate))
 		goto err_out;
 
+	preempt_enable();
 	down(&fidvid_sem);
 
 	powernow_k8_acpi_pst_values(data, newstate);
@@ -961,8 +965,11 @@ static int powernowk8_target(struct cpuf
 
 	pol->cur = find_khz_freq_from_fid(data->currfid);
 	ret = 0;
+	goto done;
 
 err_out:
+	preempt_enable();
+done:
 	set_cpus_allowed(current, oldmask);
 	return ret;
 }
@@ -1020,6 +1027,7 @@ static int __init powernowk8_cpu_init(st
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));
 
+	preempt_disable();
 	if (smp_processor_id() != pol->cpu) {
 		printk(KERN_ERR "limiting to cpu %u failed\n", pol->cpu);
 		goto err_out;
@@ -1036,6 +1044,7 @@ static int __init powernowk8_cpu_init(st
 	fidvid_msr_init();
 
 	/* run on any CPU again */
+	preempt_enable();
 	set_cpus_allowed(current, oldmask);
 
 	pol->governor = CPUFREQ_DEFAULT_GOVERNOR;
@@ -1070,6 +1079,7 @@ static int __init powernowk8_cpu_init(st
 	return 0;
 
 err_out:
+	preempt_enable();
 	set_cpus_allowed(current, oldmask);
 	powernow_k8_cpu_exit_acpi(data);
 
@@ -1101,10 +1111,11 @@ static unsigned int powernowk8_get (unsi
 	unsigned int khz = 0;
 
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+	preempt_disable();
 	if (smp_processor_id() != cpu) {
 		printk(KERN_ERR PFX "limiting to CPU %d failed in powernowk8_get\n", cpu);
-		set_cpus_allowed(current, oldmask);
-		return 0;
+		goto out;
 	}
 
 	if (query_current_values_with_pending_wait(data))
@@ -1113,6 +1124,7 @@ static unsigned int powernowk8_get (unsi
 	khz = find_khz_freq_from_fid(data->currfid);
 
 out:
+	preempt_enable();
 	set_cpus_allowed(current, oldmask);
 	return khz;
 }

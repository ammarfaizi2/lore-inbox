Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWAXQRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWAXQRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWAXQRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:17:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:59015 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030337AbWAXQRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:17:50 -0500
Message-ID: <43D65334.90601@suse.de>
Date: Tue, 24 Jan 2006 17:17:56 +0100
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cpufreq@www.linux.org.uk
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Dominik Brodowski <linux@brodo.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] _PPC frequency change issues
Content-Type: multipart/mixed;
 boundary="------------060502080107010507060704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060502080107010507060704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

and the second one fixing the usergovernor for these machines...

--------------060502080107010507060704
Content-Type: text/plain;
 name="cpufreq_userspace_delete_struct"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpufreq_userspace_delete_struct"

Author: Thomas Renninger <trenn@suse.de>

userspace governor need not to hold it's own cpufreq_policy,
better make use of the global core policy.
Also fixes a bug in case of frequency changes via _PPC.
Old min/max values have wrongly been passed to __cpufreq_driver_target()
(kind of buffered) and when max freq was available again, only the old
max(normally lowest freq) was still active.


cpufreq_userspace.c |   36 +++++++++++++++++-------------------
1 files changed, 17 insertions(+), 19 deletions(-)


Index: linux-2.6.15/drivers/cpufreq/cpufreq_userspace.c
===================================================================
--- linux-2.6.15.orig/drivers/cpufreq/cpufreq_userspace.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/cpufreq/cpufreq_userspace.c	2006-01-20 11:41:27.000000000 +0100
@@ -33,7 +33,6 @@
 static unsigned int	cpu_cur_freq[NR_CPUS]; /* current CPU freq */
 static unsigned int	cpu_set_freq[NR_CPUS]; /* CPU freq desired by userspace */
 static unsigned int	cpu_is_managed[NR_CPUS];
-static struct cpufreq_policy current_policy[NR_CPUS];
 
 static DECLARE_MUTEX	(userspace_sem); 
 
@@ -64,22 +63,22 @@
  *
  * Sets the CPU frequency to freq.
  */
-static int cpufreq_set(unsigned int freq, unsigned int cpu)
+static int cpufreq_set(unsigned int freq, struct cpufreq_policy *policy)
 {
 	int ret = -EINVAL;
 
-	dprintk("cpufreq_set for cpu %u, freq %u kHz\n", cpu, freq);
+    dprintk("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
 
 	down(&userspace_sem);
-	if (!cpu_is_managed[cpu])
+    if (!cpu_is_managed[policy->cpu])
 		goto err;
 
-	cpu_set_freq[cpu] = freq;
+    cpu_set_freq[policy->cpu] = freq;
 
-	if (freq < cpu_min_freq[cpu])
-		freq = cpu_min_freq[cpu];
-	if (freq > cpu_max_freq[cpu])
-		freq = cpu_max_freq[cpu];
+    if (freq < cpu_min_freq[policy->cpu])
+        freq = cpu_min_freq[policy->cpu];
+    if (freq > cpu_max_freq[policy->cpu])
+        freq = cpu_max_freq[policy->cpu];
 
 	/*
 	 * We're safe from concurrent calls to ->target() here
@@ -88,8 +87,7 @@
 	 * A: cpufreq_set (lock userspace_sem) -> cpufreq_driver_target(lock policy->lock)
 	 * B: cpufreq_set_policy(lock policy->lock) -> __cpufreq_governor -> cpufreq_governor_userspace (lock userspace_sem)
 	 */
-	ret = __cpufreq_driver_target(&current_policy[cpu], freq, 
-	      CPUFREQ_RELATION_L);
+    ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
 
  err:
 	up(&userspace_sem);
@@ -113,7 +111,7 @@
 	if (ret != 1)
 		return -EINVAL;
 
-	cpufreq_set(freq, policy->cpu);
+    cpufreq_set(freq, policy);
 
 	return count;
 }
@@ -141,7 +139,6 @@
 		cpu_cur_freq[cpu] = policy->cur;
 		cpu_set_freq[cpu] = policy->cur;
 		sysfs_create_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
-		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		dprintk("managing cpu %u started (%u - %u kHz, currently %u kHz)\n", cpu, cpu_min_freq[cpu], cpu_max_freq[cpu], cpu_cur_freq[cpu]);
 		up(&userspace_sem);
 		break;
@@ -161,16 +158,17 @@
 		cpu_max_freq[cpu] = policy->max;
 		dprintk("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set to %u kHz\n", cpu, cpu_min_freq[cpu], cpu_max_freq[cpu], cpu_cur_freq[cpu], cpu_set_freq[cpu]);
 		if (policy->max < cpu_set_freq[cpu]) {
-			__cpufreq_driver_target(&current_policy[cpu], policy->max, 
-			      CPUFREQ_RELATION_H);
+            if (!__cpufreq_driver_target(policy, policy->max, 
+                            CPUFREQ_RELATION_H))
+                cpu_cur_freq[cpu] = policy->max;
 		} else if (policy->min > cpu_set_freq[cpu]) {
-			__cpufreq_driver_target(&current_policy[cpu], policy->min, 
-			      CPUFREQ_RELATION_L);
+            if (!__cpufreq_driver_target(policy, policy->min, 
+                            CPUFREQ_RELATION_L))
+                cpu_cur_freq[cpu] = policy->min;
 		} else {
-			__cpufreq_driver_target(&current_policy[cpu], cpu_set_freq[cpu],
+            __cpufreq_driver_target(policy, cpu_set_freq[cpu],
 			      CPUFREQ_RELATION_L);
 		}
-		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		up(&userspace_sem);
 		break;
 	}

--------------060502080107010507060704--

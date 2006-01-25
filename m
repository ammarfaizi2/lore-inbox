Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWAYRjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWAYRjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAYRjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:39:35 -0500
Received: from mail.suse.de ([195.135.220.2]:11467 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932082AbWAYRje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:39:34 -0500
From: Thomas Renninger <trenn@suse.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH 2/2] _PPC frequency change issues
Date: Wed, 25 Jan 2006 18:39:30 +0100
User-Agent: KMail/1.8.2
Cc: "Thomas Renninger" <trenn@suse.de>, cpufreq@www.linux.org.uk,
       "Dominik Brodowski" <linux@brodo.de>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <88056F38E9E48644A0F562A38C64FB6007000574@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6007000574@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601251839.31618.trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 18:06, Pallipadi, Venkatesh wrote:
> Thanks for identifying the issues and sendint these patches Thomas.
>
> Patch 1 looks clean. New lines seem to contain spaces instead of tabs.
> The same issue is there in patch 2 as well. Can you resent it with
> indentation fixed.
>
> Patch 2 I am concenred with following hunk.
>
> @@ -161,16 +158,17 @@
>  		cpu_max_freq[cpu] = policy->max;
>  		dprintk("limit event for cpu %u: %u - %u kHz, currently
> %u kHz, last set to %u kHz\n", cpu, cpu_min_freq[cpu],
> cpu_max_freq[cpu], cpu_cur_freq[cpu], cpu_set_freq[cpu]);
>  		if (policy->max < cpu_set_freq[cpu]) {
> -			__cpufreq_driver_target(&current_policy[cpu],
> policy->max,
> -			      CPUFREQ_RELATION_H);
> +            if (!__cpufreq_driver_target(policy, policy->max,
> +                            CPUFREQ_RELATION_H))
> +                cpu_cur_freq[cpu] = policy->max;
>
> Should this me cpu_cur_freq[cpu] = policy->cur instead. As the max
> setting may not be supported by the driver, it might have set some
> closer available freq
>
> Same comment for below two driver target calls as well.
Ok, I all (cpu_max/min/cur_freq) assigned it after setting, this should be OK?

Seems as if I had some wrong indentation offset set and had not checked
the patch output itself, sorry about that.

Tell me if you still see any problems ...

Author: Thomas Renninger <trenn@suse.de>

userspace governor need not to hold it's own cpufreq_policy,
better make use of the global core policy.
Also fixes a bug in case of frequency changes via _PPC.
Old min/max values have wrongly been passed to __cpufreq_driver_target()
(kind of buffered) and when max freq was available again, only the old
max(normally lowest freq) was still active.

cpufreq_userspace.c |   52 
+++++++++++++++++++++++++++-------------------------
 1 files changed, 27 insertions(+), 25 deletions(-)

Index: linux-2.6.15/drivers/cpufreq/cpufreq_userspace.c
===================================================================
--- linux-2.6.15.orig/drivers/cpufreq/cpufreq_userspace.c
+++ linux-2.6.15/drivers/cpufreq/cpufreq_userspace.c
@@ -33,7 +33,6 @@ static unsigned int	cpu_min_freq[NR_CPUS
 static unsigned int	cpu_cur_freq[NR_CPUS]; /* current CPU freq */
 static unsigned int	cpu_set_freq[NR_CPUS]; /* CPU freq desired by userspace 
*/
 static unsigned int	cpu_is_managed[NR_CPUS];
-static struct cpufreq_policy current_policy[NR_CPUS];
 
 static DECLARE_MUTEX	(userspace_sem); 
 
@@ -64,22 +63,22 @@ static struct notifier_block userspace_c
  *
  * Sets the CPU frequency to freq.
  */
-static int cpufreq_set(unsigned int freq, unsigned int cpu)
+static int cpufreq_set(unsigned int freq, struct cpufreq_policy *policy)
 {
 	int ret = -EINVAL;
 
-	dprintk("cpufreq_set for cpu %u, freq %u kHz\n", cpu, freq);
+	dprintk("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
 
 	down(&userspace_sem);
-	if (!cpu_is_managed[cpu])
+	if (!cpu_is_managed[policy->cpu])
 		goto err;
 
-	cpu_set_freq[cpu] = freq;
+	cpu_set_freq[policy->cpu] = freq;
 
-	if (freq < cpu_min_freq[cpu])
-		freq = cpu_min_freq[cpu];
-	if (freq > cpu_max_freq[cpu])
-		freq = cpu_max_freq[cpu];
+	if (freq < cpu_min_freq[policy->cpu])
+		freq = cpu_min_freq[policy->cpu];
+	if (freq > cpu_max_freq[policy->cpu])
+		freq = cpu_max_freq[policy->cpu];
 
 	/*
 	 * We're safe from concurrent calls to ->target() here
@@ -88,8 +87,7 @@ static int cpufreq_set(unsigned int freq
 	 * A: cpufreq_set (lock userspace_sem) -> cpufreq_driver_target(lock 
policy->lock)
 	 * B: cpufreq_set_policy(lock policy->lock) -> __cpufreq_governor -> 
cpufreq_governor_userspace (lock userspace_sem)
 	 */
-	ret = __cpufreq_driver_target(&current_policy[cpu], freq, 
-	      CPUFREQ_RELATION_L);
+	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
 
  err:
 	up(&userspace_sem);
@@ -113,7 +111,7 @@ store_speed (struct cpufreq_policy *poli
 	if (ret != 1)
 		return -EINVAL;
 
-	cpufreq_set(freq, policy->cpu);
+	cpufreq_set(freq, policy);
 
 	return count;
 }
@@ -141,7 +139,6 @@ static int cpufreq_governor_userspace(st
 		cpu_cur_freq[cpu] = policy->cur;
 		cpu_set_freq[cpu] = policy->cur;
 		sysfs_create_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
-		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		dprintk("managing cpu %u started (%u - %u kHz, currently %u kHz)\n", cpu, 
cpu_min_freq[cpu], cpu_max_freq[cpu], cpu_cur_freq[cpu]);
 		up(&userspace_sem);
 		break;
@@ -157,20 +154,25 @@ static int cpufreq_governor_userspace(st
 		break;
 	case CPUFREQ_GOV_LIMITS:
 		down(&userspace_sem);
-		cpu_min_freq[cpu] = policy->min;
-		cpu_max_freq[cpu] = policy->max;
-		dprintk("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set to 
%u kHz\n", cpu, cpu_min_freq[cpu], cpu_max_freq[cpu], cpu_cur_freq[cpu], 
cpu_set_freq[cpu]);
+		dprintk("limit event for cpu %u: %u - %u kHz,"
+			"currently %u kHz, last set to %u kHz\n",
+			cpu, policy->min, policy->max,
+			cpu_cur_freq[cpu], cpu_set_freq[cpu]);
 		if (policy->max < cpu_set_freq[cpu]) {
-			__cpufreq_driver_target(&current_policy[cpu], policy->max, 
-			      CPUFREQ_RELATION_H);
-		} else if (policy->min > cpu_set_freq[cpu]) {
-			__cpufreq_driver_target(&current_policy[cpu], policy->min, 
-			      CPUFREQ_RELATION_L);
-		} else {
-			__cpufreq_driver_target(&current_policy[cpu], cpu_set_freq[cpu],
-			      CPUFREQ_RELATION_L);
+			__cpufreq_driver_target(policy, policy->max,
+						CPUFREQ_RELATION_H);
+		}
+		else if (policy->min > cpu_set_freq[cpu]) {
+			__cpufreq_driver_target(policy, policy->min,
+						CPUFREQ_RELATION_L);
+		}
+		else {
+			__cpufreq_driver_target(policy, cpu_set_freq[cpu],
+						CPUFREQ_RELATION_L);
 		}
-		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
+		cpu_min_freq[cpu] = policy->min;
+		cpu_max_freq[cpu] = policy->max;
+		cpu_cur_freq[cpu] = policy->cur;
 		up(&userspace_sem);
 		break;
 	}


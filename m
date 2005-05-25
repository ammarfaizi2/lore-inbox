Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVEYUkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVEYUkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVEYUkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:40:25 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:55046 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261354AbVEYUjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:39:43 -0400
Message-ID: <4294E24E.8000003@stud.feec.vutbr.cz>
Date: Wed, 25 May 2005 22:38:38 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <20050523082637.GA15696@elte.hu>
In-Reply-To: <20050523082637.GA15696@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------070601050305090904030406"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601050305090904030406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ingo,

I'm now running -RT-2.6.12-rc4-V0.7.47-08 on amd64.
I use cpufreq, but with the RT kernel it triggers "Kernel BUG at 
"kernel/latency.c":1295" (the check for preempt_count underflow).

I'm attaching a patch which changes a semaphore in cpufreq into a 
completion. With this patch, my system runs OK even with cpufreqd.

Michal

--------------070601050305090904030406
Content-Type: text/x-patch;
 name="cpufreq-RT.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpufreq-RT.diff"

diff -Nurp -X linux-2.6.12-rc4-RT-mich/Documentation/dontdiff linux-2.6.12-rc4-RT/drivers/cpufreq/cpufreq.c linux-2.6.12-rc4-RT-mich/drivers/cpufreq/cpufreq.c
--- linux-2.6.12-rc4-RT/drivers/cpufreq/cpufreq.c	2005-05-25 22:23:24.000000000 +0200
+++ linux-2.6.12-rc4-RT-mich/drivers/cpufreq/cpufreq.c	2005-05-25 21:56:43.000000000 +0200
@@ -605,7 +605,7 @@ static int cpufreq_add_dev (struct sys_d
 	policy->cpu = cpu;
 	policy->cpus = cpumask_of_cpu(cpu);
 
-	init_MUTEX_LOCKED(&policy->lock);
+	init_completion(&policy->done);
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update, (void *)(long)cpu);
 
@@ -646,7 +646,7 @@ static int cpufreq_add_dev (struct sys_d
 	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	policy->governor = NULL; /* to assure that the starting sequence is
 				  * run in cpufreq_set_policy */
-	up(&policy->lock);
+	complete(&policy->done);
 	
 	/* set default policy */
 	
@@ -765,11 +765,11 @@ static int cpufreq_remove_dev (struct sy
 	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 #endif
 
-	down(&data->lock);
+	wait_for_completion(&data->done);
 	if (cpufreq_driver->target)
 		__cpufreq_governor(data, CPUFREQ_GOV_STOP);
 	cpufreq_driver->target = NULL;
-	up(&data->lock);
+	complete(&data->done);
 
 	kobject_unregister(&data->kobj);
 
@@ -842,7 +842,7 @@ unsigned int cpufreq_get(unsigned int cp
 	if (!cpufreq_driver->get)
 		goto out;
 
-	down(&policy->lock);
+	wait_for_completion(&policy->done);
 
 	ret = cpufreq_driver->get(cpu);
 
@@ -855,7 +855,7 @@ unsigned int cpufreq_get(unsigned int cp
 		}
 	}
 
-	up(&policy->lock);
+	complete(&policy->done);
 
  out:
 	cpufreq_cpu_put(policy);
@@ -1136,11 +1136,11 @@ int cpufreq_driver_target(struct cpufreq
 	if (!policy)
 		return -EINVAL;
 
-	down(&policy->lock);
+	wait_for_completion(&policy->done);
 
 	ret = __cpufreq_driver_target(policy, target_freq, relation);
 
-	up(&policy->lock);
+	complete(&policy->done);
 
 	cpufreq_cpu_put(policy);
 
@@ -1177,9 +1177,9 @@ int cpufreq_governor(unsigned int cpu, u
 	if (!policy)
 		return -EINVAL;
 
-	down(&policy->lock);
+	wait_for_completion(&policy->done);
 	ret = __cpufreq_governor(policy, event);
-	up(&policy->lock);
+	complete(&policy->done);
 
 	cpufreq_cpu_put(policy);
 
@@ -1246,9 +1246,9 @@ int cpufreq_get_policy(struct cpufreq_po
 	if (!cpu_policy)
 		return -EINVAL;
 
-	down(&cpu_policy->lock);
+	wait_for_completion(&cpu_policy->done);
 	memcpy(policy, cpu_policy, sizeof(struct cpufreq_policy));
-	up(&cpu_policy->lock);
+	complete(&cpu_policy->done);
 
 	cpufreq_cpu_put(cpu_policy);
 
@@ -1360,7 +1360,7 @@ int cpufreq_set_policy(struct cpufreq_po
 		return -EINVAL;
 
 	/* lock this CPU */
-	down(&data->lock);
+	wait_for_completion(&data->done);
 
 	ret = __cpufreq_set_policy(data, policy);
 	data->user_policy.min = data->min;
@@ -1368,7 +1368,7 @@ int cpufreq_set_policy(struct cpufreq_po
 	data->user_policy.policy = data->policy;
 	data->user_policy.governor = data->governor;
 
-	up(&data->lock);
+	complete(&data->done);
 	cpufreq_cpu_put(data);
 
 	return ret;
@@ -1392,7 +1392,7 @@ int cpufreq_update_policy(unsigned int c
 	if (!data)
 		return -ENODEV;
 
-	down(&data->lock);
+	wait_for_completion(&data->done);
 
 	dprintk("updating policy for CPU %u\n", cpu);
 	memcpy(&policy, 
@@ -1405,7 +1405,7 @@ int cpufreq_update_policy(unsigned int c
 
 	ret = __cpufreq_set_policy(data, &policy);
 
-	up(&data->lock);
+	complete(&data->done);
 
 	cpufreq_cpu_put(data);
 	return ret;
diff -Nurp -X linux-2.6.12-rc4-RT-mich/Documentation/dontdiff linux-2.6.12-rc4-RT/include/linux/cpufreq.h linux-2.6.12-rc4-RT-mich/include/linux/cpufreq.h
--- linux-2.6.12-rc4-RT/include/linux/cpufreq.h	2005-05-25 22:23:26.000000000 +0200
+++ linux-2.6.12-rc4-RT-mich/include/linux/cpufreq.h	2005-05-25 21:49:25.000000000 +0200
@@ -81,7 +81,7 @@ struct cpufreq_policy {
         unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 
- 	struct semaphore	lock;   /* CPU ->setpolicy or ->target may
+ 	struct completion	done;   /* CPU ->setpolicy or ->target may
 					   only be called once a time */
 
 	struct work_struct	update; /* if update_policy() needs to be

--------------070601050305090904030406--

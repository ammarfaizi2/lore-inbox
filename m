Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVLUQFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVLUQFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVLUQFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:05:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52439 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932472AbVLUQFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:05:19 -0500
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051221155411.GA7243@elte.hu>
References: <20051221155411.GA7243@elte.hu>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 17:04:58 +0100
Message-Id: <1135181099.3456.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 16:54 +0100, Ingo Molnar wrote:


as an experiment I looked at how hard it is to turn some of the current
using-semaphore-as-mutex into using this new primitive.


Below are a few dozen such conversions; they are all
1) manually inspected for properties 2 and 3
2) cases where the lock is static to the .c file
3) all up()'s are done in the same function as the down,
   eg the most basic simple usage model

or in short: these are really simple obvious cases only.



Signed-off-by: Arjan van de Ven <arjan@infradead.org>


diff -purN linux-2.6.15-rc6-mutex/drivers/cpufreq/cpufreq.c linux-2.6.15-rc6-mutex-new/drivers/cpufreq/cpufreq.c
--- linux-2.6.15-rc6-mutex/drivers/cpufreq/cpufreq.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/cpufreq/cpufreq.c	2005-12-20 10:59:36.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/completion.h>
+#include <linux/mutex.h>
 
 #define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, "cpufreq-core", msg)
 
@@ -56,7 +57,7 @@ static DECLARE_RWSEM		(cpufreq_notifier_
 
 
 static LIST_HEAD(cpufreq_governor_list);
-static DECLARE_MUTEX		(cpufreq_governor_sem);
+static DEFINE_MUTEX		(cpufreq_governor_mutex);
 
 struct cpufreq_policy * cpufreq_cpu_get(unsigned int cpu)
 {
@@ -298,18 +299,18 @@ static int cpufreq_parse_governor (char 
 		return -EINVAL;
 	} else {
 		struct cpufreq_governor *t;
-		down(&cpufreq_governor_sem);
+		mutex_lock(&cpufreq_governor_mutex);
 		if (!cpufreq_driver || !cpufreq_driver->target)
 			goto out;
 		list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
 			if (!strnicmp(str_governor,t->name,CPUFREQ_NAME_LEN)) {
 				*governor = t;
-				up(&cpufreq_governor_sem);
+				mutex_unlock(&cpufreq_governor_mutex);
 				return 0;
 			}
 		}
 	out:
-		up(&cpufreq_governor_sem);
+		mutex_unlock(&cpufreq_governor_mutex);
 	}
 	return -EINVAL;
 }
@@ -1194,17 +1195,17 @@ int cpufreq_register_governor(struct cpu
 	if (!governor)
 		return -EINVAL;
 
-	down(&cpufreq_governor_sem);
+	mutex_lock(&cpufreq_governor_mutex);
 	
 	list_for_each_entry(t, &cpufreq_governor_list, governor_list) {
 		if (!strnicmp(governor->name,t->name,CPUFREQ_NAME_LEN)) {
-			up(&cpufreq_governor_sem);
+			mutex_unlock(&cpufreq_governor_mutex);
 			return -EBUSY;
 		}
 	}
 	list_add(&governor->governor_list, &cpufreq_governor_list);
 
- 	up(&cpufreq_governor_sem);
+ 	mutex_unlock(&cpufreq_governor_mutex);
 
 	return 0;
 }
@@ -1216,9 +1217,9 @@ void cpufreq_unregister_governor(struct 
 	if (!governor)
 		return;
 
-	down(&cpufreq_governor_sem);
+	mutex_lock(&cpufreq_governor_mutex);
 	list_del(&governor->governor_list);
-	up(&cpufreq_governor_sem);
+	mutex_unlock(&cpufreq_governor_mutex);
 	return;
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
diff -purN linux-2.6.15-rc6-mutex/drivers/cpufreq/cpufreq_conservative.c linux-2.6.15-rc6-mutex-new/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.15-rc6-mutex/drivers/cpufreq/cpufreq_conservative.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-mutex-new/drivers/cpufreq/cpufreq_conservative.c	2005-12-20 11:00:51.000000000 +0100
@@ -28,7 +28,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel_stat.h>
 #include <linux/percpu.h>
-
+#include <linux/mutex.h>
 /*
  * dbs is used in this file as a shortform for demandbased switching
  * It helps to keep variable names smaller, simpler
@@ -71,7 +71,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_inf
 
 static unsigned int dbs_enable;	/* number of CPUs using this policy */
 
-static DECLARE_MUTEX 	(dbs_sem);
+static DEFINE_MUTEX 	(dbs_mutex);
 static DECLARE_WORK	(dbs_work, do_dbs_timer, NULL);
 
 struct dbs_tuners {
@@ -139,9 +139,9 @@ static ssize_t store_sampling_down_facto
 	if (ret != 1 )
 		return -EINVAL;
 
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	dbs_tuners_ins.sampling_down_factor = input;
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -153,14 +153,14 @@ static ssize_t store_sampling_rate(struc
 	int ret;
 	ret = sscanf (buf, "%u", &input);
 
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	if (ret != 1 || input > MAX_SAMPLING_RATE || input < MIN_SAMPLING_RATE) {
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
 	}
 
 	dbs_tuners_ins.sampling_rate = input;
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -172,16 +172,16 @@ static ssize_t store_up_threshold(struct
 	int ret;
 	ret = sscanf (buf, "%u", &input);
 
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	if (ret != 1 || input > MAX_FREQUENCY_UP_THRESHOLD || 
 			input < MIN_FREQUENCY_UP_THRESHOLD ||
 			input <= dbs_tuners_ins.down_threshold) {
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
 	}
 
 	dbs_tuners_ins.up_threshold = input;
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -193,16 +193,16 @@ static ssize_t store_down_threshold(stru
 	int ret;
 	ret = sscanf (buf, "%u", &input);
 
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	if (ret != 1 || input > MAX_FREQUENCY_DOWN_THRESHOLD || 
 			input < MIN_FREQUENCY_DOWN_THRESHOLD ||
 			input >= dbs_tuners_ins.up_threshold) {
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
 	}
 
 	dbs_tuners_ins.down_threshold = input;
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -222,9 +222,9 @@ static ssize_t store_ignore_nice(struct 
 	if ( input > 1 )
 		input = 1;
 	
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	if ( input == dbs_tuners_ins.ignore_nice ) { /* nothing to do */
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		return count;
 	}
 	dbs_tuners_ins.ignore_nice = input;
@@ -236,7 +236,7 @@ static ssize_t store_ignore_nice(struct 
 		j_dbs_info->prev_cpu_idle_up = get_cpu_idle_time(j);
 		j_dbs_info->prev_cpu_idle_down = j_dbs_info->prev_cpu_idle_up;
 	}
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -257,9 +257,9 @@ static ssize_t store_freq_step(struct cp
 	
 	/* no need to test here if freq_step is zero as the user might actually
 	 * want this, they would be crazy though :) */
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	dbs_tuners_ins.freq_step = input;
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -444,12 +444,12 @@ static void dbs_check_cpu(int cpu)
 static void do_dbs_timer(void *data)
 { 
 	int i;
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	for_each_online_cpu(i)
 		dbs_check_cpu(i);
 	schedule_delayed_work(&dbs_work, 
 			usecs_to_jiffies(dbs_tuners_ins.sampling_rate));
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 } 
 
 static inline void dbs_timer_init(void)
@@ -487,7 +487,7 @@ static int cpufreq_governor_dbs(struct c
 		if (this_dbs_info->enable) /* Already enabled */
 			break;
 		 
-		down(&dbs_sem);
+		mutex_lock(&dbs_mutex);
 		for_each_cpu_mask(j, policy->cpus) {
 			struct cpu_dbs_info_s *j_dbs_info;
 			j_dbs_info = &per_cpu(cpu_dbs_info, j);
@@ -521,11 +521,11 @@ static int cpufreq_governor_dbs(struct c
 			dbs_timer_init();
 		}
 		
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		break;
 
 	case CPUFREQ_GOV_STOP:
-		down(&dbs_sem);
+		mutex_lock(&dbs_mutex);
 		this_dbs_info->enable = 0;
 		sysfs_remove_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable--;
@@ -536,12 +536,12 @@ static int cpufreq_governor_dbs(struct c
 		if (dbs_enable == 0) 
 			dbs_timer_exit();
 		
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 
 		break;
 
 	case CPUFREQ_GOV_LIMITS:
-		down(&dbs_sem);
+		mutex_lock(&dbs_mutex);
 		if (policy->max < this_dbs_info->cur_policy->cur)
 			__cpufreq_driver_target(
 					this_dbs_info->cur_policy,
@@ -550,7 +550,7 @@ static int cpufreq_governor_dbs(struct c
 			__cpufreq_driver_target(
 					this_dbs_info->cur_policy,
 				       	policy->min, CPUFREQ_RELATION_L);
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		break;
 	}
 	return 0;
diff -purN linux-2.6.15-rc6-mutex/drivers/cpufreq/cpufreq_ondemand.c linux-2.6.15-rc6-mutex-new/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.15-rc6-mutex/drivers/cpufreq/cpufreq_ondemand.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/cpufreq/cpufreq_ondemand.c	2005-12-20 11:02:24.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel_stat.h>
 #include <linux/percpu.h>
+#include <linux/mutex.h>
 
 /*
  * dbs is used in this file as a shortform for demandbased switching
@@ -70,7 +71,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_inf
 
 static unsigned int dbs_enable;	/* number of CPUs using this policy */
 
-static DECLARE_MUTEX 	(dbs_sem);
+static DEFINE_MUTEX 	(dbs_mutex);
 static DECLARE_WORK	(dbs_work, do_dbs_timer, NULL);
 
 struct dbs_tuners {
@@ -136,9 +137,9 @@ static ssize_t store_sampling_down_facto
 	if (input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
 		return -EINVAL;
 
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	dbs_tuners_ins.sampling_down_factor = input;
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -150,14 +151,14 @@ static ssize_t store_sampling_rate(struc
 	int ret;
 	ret = sscanf (buf, "%u", &input);
 
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	if (ret != 1 || input > MAX_SAMPLING_RATE || input < MIN_SAMPLING_RATE) {
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
 	}
 
 	dbs_tuners_ins.sampling_rate = input;
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -169,15 +170,15 @@ static ssize_t store_up_threshold(struct
 	int ret;
 	ret = sscanf (buf, "%u", &input);
 
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	if (ret != 1 || input > MAX_FREQUENCY_UP_THRESHOLD || 
 			input < MIN_FREQUENCY_UP_THRESHOLD) {
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
 	}
 
 	dbs_tuners_ins.up_threshold = input;
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -197,9 +198,9 @@ static ssize_t store_ignore_nice(struct 
 	if ( input > 1 )
 		input = 1;
 	
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	if ( input == dbs_tuners_ins.ignore_nice ) { /* nothing to do */
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		return count;
 	}
 	dbs_tuners_ins.ignore_nice = input;
@@ -211,7 +212,7 @@ static ssize_t store_ignore_nice(struct 
 		j_dbs_info->prev_cpu_idle_up = get_cpu_idle_time(j);
 		j_dbs_info->prev_cpu_idle_down = j_dbs_info->prev_cpu_idle_up;
 	}
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 
 	return count;
 }
@@ -356,12 +357,12 @@ static void dbs_check_cpu(int cpu)
 static void do_dbs_timer(void *data)
 { 
 	int i;
-	down(&dbs_sem);
+	mutex_lock(&dbs_mutex);
 	for_each_online_cpu(i)
 		dbs_check_cpu(i);
 	schedule_delayed_work(&dbs_work, 
 			usecs_to_jiffies(dbs_tuners_ins.sampling_rate));
-	up(&dbs_sem);
+	mutex_unlock(&dbs_mutex);
 } 
 
 static inline void dbs_timer_init(void)
@@ -399,7 +400,7 @@ static int cpufreq_governor_dbs(struct c
 		if (this_dbs_info->enable) /* Already enabled */
 			break;
 		 
-		down(&dbs_sem);
+		mutex_lock(&dbs_mutex);
 		for_each_cpu_mask(j, policy->cpus) {
 			struct cpu_dbs_info_s *j_dbs_info;
 			j_dbs_info = &per_cpu(cpu_dbs_info, j);
@@ -435,11 +436,11 @@ static int cpufreq_governor_dbs(struct c
 			dbs_timer_init();
 		}
 		
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		break;
 
 	case CPUFREQ_GOV_STOP:
-		down(&dbs_sem);
+		mutex_lock(&dbs_mutex);
 		this_dbs_info->enable = 0;
 		sysfs_remove_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable--;
@@ -450,12 +451,12 @@ static int cpufreq_governor_dbs(struct c
 		if (dbs_enable == 0) 
 			dbs_timer_exit();
 		
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 
 		break;
 
 	case CPUFREQ_GOV_LIMITS:
-		down(&dbs_sem);
+		mutex_lock(&dbs_mutex);
 		if (policy->max < this_dbs_info->cur_policy->cur)
 			__cpufreq_driver_target(
 					this_dbs_info->cur_policy,
@@ -464,7 +465,7 @@ static int cpufreq_governor_dbs(struct c
 			__cpufreq_driver_target(
 					this_dbs_info->cur_policy,
 				       	policy->min, CPUFREQ_RELATION_L);
-		up(&dbs_sem);
+		mutex_unlock(&dbs_mutex);
 		break;
 	}
 	return 0;
diff -purN linux-2.6.15-rc6-mutex/drivers/cpufreq/cpufreq_userspace.c linux-2.6.15-rc6-mutex-new/drivers/cpufreq/cpufreq_userspace.c
--- linux-2.6.15-rc6-mutex/drivers/cpufreq/cpufreq_userspace.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-mutex-new/drivers/cpufreq/cpufreq_userspace.c	2005-12-20 11:03:20.000000000 +0100
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 
@@ -35,7 +36,7 @@ static unsigned int	cpu_set_freq[NR_CPUS
 static unsigned int	cpu_is_managed[NR_CPUS];
 static struct cpufreq_policy current_policy[NR_CPUS];
 
-static DECLARE_MUTEX	(userspace_sem); 
+static DECLARE_MUTEX	(userspace_mutex); 
 
 #define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_GOVERNOR, "userspace", msg)
 
@@ -70,7 +71,7 @@ static int cpufreq_set(unsigned int freq
 
 	dprintk("cpufreq_set for cpu %u, freq %u kHz\n", cpu, freq);
 
-	down(&userspace_sem);
+	mutex_lock(&userspace_mutex);
 	if (!cpu_is_managed[cpu])
 		goto err;
 
@@ -83,16 +84,16 @@ static int cpufreq_set(unsigned int freq
 
 	/*
 	 * We're safe from concurrent calls to ->target() here
-	 * as we hold the userspace_sem lock. If we were calling
+	 * as we hold the userspace_mutex lock. If we were calling
 	 * cpufreq_driver_target, a deadlock situation might occur:
-	 * A: cpufreq_set (lock userspace_sem) -> cpufreq_driver_target(lock policy->lock)
-	 * B: cpufreq_set_policy(lock policy->lock) -> __cpufreq_governor -> cpufreq_governor_userspace (lock userspace_sem)
+	 * A: cpufreq_set (lock userspace_mutex) -> cpufreq_driver_target(lock policy->lock)
+	 * B: cpufreq_set_policy(lock policy->lock) -> __cpufreq_governor -> cpufreq_governor_userspace (lock userspace_mutex)
 	 */
 	ret = __cpufreq_driver_target(&current_policy[cpu], freq, 
 	      CPUFREQ_RELATION_L);
 
  err:
-	up(&userspace_sem);
+	mutex_unlock(&userspace_mutex);
 	return ret;
 }
 
@@ -134,7 +135,7 @@ static int cpufreq_governor_userspace(st
 		if (!cpu_online(cpu))
 			return -EINVAL;
 		BUG_ON(!policy->cur);
-		down(&userspace_sem);
+		mutex_lock(&userspace_mutex);
 		cpu_is_managed[cpu] = 1;		
 		cpu_min_freq[cpu] = policy->min;
 		cpu_max_freq[cpu] = policy->max;
@@ -143,20 +144,20 @@ static int cpufreq_governor_userspace(st
 		sysfs_create_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
 		dprintk("managing cpu %u started (%u - %u kHz, currently %u kHz)\n", cpu, cpu_min_freq[cpu], cpu_max_freq[cpu], cpu_cur_freq[cpu]);
-		up(&userspace_sem);
+		mutex_unlock(&userspace_mutex);
 		break;
 	case CPUFREQ_GOV_STOP:
-		down(&userspace_sem);
+		mutex_lock(&userspace_mutex);
 		cpu_is_managed[cpu] = 0;
 		cpu_min_freq[cpu] = 0;
 		cpu_max_freq[cpu] = 0;
 		cpu_set_freq[cpu] = 0;
 		sysfs_remove_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		dprintk("managing cpu %u stopped\n", cpu);
-		up(&userspace_sem);
+		mutex_unlock(&userspace_mutex);
 		break;
 	case CPUFREQ_GOV_LIMITS:
-		down(&userspace_sem);
+		mutex_lock(&userspace_mutex);
 		cpu_min_freq[cpu] = policy->min;
 		cpu_max_freq[cpu] = policy->max;
 		dprintk("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set to %u kHz\n", cpu, cpu_min_freq[cpu], cpu_max_freq[cpu], cpu_cur_freq[cpu], cpu_set_freq[cpu]);
@@ -171,7 +172,7 @@ static int cpufreq_governor_userspace(st
 			      CPUFREQ_RELATION_L);
 		}
 		memcpy (&current_policy[cpu], policy, sizeof(struct cpufreq_policy));
-		up(&userspace_sem);
+		mutex_unlock(&userspace_mutex);
 		break;
 	}
 	return 0;
diff -purN linux-2.6.15-rc6-mutex/drivers/i2c/busses/i2c-ali1535.c linux-2.6.15-rc6-mutex-new/drivers/i2c/busses/i2c-ali1535.c
--- linux-2.6.15-rc6-mutex/drivers/i2c/busses/i2c-ali1535.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/i2c/busses/i2c-ali1535.c	2005-12-20 11:21:01.000000000 +0100
@@ -62,6 +62,7 @@
 #include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 
@@ -136,7 +137,7 @@
 
 static struct pci_driver ali1535_driver;
 static unsigned short ali1535_smba;
-static DECLARE_MUTEX(i2c_ali1535_sem);
+static DEFINE_MUTEX(i2c_ali1535_mutex);
 
 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -345,7 +346,7 @@ static s32 ali1535_access(struct i2c_ada
 	int timeout;
 	s32 result = 0;
 
-	down(&i2c_ali1535_sem);
+	mutex_lock(&i2c_ali1535_mutex);
 	/* make sure SMBus is idle */
 	temp = inb_p(SMBHSTSTS);
 	for (timeout = 0;
@@ -460,7 +461,7 @@ static s32 ali1535_access(struct i2c_ada
 		break;
 	}
 EXIT:
-	up(&i2c_ali1535_sem);
+	mutex_unlock(&i2c_ali1535_mutex);
 	return result;
 }
 
diff -purN linux-2.6.15-rc6-mutex/drivers/i2c/chips/ds1374.c linux-2.6.15-rc6-mutex-new/drivers/i2c/chips/ds1374.c
--- linux-2.6.15-rc6-mutex/drivers/i2c/chips/ds1374.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/i2c/chips/ds1374.c	2005-12-20 11:17:24.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/mutex.h>
 
 #define DS1374_REG_TOD0		0x00
 #define DS1374_REG_TOD1		0x01
@@ -41,7 +42,7 @@
 
 #define	DS1374_DRV_NAME		"ds1374"
 
-static DECLARE_MUTEX(ds1374_mutex);
+static DEFINE_MUTEX(ds1374_mutex);
 
 static struct i2c_driver ds1374_driver;
 static struct i2c_client *save_client;
@@ -114,7 +115,7 @@ ulong ds1374_get_rtc_time(void)
 	ulong t1, t2;
 	int limit = 10;		/* arbitrary retry limit */
 
-	down(&ds1374_mutex);
+	mutex_lock(&ds1374_mutex);
 
 	/*
 	 * Since the reads are being performed one byte at a time using
@@ -127,7 +128,7 @@ ulong ds1374_get_rtc_time(void)
 		t2 = ds1374_read_rtc();
 	} while (t1 != t2 && limit--);
 
-	up(&ds1374_mutex);
+	mutex_unlock(&ds1374_mutex);
 
 	if (t1 != t2) {
 		dev_warn(&save_client->dev,
@@ -145,7 +146,7 @@ static void ds1374_set_tlet(ulong arg)
 
 	t1 = *(ulong *) arg;
 
-	down(&ds1374_mutex);
+	mutex_lock(&ds1374_mutex);
 
 	/*
 	 * Since the writes are being performed one byte at a time using
@@ -158,7 +159,7 @@ static void ds1374_set_tlet(ulong arg)
 		t2 = ds1374_read_rtc();
 	} while (t1 != t2 && limit--);
 
-	up(&ds1374_mutex);
+	mutex_unlock(&ds1374_mutex);
 
 	if (t1 != t2)
 		dev_warn(&save_client->dev,
diff -purN linux-2.6.15-rc6-mutex/drivers/i2c/chips/m41t00.c linux-2.6.15-rc6-mutex-new/drivers/i2c/chips/m41t00.c
--- linux-2.6.15-rc6-mutex/drivers/i2c/chips/m41t00.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/i2c/chips/m41t00.c	2005-12-20 11:21:44.000000000 +0100
@@ -24,13 +24,14 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/mutex.h>
 
 #include <asm/time.h>
 #include <asm/rtc.h>
 
 #define	M41T00_DRV_NAME		"m41t00"
 
-static DECLARE_MUTEX(m41t00_mutex);
+static DEFINE_MUTEX(m41t00_mutex);
 
 static struct i2c_driver m41t00_driver;
 static struct i2c_client *save_client;
@@ -54,7 +55,7 @@ m41t00_get_rtc_time(void)
 	sec = min = hour = day = mon = year = 0;
 	sec1 = min1 = hour1 = day1 = mon1 = year1 = 0;
 
-	down(&m41t00_mutex);
+	mutex_lock(&m41t00_mutex);
 	do {
 		if (((sec = i2c_smbus_read_byte_data(save_client, 0)) >= 0)
 			&& ((min = i2c_smbus_read_byte_data(save_client, 1))
@@ -80,7 +81,7 @@ m41t00_get_rtc_time(void)
 		mon1 = mon;
 		year1 = year;
 	} while (--limit > 0);
-	up(&m41t00_mutex);
+	mutex_unlock(&m41t00_mutex);
 
 	if (limit == 0) {
 		dev_warn(&save_client->dev,
@@ -125,7 +126,7 @@ m41t00_set_tlet(ulong arg)
 	BIN_TO_BCD(tm.tm_mday);
 	BIN_TO_BCD(tm.tm_year);
 
-	down(&m41t00_mutex);
+	mutex_lock(&m41t00_mutex);
 	if ((i2c_smbus_write_byte_data(save_client, 0, tm.tm_sec & 0x7f) < 0)
 		|| (i2c_smbus_write_byte_data(save_client, 1, tm.tm_min & 0x7f)
 			< 0)
@@ -140,7 +141,7 @@ m41t00_set_tlet(ulong arg)
 
 		dev_warn(&save_client->dev,"m41t00: can't write to rtc chip\n");
 
-	up(&m41t00_mutex);
+	mutex_unlock(&m41t00_mutex);
 	return;
 }
 
diff -purN linux-2.6.15-rc6-mutex/drivers/i2c/i2c-core.c linux-2.6.15-rc6-mutex-new/drivers/i2c/i2c-core.c
--- linux-2.6.15-rc6-mutex/drivers/i2c/i2c-core.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/i2c/i2c-core.c	2005-12-20 11:22:43.000000000 +0100
@@ -31,12 +31,13 @@
 #include <linux/idr.h>
 #include <linux/seq_file.h>
 #include <linux/platform_device.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 
 
 static LIST_HEAD(adapters);
 static LIST_HEAD(drivers);
-static DECLARE_MUTEX(core_lists);
+static DEFINE_MUTEX(core_lists);
 static DEFINE_IDR(i2c_adapter_idr);
 
 /* match always succeeds, as we want the probe() to tell if we really accept this match */
@@ -153,7 +154,7 @@ int i2c_add_adapter(struct i2c_adapter *
 	struct list_head   *item;
 	struct i2c_driver  *driver;
 
-	down(&core_lists);
+	mutex_lock(&core_lists);
 
 	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0) {
 		res = -ENOMEM;
@@ -203,7 +204,7 @@ int i2c_add_adapter(struct i2c_adapter *
 	}
 
 out_unlock:
-	up(&core_lists);
+	mutex_unlock(&core_lists);
 	return res;
 }
 
@@ -216,7 +217,7 @@ int i2c_del_adapter(struct i2c_adapter *
 	struct i2c_client *client;
 	int res = 0;
 
-	down(&core_lists);
+	mutex_lock(&core_lists);
 
 	/* First make sure that this adapter was ever added */
 	list_for_each_entry(adap_from_list, &adapters, list) {
@@ -275,7 +276,7 @@ int i2c_del_adapter(struct i2c_adapter *
 	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
 
  out_unlock:
-	up(&core_lists);
+	mutex_unlock(&core_lists);
 	return res;
 }
 
@@ -292,7 +293,7 @@ int i2c_add_driver(struct i2c_driver *dr
 	struct i2c_adapter *adapter;
 	int res = 0;
 
-	down(&core_lists);
+	mutex_lock(&core_lists);
 
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.owner = driver->owner;
@@ -317,7 +318,7 @@ int i2c_add_driver(struct i2c_driver *dr
 	}
 
  out_unlock:
-	up(&core_lists);
+	mutex_unlock(&core_lists);
 	return res;
 }
 
@@ -329,7 +330,7 @@ int i2c_del_driver(struct i2c_driver *dr
 	
 	int res = 0;
 
-	down(&core_lists);
+	mutex_lock(&core_lists);
 
 	/* Have a look at each adapter, if clients of this driver are still
 	 * attached. If so, detach them to be able to kill the driver 
@@ -371,7 +372,7 @@ int i2c_del_driver(struct i2c_driver *dr
 	pr_debug("i2c-core: driver [%s] unregistered\n", driver->name);
 
  out_unlock:
-	up(&core_lists);
+	mutex_unlock(&core_lists);
 	return 0;
 }
 
@@ -802,12 +803,12 @@ struct i2c_adapter* i2c_get_adapter(int 
 {
 	struct i2c_adapter *adapter;
 	
-	down(&core_lists);
+	mutex_lock(&core_lists);
 	adapter = (struct i2c_adapter *)idr_find(&i2c_adapter_idr, id);
 	if (adapter && !try_module_get(adapter->owner))
 		adapter = NULL;
 
-	up(&core_lists);
+	mutex_unlock(&core_lists);
 	return adapter;
 }
 
diff -purN linux-2.6.15-rc6-mutex/drivers/ide/ide-cd.c linux-2.6.15-rc6-mutex-new/drivers/ide/ide-cd.c
--- linux-2.6.15-rc6-mutex/drivers/ide/ide-cd.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/ide/ide-cd.c	2005-12-20 10:55:24.000000000 +0100
@@ -313,6 +313,7 @@
 #include <linux/cdrom.h>
 #include <linux/ide.h>
 #include <linux/completion.h>
+#include <linux/mutex.h>
 
 #include <scsi/scsi.h>	/* For SCSI -> ATAPI command conversion */
 
@@ -324,7 +325,7 @@
 
 #include "ide-cd.h"
 
-static DECLARE_MUTEX(idecd_ref_sem);
+static DEFINE_MUTEX(idecd_ref_mutex);
 
 #define to_ide_cd(obj) container_of(obj, struct cdrom_info, kref) 
 
@@ -335,11 +336,11 @@ static struct cdrom_info *ide_cd_get(str
 {
 	struct cdrom_info *cd = NULL;
 
-	down(&idecd_ref_sem);
+	mutex_lock(&idecd_ref_mutex);
 	cd = ide_cd_g(disk);
 	if (cd)
 		kref_get(&cd->kref);
-	up(&idecd_ref_sem);
+	mutex_unlock(&idecd_ref_mutex);
 	return cd;
 }
 
@@ -347,9 +348,9 @@ static void ide_cd_release(struct kref *
 
 static void ide_cd_put(struct cdrom_info *cd)
 {
-	down(&idecd_ref_sem);
+	mutex_lock(&idecd_ref_mutex);
 	kref_put(&cd->kref, ide_cd_release);
-	up(&idecd_ref_sem);
+	mutex_unlock(&idecd_ref_mutex);
 }
 
 /****************************************************************************
diff -purN linux-2.6.15-rc6-mutex/drivers/ide/ide-disk.c linux-2.6.15-rc6-mutex-new/drivers/ide/ide-disk.c
--- linux-2.6.15-rc6-mutex/drivers/ide/ide-disk.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/ide/ide-disk.c	2005-12-20 10:56:04.000000000 +0100
@@ -60,6 +60,7 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 
 #define _IDE_DISK
 
@@ -78,7 +79,7 @@ struct ide_disk_obj {
 	struct kref	kref;
 };
 
-static DECLARE_MUTEX(idedisk_ref_sem);
+static DEFINE_MUTEX(idedisk_ref_mutex);
 
 #define to_ide_disk(obj) container_of(obj, struct ide_disk_obj, kref)
 
@@ -89,11 +90,11 @@ static struct ide_disk_obj *ide_disk_get
 {
 	struct ide_disk_obj *idkp = NULL;
 
-	down(&idedisk_ref_sem);
+	mutex_lock(&idedisk_ref_mutex);
 	idkp = ide_disk_g(disk);
 	if (idkp)
 		kref_get(&idkp->kref);
-	up(&idedisk_ref_sem);
+	mutex_unlock(&idedisk_ref_mutex);
 	return idkp;
 }
 
@@ -101,9 +102,9 @@ static void ide_disk_release(struct kref
 
 static void ide_disk_put(struct ide_disk_obj *idkp)
 {
-	down(&idedisk_ref_sem);
+	mutex_lock(&idedisk_ref_mutex);
 	kref_put(&idkp->kref, ide_disk_release);
-	up(&idedisk_ref_sem);
+	mutex_unlock(&idedisk_ref_mutex);
 }
 
 /*
diff -purN linux-2.6.15-rc6-mutex/drivers/ide/ide-floppy.c linux-2.6.15-rc6-mutex-new/drivers/ide/ide-floppy.c
--- linux-2.6.15-rc6-mutex/drivers/ide/ide-floppy.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/ide/ide-floppy.c	2005-12-20 10:56:45.000000000 +0100
@@ -98,6 +98,7 @@
 #include <linux/cdrom.h>
 #include <linux/ide.h>
 #include <linux/bitops.h>
+#include <linux/mutex.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -517,7 +518,7 @@ typedef struct {
 	u8		reserved[4];
 } idefloppy_mode_parameter_header_t;
 
-static DECLARE_MUTEX(idefloppy_ref_sem);
+static DEFINE_MUTEX(idefloppy_ref_mutex);
 
 #define to_ide_floppy(obj) container_of(obj, struct ide_floppy_obj, kref)
 
@@ -528,11 +529,11 @@ static struct ide_floppy_obj *ide_floppy
 {
 	struct ide_floppy_obj *floppy = NULL;
 
-	down(&idefloppy_ref_sem);
+	mutex_lock(&idefloppy_ref_mutex);
 	floppy = ide_floppy_g(disk);
 	if (floppy)
 		kref_get(&floppy->kref);
-	up(&idefloppy_ref_sem);
+	mutex_unlock(&idefloppy_ref_mutex);
 	return floppy;
 }
 
@@ -540,9 +541,9 @@ static void ide_floppy_release(struct kr
 
 static void ide_floppy_put(struct ide_floppy_obj *floppy)
 {
-	down(&idefloppy_ref_sem);
+	mutex_lock(&idefloppy_ref_mutex);
 	kref_put(&floppy->kref, ide_floppy_release);
-	up(&idefloppy_ref_sem);
+	mutex_unlock(&idefloppy_ref_mutex);
 }
 
 /*
diff -purN linux-2.6.15-rc6-mutex/drivers/ide/ide-tape.c linux-2.6.15-rc6-mutex-new/drivers/ide/ide-tape.c
--- linux-2.6.15-rc6-mutex/drivers/ide/ide-tape.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/ide/ide-tape.c	2005-12-20 10:57:59.000000000 +0100
@@ -443,6 +443,7 @@
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/bitops.h>
+#include <linux/mutex.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -1011,7 +1012,7 @@ typedef struct ide_tape_obj {
          int debug_level; 
 } idetape_tape_t;
 
-static DECLARE_MUTEX(idetape_ref_sem);
+static DEFINE_MUTEX(idetape_ref_mutex);
 
 static struct class *idetape_sysfs_class;
 
@@ -1024,11 +1025,11 @@ static struct ide_tape_obj *ide_tape_get
 {
 	struct ide_tape_obj *tape = NULL;
 
-	down(&idetape_ref_sem);
+	mutex_lock(&idetape_ref_mutex);
 	tape = ide_tape_g(disk);
 	if (tape)
 		kref_get(&tape->kref);
-	up(&idetape_ref_sem);
+	mutex_unlock(&idetape_ref_mutex);
 	return tape;
 }
 
@@ -1036,9 +1037,9 @@ static void ide_tape_release(struct kref
 
 static void ide_tape_put(struct ide_tape_obj *tape)
 {
-	down(&idetape_ref_sem);
+	mutex_lock(&idetape_ref_mutex);
 	kref_put(&tape->kref, ide_tape_release);
-	up(&idetape_ref_sem);
+	mutex_unlock(&idetape_ref_mutex);
 }
 
 /*
@@ -1290,11 +1291,11 @@ static struct ide_tape_obj *ide_tape_chr
 {
 	struct ide_tape_obj *tape = NULL;
 
-	down(&idetape_ref_sem);
+	mutex_lock(&idetape_ref_mutex);
 	tape = idetape_devs[i];
 	if (tape)
 		kref_get(&tape->kref);
-	up(&idetape_ref_sem);
+	mutex_unlock(&idetape_ref_mutex);
 	return tape;
 }
 
@@ -4874,11 +4875,11 @@ static int ide_tape_probe(struct device 
 
 	drive->driver_data = tape;
 
-	down(&idetape_ref_sem);
+	mutex_lock(&idetape_ref_mutex);
 	for (minor = 0; idetape_devs[minor]; minor++)
 		;
 	idetape_devs[minor] = tape;
-	up(&idetape_ref_sem);
+	mutex_unlock(&idetape_ref_mutex);
 
 	idetape_setup(drive, tape, minor);
 
diff -purN linux-2.6.15-rc6-mutex/drivers/mmc/mmc_block.c linux-2.6.15-rc6-mutex-new/drivers/mmc/mmc_block.c
--- linux-2.6.15-rc6-mutex/drivers/mmc/mmc_block.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/mmc/mmc_block.c	2005-12-20 11:35:10.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/kdev_t.h>
 #include <linux/blkdev.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/mutex.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/protocol.h>
@@ -56,33 +57,33 @@ struct mmc_blk_data {
 	unsigned int	block_bits;
 };
 
-static DECLARE_MUTEX(open_lock);
+static DEFINE_MUTEX(open_lock);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
 	struct mmc_blk_data *md;
 
-	down(&open_lock);
+	mutex_lock(&open_lock);
 	md = disk->private_data;
 	if (md && md->usage == 0)
 		md = NULL;
 	if (md)
 		md->usage++;
-	up(&open_lock);
+	mutex_unlock(&open_lock);
 
 	return md;
 }
 
 static void mmc_blk_put(struct mmc_blk_data *md)
 {
-	down(&open_lock);
+	mutex_lock(&open_lock);
 	md->usage--;
 	if (md->usage == 0) {
 		put_disk(md->disk);
 		mmc_cleanup_queue(&md->queue);
 		kfree(md);
 	}
-	up(&open_lock);
+	mutex_unlock(&open_lock);
 }
 
 static inline int mmc_blk_readonly(struct mmc_card *card)
diff -purN linux-2.6.15-rc6-mutex/drivers/mtd/devices/doc2000.c linux-2.6.15-rc6-mutex-new/drivers/mtd/devices/doc2000.c
--- linux-2.6.15-rc6-mutex/drivers/mtd/devices/doc2000.c	2005-12-20 09:19:25.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/mtd/devices/doc2000.c	2005-12-20 10:54:45.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/mutex.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -975,13 +976,13 @@ static int doc_writev_ecc(struct mtd_inf
 			  u_char *eccbuf, struct nand_oobinfo *oobsel)
 {
 	static char static_buf[512];
-	static DECLARE_MUTEX(writev_buf_sem);
+	static DEFINE_MUTEX(writev_buf_mutex);
 
 	size_t totretlen = 0;
 	size_t thisvecofs = 0;
 	int ret= 0;
 
-	down(&writev_buf_sem);
+	mutex_lock(&writev_buf_mutex);
 
 	while(count) {
 		size_t thislen, thisretlen;
@@ -1024,7 +1025,7 @@ static int doc_writev_ecc(struct mtd_inf
 		to += thislen;
 	}
 
-	up(&writev_buf_sem);
+	mutex_unlock(&writev_buf_mutex);
 	*retlen = totretlen;
 	return ret;
 }
diff -purN linux-2.6.15-rc6-mutex/drivers/pci/hotplug/sgi_hotplug.c linux-2.6.15-rc6-mutex-new/drivers/pci/hotplug/sgi_hotplug.c
--- linux-2.6.15-rc6-mutex/drivers/pci/hotplug/sgi_hotplug.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-mutex-new/drivers/pci/hotplug/sgi_hotplug.c	2005-12-20 10:51:26.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 #include <asm/sn/addrs.h>
 #include <asm/sn/l1.h>
@@ -81,7 +82,7 @@ static struct hotplug_slot_ops sn_hotplu
 	.get_power_status       = get_power_status,
 };
 
-static DECLARE_MUTEX(sn_hotplug_sem);
+static DEFINE_MUTEX(sn_hotplug_mutex);
 
 static ssize_t path_show (struct hotplug_slot *bss_hotplug_slot,
 	       		  char *buf)
@@ -339,7 +340,7 @@ static int enable_slot(struct hotplug_sl
 	int rc;
 
 	/* Serialize the Linux PCI infrastructure */
-	down(&sn_hotplug_sem);
+	mutex_lock(&sn_hotplug_mutex);
 
 	/*
 	 * Power-on and initialize the slot in the SN
@@ -347,7 +348,7 @@ static int enable_slot(struct hotplug_sl
 	 */
 	rc = sn_slot_enable(bss_hotplug_slot, slot->device_num);
 	if (rc) {
-		up(&sn_hotplug_sem);
+		mutex_unlock(&sn_hotplug_mutex);
 		return rc;
 	}
 
@@ -355,7 +356,7 @@ static int enable_slot(struct hotplug_sl
 				  PCI_DEVFN(slot->device_num + 1, 0));
 	if (!num_funcs) {
 		dev_dbg(slot->pci_bus->self, "no device in slot\n");
-		up(&sn_hotplug_sem);
+		mutex_unlock(&sn_hotplug_mutex);
 		return -ENODEV;
 	}
 
@@ -395,7 +396,7 @@ static int enable_slot(struct hotplug_sl
 	if (new_ppb)
 		pci_bus_add_devices(new_bus);
 
-	up(&sn_hotplug_sem);
+	mutex_unlock(&sn_hotplug_mutex);
 
 	if (rc == 0)
 		dev_dbg(slot->pci_bus->self,
@@ -415,7 +416,7 @@ static int disable_slot(struct hotplug_s
 	int rc;
 
 	/* Acquire update access to the bus */
-	down(&sn_hotplug_sem);
+	mutex_lock(&sn_hotplug_mutex);
 
 	/* is it okay to bring this slot down? */
 	rc = sn_slot_disable(bss_hotplug_slot, slot->device_num,
@@ -450,7 +451,7 @@ static int disable_slot(struct hotplug_s
 			     PCI_REQ_SLOT_DISABLE);
  leaving:
 	/* Release the bus lock */
-	up(&sn_hotplug_sem);
+	mutex_unlock(&sn_hotplug_mutex);
 
 	return rc;
 }
@@ -462,9 +463,9 @@ static inline int get_power_status(struc
 	struct pcibus_info *pcibus_info;
 
 	pcibus_info = SN_PCIBUS_BUSSOFT_INFO(slot->pci_bus);
-	down(&sn_hotplug_sem);
+	mutex_lock(&sn_hotplug_mutex);
 	*value = pcibus_info->pbi_enabled_devices & (1 << slot->device_num);
-	up(&sn_hotplug_sem);
+	mutex_unlock(&sn_hotplug_mutex);
 	return 0;
 }
 
diff -purN linux-2.6.15-rc6-mutex/drivers/pcmcia/ds.c linux-2.6.15-rc6-mutex-new/drivers/pcmcia/ds.c
--- linux-2.6.15-rc6-mutex/drivers/pcmcia/ds.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/pcmcia/ds.c	2005-12-20 11:37:29.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/crc32.h>
 #include <linux/firmware.h>
+#include <linux/mutex.h>
 
 #define IN_CARD_SERVICES
 #include <pcmcia/cs_types.h>
@@ -499,7 +500,7 @@ static int pcmcia_device_query(struct pc
  * won't work, this doesn't matter much at the moment: the driver core doesn't
  * support it either.
  */
-static DECLARE_MUTEX(device_add_lock);
+static DEFINE_MUTEX(device_add_lock);
 
 struct pcmcia_device * pcmcia_device_add(struct pcmcia_socket *s, unsigned int function)
 {
@@ -511,7 +512,7 @@ struct pcmcia_device * pcmcia_device_add
 	if (!s)
 		return NULL;
 
-	down(&device_add_lock);
+	mutex_lock(&device_add_lock);
 
 	/* max of 2 devices per card */
 	if (s->device_count == 2)
@@ -557,7 +558,7 @@ struct pcmcia_device * pcmcia_device_add
 		goto err_free;
        }
 
-	up(&device_add_lock);
+	mutex_unlock(&device_add_lock);
 
 	return p_dev;
 
@@ -566,7 +567,7 @@ struct pcmcia_device * pcmcia_device_add
 	kfree(p_dev);
 	s->device_count--;
  err_put:
-	up(&device_add_lock);
+	mutex_unlock(&device_add_lock);
 	pcmcia_put_socket(s);
 
 	return NULL;
diff -purN linux-2.6.15-rc6-mutex/drivers/pcmcia/rsrc_nonstatic.c linux-2.6.15-rc6-mutex-new/drivers/pcmcia/rsrc_nonstatic.c
--- linux-2.6.15-rc6-mutex/drivers/pcmcia/rsrc_nonstatic.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/pcmcia/rsrc_nonstatic.c	2005-12-20 11:38:25.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/device.h>
+#include <linux/mutex.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -61,7 +62,7 @@ struct socket_data {
 	unsigned int			rsrc_mem_probe;
 };
 
-static DECLARE_MUTEX(rsrc_sem);
+static DEFINE_MUTEX(rsrc_mutex);
 #define MEM_PROBE_LOW	(1 << 0)
 #define MEM_PROBE_HIGH	(1 << 1)
 
@@ -484,7 +485,7 @@ static void pcmcia_nonstatic_validate_me
 	if (probe_mem) {
 		unsigned int probe_mask;
 
-		down(&rsrc_sem);
+		mutex_lock(&rsrc_mutex);
 
 		probe_mask = MEM_PROBE_LOW;
 		if (s->features & SS_CAP_PAGE_REGS)
@@ -497,7 +498,7 @@ static void pcmcia_nonstatic_validate_me
 				validate_mem(s, probe_mask);
 		}
 
-		up(&rsrc_sem);
+		mutex_unlock(&rsrc_mutex);
 	}
 }
 
@@ -574,7 +575,7 @@ static int nonstatic_adjust_io_region(st
 	struct socket_data *s_data = s->resource_data;
 	int ret = -ENOMEM;
 
-	down(&rsrc_sem);
+	mutex_lock(&rsrc_mutex);
 	for (m = s_data->io_db.next; m != &s_data->io_db; m = m->next) {
 		unsigned long start = m->base;
 		unsigned long end = m->base + m->num - 1;
@@ -585,7 +586,7 @@ static int nonstatic_adjust_io_region(st
 		ret = adjust_resource(res, r_start, r_end - r_start + 1);
 		break;
 	}
-	up(&rsrc_sem);
+	mutex_unlock(&rsrc_mutex);
 
 	return ret;
 }
@@ -619,7 +620,7 @@ static struct resource *nonstatic_find_i
 	data.offset = base & data.mask;
 	data.map = &s_data->io_db;
 
-	down(&rsrc_sem);
+	mutex_lock(&rsrc_mutex);
 #ifdef CONFIG_PCI
 	if (s->cb_dev) {
 		ret = pci_bus_alloc_resource(s->cb_dev->bus, res, num, 1,
@@ -628,7 +629,7 @@ static struct resource *nonstatic_find_i
 #endif
 		ret = allocate_resource(&ioport_resource, res, num, min, ~0UL,
 					1, pcmcia_align, &data);
-	up(&rsrc_sem);
+	mutex_unlock(&rsrc_mutex);
 
 	if (ret != 0) {
 		kfree(res);
@@ -661,7 +662,7 @@ static struct resource * nonstatic_find_
 			min = 0x100000UL + base;
 		}
 
-		down(&rsrc_sem);
+		mutex_lock(&rsrc_mutex);
 #ifdef CONFIG_PCI
 		if (s->cb_dev) {
 			ret = pci_bus_alloc_resource(s->cb_dev->bus, res, num,
@@ -671,7 +672,7 @@ static struct resource * nonstatic_find_
 #endif
 			ret = allocate_resource(&iomem_resource, res, num, min,
 						max, 1, pcmcia_align, &data);
-		up(&rsrc_sem);
+		mutex_unlock(&rsrc_mutex);
 		if (ret == 0 || low)
 			break;
 		low = 1;
@@ -694,7 +695,7 @@ static int adjust_memory(struct pcmcia_s
 	if (end < start)
 		return -EINVAL;
 
-	down(&rsrc_sem);
+	mutex_lock(&rsrc_mutex);
 	switch (action) {
 	case ADD_MANAGED_RESOURCE:
 		ret = add_interval(&data->mem_db, start, size);
@@ -712,7 +713,7 @@ static int adjust_memory(struct pcmcia_s
 	default:
 		ret = -EINVAL;
 	}
-	up(&rsrc_sem);
+	mutex_unlock(&rsrc_mutex);
 
 	return ret;
 }
@@ -730,7 +731,7 @@ static int adjust_io(struct pcmcia_socke
 	if (end > IO_SPACE_LIMIT)
 		return -EINVAL;
 
-	down(&rsrc_sem);
+	mutex_lock(&rsrc_mutex);
 	switch (action) {
 	case ADD_MANAGED_RESOURCE:
 		if (add_interval(&data->io_db, start, size) != 0) {
@@ -749,7 +750,7 @@ static int adjust_io(struct pcmcia_socke
 		ret = -EINVAL;
 		break;
 	}
-	up(&rsrc_sem);
+	mutex_unlock(&rsrc_mutex);
 
 	return ret;
 }
@@ -857,7 +858,7 @@ static void nonstatic_release_resource_d
 	struct socket_data *data = s->resource_data;
 	struct resource_map *p, *q;
 
-	down(&rsrc_sem);
+	mutex_lock(&rsrc_mutex);
 	for (p = data->mem_db.next; p != &data->mem_db; p = q) {
 		q = p->next;
 		kfree(p);
@@ -866,7 +867,7 @@ static void nonstatic_release_resource_d
 		q = p->next;
 		kfree(p);
 	}
-	up(&rsrc_sem);
+	mutex_unlock(&rsrc_mutex);
 }
 
 
@@ -891,7 +892,7 @@ static ssize_t show_io_db(struct class_d
 	struct resource_map *p;
 	ssize_t ret = 0;
 
-	down(&rsrc_sem);
+	mutex_lock(&rsrc_mutex);
 	data = s->resource_data;
 
 	for (p = data->io_db.next; p != &data->io_db; p = p->next) {
@@ -903,7 +904,7 @@ static ssize_t show_io_db(struct class_d
 				 ((unsigned long) p->base + p->num - 1));
 	}
 
-	up(&rsrc_sem);
+	mutex_unlock(&rsrc_mutex);
 	return (ret);
 }
 
@@ -943,7 +944,7 @@ static ssize_t show_mem_db(struct class_
 	struct resource_map *p;
 	ssize_t ret = 0;
 
-	down(&rsrc_sem);
+	mutex_lock(&rsrc_mutex);
 	data = s->resource_data;
 
 	for (p = data->mem_db.next; p != &data->mem_db; p = p->next) {
@@ -955,7 +956,7 @@ static ssize_t show_mem_db(struct class_
 				 ((unsigned long) p->base + p->num - 1));
 	}
 
-	up(&rsrc_sem);
+	mutex_unlock(&rsrc_mutex);
 	return (ret);
 }
 
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/dpt_i2o.c linux-2.6.15-rc6-mutex-new/drivers/scsi/dpt_i2o.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/dpt_i2o.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/dpt_i2o.c	2005-12-20 10:48:30.000000000 +0100
@@ -61,6 +61,7 @@ MODULE_DESCRIPTION("Adaptec I2O RAID Dri
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
+#include <linux/mutex.h>
 
 #include <asm/processor.h>	/* for boot_cpu_data */
 #include <asm/pgtable.h>
@@ -106,7 +107,7 @@ static dpt_sig_S DPTI_sig = {
  *============================================================================
  */
 
-static DECLARE_MUTEX(adpt_configuration_lock);
+static DEFINE_MUTEX(adpt_configuration_lock);
 
 static struct i2o_sys_tbl *sys_tbl = NULL;
 static int sys_tbl_ind = 0;
@@ -537,13 +538,13 @@ static int adpt_proc_info(struct Scsi_Ho
 	 */
 
 	// Find HBA (host bus adapter) we are looking for
-	down(&adpt_configuration_lock);
+	mutex_lock(&adpt_configuration_lock);
 	for (pHba = hba_chain; pHba; pHba = pHba->next) {
 		if (pHba->host == host) {
 			break;	/* found adapter */
 		}
 	}
-	up(&adpt_configuration_lock);
+	mutex_unlock(&adpt_configuration_lock);
 	if (pHba == NULL) {
 		return 0;
 	}
@@ -958,7 +959,7 @@ static int adpt_install_hba(struct scsi_
 	}
 	memset(pHba, 0, sizeof(adpt_hba));
 
-	down(&adpt_configuration_lock);
+	mutex_lock(&adpt_configuration_lock);
 
 	if(hba_chain != NULL){
 		for(p = hba_chain; p->next; p = p->next);
@@ -971,7 +972,7 @@ static int adpt_install_hba(struct scsi_
 	sprintf(pHba->name, "dpti%d", hba_count);
 	hba_count++;
 	
-	up(&adpt_configuration_lock);
+	mutex_unlock(&adpt_configuration_lock);
 
 	pHba->pDev = pDev;
 	pHba->base_addr_phys = base_addr0_phys;
@@ -1027,7 +1028,7 @@ static void adpt_i2o_delete_hba(adpt_hba
 	struct adpt_device* pNext;
 
 
-	down(&adpt_configuration_lock);
+	mutex_lock(&adpt_configuration_lock);
 	// scsi_unregister calls our adpt_release which
 	// does a quiese
 	if(pHba->host){
@@ -1046,7 +1047,7 @@ static void adpt_i2o_delete_hba(adpt_hba
 	}
 
 	hba_count--;
-	up(&adpt_configuration_lock);
+	mutex_unlock(&adpt_configuration_lock);
 
 	iounmap(pHba->base_addr_virt);
 	pci_release_regions(pHba->pDev);
@@ -1549,7 +1550,7 @@ static int adpt_i2o_parse_lct(adpt_hba* 
  
 static int adpt_i2o_install_device(adpt_hba* pHba, struct i2o_device *d)
 {
-	down(&adpt_configuration_lock);
+	mutex_lock(&adpt_configuration_lock);
 	d->controller=pHba;
 	d->owner=NULL;
 	d->next=pHba->devices;
@@ -1560,7 +1561,7 @@ static int adpt_i2o_install_device(adpt_
 	pHba->devices=d;
 	*d->dev_name = 0;
 
-	up(&adpt_configuration_lock);
+	mutex_unlock(&adpt_configuration_lock);
 	return 0;
 }
 
@@ -1575,24 +1576,24 @@ static int adpt_open(struct inode *inode
 	if (minor >= hba_count) {
 		return -ENXIO;
 	}
-	down(&adpt_configuration_lock);
+	mutex_lock(&adpt_configuration_lock);
 	for (pHba = hba_chain; pHba; pHba = pHba->next) {
 		if (pHba->unit == minor) {
 			break;	/* found adapter */
 		}
 	}
 	if (pHba == NULL) {
-		up(&adpt_configuration_lock);
+		mutex_unlock(&adpt_configuration_lock);
 		return -ENXIO;
 	}
 
 //	if(pHba->in_use){
-	//	up(&adpt_configuration_lock);
+	//	mutex_unlock(&adpt_configuration_lock);
 //		return -EBUSY;
 //	}
 
 	pHba->in_use = 1;
-	up(&adpt_configuration_lock);
+	mutex_unlock(&adpt_configuration_lock);
 
 	return 0;
 }
@@ -1606,13 +1607,13 @@ static int adpt_close(struct inode *inod
 	if (minor >= hba_count) {
 		return -ENXIO;
 	}
-	down(&adpt_configuration_lock);
+	mutex_lock(&adpt_configuration_lock);
 	for (pHba = hba_chain; pHba; pHba = pHba->next) {
 		if (pHba->unit == minor) {
 			break;	/* found adapter */
 		}
 	}
-	up(&adpt_configuration_lock);
+	mutex_unlock(&adpt_configuration_lock);
 	if (pHba == NULL) {
 		return -ENXIO;
 	}
@@ -1910,13 +1911,13 @@ static int adpt_ioctl(struct inode *inod
 	if (minor >= DPTI_MAX_HBA){
 		return -ENXIO;
 	}
-	down(&adpt_configuration_lock);
+	mutex_lock(&adpt_configuration_lock);
 	for (pHba = hba_chain; pHba; pHba = pHba->next) {
 		if (pHba->unit == minor) {
 			break;	/* found adapter */
 		}
 	}
-	up(&adpt_configuration_lock);
+	mutex_unlock(&adpt_configuration_lock);
 	if(pHba == NULL){
 		return -ENXIO;
 	}
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/ide-scsi.c linux-2.6.15-rc6-mutex-new/drivers/scsi/ide-scsi.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/ide-scsi.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/ide-scsi.c	2005-12-20 10:48:30.000000000 +0100
@@ -47,6 +47,7 @@
 #include <linux/ide.h>
 #include <linux/scatterlist.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -109,7 +110,7 @@ typedef struct ide_scsi_obj {
 	unsigned long log;			/* log flags */
 } idescsi_scsi_t;
 
-static DECLARE_MUTEX(idescsi_ref_sem);
+static DEFINE_MUTEX(idescsi_ref_mutex);
 
 #define ide_scsi_g(disk) \
 	container_of((disk)->private_data, struct ide_scsi_obj, driver)
@@ -118,19 +119,19 @@ static struct ide_scsi_obj *ide_scsi_get
 {
 	struct ide_scsi_obj *scsi = NULL;
 
-	down(&idescsi_ref_sem);
+	mutex_lock(&idescsi_ref_mutex);
 	scsi = ide_scsi_g(disk);
 	if (scsi)
 		scsi_host_get(scsi->host);
-	up(&idescsi_ref_sem);
+	mutex_unlock(&idescsi_ref_mutex);
 	return scsi;
 }
 
 static void ide_scsi_put(struct ide_scsi_obj *scsi)
 {
-	down(&idescsi_ref_sem);
+	mutex_lock(&idescsi_ref_mutex);
 	scsi_host_put(scsi->host);
-	up(&idescsi_ref_sem);
+	mutex_unlock(&idescsi_ref_mutex);
 }
 
 static inline idescsi_scsi_t *scsihost_to_idescsi(struct Scsi_Host *host)
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/megaraid/megaraid_sas.c linux-2.6.15-rc6-mutex-new/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/megaraid/megaraid_sas.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/megaraid/megaraid_sas.c	2005-12-20 10:48:30.000000000 +0100
@@ -35,6 +35,7 @@
 #include <asm/uaccess.h>
 #include <linux/fs.h>
 #include <linux/compat.h>
+#include <linux/mutex.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -72,7 +73,7 @@ MODULE_DEVICE_TABLE(pci, megasas_pci_tab
 static int megasas_mgmt_majorno;
 static struct megasas_mgmt_info megasas_mgmt_info;
 static struct fasync_struct *megasas_async_queue;
-static DECLARE_MUTEX(megasas_async_queue_mutex);
+static DEFINE_MUTEX(megasas_async_queue_mutex);
 
 /**
  * megasas_get_cmd -	Get a command from the free pool
@@ -2362,11 +2363,11 @@ static int megasas_mgmt_fasync(int fd, s
 {
 	int rc;
 
-	down(&megasas_async_queue_mutex);
+	mutex_lock(&megasas_async_queue_mutex);
 
 	rc = fasync_helper(fd, filep, mode, &megasas_async_queue);
 
-	up(&megasas_async_queue_mutex);
+	mutex_unlock(&megasas_async_queue_mutex);
 
 	if (rc >= 0) {
 		/* For sanity check when we get ioctl */
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/scsi.c linux-2.6.15-rc6-mutex-new/drivers/scsi/scsi.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/scsi.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/scsi.c	2005-12-20 10:48:30.000000000 +0100
@@ -55,6 +55,7 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/mutex.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -210,7 +211,7 @@ static struct scsi_host_cmd_pool scsi_cm
 	.gfp_mask	= __GFP_DMA,
 };
 
-static DECLARE_MUTEX(host_cmd_pool_mutex);
+static DEFINE_MUTEX(host_cmd_pool_mutex);
 
 static struct scsi_cmnd *__scsi_get_command(struct Scsi_Host *shost,
 					    gfp_t gfp_mask)
@@ -331,7 +332,7 @@ int scsi_setup_command_freelist(struct S
 	 * Select a command slab for this host and create it if not
 	 * yet existant.
 	 */
-	down(&host_cmd_pool_mutex);
+	mutex_lock(&host_cmd_pool_mutex);
 	pool = (shost->unchecked_isa_dma ? &scsi_cmd_dma_pool : &scsi_cmd_pool);
 	if (!pool->users) {
 		pool->slab = kmem_cache_create(pool->name,
@@ -343,7 +344,7 @@ int scsi_setup_command_freelist(struct S
 
 	pool->users++;
 	shost->cmd_pool = pool;
-	up(&host_cmd_pool_mutex);
+	mutex_unlock(&host_cmd_pool_mutex);
 
 	/*
 	 * Get one backup command for this host.
@@ -360,7 +361,7 @@ int scsi_setup_command_freelist(struct S
 		kmem_cache_destroy(pool->slab);
 	return -ENOMEM;
  fail:
-	up(&host_cmd_pool_mutex);
+	mutex_unlock(&host_cmd_pool_mutex);
 	return -ENOMEM;
 
 }
@@ -382,10 +383,10 @@ void scsi_destroy_command_freelist(struc
 		kmem_cache_free(shost->cmd_pool->slab, cmd);
 	}
 
-	down(&host_cmd_pool_mutex);
+	mutex_lock(&host_cmd_pool_mutex);
 	if (!--shost->cmd_pool->users)
 		kmem_cache_destroy(shost->cmd_pool->slab);
-	up(&host_cmd_pool_mutex);
+	mutex_unlock(&host_cmd_pool_mutex);
 }
 
 #ifdef CONFIG_SCSI_LOGGING
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/scsi_proc.c linux-2.6.15-rc6-mutex-new/drivers/scsi/scsi_proc.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/scsi_proc.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/scsi_proc.c	2005-12-20 10:48:30.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/blkdev.h>
 #include <linux/seq_file.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi.h>
@@ -41,7 +42,7 @@
 static struct proc_dir_entry *proc_scsi;
 
 /* Protect sht->present and sht->proc_dir */
-static DECLARE_MUTEX(global_host_template_sem);
+static DEFINE_MUTEX(global_host_template_mutex);
 
 static int proc_scsi_read(char *buffer, char **start, off_t offset,
 			  int length, int *eof, void *data)
@@ -83,7 +84,7 @@ void scsi_proc_hostdir_add(struct scsi_h
 	if (!sht->proc_info)
 		return;
 
-	down(&global_host_template_sem);
+	mutex_lock(&global_host_template_mutex);
 	if (!sht->present++) {
 		sht->proc_dir = proc_mkdir(sht->proc_name, proc_scsi);
         	if (!sht->proc_dir)
@@ -92,7 +93,7 @@ void scsi_proc_hostdir_add(struct scsi_h
 		else
 			sht->proc_dir->owner = sht->module;
 	}
-	up(&global_host_template_sem);
+	mutex_unlock(&global_host_template_mutex);
 }
 
 void scsi_proc_hostdir_rm(struct scsi_host_template *sht)
@@ -100,12 +101,12 @@ void scsi_proc_hostdir_rm(struct scsi_ho
 	if (!sht->proc_info)
 		return;
 
-	down(&global_host_template_sem);
+	mutex_lock(&global_host_template_mutex);
 	if (!--sht->present && sht->proc_dir) {
 		remove_proc_entry(sht->proc_name, proc_scsi);
 		sht->proc_dir = NULL;
 	}
-	up(&global_host_template_sem);
+	mutex_unlock(&global_host_template_mutex);
 }
 
 void scsi_proc_host_add(struct Scsi_Host *shost)
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/scsi_transport_iscsi.c linux-2.6.15-rc6-mutex-new/drivers/scsi/scsi_transport_iscsi.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/scsi_transport_iscsi.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/scsi_transport_iscsi.c	2005-12-20 10:48:30.000000000 +0100
@@ -24,6 +24,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/mempool.h>
+#include <linux/mutex.h>
 #include <net/tcp.h>
 
 #include <scsi/scsi.h>
@@ -46,7 +47,7 @@ struct iscsi_internal {
 	struct list_head sessions;
 	/*
 	 * lock to serialize access to the sessions list which must
-	 * be taken after the rx_queue_sema
+	 * be taken after the rx_queue_mutex
 	 */
 	spinlock_t session_lock;
 	/*
@@ -70,7 +71,7 @@ struct iscsi_internal {
 /*
  * list of registered transports and lock that must
  * be held while accessing list. The iscsi_transport_lock must
- * be acquired after the rx_queue_sema.
+ * be acquired after the rx_queue_mutex.
  */
 static LIST_HEAD(iscsi_transports);
 static DEFINE_SPINLOCK(iscsi_transport_lock);
@@ -145,7 +146,7 @@ static DECLARE_TRANSPORT_CLASS(iscsi_con
 
 static struct sock *nls;
 static int daemon_pid;
-static DECLARE_MUTEX(rx_queue_sema);
+static DEFINE_MUTEX(rx_queue_mutex);
 
 struct mempool_zone {
 	mempool_t *pool;
@@ -881,7 +882,7 @@ iscsi_if_rx(struct sock *sk, int len)
 {
 	struct sk_buff *skb;
 
-	down(&rx_queue_sema);
+	mutex_lock(&rx_queue_mutex);
 	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
 		while (skb->len >= NLMSG_SPACE(0)) {
 			int err;
@@ -923,7 +924,7 @@ iscsi_if_rx(struct sock *sk, int len)
 		}
 		kfree_skb(skb);
 	}
-	up(&rx_queue_sema);
+	mutex_unlock(&rx_queue_mutex);
 }
 
 /*
@@ -1159,7 +1160,7 @@ int iscsi_unregister_transport(struct is
 
 	BUG_ON(!tt);
 
-	down(&rx_queue_sema);
+	mutex_lock(&rx_queue_mutex);
 
 	priv = iscsi_if_transport_lookup(tt);
 	BUG_ON (!priv);
@@ -1167,7 +1168,7 @@ int iscsi_unregister_transport(struct is
 	spin_lock_irqsave(&priv->session_lock, flags);
 	if (!list_empty(&priv->sessions)) {
 		spin_unlock_irqrestore(&priv->session_lock, flags);
-		up(&rx_queue_sema);
+		mutex_unlock(&rx_queue_mutex);
 		return -EPERM;
 	}
 	spin_unlock_irqrestore(&priv->session_lock, flags);
@@ -1181,7 +1182,7 @@ int iscsi_unregister_transport(struct is
 
 	sysfs_remove_group(&priv->cdev.kobj, &iscsi_transport_group);
 	class_device_unregister(&priv->cdev);
-	up(&rx_queue_sema);
+	mutex_unlock(&rx_queue_mutex);
 
 	return 0;
 }
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/sd.c linux-2.6.15-rc6-mutex-new/drivers/scsi/sd.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/sd.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/sd.c	2005-12-20 10:48:30.000000000 +0100
@@ -49,6 +49,7 @@
 #include <linux/blkpg.h>
 #include <linux/kref.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi.h>
@@ -110,7 +111,7 @@ static DEFINE_SPINLOCK(sd_index_lock);
 /* This semaphore is used to mediate the 0->1 reference get in the
  * face of object destruction (i.e. we can't allow a get on an
  * object after last put) */
-static DECLARE_MUTEX(sd_ref_sem);
+static DEFINE_MUTEX(sd_ref_mutex);
 
 static int sd_revalidate_disk(struct gendisk *disk);
 static void sd_rw_intr(struct scsi_cmnd * SCpnt);
@@ -195,9 +196,9 @@ static struct scsi_disk *scsi_disk_get(s
 {
 	struct scsi_disk *sdkp;
 
-	down(&sd_ref_sem);
+	mutex_lock(&sd_ref_mutex);
 	sdkp = __scsi_disk_get(disk);
-	up(&sd_ref_sem);
+	mutex_unlock(&sd_ref_mutex);
 	return sdkp;
 }
 
@@ -205,11 +206,11 @@ static struct scsi_disk *scsi_disk_get_f
 {
 	struct scsi_disk *sdkp;
 
-	down(&sd_ref_sem);
+	mutex_lock(&sd_ref_mutex);
 	sdkp = dev_get_drvdata(dev);
 	if (sdkp)
 		sdkp = __scsi_disk_get(sdkp->disk);
-	up(&sd_ref_sem);
+	mutex_unlock(&sd_ref_mutex);
 	return sdkp;
 }
 
@@ -217,10 +218,10 @@ static void scsi_disk_put(struct scsi_di
 {
 	struct scsi_device *sdev = sdkp->device;
 
-	down(&sd_ref_sem);
+	mutex_lock(&sd_ref_mutex);
 	kref_put(&sdkp->kref, scsi_disk_release);
 	scsi_device_put(sdev);
-	up(&sd_ref_sem);
+	mutex_unlock(&sd_ref_mutex);
 }
 
 /**
@@ -1643,10 +1644,10 @@ static int sd_remove(struct device *dev)
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
 
-	down(&sd_ref_sem);
+	mutex_lock(&sd_ref_mutex);
 	dev_set_drvdata(dev, NULL);
 	kref_put(&sdkp->kref, scsi_disk_release);
-	up(&sd_ref_sem);
+	mutex_unlock(&sd_ref_mutex);
 
 	return 0;
 }
@@ -1655,7 +1656,7 @@ static int sd_remove(struct device *dev)
  *	scsi_disk_release - Called to free the scsi_disk structure
  *	@kref: pointer to embedded kref
  *
- *	sd_ref_sem must be held entering this routine.  Because it is
+ *	sd_ref_mutex must be held entering this routine.  Because it is
  *	called on last put, you should always use the scsi_disk_get()
  *	scsi_disk_put() helpers which manipulate the semaphore directly
  *	and never do a direct kref_put().
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/sr.c linux-2.6.15-rc6-mutex-new/drivers/scsi/sr.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/sr.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/sr.c	2005-12-20 10:48:30.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi.h>
@@ -90,7 +91,7 @@ static DEFINE_SPINLOCK(sr_index_lock);
 /* This semaphore is used to mediate the 0->1 reference get in the
  * face of object destruction (i.e. we can't allow a get on an
  * object after last put) */
-static DECLARE_MUTEX(sr_ref_sem);
+static DEFINE_MUTEX(sr_ref_mutex);
 
 static int sr_open(struct cdrom_device_info *, int);
 static void sr_release(struct cdrom_device_info *);
@@ -133,7 +134,7 @@ static inline struct scsi_cd *scsi_cd_ge
 {
 	struct scsi_cd *cd = NULL;
 
-	down(&sr_ref_sem);
+	mutex_lock(&sr_ref_mutex);
 	if (disk->private_data == NULL)
 		goto out;
 	cd = scsi_cd(disk);
@@ -146,7 +147,7 @@ static inline struct scsi_cd *scsi_cd_ge
 	kref_put(&cd->kref, sr_kref_release);
 	cd = NULL;
  out:
-	up(&sr_ref_sem);
+	mutex_unlock(&sr_ref_mutex);
 	return cd;
 }
 
@@ -154,10 +155,10 @@ static inline void scsi_cd_put(struct sc
 {
 	struct scsi_device *sdev = cd->device;
 
-	down(&sr_ref_sem);
+	mutex_lock(&sr_ref_mutex);
 	kref_put(&cd->kref, sr_kref_release);
 	scsi_device_put(sdev);
-	up(&sr_ref_sem);
+	mutex_unlock(&sr_ref_mutex);
 }
 
 /*
@@ -845,7 +846,7 @@ static int sr_packet(struct cdrom_device
  *	sr_kref_release - Called to free the scsi_cd structure
  *	@kref: pointer to embedded kref
  *
- *	sr_ref_sem must be held entering this routine.  Because it is
+ *	sr_ref_mutex must be held entering this routine.  Because it is
  *	called on last put, you should always use the scsi_cd_get()
  *	scsi_cd_put() helpers which manipulate the semaphore directly
  *	and never do a direct kref_put().
@@ -874,9 +875,9 @@ static int sr_remove(struct device *dev)
 
 	del_gendisk(cd->disk);
 
-	down(&sr_ref_sem);
+	mutex_lock(&sr_ref_mutex);
 	kref_put(&cd->kref, sr_kref_release);
-	up(&sr_ref_sem);
+	mutex_unlock(&sr_ref_mutex);
 
 	return 0;
 }
diff -purN linux-2.6.15-rc6-mutex/drivers/scsi/st.c linux-2.6.15-rc6-mutex-new/drivers/scsi/st.c
--- linux-2.6.15-rc6-mutex/drivers/scsi/st.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/scsi/st.c	2005-12-20 10:48:30.000000000 +0100
@@ -38,6 +38,7 @@ static char *verstr = "20050830";
 #include <linux/devfs_fs_kernel.h>
 #include <linux/cdev.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 #include <asm/dma.h>
@@ -223,7 +224,7 @@ static void scsi_tape_release(struct kre
 
 #define to_scsi_tape(obj) container_of(obj, struct scsi_tape, kref)
 
-static DECLARE_MUTEX(st_ref_sem);
+static DEFINE_MUTEX(st_ref_mutex);
 
 
 #include "osst_detect.h"
@@ -240,7 +241,7 @@ static struct scsi_tape *scsi_tape_get(i
 {
 	struct scsi_tape *STp = NULL;
 
-	down(&st_ref_sem);
+	mutex_lock(&st_ref_mutex);
 	write_lock(&st_dev_arr_lock);
 
 	if (dev < st_dev_max && scsi_tapes != NULL)
@@ -262,7 +263,7 @@ out_put:
 	STp = NULL;
 out:
 	write_unlock(&st_dev_arr_lock);
-	up(&st_ref_sem);
+	mutex_unlock(&st_ref_mutex);
 	return STp;
 }
 
@@ -270,10 +271,10 @@ static void scsi_tape_put(struct scsi_ta
 {
 	struct scsi_device *sdev = STp->device;
 
-	down(&st_ref_sem);
+	mutex_lock(&st_ref_mutex);
 	kref_put(&STp->kref, scsi_tape_release);
 	scsi_device_put(sdev);
-	up(&st_ref_sem);
+	mutex_unlock(&st_ref_mutex);
 }
 
 struct st_reject_data {
@@ -4144,9 +4145,9 @@ static int st_remove(struct device *dev)
 				}
 			}
 
-			down(&st_ref_sem);
+			mutex_lock(&st_ref_mutex);
 			kref_put(&tpnt->kref, scsi_tape_release);
-			up(&st_ref_sem);
+			mutex_unlock(&st_ref_mutex);
 			return 0;
 		}
 	}
@@ -4159,7 +4160,7 @@ static int st_remove(struct device *dev)
  *      scsi_tape_release - Called to free the Scsi_Tape structure
  *      @kref: pointer to embedded kref
  *
- *      st_ref_sem must be held entering this routine.  Because it is
+ *      st_ref_mutex must be held entering this routine.  Because it is
  *      called on last put, you should always use the scsi_tape_get()
  *      scsi_tape_put() helpers which manipulate the semaphore directly
  *      and never do a direct kref_put().
diff -purN linux-2.6.15-rc6-mutex/drivers/serial/8250.c linux-2.6.15-rc6-mutex-new/drivers/serial/8250.c
--- linux-2.6.15-rc6-mutex/drivers/serial/8250.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/serial/8250.c	2005-12-20 10:48:30.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
 #include <linux/nmi.h>
+#include <linux/mutex.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -2480,7 +2481,7 @@ static struct platform_device *serial825
  * 16x50 serial ports to be configured at run-time, to support PCMCIA
  * modems and PCI multiport cards.
  */
-static DECLARE_MUTEX(serial_sem);
+static DEFINE_MUTEX(serial_mutex);
 
 static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *port)
 {
@@ -2535,7 +2536,7 @@ int serial8250_register_port(struct uart
 	if (port->uartclk == 0)
 		return -EINVAL;
 
-	down(&serial_sem);
+	mutex_lock(&serial_mutex);
 
 	uart = serial8250_find_match_or_unused(port);
 	if (uart) {
@@ -2557,7 +2558,7 @@ int serial8250_register_port(struct uart
 		if (ret == 0)
 			ret = uart->port.line;
 	}
-	up(&serial_sem);
+	mutex_unlock(&serial_mutex);
 
 	return ret;
 }
@@ -2574,7 +2575,7 @@ void serial8250_unregister_port(int line
 {
 	struct uart_8250_port *uart = &serial8250_ports[line];
 
-	down(&serial_sem);
+	mutex_lock(&serial_mutex);
 	uart_remove_one_port(&serial8250_reg, &uart->port);
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
@@ -2584,7 +2585,7 @@ void serial8250_unregister_port(int line
 	} else {
 		uart->port.dev = NULL;
 	}
-	up(&serial_sem);
+	mutex_unlock(&serial_mutex);
 }
 EXPORT_SYMBOL(serial8250_unregister_port);
 
diff -purN linux-2.6.15-rc6-mutex/drivers/serial/crisv10.c linux-2.6.15-rc6-mutex-new/drivers/serial/crisv10.c
--- linux-2.6.15-rc6-mutex/drivers/serial/crisv10.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/serial/crisv10.c	2005-12-20 10:48:30.000000000 +0100
@@ -442,6 +442,7 @@ static char *serial_version = "$Revision
 #include <linux/init.h>
 #include <asm/uaccess.h>
 #include <linux/kernel.h>
+#include <linux/mutex.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1315,11 +1316,7 @@ static const struct control_pins e100_mo
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf;
-#ifdef DECLARE_MUTEX
-static DECLARE_MUTEX(tmp_buf_sem);
-#else
-static struct semaphore tmp_buf_sem = MUTEX;
-#endif
+static DEFINE_MUTEX(tmp_buf_mutex);
 
 /* Calculate the chartime depending on baudrate, numbor of bits etc. */
 static void update_char_time(struct e100_serial * info)
@@ -3661,7 +3658,7 @@ rs_raw_write(struct tty_struct * tty, in
 	 * design.
 	 */
 	if (from_user) {
-		down(&tmp_buf_sem);
+		mutex_lock(&tmp_buf_mutex);
 		while (1) {
 			int c1;
 			c = CIRC_SPACE_TO_END(info->xmit.head,
@@ -3692,7 +3689,7 @@ rs_raw_write(struct tty_struct * tty, in
 			count -= c;
 			ret += c;
 		}
-		up(&tmp_buf_sem);
+		mutex_unlock(&tmp_buf_mutex);
 	} else {
 		cli();
 		while (count) {
diff -purN linux-2.6.15-rc6-mutex/drivers/serial/pmac_zilog.c linux-2.6.15-rc6-mutex-new/drivers/serial/pmac_zilog.c
--- linux-2.6.15-rc6-mutex/drivers/serial/pmac_zilog.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-mutex-new/drivers/serial/pmac_zilog.c	2005-12-20 10:48:30.000000000 +0100
@@ -60,6 +60,7 @@
 #include <linux/pmu.h>
 #include <linux/bitops.h>
 #include <linux/sysrq.h>
+#include <linux/mutex.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -96,7 +97,7 @@ MODULE_LICENSE("GPL");
  */
 static struct uart_pmac_port	pmz_ports[MAX_ZS_PORTS];
 static int			pmz_ports_count;
-static DECLARE_MUTEX(pmz_irq_sem);
+static DEFINE_MUTEX(pmz_irq_mutex);
 
 static struct uart_driver pmz_uart_reg = {
 	.owner		=	THIS_MODULE,
@@ -945,7 +946,7 @@ static int pmz_startup(struct uart_port 
 	if (uap->node == NULL)
 		return -ENODEV;
 
-	down(&pmz_irq_sem);
+	mutex_lock(&pmz_irq_mutex);
 
 	uap->flags |= PMACZILOG_FLAG_IS_OPEN;
 
@@ -963,11 +964,11 @@ static int pmz_startup(struct uart_port 
 		dev_err(&uap->dev->ofdev.dev,
 			"Unable to register zs interrupt handler.\n");
 		pmz_set_scc_power(uap, 0);
-		up(&pmz_irq_sem);
+		mutex_unlock(&pmz_irq_mutex);
 		return -ENXIO;
 	}
 
-	up(&pmz_irq_sem);
+	mutex_unlock(&pmz_irq_mutex);
 
 	/* Right now, we deal with delay by blocking here, I'll be
 	 * smarter later on
@@ -1004,7 +1005,7 @@ static void pmz_shutdown(struct uart_por
 	if (uap->node == NULL)
 		return;
 
-	down(&pmz_irq_sem);
+	mutex_lock(&pmz_irq_mutex);
 
 	/* Release interrupt handler */
        	free_irq(uap->port.irq, uap);
@@ -1025,7 +1026,7 @@ static void pmz_shutdown(struct uart_por
 
 	if (ZS_IS_CONS(uap) || ZS_IS_ASLEEP(uap)) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		up(&pmz_irq_sem);
+		mutex_unlock(&pmz_irq_mutex);
 		return;
 	}
 
@@ -1042,7 +1043,7 @@ static void pmz_shutdown(struct uart_por
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	up(&pmz_irq_sem);
+	mutex_unlock(&pmz_irq_mutex);
 
 	pmz_debug("pmz: shutdown() done.\n");
 }
@@ -1607,7 +1608,7 @@ static int pmz_suspend(struct macio_dev 
 
 	state = pmz_uart_reg.state + uap->port.line;
 
-	down(&pmz_irq_sem);
+	mutex_lock(&pmz_irq_mutex);
 	down(&state->sem);
 
 	spin_lock_irqsave(&uap->port.lock, flags);
@@ -1640,7 +1641,7 @@ static int pmz_suspend(struct macio_dev 
 	pmz_set_scc_power(uap, 0);
 
 	up(&state->sem);
-	up(&pmz_irq_sem);
+	mutex_unlock(&pmz_irq_mutex);
 
 	pmz_debug("suspend, switching complete\n");
 
@@ -1667,7 +1668,7 @@ static int pmz_resume(struct macio_dev *
 
 	state = pmz_uart_reg.state + uap->port.line;
 
-	down(&pmz_irq_sem);
+	mutex_lock(&pmz_irq_mutex);
 	down(&state->sem);
 
 	spin_lock_irqsave(&uap->port.lock, flags);
@@ -1701,7 +1702,7 @@ static int pmz_resume(struct macio_dev *
 
  bail:
 	up(&state->sem);
-	up(&pmz_irq_sem);
+	mutex_unlock(&pmz_irq_mutex);
 
 	/* Right now, we deal with delay by blocking here, I'll be
 	 * smarter later on
diff -purN linux-2.6.15-rc6-mutex/drivers/serial/serial_core.c linux-2.6.15-rc6-mutex-new/drivers/serial/serial_core.c
--- linux-2.6.15-rc6-mutex/drivers/serial/serial_core.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/serial/serial_core.c	2005-12-20 10:48:30.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/device.h>
 #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
 #include <linux/delay.h>
+#include <linux/mutex.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -47,7 +48,7 @@
 /*
  * This is used to lock changes in serial line configuration.
  */
-static DECLARE_MUTEX(port_sem);
+static DEFINE_MUTEX(port_mutex);
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
@@ -1471,7 +1472,7 @@ static struct uart_state *uart_get(struc
 {
 	struct uart_state *state;
 
-	down(&port_sem);
+	mutex_lock(&port_mutex);
 	state = drv->state + line;
 	if (down_interruptible(&state->sem)) {
 		state = ERR_PTR(-ERESTARTSYS);
@@ -1508,7 +1509,7 @@ static struct uart_state *uart_get(struc
 	}
 
  out:
-	up(&port_sem);
+	mutex_unlock(&port_mutex);
 	return state;
 }
 
@@ -2218,7 +2219,7 @@ int uart_add_one_port(struct uart_driver
 
 	state = drv->state + port->line;
 
-	down(&port_sem);
+	mutex_lock(&port_mutex);
 	if (state->port) {
 		ret = -EINVAL;
 		goto out;
@@ -2254,7 +2255,7 @@ int uart_add_one_port(struct uart_driver
 		register_console(port->cons);
 
  out:
-	up(&port_sem);
+	mutex_unlock(&port_mutex);
 
 	return ret;
 }
@@ -2278,7 +2279,7 @@ int uart_remove_one_port(struct uart_dri
 		printk(KERN_ALERT "Removing wrong port: %p != %p\n",
 			state->port, port);
 
-	down(&port_sem);
+	mutex_lock(&port_mutex);
 
 	/*
 	 * Remove the devices from devfs
@@ -2287,7 +2288,7 @@ int uart_remove_one_port(struct uart_dri
 
 	uart_unconfigure_port(drv, state);
 	state->port = NULL;
-	up(&port_sem);
+	mutex_unlock(&port_mutex);
 
 	return 0;
 }
diff -purN linux-2.6.15-rc6-mutex/drivers/serial/serial_txx9.c linux-2.6.15-rc6-mutex-new/drivers/serial/serial_txx9.c
--- linux-2.6.15-rc6-mutex/drivers/serial/serial_txx9.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-mutex-new/drivers/serial/serial_txx9.c	2005-12-20 10:48:30.000000000 +0100
@@ -52,6 +52,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
+#include <linux/mutex.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1029,7 +1030,7 @@ static void serial_txx9_resume_port(int 
 	uart_resume_port(&serial_txx9_reg, &serial_txx9_ports[line].port);
 }
 
-static DECLARE_MUTEX(serial_txx9_sem);
+static DEFINE_MUTEX(serial_txx9_mutex);
 
 /**
  *	serial_txx9_register_port - register a serial port
@@ -1048,7 +1049,7 @@ static int __devinit serial_txx9_registe
 	struct uart_txx9_port *uart;
 	int ret = -ENOSPC;
 
-	down(&serial_txx9_sem);
+	mutex_lock(&serial_txx9_mutex);
 	for (i = 0; i < UART_NR; i++) {
 		uart = &serial_txx9_ports[i];
 		if (uart->port.type == PORT_UNKNOWN)
@@ -1069,7 +1070,7 @@ static int __devinit serial_txx9_registe
 		if (ret == 0)
 			ret = uart->port.line;
 	}
-	up(&serial_txx9_sem);
+	mutex_unlock(&serial_txx9_mutex);
 	return ret;
 }
 
@@ -1084,7 +1085,7 @@ static void __devexit serial_txx9_unregi
 {
 	struct uart_txx9_port *uart = &serial_txx9_ports[line];
 
-	down(&serial_txx9_sem);
+	mutex_lock(&serial_txx9_mutex);
 	uart_remove_one_port(&serial_txx9_reg, &uart->port);
 	uart->port.flags = 0;
 	uart->port.type = PORT_UNKNOWN;
@@ -1093,7 +1094,7 @@ static void __devexit serial_txx9_unregi
 	uart->port.membase = 0;
 	uart->port.dev = NULL;
 	uart_add_one_port(&serial_txx9_reg, &uart->port);
-	up(&serial_txx9_sem);
+	mutex_unlock(&serial_txx9_mutex);
 }
 
 /*
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/class/cdc-acm.c linux-2.6.15-rc6-mutex-new/drivers/usb/class/cdc-acm.c
--- linux-2.6.15-rc6-mutex/drivers/usb/class/cdc-acm.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/class/cdc-acm.c	2005-12-20 10:48:30.000000000 +0100
@@ -58,6 +58,7 @@
 #include <linux/tty_flip.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
 #include <linux/usb_cdc.h>
@@ -77,7 +78,7 @@ static struct usb_driver acm_driver;
 static struct tty_driver *acm_tty_driver;
 static struct acm *acm_table[ACM_TTY_MINORS];
 
-static DECLARE_MUTEX(open_sem);
+static DEFINE_MUTEX(open_mutex);
 
 #define ACM_READY(acm)	(acm && acm->dev && acm->used)
 
@@ -371,7 +372,7 @@ static int acm_tty_open(struct tty_struc
 	int rv = -EINVAL;
 	dbg("Entering acm_tty_open.\n");
 	
-	down(&open_sem);
+	mutex_lock(&open_mutex);
 
 	acm = acm_table[tty->index];
 	if (!acm || !acm->dev)
@@ -409,7 +410,7 @@ static int acm_tty_open(struct tty_struc
 
 done:
 err_out:
-	up(&open_sem);
+	mutex_unlock(&open_mutex);
 	return rv;
 
 full_bailout:
@@ -418,7 +419,7 @@ bail_out_and_unlink:
 	usb_kill_urb(acm->ctrlurb);
 bail_out:
 	acm->used--;
-	up(&open_sem);
+	mutex_unlock(&open_mutex);
 	return -EIO;
 }
 
@@ -440,7 +441,7 @@ static void acm_tty_close(struct tty_str
 	if (!acm || !acm->used)
 		return;
 
-	down(&open_sem);
+	mutex_lock(&open_mutex);
 	if (!--acm->used) {
 		if (acm->dev) {
 			acm_set_control(acm, acm->ctrlout = 0);
@@ -450,7 +451,7 @@ static void acm_tty_close(struct tty_str
 		} else
 			acm_tty_unregister(acm);
 	}
-	up(&open_sem);
+	mutex_unlock(&open_mutex);
 }
 
 static int acm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -942,7 +943,7 @@ static void acm_disconnect(struct usb_in
 		return;
 	}
 
-	down(&open_sem);
+	mutex_lock(&open_mutex);
 	acm->dev = NULL;
 	usb_set_intfdata (intf, NULL);
 
@@ -960,11 +961,11 @@ static void acm_disconnect(struct usb_in
 
 	if (!acm->used) {
 		acm_tty_unregister(acm);
-		up(&open_sem);
+		mutex_unlock(&open_mutex);
 		return;
 	}
 
-	up(&open_sem);
+	mutex_unlock(&open_mutex);
 
 	if (acm->tty)
 		tty_hangup(acm->tty);
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/class/usblp.c linux-2.6.15-rc6-mutex-new/drivers/usb/class/usblp.c
--- linux-2.6.15-rc6-mutex/drivers/usb/class/usblp.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/class/usblp.c	2005-12-20 10:48:30.000000000 +0100
@@ -54,6 +54,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/lp.h>
+#include <linux/mutex.h>
 #undef DEBUG
 #include <linux/usb.h>
 
@@ -222,7 +223,7 @@ static int usblp_cache_device_id_string(
 
 /* forward reference to make our lives easier */
 static struct usb_driver usblp_driver;
-static DECLARE_MUTEX(usblp_sem);	/* locks the existence of usblp's */
+static DEFINE_MUTEX(usblp_mutex);	/* locks the existence of usblp's */
 
 /*
  * Functions for usblp control messages.
@@ -345,7 +346,7 @@ static int usblp_open(struct inode *inod
 	if (minor < 0)
 		return -ENODEV;
 
-	down (&usblp_sem);
+	mutex_lock (&usblp_mutex);
 
 	retval = -ENODEV;
 	intf = usb_find_interface(&usblp_driver, minor);
@@ -393,7 +394,7 @@ static int usblp_open(struct inode *inod
 		}
 	}
 out:
-	up (&usblp_sem);
+	mutex_unlock (&usblp_mutex);
 	return retval;
 }
 
@@ -419,13 +420,13 @@ static int usblp_release(struct inode *i
 {
 	struct usblp *usblp = file->private_data;
 
-	down (&usblp_sem);
+	mutex_lock (&usblp_mutex);
 	usblp->used = 0;
 	if (usblp->present) {
 		usblp_unlink_urbs(usblp);
 	} else 		/* finish cleanup from disconnect */
 		usblp_cleanup (usblp);
-	up (&usblp_sem);
+	mutex_unlock (&usblp_mutex);
 	return 0;
 }
 
@@ -1156,7 +1157,7 @@ static void usblp_disconnect(struct usb_
 		BUG ();
 	}
 
-	down (&usblp_sem);
+	mutex_lock (&usblp_mutex);
 	down (&usblp->sem);
 	usblp->present = 0;
 	usb_set_intfdata (intf, NULL);
@@ -1170,7 +1171,7 @@ static void usblp_disconnect(struct usb_
 
 	if (!usblp->used)
 		usblp_cleanup (usblp);
-	up (&usblp_sem);
+	mutex_unlock (&usblp_mutex);
 }
 
 static struct usb_device_id usblp_ids [] = {
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/core/hub.c linux-2.6.15-rc6-mutex-new/drivers/usb/core/hub.c
--- linux-2.6.15-rc6-mutex/drivers/usb/core/hub.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/core/hub.c	2005-12-20 10:48:30.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/kthread.h>
+#include <linux/mutex.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -2107,7 +2108,7 @@ static int
 hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port1,
 		int retry_counter)
 {
-	static DECLARE_MUTEX(usb_address0_sem);
+	static DEFINE_MUTEX(usb_address0_mutex);
 
 	struct usb_device	*hdev = hub->hdev;
 	int			i, j, retval;
@@ -2128,7 +2129,7 @@ hub_port_init (struct usb_hub *hub, stru
 	if (oldspeed == USB_SPEED_LOW)
 		delay = HUB_LONG_RESET_TIME;
 
-	down(&usb_address0_sem);
+	mutex_lock(&usb_address0_mutex);
 
 	/* Reset the device; full speed may morph to high speed */
 	retval = hub_port_reset(hub, port1, udev, delay);
@@ -2326,7 +2327,7 @@ hub_port_init (struct usb_hub *hub, stru
 fail:
 	if (retval)
 		hub_port_disable(hub, port1, 0);
-	up(&usb_address0_sem);
+	mutex_unlock(&usb_address0_mutex);
 	return retval;
 }
 
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/core/notify.c linux-2.6.15-rc6-mutex-new/drivers/usb/core/notify.c
--- linux-2.6.15-rc6-mutex/drivers/usb/core/notify.c	2005-12-20 09:19:26.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/core/notify.c	2005-12-20 10:48:30.000000000 +0100
@@ -13,16 +13,17 @@
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <linux/usb.h>
+#include <linux/mutex.h>
 #include "usb.h"
 
 
 static struct notifier_block *usb_notifier_list;
-static DECLARE_MUTEX(usb_notifier_lock);
+static DEFINE_MUTEX(usb_notifier_lock);
 
 static void usb_notifier_chain_register(struct notifier_block **list,
 					struct notifier_block *n)
 {
-	down(&usb_notifier_lock);
+	mutex_lock(&usb_notifier_lock);
 	while (*list) {
 		if (n->priority > (*list)->priority)
 			break;
@@ -30,13 +31,13 @@ static void usb_notifier_chain_register(
 	}
 	n->next = *list;
 	*list = n;
-	up(&usb_notifier_lock);
+	mutex_unlock(&usb_notifier_lock);
 }
 
 static void usb_notifier_chain_unregister(struct notifier_block **nl,
 				   struct notifier_block *n)
 {
-	down(&usb_notifier_lock);
+	mutex_lock(&usb_notifier_lock);
 	while ((*nl)!=NULL) {
 		if ((*nl)==n) {
 			*nl = n->next;
@@ -45,7 +46,7 @@ static void usb_notifier_chain_unregiste
 		nl=&((*nl)->next);
 	}
 exit:
-	up(&usb_notifier_lock);
+	mutex_unlock(&usb_notifier_lock);
 }
 
 static int usb_notifier_call_chain(struct notifier_block **n,
@@ -54,7 +55,7 @@ static int usb_notifier_call_chain(struc
 	int ret=NOTIFY_DONE;
 	struct notifier_block *nb = *n;
 
-	down(&usb_notifier_lock);
+	mutex_lock(&usb_notifier_lock);
 	while (nb) {
 		ret = nb->notifier_call(nb,val,v);
 		if (ret&NOTIFY_STOP_MASK) {
@@ -63,7 +64,7 @@ static int usb_notifier_call_chain(struc
 		nb = nb->next;
 	}
 exit:
-	up(&usb_notifier_lock);
+	mutex_unlock(&usb_notifier_lock);
 	return ret;
 }
 
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/input/ati_remote.c linux-2.6.15-rc6-mutex-new/drivers/usb/input/ati_remote.c
--- linux-2.6.15-rc6-mutex/drivers/usb/input/ati_remote.c	2005-12-20 09:19:27.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/input/ati_remote.c	2005-12-20 10:48:30.000000000 +0100
@@ -158,8 +158,6 @@ static char accel[] = { 1, 2, 4, 6, 9, 1
  */
 #define FILTER_TIME (HZ / 20)
 
-static DECLARE_MUTEX(disconnect_sem);
-
 struct ati_remote {
 	struct input_dev *idev;
 	struct usb_device *udev;
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/misc/idmouse.c linux-2.6.15-rc6-mutex-new/drivers/usb/misc/idmouse.c
--- linux-2.6.15-rc6-mutex/drivers/usb/misc/idmouse.c	2005-12-20 09:19:27.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/misc/idmouse.c	2005-12-20 10:48:30.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
 
@@ -122,7 +123,7 @@ static struct usb_driver idmouse_driver 
 };
 
 /* prevent races between open() and disconnect() */
-static DECLARE_MUTEX(disconnect_sem);
+static DEFINE_MUTEX(disconnect_mutex);
 
 static int idmouse_create_image(struct usb_idmouse *dev)
 {
@@ -214,18 +215,18 @@ static int idmouse_open(struct inode *in
 	int result = 0;
 
 	/* prevent disconnects */
-	down(&disconnect_sem);
+	mutex_lock(&disconnect_mutex);
 
 	/* get the interface from minor number and driver information */
 	interface = usb_find_interface (&idmouse_driver, iminor (inode));
 	if (!interface) {
-		up(&disconnect_sem);
+		mutex_unlock(&disconnect_mutex);
 		return -ENODEV;
 	}
 	/* get the device information block from the interface */
 	dev = usb_get_intfdata(interface);
 	if (!dev) {
-		up(&disconnect_sem);
+		mutex_unlock(&disconnect_mutex);
 		return -ENODEV;
 	}
 
@@ -259,7 +260,7 @@ error:
 	up(&dev->sem);
 
 	/* unlock the disconnect semaphore */
-	up(&disconnect_sem);
+	mutex_unlock(&disconnect_mutex);
 	return result;
 }
 
@@ -268,12 +269,12 @@ static int idmouse_release(struct inode 
 	struct usb_idmouse *dev;
 
 	/* prevent a race condition with open() */
-	down(&disconnect_sem);
+	mutex_lock(&disconnect_mutex);
 
 	dev = (struct usb_idmouse *) file->private_data;
 
 	if (dev == NULL) {
-		up(&disconnect_sem);
+		mutex_unlock(&disconnect_mutex);
 		return -ENODEV;
 	}
 
@@ -283,7 +284,7 @@ static int idmouse_release(struct inode 
 	/* are we really open? */
 	if (dev->open <= 0) {
 		up(&dev->sem);
-		up(&disconnect_sem);
+		mutex_unlock(&disconnect_mutex);
 		return -ENODEV;
 	}
 
@@ -293,12 +294,12 @@ static int idmouse_release(struct inode 
 		/* the device was unplugged before the file was released */
 		up(&dev->sem);
 		idmouse_delete(dev);
-		up(&disconnect_sem);
+		mutex_unlock(&disconnect_mutex);
 		return 0;
 	}
 
 	up(&dev->sem);
-	up(&disconnect_sem);
+	mutex_unlock(&disconnect_mutex);
 	return 0;
 }
 
@@ -401,7 +402,7 @@ static void idmouse_disconnect(struct us
 	struct usb_idmouse *dev;
 
 	/* prevent races with open() */
-	down(&disconnect_sem);
+	mutex_lock(&disconnect_mutex);
 
 	/* get device structure */
 	dev = usb_get_intfdata(interface);
@@ -423,7 +424,7 @@ static void idmouse_disconnect(struct us
 	if (!dev->open)
 		idmouse_delete(dev);
 
-	up(&disconnect_sem);
+	mutex_unlock(&disconnect_mutex);
 
 	info("%s disconnected", DRIVER_DESC);
 }
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/misc/ldusb.c linux-2.6.15-rc6-mutex-new/drivers/usb/misc/ldusb.c
--- linux-2.6.15-rc6-mutex/drivers/usb/misc/ldusb.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/misc/ldusb.c	2005-12-20 10:48:30.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 #include <linux/input.h>
@@ -165,7 +166,7 @@ struct ld_usb {
 };
 
 /* prevent races between open() and disconnect() */
-static DECLARE_MUTEX(disconnect_sem);
+static DEFINE_MUTEX(disconnect_mutex);
 
 static struct usb_driver ld_usb_driver;
 
@@ -286,7 +287,7 @@ static int ld_usb_open(struct inode *ino
 	nonseekable_open(inode, file);
 	subminor = iminor(inode);
 
-	down(&disconnect_sem);
+	mutex_lock(&disconnect_mutex);
 
 	interface = usb_find_interface(&ld_usb_driver, subminor);
 
@@ -348,7 +349,7 @@ unlock_exit:
 	up(&dev->sem);
 
 unlock_disconnect_exit:
-	up(&disconnect_sem);
+	mutex_unlock(&disconnect_mutex);
 
 	return retval;
 }
@@ -734,7 +735,7 @@ static void ld_usb_disconnect(struct usb
 	struct ld_usb *dev;
 	int minor;
 
-	down(&disconnect_sem);
+	mutex_lock(&disconnect_mutex);
 
 	dev = usb_get_intfdata(intf);
 	usb_set_intfdata(intf, NULL);
@@ -755,7 +756,7 @@ static void ld_usb_disconnect(struct usb
 		up(&dev->sem);
 	}
 
-	up(&disconnect_sem);
+	mutex_unlock(&disconnect_mutex);
 
 	dev_info(&intf->dev, "LD USB Device #%d now disconnected\n",
 		 (minor - USB_LD_MINOR_BASE));
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/misc/legousbtower.c linux-2.6.15-rc6-mutex-new/drivers/usb/misc/legousbtower.c
--- linux-2.6.15-rc6-mutex/drivers/usb/misc/legousbtower.c	2005-12-20 09:19:27.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/misc/legousbtower.c	2005-12-20 10:48:30.000000000 +0100
@@ -83,6 +83,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
 #include <linux/poll.h>
@@ -256,7 +257,7 @@ static void tower_disconnect	(struct usb
 
 
 /* prevent races between open() and disconnect */
-static DECLARE_MUTEX (disconnect_sem);
+static DEFINE_MUTEX (disconnect_mutex);
 
 /* file operations needed when we register this driver */
 static struct file_operations tower_fops = {
@@ -350,7 +351,7 @@ static int tower_open (struct inode *ino
 	nonseekable_open(inode, file);
 	subminor = iminor(inode);
 
-	down (&disconnect_sem);
+	mutex_lock (&disconnect_mutex);
 
 	interface = usb_find_interface (&tower_driver, subminor);
 
@@ -428,7 +429,7 @@ unlock_exit:
 	up (&dev->sem);
 
 unlock_disconnect_exit:
-	up (&disconnect_sem);
+	mutex_unlock (&disconnect_mutex);
 
 	dbg(2, "%s: leave, return value %d ", __FUNCTION__, retval);
 
@@ -1006,7 +1007,7 @@ static void tower_disconnect (struct usb
 
 	dbg(2, "%s: enter", __FUNCTION__);
 
-	down (&disconnect_sem);
+	mutex_lock (&disconnect_mutex);
 
 	dev = usb_get_intfdata (interface);
 	usb_set_intfdata (interface, NULL);
@@ -1028,7 +1029,7 @@ static void tower_disconnect (struct usb
 		up (&dev->sem);
 	}
 
-	up (&disconnect_sem);
+	mutex_unlock (&disconnect_mutex);
 
 	info("LEGO USB Tower #%d now disconnected", (minor - LEGO_USB_TOWER_MINOR_BASE));
 
diff -purN linux-2.6.15-rc6-mutex/drivers/usb/serial/pl2303.c linux-2.6.15-rc6-mutex-new/drivers/usb/serial/pl2303.c
--- linux-2.6.15-rc6-mutex/drivers/usb/serial/pl2303.c	2005-12-20 09:19:27.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/drivers/usb/serial/pl2303.c	2005-12-20 10:48:30.000000000 +0100
@@ -43,8 +43,6 @@ static int debug;
 #define PL2303_BUF_SIZE		1024
 #define PL2303_TMP_BUF_SIZE	1024
 
-static DECLARE_MUTEX(pl2303_tmp_buf_sem);
-
 struct pl2303_buf {
 	unsigned int	buf_size;
 	char		*buf_buf;
diff -purN linux-2.6.15-rc6-mutex/kernel/kthread.c linux-2.6.15-rc6-mutex-new/kernel/kthread.c
--- linux-2.6.15-rc6-mutex/kernel/kthread.c	2005-12-20 09:19:28.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/kernel/kthread.c	2005-12-20 10:48:30.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/unistd.h>
 #include <linux/file.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <asm/semaphore.h>
 
 /*
@@ -41,7 +42,7 @@ struct kthread_stop_info
 
 /* Thread stopping is done by setthing this var: lock serializes
  * multiple kthread_stop calls. */
-static DECLARE_MUTEX(kthread_stop_lock);
+static DEFINE_MUTEX(kthread_stop_lock);
 static struct kthread_stop_info kthread_stop_info;
 
 int kthread_should_stop(void)
@@ -173,7 +174,7 @@ int kthread_stop_sem(struct task_struct 
 {
 	int ret;
 
-	down(&kthread_stop_lock);
+	mutex_lock(&kthread_stop_lock);
 
 	/* It could exit after stop_info.k set, but before wake_up_process. */
 	get_task_struct(k);
@@ -194,7 +195,7 @@ int kthread_stop_sem(struct task_struct 
 	wait_for_completion(&kthread_stop_info.done);
 	kthread_stop_info.k = NULL;
 	ret = kthread_stop_info.err;
-	up(&kthread_stop_lock);
+	mutex_unlock(&kthread_stop_lock);
 
 	return ret;
 }
diff -purN linux-2.6.15-rc6-mutex/kernel/module.c linux-2.6.15-rc6-mutex-new/kernel/module.c
--- linux-2.6.15-rc6-mutex/kernel/module.c	2005-12-20 09:19:28.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/kernel/module.c	2005-12-20 10:48:30.000000000 +0100
@@ -38,6 +38,7 @@
 #include <linux/device.h>
 #include <linux/string.h>
 #include <linux/sched.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
@@ -62,15 +63,15 @@ static DEFINE_SPINLOCK(modlist_lock);
 static DECLARE_MUTEX(module_mutex);
 static LIST_HEAD(modules);
 
-static DECLARE_MUTEX(notify_mutex);
+static DEFINE_MUTEX(notify_mutex);
 static struct notifier_block * module_notify_list;
 
 int register_module_notifier(struct notifier_block * nb)
 {
 	int err;
-	down(&notify_mutex);
+	mutex_lock(&notify_mutex);
 	err = notifier_chain_register(&module_notify_list, nb);
-	up(&notify_mutex);
+	mutex_unlock(&notify_mutex);
 	return err;
 }
 EXPORT_SYMBOL(register_module_notifier);
@@ -78,9 +79,9 @@ EXPORT_SYMBOL(register_module_notifier);
 int unregister_module_notifier(struct notifier_block * nb)
 {
 	int err;
-	down(&notify_mutex);
+	mutex_lock(&notify_mutex);
 	err = notifier_chain_unregister(&module_notify_list, nb);
-	up(&notify_mutex);
+	mutex_unlock(&notify_mutex);
 	return err;
 }
 EXPORT_SYMBOL(unregister_module_notifier);
@@ -1905,9 +1906,9 @@ sys_init_module(void __user *umod,
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
-	down(&notify_mutex);
+	mutex_lock(&notify_mutex);
 	notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
-	up(&notify_mutex);
+	mutex_unlock(&notify_mutex);
 
 	/* Start the module */
 	if (mod->init != NULL)
diff -purN linux-2.6.15-rc6-mutex/kernel/posix-timers.c linux-2.6.15-rc6-mutex-new/kernel/posix-timers.c
--- linux-2.6.15-rc6-mutex/kernel/posix-timers.c	2005-12-20 09:19:28.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/kernel/posix-timers.c	2005-12-20 10:48:30.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -1312,7 +1313,7 @@ sys_clock_getres(clockid_t which_clock, 
 static DECLARE_WAIT_QUEUE_HEAD(nanosleep_abs_wqueue);
 static DECLARE_WORK(clock_was_set_work, (void(*)(void*))clock_was_set, NULL);
 
-static DECLARE_MUTEX(clock_was_set_lock);
+static DEFINE_MUTEX(clock_was_set_lock);
 
 void clock_was_set(void)
 {
@@ -1363,7 +1364,7 @@ void clock_was_set(void)
 
 	 */
 
-	down(&clock_was_set_lock);
+	mutex_lock(&clock_was_set_lock);
 	spin_lock_irq(&abs_list.lock);
 	list_splice_init(&abs_list.list, &cws_list);
 	spin_unlock_irq(&abs_list.lock);
@@ -1389,7 +1390,7 @@ void clock_was_set(void)
 		spin_unlock_irq(&abs_list.lock);
 	} while (1);
 
-	up(&clock_was_set_lock);
+	mutex_unlock(&clock_was_set_lock);
 }
 
 long clock_nanosleep_restart(struct restart_block *restart_block);
diff -purN linux-2.6.15-rc6-mutex/kernel/power/pm.c linux-2.6.15-rc6-mutex-new/kernel/power/pm.c
--- linux-2.6.15-rc6-mutex/kernel/power/pm.c	2005-12-20 09:19:28.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/kernel/power/pm.c	2005-12-20 10:48:30.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/pm.h>
 #include <linux/pm_legacy.h>
 #include <linux/interrupt.h>
+#include <linux/mutex.h>
 
 int pm_active;
 
@@ -40,7 +41,7 @@ int pm_active;
  *	until a resume but that will be fine.
  */
  
-static DECLARE_MUTEX(pm_devs_lock);
+static DEFINE_MUTEX(pm_devs_lock);
 static LIST_HEAD(pm_devs);
 
 /**
@@ -67,9 +68,9 @@ struct pm_dev *pm_register(pm_dev_t type
 		dev->id = id;
 		dev->callback = callback;
 
-		down(&pm_devs_lock);
+		mutex_lock(&pm_devs_lock);
 		list_add(&dev->entry, &pm_devs);
-		up(&pm_devs_lock);
+		mutex_unlock(&pm_devs_lock);
 	}
 	return dev;
 }
@@ -85,9 +86,9 @@ struct pm_dev *pm_register(pm_dev_t type
 void pm_unregister(struct pm_dev *dev)
 {
 	if (dev) {
-		down(&pm_devs_lock);
+		mutex_lock(&pm_devs_lock);
 		list_del(&dev->entry);
-		up(&pm_devs_lock);
+		mutex_unlock(&pm_devs_lock);
 
 		kfree(dev);
 	}
@@ -118,7 +119,7 @@ void pm_unregister_all(pm_callback callb
 	if (!callback)
 		return;
 
-	down(&pm_devs_lock);
+	mutex_lock(&pm_devs_lock);
 	entry = pm_devs.next;
 	while (entry != &pm_devs) {
 		struct pm_dev *dev = list_entry(entry, struct pm_dev, entry);
@@ -126,7 +127,7 @@ void pm_unregister_all(pm_callback callb
 		if (dev->callback == callback)
 			__pm_unregister(dev);
 	}
-	up(&pm_devs_lock);
+	mutex_unlock(&pm_devs_lock);
 }
 
 /**
@@ -234,7 +235,7 @@ int pm_send_all(pm_request_t rqst, void 
 {
 	struct list_head *entry;
 	
-	down(&pm_devs_lock);
+	mutex_lock(&pm_devs_lock);
 	entry = pm_devs.next;
 	while (entry != &pm_devs) {
 		struct pm_dev *dev = list_entry(entry, struct pm_dev, entry);
@@ -246,13 +247,13 @@ int pm_send_all(pm_request_t rqst, void 
 				 */
 				if (rqst == PM_SUSPEND)
 					pm_undo_all(dev);
-				up(&pm_devs_lock);
+				mutex_unlock(&pm_devs_lock);
 				return status;
 			}
 		}
 		entry = entry->next;
 	}
-	up(&pm_devs_lock);
+	mutex_unlock(&pm_devs_lock);
 	return 0;
 }
 
diff -purN linux-2.6.15-rc6-mutex/kernel/profile.c linux-2.6.15-rc6-mutex-new/kernel/profile.c
--- linux-2.6.15-rc6-mutex/kernel/profile.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-mutex-new/kernel/profile.c	2005-12-20 10:48:30.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/profile.h>
 #include <linux/highmem.h>
+#include <linux/mutex.h>
 #include <asm/sections.h>
 #include <asm/semaphore.h>
 
@@ -44,7 +45,7 @@ static cpumask_t prof_cpu_mask = CPU_MAS
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
-static DECLARE_MUTEX(profile_flip_mutex);
+static DEFINE_MUTEX(profile_flip_mutex);
 #endif /* CONFIG_SMP */
 
 static int __init profile_setup(char * str)
@@ -243,7 +244,7 @@ static void profile_flip_buffers(void)
 {
 	int i, j, cpu;
 
-	down(&profile_flip_mutex);
+	mutex_lock(&profile_flip_mutex);
 	j = per_cpu(cpu_profile_flip, get_cpu());
 	put_cpu();
 	on_each_cpu(__profile_flip_buffers, NULL, 0, 1);
@@ -259,14 +260,14 @@ static void profile_flip_buffers(void)
 			hits[i].hits = hits[i].pc = 0;
 		}
 	}
-	up(&profile_flip_mutex);
+	mutex_unlock(&profile_flip_mutex);
 }
 
 static void profile_discard_flip_buffers(void)
 {
 	int i, cpu;
 
-	down(&profile_flip_mutex);
+	mutex_lock(&profile_flip_mutex);
 	i = per_cpu(cpu_profile_flip, get_cpu());
 	put_cpu();
 	on_each_cpu(__profile_flip_buffers, NULL, 0, 1);
@@ -274,7 +275,7 @@ static void profile_discard_flip_buffers
 		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[i];
 		memset(hits, 0, NR_PROFILE_HIT*sizeof(struct profile_hit));
 	}
-	up(&profile_flip_mutex);
+	mutex_unlock(&profile_flip_mutex);
 }
 
 void profile_hit(int type, void *__pc)
diff -purN linux-2.6.15-rc6-mutex/lib/reed_solomon/reed_solomon.c linux-2.6.15-rc6-mutex-new/lib/reed_solomon/reed_solomon.c
--- linux-2.6.15-rc6-mutex/lib/reed_solomon/reed_solomon.c	2005-12-20 09:19:28.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/lib/reed_solomon/reed_solomon.c	2005-12-20 10:48:30.000000000 +0100
@@ -44,12 +44,13 @@
 #include <linux/module.h>
 #include <linux/rslib.h>
 #include <linux/slab.h>
+#include <linux/mutex.h>
 #include <asm/semaphore.h>
 
 /* This list holds all currently allocated rs control structures */
 static LIST_HEAD (rslist);
 /* Protection for the list */
-static DECLARE_MUTEX(rslistlock);
+static DEFINE_MUTEX(rslistlock);
 
 /**
  * rs_init - Initialize a Reed-Solomon codec
@@ -161,7 +162,7 @@ errrs:
  */
 void free_rs(struct rs_control *rs)
 {
-	down(&rslistlock);
+	mutex_lock(&rslistlock);
 	rs->users--;
 	if(!rs->users) {
 		list_del(&rs->list);
@@ -170,7 +171,7 @@ void free_rs(struct rs_control *rs)
 		kfree(rs->genpoly);
 		kfree(rs);
 	}
-	up(&rslistlock);
+	mutex_unlock(&rslistlock);
 }
 
 /**
@@ -201,7 +202,7 @@ struct rs_control *init_rs(int symsize, 
 	if (nroots < 0 || nroots >= (1<<symsize))
 		return NULL;
 
-	down(&rslistlock);
+	mutex_lock(&rslistlock);
 
 	/* Walk through the list and look for a matching entry */
 	list_for_each(tmp, &rslist) {
@@ -228,7 +229,7 @@ struct rs_control *init_rs(int symsize, 
 		list_add(&rs->list, &rslist);
 	}
 out:
-	up(&rslistlock);
+	mutex_unlock(&rslistlock);
 	return rs;
 }
 
diff -purN linux-2.6.15-rc6-mutex/security/keys/process_keys.c linux-2.6.15-rc6-mutex-new/security/keys/process_keys.c
--- linux-2.6.15-rc6-mutex/security/keys/process_keys.c	2005-12-20 09:19:28.000000000 +0100
+++ linux-2.6.15-rc6-mutex-new/security/keys/process_keys.c	2005-12-20 11:09:01.000000000 +0100
@@ -16,11 +16,12 @@
 #include <linux/keyctl.h>
 #include <linux/fs.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
 #include "internal.h"
 
 /* session keyring create vs join semaphore */
-static DECLARE_MUTEX(key_session_sem);
+static DEFINE_MUTEX(key_session_mutex);
 
 /* the root user's tracking struct */
 struct key_user root_key_user = {
@@ -706,7 +707,7 @@ long join_session_keyring(const char *na
 	}
 
 	/* allow the user to join or create a named keyring */
-	down(&key_session_sem);
+	mutex_lock(&key_session_mutex);
 
 	/* look for an existing keyring of this name */
 	keyring = find_keyring_by_name(name, 0);
@@ -732,7 +733,7 @@ long join_session_keyring(const char *na
 	key_put(keyring);
 
 error2:
-	up(&key_session_sem);
+	mutex_unlock(&key_session_mutex);
 error:
 	return ret;
 



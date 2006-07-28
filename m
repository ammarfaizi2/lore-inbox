Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161308AbWG1VYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161308AbWG1VYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWG1VYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:24:06 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:9704 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161308AbWG1VYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:24:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Date: Fri, 28 Jul 2006 23:23:14 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200607281015.30048.rjw@sisk.pl> <20060728182041.GI19076@localdomain> <200607282115.45407.rjw@sisk.pl>
In-Reply-To: <200607282115.45407.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282323.14570.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 21:15, Rafael J. Wysocki wrote:
> Hi Nathan,
> 
> On Friday 28 July 2006 20:20, Nathan Lynch wrote:
> > Hi Rafael-
> > 
]--snip--[
> I'm not quite sure if we can finish with CPU0 offline.  Perhaps it's better to
> check if CPU0 is online and bring it up if not and then continue or return
> an error if that fails?

I've tried to implement this idea in the appended patch (I'm omitting the
changes outside of kernel/cpu.c as they are not relevant here).

Please have a look.

Rafael


--- linux-2.6.18-rc2-mm1.orig/kernel/cpu.c	2006-07-28 21:03:21.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/cpu.c	2006-07-28 22:59:03.000000000 +0200
@@ -21,6 +21,11 @@ static DEFINE_MUTEX(cpu_bitmask_lock);
 
 static __cpuinitdata BLOCKING_NOTIFIER_HEAD(cpu_chain);
 
+/* If set, cpu_up and cpu_down will return -EBUSY and do nothing.
+ * Should always be manipulated under cpu_add_remove_lock
+ */
+static int cpu_hotplug_disabled;
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 /* Crappy recursive lock-takers in cpufreq! Complain loudly about idiots */
@@ -108,30 +113,25 @@ static int take_cpu_down(void *unused)
 	return 0;
 }
 
-int cpu_down(unsigned int cpu)
+/* Requires cpu_add_remove_lock to be held */
+static int _cpu_down(unsigned int cpu)
 {
 	int err;
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
 
-	mutex_lock(&cpu_add_remove_lock);
-	if (num_online_cpus() == 1) {
-		err = -EBUSY;
-		goto out;
-	}
+	if (num_online_cpus() == 1)
+		return -EBUSY;
 
-	if (!cpu_online(cpu)) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (!cpu_online(cpu))
+		return -EINVAL;
 
 	err = blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
 						(void *)(long)cpu);
 	if (err == NOTIFY_BAD) {
 		printk("%s: attempt to take down CPU %u failed\n",
 				__FUNCTION__, cpu);
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Ensure that we are not runnable on dying cpu */
@@ -179,22 +179,31 @@ out_thread:
 	err = kthread_stop(p);
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
-out:
+	return err;
+}
+
+int cpu_down(unsigned int cpu)
+{
+	int err = 0;
+
+	mutex_lock(&cpu_add_remove_lock);
+	if (cpu_hotplug_disabled)
+		err = -EBUSY;
+	else
+		err = _cpu_down(cpu);
+
 	mutex_unlock(&cpu_add_remove_lock);
 	return err;
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
 
-int __devinit cpu_up(unsigned int cpu)
+static int __devinit _cpu_up(unsigned int cpu)
 {
 	int ret;
 	void *hcpu = (void *)(long)cpu;
 
-	mutex_lock(&cpu_add_remove_lock);
-	if (cpu_online(cpu) || !cpu_present(cpu)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (cpu_online(cpu) || !cpu_present(cpu))
+		return -EINVAL;
 
 	ret = blocking_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
 	if (ret == NOTIFY_BAD) {
@@ -219,7 +228,95 @@ out_notify:
 	if (ret != 0)
 		blocking_notifier_call_chain(&cpu_chain,
 				CPU_UP_CANCELED, hcpu);
+
+	return ret;
+}
+
+int __devinit cpu_up(unsigned int cpu)
+{
+	int err = 0;
+
+	mutex_lock(&cpu_add_remove_lock);
+	if (cpu_hotplug_disabled)
+		err = -EBUSY;
+	else
+		err = _cpu_up(cpu);
+
+	mutex_unlock(&cpu_add_remove_lock);
+	return err;
+}
+
+#ifdef CONFIG_SUSPEND_SMP
+static cpumask_t frozen_cpus;
+
+int disable_nonboot_cpus(void)
+{
+	int cpu, first_cpu, error;
+
+	mutex_lock(&cpu_add_remove_lock);
+	first_cpu = first_cpu(cpu_present_map);
+	if (!cpu_online(first_cpu)) {
+		error = _cpu_up(first_cpu);
+		if (error) {
+			printk(KERN_ERR "Could not bring CPU%d up.\n",
+				first_cpu);
+			goto out;
+		}
+	}
+	error = set_cpus_allowed(current, cpumask_of_cpu(first_cpu));
+	if (error) {
+		printk(KERN_ERR "Could not run on CPU%d\n", first_cpu);
+		goto out;
+	}
+	/* We take down all of the non-boot CPUs in one shot to avoid races
+	 * with the userspace trying to use the CPU hotplug at the same time
+	 */
+	cpus_clear(frozen_cpus);
+	printk("Disabling non-boot CPUs ...\n");
+	for_each_online_cpu(cpu) {
+		if (cpu == first_cpu)
+			continue;
+		error = _cpu_down(cpu);
+		if (!error) {
+			cpu_set(cpu, frozen_cpus);
+			printk("CPU%d is down\n", cpu);
+		} else {
+			printk(KERN_ERR "Error taking CPU%d down: %d\n",
+				cpu, error);
+			break;
+		}
+	}
+	if (!error) {
+		BUG_ON(num_online_cpus() > 1);
+		/* Make sure the CPUs won't be enabled by someone else */
+		cpu_hotplug_disabled = 1;
+	} else {
+		printk(KERN_ERR "Non-boot CPUs are not disabled");
+	}
 out:
 	mutex_unlock(&cpu_add_remove_lock);
-	return ret;
+	return error;
+}
+
+void enable_nonboot_cpus(void)
+{
+	int cpu, error;
+
+	/* Allow everyone to use the CPU hotplug again */
+	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_disabled = 0;
+	mutex_unlock(&cpu_add_remove_lock);
+
+	printk("Enabling non-boot CPUs ...\n");
+	for_each_cpu_mask(cpu, frozen_cpus) {
+		error = cpu_up(cpu);
+		if (!error) {
+			printk("CPU%d is up\n", cpu);
+			continue;
+		}
+		printk(KERN_WARNING "Error taking CPU%d up: %d\n",
+			cpu, error);
+	}
+	cpus_clear(frozen_cpus);
 }
+#endif

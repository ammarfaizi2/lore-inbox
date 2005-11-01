Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVKATPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVKATPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVKATPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:15:40 -0500
Received: from fmr22.intel.com ([143.183.121.14]:49641 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751165AbVKATPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:15:39 -0500
Date: Tue, 1 Nov 2005 11:14:17 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux@brodo.de,
       venkatesh.pallipadi@intel.com
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Message-ID: <20051101111417.A31379@unix-os.sc.intel.com>
References: <200510311606.36615.rjw@sisk.pl> <200510312045.32908.rjw@sisk.pl> <20051031124216.A18213@unix-os.sc.intel.com> <200511012007.19762.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200511012007.19762.rjw@sisk.pl>; from rjw@sisk.pl on Tue, Nov 01, 2005 at 08:07:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 08:07:19PM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> > of taking cpucontrol lock in __cpufreq_driver_target().
> 
> Yes, that's it.
> 
> > The reason is we now enter the same code path from the cpu_up() and cpu_down()
> > generated cpu notifier callbacks and ends up trying to lock when the 
> > call path already has the cpucontrol lock.
> > 
> > Its happening because we do set_cpus_allowed() in powernowk8_target().
> 
> Unfortunately, powernowk8_target() calls schedule() right after
> set_cpus_allowed(), so it throws "scheduling while atomic" on every call,
> because of the preempt_disable()/_enable() around it.
> 
> Greetings,
> Rafael
> 

Thanks Rafael,

could you try this patch instead? I hate to keep these state variables 
and thats why i went with the preempt approach, too bad it seems it wont
work for more than just the case you mentioned.

seems ugly, but i dont find a better looking cure...


-- 
Cheers,
Ashok Raj
- Open Source Technology Center



When calling target drivers to set frequency, we used to take cpucontrol
semaphore. When we modified the code to accomodate CPU hotplug, there was an 
attempt to take a double lock leading to a deadlock. Since the code called from
under the CPU hotplug notifiers already hold the cpucontrol lock.

we attempted to circumvent this ugly state keeping by just doing a simple 
preempt_disable() and preempt_enable(), but that appears to get in the
way when cpufreq drivers attempt to do set_cpus_allowed() since this call 
will go to sleep.

Now we just keep a state variable and each notifier path is supposed to set 
this to avoid the cpufreq driver taking double locks.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------------------
 drivers/cpufreq/cpufreq.c       |   35 +++++++++++++++++++----------------
 drivers/cpufreq/cpufreq_stats.c |    2 ++
 include/linux/cpufreq.h         |    2 ++
 3 files changed, 23 insertions(+), 16 deletions(-)

Index: linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq.c
@@ -38,6 +38,8 @@ static struct cpufreq_driver   	*cpufreq
 static struct cpufreq_policy	*cpufreq_cpu_data[NR_CPUS];
 static DEFINE_SPINLOCK(cpufreq_driver_lock);
 
+int cpufreq_hotplug_inprogress;
+EXPORT_SYMBOL_GPL(cpufreq_hotplug_inprogress);
 
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
@@ -59,6 +61,18 @@ static DECLARE_RWSEM		(cpufreq_notifier_
 static LIST_HEAD(cpufreq_governor_list);
 static DECLARE_MUTEX		(cpufreq_governor_sem);
 
+static void cpufreq_lock_hotplug(void)
+{
+	if (!cpufreq_hotplug_inprogress)
+		lock_cpu_hotplug();
+}
+
+static void cpufreq_unlock_hotplug(void)
+{
+	if (!cpufreq_hotplug_inprogress)
+		unlock_cpu_hotplug();
+}
+
 struct cpufreq_policy * cpufreq_cpu_get(unsigned int cpu)
 {
 	struct cpufreq_policy *data;
@@ -1114,25 +1128,12 @@ int __cpufreq_driver_target(struct cpufr
 {
 	int retval = -EINVAL;
 
-	/*
-	 * Converted the lock_cpu_hotplug to preempt_disable()
-	 * and preempt enable. This is a bit kludgy and relies on
-	 * how cpu hotplug works. All we need is a gaurantee that cpu hotplug
-	 * wont make progress on any cpu. Once we do preempt_disable(), this
-	 * would ensure hotplug threads dont get on this cpu, thereby delaying
-	 * the cpu remove process.
-	 *
-	 * we removed the lock_cpu_hotplug since we need to call this function via
-	 * cpu hotplug callbacks, which result in locking the cpu hotplug
-	 * thread itself. Agree this is not very clean, cpufreq community
-	 * could improve this if required. - Ashok Raj <ashok.raj@intel.com>
-	 */
-	preempt_disable();
+	cpufreq_lock_hotplug();
 	dprintk("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
 		target_freq, relation);
 	if (cpu_online(policy->cpu) && cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
-	preempt_enable();
+	cpufreq_unlock_hotplug();
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
@@ -1432,8 +1433,9 @@ static int __cpuinit cpufreq_cpu_callbac
 	struct sys_device *sys_dev;
 
 	sys_dev = get_cpu_sysdev(cpu);
-
+
 	if (sys_dev) {
+		cpufreq_hotplug_inprogress = 1;
 		switch (action) {
 			case CPU_ONLINE:
 				(void) cpufreq_add_dev(sys_dev);
@@ -1455,6 +1457,7 @@ static int __cpuinit cpufreq_cpu_callbac
 				(void) cpufreq_remove_dev(sys_dev);
 				break;
 		}
+		cpufreq_hotplug_inprogress = 0;
 	}
 	return NOTIFY_OK;
 }
Index: linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq_stats.c
@@ -302,6 +302,7 @@ static int __cpuinit cpufreq_stat_cpu_ca
 {
 	unsigned int cpu = (unsigned long)hcpu;
 
+	cpufreq_hotplug_inprogress = 1;
 	switch (action) {
 		case CPU_ONLINE:
 			cpufreq_update_policy(cpu);
@@ -310,6 +311,7 @@ static int __cpuinit cpufreq_stat_cpu_ca
 			cpufreq_stats_free_table(cpu);
 			break;
 	}
+	cpufreq_hotplug_inprogress = 0;
 	return NOTIFY_OK;
 }
 
Index: linux-2.6.14-rc4-mm1/include/linux/cpufreq.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/linux/cpufreq.h
+++ linux-2.6.14-rc4-mm1/include/linux/cpufreq.h
@@ -156,6 +156,8 @@ struct cpufreq_governor {
 	struct module		*owner;
 };
 
+extern int cpufreq_hotplug_inprogress;
+
 /* pass a target to the cpufreq driver 
  */
 extern int cpufreq_driver_target(struct cpufreq_policy *policy,

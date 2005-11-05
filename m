Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVKEXUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVKEXUp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 18:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVKEXUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 18:20:45 -0500
Received: from fmr21.intel.com ([143.183.121.13]:3717 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750707AbVKEXUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 18:20:44 -0500
Date: Sat, 5 Nov 2005 15:19:44 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, rjw@sisk.pl, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, mingo@elte.hu, linux@brodo.de,
       venkatesh.pallipadi@intel.com
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Message-ID: <20051105151944.A30804@unix-os.sc.intel.com>
References: <200510311606.36615.rjw@sisk.pl> <200510312045.32908.rjw@sisk.pl> <20051031124216.A18213@unix-os.sc.intel.com> <200511012007.19762.rjw@sisk.pl> <20051101111417.A31379@unix-os.sc.intel.com> <20051104143035.120fe158.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051104143035.120fe158.akpm@osdl.org>; from akpm@osdl.org on Fri, Nov 04, 2005 at 02:30:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 02:30:35PM -0800, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> > 
> > ...
> >
> > seems ugly, but i dont find a better looking cure...
> > 
> 
> Could you take another look, please?   It really is pretty gross.
> 

So here it is again... thanks to Andrew suggesting to take the PF_ avenue.

Sure enough the old one was gross, and there was an even groosier patch
that met infant mortality...

since the last patch in -git8 broke some implementations, this is 
relative to that earlier patch. 

It would be nice to have this in base sooner so cpufreq's dont break.

Thanks a ton.

--------------
When calling target drivers to set frequency, we take cpucontrol lock.
When we modified the code to accomodate CPU hotplug, there was an 
attempt to take a double lock of cpucontrol leading to a deadlock. 
Since the current thread context is already holding the cpucontrol lock, 
we dont need to make another attempt to acquire it. 

Now we leave a trace in current->flags indicating current thread already 
is under cpucontrol lock held, so we dont attempt to do this another time.

Thanks to Andrew Morton for the beating:-) 

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------------------
 drivers/cpufreq/cpufreq.c |   24 ++++++++++--------------
 include/linux/cpu.h       |    1 +
 include/linux/sched.h     |    1 +
 kernel/cpu.c              |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 14 deletions(-)

Index: linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq.c
@@ -38,7 +38,6 @@ static struct cpufreq_driver   	*cpufreq
 static struct cpufreq_policy	*cpufreq_cpu_data[NR_CPUS];
 static DEFINE_SPINLOCK(cpufreq_driver_lock);
 
-
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
 static void handle_update(void *data);
@@ -1115,24 +1114,21 @@ int __cpufreq_driver_target(struct cpufr
 	int retval = -EINVAL;
 
 	/*
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
+	 * If we are already in context of hotplug thread, we dont need to
+	 * acquire the hotplug lock. Otherwise acquire cpucontrol to prevent
+	 * hotplug from removing this cpu that we are working on.
 	 */
-	preempt_disable();
+	if (!current_in_cpu_hotplug())
+		lock_cpu_hotplug();
+
 	dprintk("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
 		target_freq, relation);
 	if (cpu_online(policy->cpu) && cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
-	preempt_enable();
+
+	if (!current_in_cpu_hotplug())
+		unlock_cpu_hotplug();
+
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
Index: linux-2.6.14-rc4-mm1/include/linux/cpu.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/linux/cpu.h
+++ linux-2.6.14-rc4-mm1/include/linux/cpu.h
@@ -33,6 +33,7 @@ struct cpu {
 
 extern int register_cpu(struct cpu *, int, struct node *);
 extern struct sys_device *get_cpu_sysdev(int cpu);
+extern int current_in_cpu_hotplug(void);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *, struct node *);
 #endif
Index: linux-2.6.14-rc4-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/linux/sched.h
+++ linux-2.6.14-rc4-mm1/include/linux/sched.h
@@ -880,6 +880,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_HOTPLUG_CPU	0x01000000	/* Currently performing CPU hotplug */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-2.6.14-rc4-mm1/kernel/cpu.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/cpu.c
+++ linux-2.6.14-rc4-mm1/kernel/cpu.c
@@ -20,6 +20,24 @@ DECLARE_MUTEX(cpucontrol);
 
 static struct notifier_block *cpu_chain;
 
+/*
+ * Used to check by callers if they need to acquire the cpucontrol
+ * or not to protect a cpu from being removed. Its sometimes required to
+ * call these functions both for normal operations, and in response to
+ * a cpu being added/removed. If the context of the call is in the same
+ * thread context as a CPU hotplug thread, we dont need to take the lock
+ * since its already protected
+ * check drivers/cpufreq/cpufreq.c for its usage - Ashok Raj
+ */
+
+int current_in_cpu_hotplug(void)
+{
+	return (current->flags & PF_HOTPLUG_CPU);
+}
+
+EXPORT_SYMBOL_GPL(current_in_cpu_hotplug);
+
+
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
 {
@@ -93,6 +111,13 @@ int cpu_down(unsigned int cpu)
 		goto out;
 	}
 
+	/*
+	 * Leave a trace in current->flags indicating we are already in
+	 * process of performing CPU hotplug. Callers can check if cpucontrol
+	 * is already acquired by current thread, and if so not cause
+	 * a dead lock by not acquiring the lock
+	 */
+	current->flags |= PF_HOTPLUG_CPU;
 	err = notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
 						(void *)(long)cpu);
 	if (err == NOTIFY_BAD) {
@@ -145,6 +170,7 @@ out_thread:
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
 out:
+	current->flags &= ~PF_HOTPLUG_CPU;
 	unlock_cpu_hotplug();
 	return err;
 }
@@ -162,6 +188,12 @@ int __devinit cpu_up(unsigned int cpu)
 		ret = -EINVAL;
 		goto out;
 	}
+
+	/*
+	 * Leave a trace in current->flags indicating we are already in
+	 * process of performing CPU hotplug.
+	 */
+	current->flags |= PF_HOTPLUG_CPU;
 	ret = notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
 	if (ret == NOTIFY_BAD) {
 		printk("%s: attempt to bring up CPU %u failed\n",
@@ -184,6 +216,7 @@ out_notify:
 	if (ret != 0)
 		notifier_call_chain(&cpu_chain, CPU_UP_CANCELED, hcpu);
 out:
+	current->flags &= ~PF_HOTPLUG_CPU;
 	up(&cpucontrol);
 	return ret;
 }

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWGZVei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWGZVei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWGZVei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:34:38 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:58070 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030226AbWGZVeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:34:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
Date: Wed, 26 Jul 2006 23:33:49 +0200
User-Agent: KMail/1.9.3
Cc: vatsa@in.ibm.com, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <20060726204233.GA23488@in.ibm.com> <1153947786.3381.58.camel@laptopd505.fenrus.org>
In-Reply-To: <1153947786.3381.58.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607262333.49256.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 23:03, Arjan van de Ven wrote:
> On Wed, 2006-07-26 at 13:42 -0700, Srivatsa Vaddagiri wrote:
> > On Wed, Jul 26, 2006 at 09:42:34PM +0200, Arjan van de Ven wrote:
> > > As a quick hack I made non-lock_cpu_hotplug()'ing versions of the 3 key
> > > workqueue functions (patch below). It works, it's correct, it's just so
> > > ugly that I'm almost too ashamed to post it. I haven't found a better
> > > solution yet though... time to take a step back I suppose.
> > 
> > My worry is that such special cases might be needed in more places as we
> > discover further or as code evolves. Fundamentally looks like the locked and 
> > unlocked paths of the kernel cannot be separated so well because of interaction 
> > between subsystems. /me thinks rwsem seems to be a sane thing to go after.
> 
> rwsems unfortunately help you zilch; an rwsem is just a mutex with a
> performance tweak, but from the deadlock perspective it's really a
> mutex.
> 
> I'm really starting to feel that the hotplug lock would have been better
> of being a refcount (with a waitqueue for zero) than a lock. While
> "refcount+waitqueue" sort of IS a lock, the semantics make more sense
> imo...

Related, it looks like we need to disable the cpu hotplug for suspend, either
to disk or to RAM, so that the userspace won't enable the CPUs we have
taken down before freezing tasks.  I have a patch for that, which is appended
(experimental, untested), and I hope it won't interfere with what you're
now doing.

Or perhaps I can get the same result in a better way?

Please advise.

Greetings,
Rafael


---
 include/linux/cpu.h     |    3 ++
 include/linux/suspend.h |    4 +--
 kernel/cpu.c            |   49 +++++++++++++++++++++++++++++++++---------------
 kernel/power/disk.c     |    6 ++++-
 kernel/power/main.c     |    9 ++------
 kernel/power/smp.c      |   39 +++++++++++++++++++++++++++-----------
 kernel/power/user.c     |   13 +++++++-----
 7 files changed, 83 insertions(+), 40 deletions(-)

Index: linux-2.6.18-rc2/include/linux/suspend.h
===================================================================
--- linux-2.6.18-rc2.orig/include/linux/suspend.h	2006-07-26 08:52:42.000000000 +0200
+++ linux-2.6.18-rc2/include/linux/suspend.h	2006-07-26 09:17:16.000000000 +0200
@@ -58,10 +58,10 @@ static inline int software_suspend(void)
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_SUSPEND_SMP
-extern void disable_nonboot_cpus(void);
+extern int disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
 #else
-static inline void disable_nonboot_cpus(void) {}
+static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
 #endif
 
Index: linux-2.6.18-rc2/kernel/power/smp.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/smp.c	2006-07-26 08:52:42.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/smp.c	2006-07-26 23:16:34.000000000 +0200
@@ -20,33 +20,50 @@
 /* This is protected by pm_sem semaphore */
 static cpumask_t frozen_cpus;
 
-void disable_nonboot_cpus(void)
+int disable_nonboot_cpus(void)
 {
-	int cpu, error;
+	int cpu, error = 0;
 
-	error = 0;
+	/* We take down all of the non-boot CPUs in one shot to avoid races
+	 * with the userspace trying to use the CPU hotplug at the same time
+	 */
+	lock_cpu_hotplug();
 	cpus_clear(frozen_cpus);
 	printk("Freezing cpus ...\n");
 	for_each_online_cpu(cpu) {
 		if (cpu == 0)
 			continue;
-		error = cpu_down(cpu);
+		error = __cpu_down(cpu);
 		if (!error) {
 			cpu_set(cpu, frozen_cpus);
 			printk("CPU%d is down\n", cpu);
-			continue;
+		} else {
+			printk(KERN_ERR "Error taking cpu %d down: %d\n",
+				cpu, error);
+			break;
 		}
-		printk("Error taking cpu %d down: %d\n", cpu, error);
 	}
-	BUG_ON(raw_smp_processor_id() != 0);
-	if (error)
-		panic("cpus not sleeping");
+	if (!error) {
+		BUG_ON(num_online_cpus() > 1);
+		BUG_ON(raw_smp_processor_id() != 0);
+		/* Make sure cpu_up() and cpu_down() won't work from now on */
+		cpu_hotplug_disabled = 1;
+	} else {
+		printk(KERN_ERR "cpus are not sleeping");
+	}
+	unlock_cpu_hotplug();
+	return error;
 }
 
 void enable_nonboot_cpus(void)
 {
 	int cpu, error;
 
+	/* Enable the CPU hotplug so that the userspace can use it */
+	lock_cpu_hotplug();
+	cpu_hotplug_disabled = 0;
+	unlock_cpu_hotplug();
+
 	printk("Thawing cpus ...\n");
 	for_each_cpu_mask(cpu, frozen_cpus) {
 		error = cpu_up(cpu);
@@ -54,8 +71,8 @@ void enable_nonboot_cpus(void)
 			printk("CPU%d is up\n", cpu);
 			continue;
 		}
-		printk("Error taking cpu %d up: %d\n", cpu, error);
-		panic("Not enough cpus");
+		printk(KERN_WARNING "Error taking cpu %d up: %d\n",
+			cpu, error);
 	}
 	cpus_clear(frozen_cpus);
 }
Index: linux-2.6.18-rc2/kernel/power/disk.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/disk.c	2006-07-26 08:52:49.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/disk.c	2006-07-26 08:57:01.000000000 +0200
@@ -72,7 +72,10 @@ static int prepare_processes(void)
 	int error;
 
 	pm_prepare_console();
-	disable_nonboot_cpus();
+
+	error = disable_nonboot_cpus();
+	if (error)
+		goto enable_cpus;
 
 	if (freeze_processes()) {
 		error = -EBUSY;
@@ -84,6 +87,7 @@ static int prepare_processes(void)
 		return 0;
 thaw:
 	thaw_processes();
+enable_cpus:
 	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
Index: linux-2.6.18-rc2/kernel/power/main.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/main.c	2006-07-26 08:52:42.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/main.c	2006-07-26 08:57:01.000000000 +0200
@@ -51,7 +51,7 @@ void pm_set_ops(struct pm_ops * ops)
 
 static int suspend_prepare(suspend_state_t state)
 {
-	int error = 0;
+	int error;
 	unsigned int free_pages;
 
 	if (!pm_ops || !pm_ops->enter)
@@ -59,12 +59,9 @@ static int suspend_prepare(suspend_state
 
 	pm_prepare_console();
 
-	disable_nonboot_cpus();
-
-	if (num_online_cpus() != 1) {
-		error = -EPERM;
+	error = disable_nonboot_cpus();
+	if (error)
 		goto Enable_cpu;
-	}
 
 	if (freeze_processes()) {
 		error = -EAGAIN;
Index: linux-2.6.18-rc2/kernel/power/user.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/user.c	2006-07-26 08:52:49.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/user.c	2006-07-26 08:57:33.000000000 +0200
@@ -139,12 +139,15 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		down(&pm_sem);
-		disable_nonboot_cpus();
-		if (freeze_processes()) {
-			thaw_processes();
-			enable_nonboot_cpus();
-			error = -EBUSY;
+		error = disable_nonboot_cpus();
+		if (!error) {
+			error = freeze_processes();
+			if (error) {
+				thaw_processes();
+				error = -EBUSY;
+			}
 		}
+		enable_nonboot_cpus();
 		up(&pm_sem);
 		if (!error)
 			data->frozen = 1;
Index: linux-2.6.18-rc2/include/linux/cpu.h
===================================================================
--- linux-2.6.18-rc2.orig/include/linux/cpu.h	2006-07-16 11:38:15.000000000 +0200
+++ linux-2.6.18-rc2/include/linux/cpu.h	2006-07-26 23:00:12.000000000 +0200
@@ -50,6 +50,8 @@ static inline void unregister_cpu_notifi
 #endif
 extern int current_in_cpu_hotplug(void);
 
+extern int cpu_hotplug_disabled;
+
 int cpu_up(unsigned int cpu);
 
 #else
@@ -81,6 +83,7 @@ extern int lock_cpu_hotplug_interruptibl
 }
 #define register_hotcpu_notifier(nb)	register_cpu_notifier(nb)
 #define unregister_hotcpu_notifier(nb)	unregister_cpu_notifier(nb)
+int __cpu_down(unsigned int cpu);
 int cpu_down(unsigned int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
Index: linux-2.6.18-rc2/kernel/cpu.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/cpu.c	2006-07-16 11:38:16.000000000 +0200
+++ linux-2.6.18-rc2/kernel/cpu.c	2006-07-26 22:59:31.000000000 +0200
@@ -20,6 +20,12 @@ static DEFINE_MUTEX(cpucontrol);
 
 static __cpuinitdata BLOCKING_NOTIFIER_HEAD(cpu_chain);
 
+/* If set, cpu_up and cpu_down will not work.
+ * Should always be manipulated with the cpucontrol mutex locked.
+ * Currently only swsusp uses it.
+ */
+int cpu_hotplug_disabled;
+
 #ifdef CONFIG_HOTPLUG_CPU
 static struct task_struct *lock_cpu_hotplug_owner;
 static int lock_cpu_hotplug_depth;
@@ -116,32 +122,25 @@ static int take_cpu_down(void *unused)
 	return 0;
 }
 
-int cpu_down(unsigned int cpu)
+/* Requires cpucontrol mutex to be locked */
+int __cpu_down(unsigned int cpu)
 {
 	int err;
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
 
-	if ((err = lock_cpu_hotplug_interruptible()) != 0)
-		return err;
-
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
@@ -186,7 +185,22 @@ out_thread:
 	err = kthread_stop(p);
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
-out:
+	return err;
+}
+
+int cpu_down(unsigned int cpu)
+{
+	int err;
+
+	err = lock_cpu_hotplug_interruptible();
+	if (err)
+		return err;
+
+	if (cpu_hotplug_disabled)
+		err = -EPERM;
+	else
+		err = __cpu_down(cpu);
+
 	unlock_cpu_hotplug();
 	return err;
 }
@@ -200,6 +214,11 @@ int __devinit cpu_up(unsigned int cpu)
 	if ((ret = lock_cpu_hotplug_interruptible()) != 0)
 		return ret;
 
+	if (cpu_hotplug_disabled) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;

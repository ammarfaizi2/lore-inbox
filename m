Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965291AbWKNMWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbWKNMWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWKNMWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:22:50 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:61913 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965291AbWKNMWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:22:49 -0500
Date: Tue, 14 Nov 2006 17:52:14 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       vatsa@in.ibm.com, dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: [PATCH 2/4] Define and use new events,CPU_LOCK_ACQUIRE and CPU_LOCK_RELEASE.
Message-ID: <20061114122214.GC31787@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114121832.GA31787@in.ibm.com> <20061114122050.GB31787@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114122050.GB31787@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to provide an alternate mechanism for postponing
a hotplug event instead of using a global mechanism like lock_cpu_hotplug.

The proposal is to add two new events namely CPU_LOCK_ACQUIRE and
CPU_LOCK_RELEASE. The notification for these two events would be sent
out before and after a cpu_hotplug event respectively.

During the CPU_LOCK_ACQUIRE event, a cpu-hotplug-aware subsystem is
supposed to acquire any per-subsystem hotcpu mutex ( Eg. workqueue_mutex
in kernel/workqueue.c ). 

During the CPU_LOCK_RELEASE release event the cpu-hotplug-aware subsystem
is supposed to release the per-subsystem hotcpu mutex.

The reasons for defining new events as opposed to reusing the existing events
like CPU_UP_PREPARE/CPU_UP_FAILED/CPU_ONLINE for locking/unlocking of 
per-subsystem hotcpu mutexes are as follow:

	- CPU_LOCK_ACQUIRE: All hotcpu mutexes are taken before subsystems
	start handling pre-hotplug events like CPU_UP_PREPARE/CPU_DOWN_PREPARE 
	etc, thus ensuring a clean handling of these events. 
	
	- CPU_LOCK_RELEASE: The hotcpu mutexes will be released only after
	all subsystems have handled post-hotplug events like CPU_DOWN_FAILED,
	CPU_DEAD,CPU_ONLINE etc thereby ensuring that there are no subsequent
	clashes amongst the interdependent subsystems after a cpu hotplugs.
	
This patch also uses __raw_notifier_call chain in _cpu_up to take care 
of the dependency between the two consequetive calls to
raw_notifier_call_chain.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

--
 include/linux/notifier.h |    2 ++
 kernel/cpu.c             |   15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

Index: hotplug/kernel/cpu.c
===================================================================
--- hotplug.orig/kernel/cpu.c
+++ hotplug/kernel/cpu.c
@@ -132,6 +132,8 @@ static int _cpu_down(unsigned int cpu)
 	if (!cpu_online(cpu))
 		return -EINVAL;
 
+	raw_notifier_call_chain(&cpu_chain, CPU_LOCK_ACQUIRE,
+						(void *)(long)cpu);
 	err = raw_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
 						(void *)(long)cpu);
 	if (err == NOTIFY_BAD) {
@@ -185,6 +187,8 @@ out_thread:
 	err = kthread_stop(p);
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
+	raw_notifier_call_chain(&cpu_chain, CPU_LOCK_RELEASE,
+						(void *)(long)cpu);
 	return err;
 }
 
@@ -206,13 +210,15 @@ int cpu_down(unsigned int cpu)
 /* Requires cpu_add_remove_lock to be held */
 static int __devinit _cpu_up(unsigned int cpu)
 {
-	int ret;
+	int ret, nr_calls = 0;
 	void *hcpu = (void *)(long)cpu;
 
 	if (cpu_online(cpu) || !cpu_present(cpu))
 		return -EINVAL;
 
-	ret = raw_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
+	raw_notifier_call_chain(&cpu_chain, CPU_LOCK_ACQUIRE, hcpu);
+	ret = __raw_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu,
+							-1, &nr_calls);
 	if (ret == NOTIFY_BAD) {
 		printk("%s: attempt to bring up CPU %u failed\n",
 				__FUNCTION__, cpu);
@@ -233,8 +239,9 @@ static int __devinit _cpu_up(unsigned in
 
 out_notify:
 	if (ret != 0)
-		raw_notifier_call_chain(&cpu_chain,
-				CPU_UP_CANCELED, hcpu);
+		__raw_notifier_call_chain(&cpu_chain,
+				CPU_UP_CANCELED, hcpu, nr_calls, NULL);
+	raw_notifier_call_chain(&cpu_chain, CPU_LOCK_RELEASE, hcpu);
 
 	return ret;
 }
Index: hotplug/include/linux/notifier.h
===================================================================
--- hotplug.orig/include/linux/notifier.h
+++ hotplug/include/linux/notifier.h
@@ -194,6 +194,8 @@ extern int __srcu_notifier_call_chain(st
 #define CPU_DOWN_PREPARE	0x0005 /* CPU (unsigned)v going down */
 #define CPU_DOWN_FAILED		0x0006 /* CPU (unsigned)v NOT going down */
 #define CPU_DEAD		0x0007 /* CPU (unsigned)v dead */
+#define CPU_LOCK_ACQUIRE	0x0008 /* Acquire all hotcpu locks */
+#define CPU_LOCK_RELEASE	0x0009 /* Release all hotcpu locks */
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"

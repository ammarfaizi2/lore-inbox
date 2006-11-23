Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933744AbWKWOCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933744AbWKWOCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 09:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933739AbWKWOCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 09:02:19 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:2691 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S933744AbWKWOCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 09:02:18 -0500
Date: Thu, 23 Nov 2006 18:48:52 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: akpm@osdl.org, vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org,
       dipankar@in.ibm.com
Subject: [PATCH] Handle per-subsystem mutexes for CONFIG_HOTPLUG_CPU not set.
Message-ID: <20061123131852.GA20313@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HOTPLUG_CPU is not set, lock_cpu_hotplug() and 
unlock_cpu_hotplug() default to no-ops.

However, in case of the proposed per-subsystem hotcpu mutex scheme, 
the hotcpu mutexes will be taken/released, even when
CONFIG_HOTPLUG_CPU is not set. This is an unnecessary overhead
both w.r.t space and time ;-)

This patch

* Provides a common interface for all the subsystems to lock and
unlock their per-subsystem hotcpu mutexes.
When CONFIG_HOTPLUG_CPU is not set, these operations would be no-ops.

Usage:
a) Each hotcpu aware subsystem defines the hotcpu_mutex as follows
#ifdef CONFIG_HOTPLUG_CPU
DEFINE_MUTEX(my_hotcpu_mutex);
#endif

b) The hotcpu aware subsystem uses
cpuhotplug_mutex_lock(&my_hotcpu_mutex)
and 
cpuhotplug_mutex_unlock(&my_hotcpu_mutex) 
instead of the usual mutex_lock/mutex_unlock.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

---
 include/linux/cpu.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

Index: hotplug/include/linux/cpu.h
===================================================================
--- hotplug.orig/include/linux/cpu.h
+++ hotplug/include/linux/cpu.h
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
 #include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 struct cpu {
 	int node_id;		/* The node which contains the CPU */
@@ -74,6 +75,17 @@ extern struct sysdev_class cpu_sysdev_cl
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* Stop CPUs going up and down. */
+
+static inline void cpuhotplug_mutex_lock(struct mutex *cpu_hp_mutex)
+{
+	mutex_lock(cpu_hp_mutex);
+}
+
+static inline void cpuhotplug_mutex_unlock(struct mutex *cpu_hp_mutex)
+{
+	mutex_unlock(cpu_hp_mutex);
+}
+
 extern void lock_cpu_hotplug(void);
 extern void unlock_cpu_hotplug(void);
 #define hotcpu_notifier(fn, pri) {				\
@@ -86,6 +98,9 @@ extern void unlock_cpu_hotplug(void);
 int cpu_down(unsigned int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
+#define cpuhotplug_mutex_lock(m)	do { } while (0)
+#define cpuhotplug_mutex_unlock(m)	do { } while (0)
+
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
 #define lock_cpu_hotplug_interruptible() 0
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"

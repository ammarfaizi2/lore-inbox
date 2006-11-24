Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934484AbWKXMiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934484AbWKXMiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 07:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934501AbWKXMiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 07:38:05 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:40320 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S934484AbWKXMiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 07:38:02 -0500
Date: Fri, 24 Nov 2006 17:43:44 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org,
       dipankar@in.ibm.com
Subject: [PATCH][v2] Handle per-subsystem mutexes for CONFIG_HOTPLUG_CPU not set.
Message-ID: <20061124121344.GF4666@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061123131852.GA20313@in.ibm.com> <20061123125446.3cd9ff0f.akpm@osdl.org> <20061124042702.GA4666@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124042702.GA4666@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 09:57:02AM +0530, Gautham R Shenoy wrote:
> > But what to do about the now-unneeded mutex?
> >
> > We can just leave it there if CONFIG_HOTPLUG_CPU=n but then we'll get
> > unused variable warnings for statically-defined mutexes.
> 
> Why even leave it there?
> 
> Can't we do something as follows, which has already been suggested in
> the patch description:
> 
> Each hotcpu aware subsystem defines the hotcpu_mutex as follows
> #ifdef CONFIG_HOTPLUG_CPU
> [static] DEFINE_MUTEX(my_hotcpu_mutex);
> #endif
> 
> That way, we won't be having any unneeded mutexes at all.

I take back these words. In addition to the fact that this would
introduce more #ifdef noise in .c files, this approach won't work
in cases where we will be reusing existing mutexes as hotcpu_mutexes.
Eg: workqueue_mutex in kernel/workqueue.c and cache_chain_mutex in
mm/slab.c

> > or
> >
> > #define cpuhotplug_mutex_lock(m)	do { (void)(m); } while (0)
> >
> >
> > Given that the former won't work, I'd suggest the latter ;)

The patch below implements the latter :)

This patch provides a common interface for all the subsystems to 
lock and unlock their per-subsystem hotcpu mutexes.

When CONFIG_HOTPLUG_CPU is not set, these operations would be no-ops.

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
+#define cpuhotplug_mutex_lock(m)	do { (void)(m); } while (0)
+#define cpuhotplug_mutex_unlock(m)	do { (void)(m); } while (0)
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

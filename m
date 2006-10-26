Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423274AbWJZK5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423274AbWJZK5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423299AbWJZK5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:57:49 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:30676 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423274AbWJZK5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:57:47 -0400
Date: Thu, 26 Oct 2006 16:28:31 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, gaughen@us.ibm.com, arjan@linux.intel.org,
       davej@redhat.com, venkatesh.pallipadi@intel.com, kiran@scalex86.org
Subject: [PATCH 5/5] lock_cpu_hotplug: Redesign - Lockdep support for lightweight lock_cpu_hotplug.
Message-ID: <20061026105831.GF11803@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061026104858.GA11803@in.ibm.com> <20061026105058.GB11803@in.ibm.com> <20061026105342.GC11803@in.ibm.com> <20061026105523.GD11803@in.ibm.com> <20061026105731.GE11803@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026105731.GE11803@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add lockdep support to (refcount+waitqueue) implementation of
lock_cpu_hotplug.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

---
 kernel/cpu.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

Index: hotplug/kernel/cpu.c
===================================================================
--- hotplug.orig/kernel/cpu.c
+++ hotplug/kernel/cpu.c
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/rcupdate.h>
+#include <linux/lockdep.h>
 
 static __cpuinitdata RAW_NOTIFIER_HEAD(cpu_chain);
 
@@ -61,6 +62,9 @@ static struct {
 	spinlock_t lock;
 	wait_queue_head_t read_queue;
 	wait_queue_head_t write_queue;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
 } cpu_hotplug;
 
 DEFINE_PER_CPU(int, refcount) = {0};
@@ -83,6 +87,16 @@ static inline int nr_readers(void)
 	return count;
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static inline void cpu_hotplug_lockdep_init(void)
+{
+	static struct lock_class_key __key;
+	lockdep_init_map(&cpu_hotplug.dep_map, "cpu-hotplug-lock", &__key, 0);
+}
+#else
+	#define cpu_hotplug_lockdep_init() do { } while (0);
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
 void __init cpu_hotplug_init(void)
 {
@@ -90,6 +104,7 @@ void __init cpu_hotplug_init(void)
 	spin_lock_init(&cpu_hotplug.lock);
 	init_waitqueue_head(&cpu_hotplug.read_queue);
 	init_waitqueue_head(&cpu_hotplug.write_queue);
+	cpu_hotplug_lockdep_init();
 }
 
 static void slow_path_reader_lock(void);
@@ -105,6 +120,7 @@ static void slow_path_reader_unlock(void
 */
 void lock_cpu_hotplug(void)
 {
+	rwlock_acquire_read(&cpu_hotplug.dep_map, 0, 0, _RET_IP_);
 	preempt_disable();
 	if (likely(!writer_exists())) {
 		per_cpu(refcount, smp_processor_id())++;
@@ -118,6 +134,7 @@ EXPORT_SYMBOL_GPL(lock_cpu_hotplug);
 
 void unlock_cpu_hotplug(void)
 {
+	rwlock_release(&cpu_hotplug.dep_map, 1, _RET_IP_);
 	preempt_disable();
 	if (likely(!writer_exists())) {
 		per_cpu(refcount, smp_processor_id())--;
@@ -135,6 +152,8 @@ static void cpu_hotplug_begin(void)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
+	rwlock_acquire(&cpu_hotplug.dep_map, 0, 0, _RET_IP_);
+
 	spin_lock(&cpu_hotplug.lock);
 	if (likely(cpu_hotplug.status == NO_WRITERS)) {
 		cpu_hotplug.status = WRITER_WAITING;
@@ -165,6 +184,7 @@ static void cpu_hotplug_begin(void)
 
 static void cpu_hotplug_done(void)
 {
+	rwlock_release(&cpu_hotplug.dep_map, 1, _RET_IP_);
 	spin_lock(&cpu_hotplug.lock);
 
 	if (!list_empty(&cpu_hotplug.write_queue.task_list))
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"

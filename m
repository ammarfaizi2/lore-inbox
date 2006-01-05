Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWAEE4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWAEE4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 23:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWAEE4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 23:56:47 -0500
Received: from thorn.pobox.com ([208.210.124.75]:37053 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1750829AbWAEE4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 23:56:47 -0500
Date: Wed, 4 Jan 2006 22:58:10 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix workqueue oops during cpu offline
Message-ID: <20060105045810.GE16729@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.15, powerpc systems oops when cpu 0 is offlined.  This is a
regression from 2.6.14, caused by commit id
bce61dd49d6ba7799be2de17c772e4c701558f14 ("Fix hardcoded cpu=0 in
workqueue for per_cpu_ptr() calls").

So here's what's going on:

System boots with first online cpu == 0.

kmod.c creates a single-thread workqueue "khelper"

__create_workqueue creates a workqueue thread, passing cpu 0, the
first online cpu.

create_workqueue_thread initializes the cpu_workqueue_struct at
position 0 in the alloc_percpu'd area at wq->cpu_wq.

Admin offlines cpu 0 (echo 0 > /sys/devices/system/cpu/cpu0/online)

After the cpu has been taken down, drivers/base/cpu.c::store_online
calls kobject_hotplug.

kobject_hotplug calls call_usermodehelper_keys, which queues work to
the khelper workqueue.

This is where things go wrong -- any_online_cpu() now gets 1, not 0.
In queue_work, the cpu_workqueue_struct at per_cpu_ptr(wq->cpu_wq, 1) is
uninitialized.

__queue_work blows up trying to manipulate cwq->worklist --
alloc_percpu'd areas are 0-initialized, so we deref a null pointer:

cpu 0 (hwid 0) Ready to die...
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc00000000007a874
cpu 0x1: Vector: 300 (Data Access) at [c00000009a9b74f0]
    pc: c00000000007a874: .__queue_work+0x54/0xb0
    lr: c00000000007a844: .__queue_work+0x24/0xb0
    sp: c00000009a9b7770
   msr: 8000000000001032
   dar: 0
 dsisr: 42000000
  current = 0xc00000009fd537f0
  paca    = 0xc000000000641c00
    pid   = 4330, comm = bash
enter ? for help
1:mon> t
[c00000009a9b7810] c00000000007b578 .queue_work+0xf8/0x1b0
[c00000009a9b78a0] c00000000007a654 .call_usermodehelper_keys+0x154/0x1a0
[c00000009a9b7a40] c000000000242158 .kobject_hotplug+0x398/0x3a0
[c00000009a9b7b30] c0000000002d39ec .store_online+0xec/0x100
[c00000009a9b7bc0] c0000000002ce3b4 .sysdev_store+0x44/0x60
[c00000009a9b7c40] c000000000122250 .sysfs_write_file+0x100/0x1f0
[c00000009a9b7cf0] c0000000000cb048 .vfs_write+0x108/0x1d0
[c00000009a9b7d90] c0000000000cbccc .sys_write+0x4c/0x90
[c00000009a9b7e30] c000000000008600 syscall_exit+0x0/0x18


I think the sane solution is to pick a valid index to use at system
init and stick with it.  Obviously, 0 won't work any more (I suspect
it used to work on Ben's system until wq->cpu_wq was changed from a
static NR_CPUS array to alloc_percpu).

The patch below fixes it for me on powerpc -- Ben, are you able to
test this to make sure it works on your machine?

Changelog and patch follow:

Use first_cpu(cpu_possible_map) for the single-thread workqueue case.
We used to hardcode 0, but that broke on systems where
!cpu_possible(0) when workqueue_struct->cpu_workqueue_struct was
changed from a static array to alloc_percpu.

Commit id bce61dd49d6ba7799be2de17c772e4c701558f14 ("Fix hardcoded
cpu=0 in workqueue for per_cpu_ptr() calls") fixed that for Ben's
funky sparc64 system, but it regressed my Power5.  Offlining cpu 0
oopses upon the next call to queue_work for a single-thread workqueue,
because now we try to manipulate per_cpu_ptr(wq->cpu_wq, 1), which is
uninitialized.

So we need to establish an unchanging "slot" for single-thread
workqueues which will have a valid percpu allocation.  Since
alloc_percpu keys off of cpu_possible_map, which must not change after
initialization, make this slot == first_cpu(cpu_possible_map).


Signed-off-by: Nathan Lynch <ntl@pobox.com>


--- cpuhp-workqueue-oops.orig/kernel/workqueue.c
+++ cpuhp-workqueue-oops/kernel/workqueue.c
@@ -29,7 +29,8 @@
 #include <linux/kthread.h>
 
 /*
- * The per-CPU workqueue (if single thread, we always use cpu 0's).
+ * The per-CPU workqueue (if single thread, we always use the first
+ * possible cpu).
  *
  * The sequence counters are for flush_scheduled_work().  It wants to wait
  * until until all currently-scheduled works are completed, but it doesn't
@@ -69,6 +70,8 @@ struct workqueue_struct {
 static DEFINE_SPINLOCK(workqueue_lock);
 static LIST_HEAD(workqueues);
 
+static int singlethread_cpu;
+
 /* If it's single threaded, it isn't in the list of workqueues. */
 static inline int is_single_threaded(struct workqueue_struct *wq)
 {
@@ -102,7 +105,7 @@ int fastcall queue_work(struct workqueue
 
 	if (!test_and_set_bit(0, &work->pending)) {
 		if (unlikely(is_single_threaded(wq)))
-			cpu = any_online_cpu(cpu_online_map);
+			cpu = singlethread_cpu;
 		BUG_ON(!list_empty(&work->entry));
 		__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 		ret = 1;
@@ -118,7 +121,7 @@ static void delayed_work_timer_fn(unsign
 	int cpu = smp_processor_id();
 
 	if (unlikely(is_single_threaded(wq)))
-		cpu = any_online_cpu(cpu_online_map);
+		cpu = singlethread_cpu;
 
 	__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 }
@@ -267,7 +270,7 @@ void fastcall flush_workqueue(struct wor
 
 	if (is_single_threaded(wq)) {
 		/* Always use first cpu's area. */
-		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, any_online_cpu(cpu_online_map)));
+		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
 	} else {
 		int cpu;
 
@@ -320,7 +323,7 @@ struct workqueue_struct *__create_workqu
 	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, any_online_cpu(cpu_online_map));
+		p = create_workqueue_thread(wq, singlethread_cpu);
 		if (!p)
 			destroy = 1;
 		else
@@ -374,7 +377,7 @@ void destroy_workqueue(struct workqueue_
 	/* We don't need the distraction of CPUs appearing and vanishing. */
 	lock_cpu_hotplug();
 	if (is_single_threaded(wq))
-		cleanup_workqueue_thread(wq, any_online_cpu(cpu_online_map));
+		cleanup_workqueue_thread(wq, singlethread_cpu);
 	else {
 		for_each_online_cpu(cpu)
 			cleanup_workqueue_thread(wq, cpu);
@@ -543,6 +546,7 @@ static int __devinit workqueue_cpu_callb
 
 void init_workqueues(void)
 {
+	singlethread_cpu = first_cpu(cpu_possible_map);
 	hotcpu_notifier(workqueue_cpu_callback, 0);
 	keventd_wq = create_workqueue("events");
 	BUG_ON(!keventd_wq);

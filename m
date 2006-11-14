Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933377AbWKNKYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377AbWKNKYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 05:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933379AbWKNKYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 05:24:14 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:3714 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S933377AbWKNKYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 05:24:13 -0500
Message-ID: <45599B31.1080802@openvz.org>
Date: Tue, 14 Nov 2006 13:32:17 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rml@tech9.net, devel@openvz.org
Subject: [PATCH] move_task_off_dead_cpu() should be called with disabled ints
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

move_task_off_dead_cpu() requires interrupts to be disabled,
while migrate_dead() calls it with enabled interrupts.
Added appropriate comments to functions and added
BUG_ON(!irqs_disabled()) into double_rq_lock() and
double_lock_balance() which are the origin sources of such bugs.

Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--- ./kernel/sched.c.schedx	2006-11-08 17:44:15.000000000 +0300
+++ ./kernel/sched.c	2006-11-14 11:32:24.000000000 +0300
@@ -1942,6 +1942,7 @@ static void double_rq_lock(struct rq *rq
 	__acquires(rq1->lock)
 	__acquires(rq2->lock)
 {
+	BUG_ON(!irqs_disabled());
 	if (rq1 == rq2) {
 		spin_lock(&rq1->lock);
 		__acquire(rq2->lock);	/* Fake it out ;) */
@@ -1981,6 +1982,11 @@ static void double_lock_balance(struct r
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
+	if (unlikely(!irqs_disabled())) {
+		/* printk() doesn't work good under rq->lock */
+		spin_unlock(&this_rq->lock);
+		BUG_ON(1);
+	}
 	if (unlikely(!spin_trylock(&busiest->lock))) {
 		if (busiest < this_rq) {
 			spin_unlock(&this_rq->lock);
@@ -5056,7 +5062,10 @@ wait_to_die:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* Figure out where task on dead CPU should go, use force if neccessary. */
+/*
+ * Figure out where task on dead CPU should go, use force if neccessary.
+ * NOTE: interrupts should be disabled by the caller
+ */
 static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *p)
 {
 	unsigned long flags;
@@ -5176,6 +5185,7 @@ void idle_task_exit(void)
 	mmdrop(mm);
 }
 
+/* called under rq->lock with disabled interrupts */
 static void migrate_dead(unsigned int dead_cpu, struct task_struct *p)
 {
 	struct rq *rq = cpu_rq(dead_cpu);
@@ -5192,10 +5202,11 @@ static void migrate_dead(unsigned int de
 	 * Drop lock around migration; if someone else moves it,
 	 * that's OK.  No task can be added to this CPU, so iteration is
 	 * fine.
+	 * NOTE: interrupts should be left disabled  --dev@
 	 */
-	spin_unlock_irq(&rq->lock);
+	spin_unlock(&rq->lock);
 	move_task_off_dead_cpu(dead_cpu, p);
-	spin_lock_irq(&rq->lock);
+	spin_lock(&rq->lock);
 
 	put_task_struct(p);
 }

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVKYX2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVKYX2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 18:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbVKYX2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 18:28:22 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:19608 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932291AbVKYX2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 18:28:21 -0500
Date: Fri, 25 Nov 2005 15:28:29 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, levon@movementarian.org
Subject: Re: BUG: spinlock recursion on 2.6.14-mm2 when oprofiling
Message-ID: <20051125232829.GA2405@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051118152101.GA4690@mail.ustc.edu.cn> <20051125220117.GA1836@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051125220117.GA1836@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 02:01:17PM -0800, Paul E. McKenney wrote:
> One concern on the attached patch is the possible effect on latency.
> 
> John, any reason why the dead_tasks list cannot be spliced onto a
> local list, then freed outside of the task_mortuary lock?  Any reason
> why the dying_tasks list cannot be spliced onto the dead_tasks list
> (an O(1) operation)?

And here is an alternative patch that assumes that the answer to both
questions above is "no".  It is shorter, though mostly due to use of
the list_splice_init() and list_for_each_entry_safe() primitives.


						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

 buffer_sync.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-mm2/drivers/oprofile/buffer_sync.c linux-2.6.14-mm2-fixmortuary/drivers/oprofile/buffer_sync.c
--- linux-2.6.14-mm2/drivers/oprofile/buffer_sync.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-mm2-fixmortuary/drivers/oprofile/buffer_sync.c	2005-11-25 14:51:26.000000000 -0800
@@ -46,10 +46,11 @@ static void process_task_mortuary(void);
  */
 static int task_free_notify(struct notifier_block * self, unsigned long val, void * data)
 {
+	unsigned long flags;
 	struct task_struct * task = data;
-	spin_lock(&task_mortuary);
+	spin_lock_irqsave(&task_mortuary, flags);
 	list_add(&task->tasks, &dying_tasks);
-	spin_unlock(&task_mortuary);
+	spin_unlock_irqrestore(&task_mortuary, flags);
 	return NOTIFY_OK;
 }
 
@@ -431,25 +432,22 @@ static void increment_tail(struct oprofi
  */
 static void process_task_mortuary(void)
 {
-	struct list_head * pos;
-	struct list_head * pos2;
+	unsigned long flags;
+	LIST_HEAD(local_dead_tasks);
 	struct task_struct * task;
+	struct task_struct * ttask;
 
-	spin_lock(&task_mortuary);
+	spin_lock_irqsave(&task_mortuary, flags);
 
-	list_for_each_safe(pos, pos2, &dead_tasks) {
-		task = list_entry(pos, struct task_struct, tasks);
-		list_del(&task->tasks);
-		free_task(task);
-	}
+	list_splice_init(&dead_tasks, &local_dead_tasks);
+	list_splice_init(&dying_tasks, &dead_tasks);
 
-	list_for_each_safe(pos, pos2, &dying_tasks) {
-		task = list_entry(pos, struct task_struct, tasks);
+	spin_unlock_irqrestore(&task_mortuary, flags);
+
+	list_for_each_entry_safe(task, ttask, &local_dead_tasks, tasks) {
 		list_del(&task->tasks);
-		list_add_tail(&task->tasks, &dead_tasks);
+		free_task(task);
 	}
-
-	spin_unlock(&task_mortuary);
 }
 
 

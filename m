Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756605AbWKSMIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605AbWKSMIi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 07:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756606AbWKSMIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 07:08:38 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:15540 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1756605AbWKSMIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 07:08:37 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4] swsusp: Untangle freeze_processes
Date: Sun, 19 Nov 2006 13:05:01 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200611182335.27453.rjw@sisk.pl> <200611182347.16692.rjw@sisk.pl> <20061119020926.GD15873@elf.ucw.cz>
In-Reply-To: <20061119020926.GD15873@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191305.02250.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 19 November 2006 03:09, Pavel Machek wrote:
> Hi!
> 
> > Move the loop from freeze_processes() to a separate function and call it
> > independently for user space processes and kernel threads so that the order of
> > freezing tasks is clearly visible.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  kernel/power/process.c |   88 ++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 58 insertions(+), 30 deletions(-)
> >
> 
> >  		do_each_thread(g, p) {
> > +			if (is_user_space(p)) {
> > +				if(!freeze_user_space)
> > +					continue;
> > +			} else {
> > +				if(freeze_user_space)
> > +					continue;
> > +			}
> 
> Needs space between if and (, but lets use if (is_user_space() !=
> freeze_user_space) trick here, too.

OK

New version of the patch follows.

---
Move the loop from freeze_processes() to a separate function and call it
independently for user space processes and kernel threads so that the order of
freezing tasks is clearly visible.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   84 +++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 30 deletions(-)

Index: linux-2.6.19-rc5-mm2/kernel/power/process.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/power/process.c
+++ linux-2.6.19-rc5-mm2/kernel/power/process.c
@@ -86,24 +86,23 @@ static inline int is_user_space(struct t
 	return p->mm && !(p->flags & PF_BORROWED_MM);
 }
 
-/* 0 = success, else # of processes that we failed to stop */
-int freeze_processes(void)
+static unsigned int try_to_freeze_tasks(int freeze_user_space)
 {
-	int todo, nr_user, user_frozen;
-	unsigned long start_time;
 	struct task_struct *g, *p;
+	unsigned long end_time;
+	unsigned int todo;
 
-	printk("Stopping tasks... ");
-	start_time = jiffies;
-	user_frozen = 0;
+	end_time = jiffies + TIMEOUT;
 	do {
-		nr_user = todo = 0;
+		todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (!freezeable(p))
 				continue;
+
 			if (frozen(p))
 				continue;
+
 			if (p->state == TASK_TRACED &&
 			    (frozen(p->parent) ||
 			     p->parent->state == TASK_STOPPED)) {
@@ -111,51 +110,76 @@ int freeze_processes(void)
 				continue;
 			}
 			if (is_user_space(p)) {
+				if (!freeze_user_space)
+					continue;
+
 				/* Freeze the task unless there is a vfork
 				 * completion pending
 				 */
 				if (!p->vfork_done)
 					freeze_process(p);
-				nr_user++;
 			} else {
-				/* Freeze only if the user space is frozen */
-				if (user_frozen)
-					freeze_process(p);
-				todo++;
+				if (freeze_user_space)
+					continue;
+
+				freeze_process(p);
 			}
+			todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		todo += nr_user;
-		if (!user_frozen && !nr_user) {
-			sys_sync();
-			start_time = jiffies;
-		}
-		user_frozen = !nr_user;
 		yield();			/* Yield is okay here */
-		if (todo && time_after(jiffies, start_time + TIMEOUT))
+		if (todo && time_after(jiffies, end_time))
 			break;
-	} while(todo);
+	} while (todo);
 
-	/* This does not unfreeze processes that are already frozen
-	 * (we have slightly ugly calling convention in that respect,
-	 * and caller must call thaw_processes() if something fails),
-	 * but it cleans up leftover PF_FREEZE requests.
-	 */
 	if (todo) {
+		/* This does not unfreeze processes that are already frozen
+		 * (we have slightly ugly calling convention in that respect,
+		 * and caller must call thaw_processes() if something fails),
+		 * but it cleans up leftover PF_FREEZE requests.
+		 */
 		printk("\n");
-		printk(KERN_ERR "Stopping tasks timed out "
-			"after %d seconds (%d tasks remaining):\n",
-			TIMEOUT / HZ, todo);
+		printk(KERN_ERR "Stopping %s timed out after %d seconds "
+				"(%d tasks refusing to freeze):\n",
+				freeze_user_space ? "user space processes" :
+					"kernel threads",
+				TIMEOUT / HZ, todo);
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
+			if (is_user_space(p) == !freeze_user_space)
+				continue;
+
 			if (freezeable(p) && !frozen(p))
 				printk(KERN_ERR " %s\n", p->comm);
+
 			cancel_freezing(p);
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		return todo;
 	}
 
+	return todo;
+}
+
+/**
+ *	freeze_processes - tell processes to enter the refrigerator
+ *
+ *	Returns 0 on success, or the number of processes that didn't freeze,
+ *	although they were told to.
+ */
+int freeze_processes(void)
+{
+	unsigned int nr_unfrozen;
+
+	printk("Stopping tasks ... ");
+	nr_unfrozen = try_to_freeze_tasks(FREEZER_USER_SPACE);
+	if (nr_unfrozen)
+		return nr_unfrozen;
+
+	sys_sync();
+	nr_unfrozen = try_to_freeze_tasks(FREEZER_KERNEL_THREADS);
+	if (nr_unfrozen)
+		return nr_unfrozen;
+
 	printk("done.\n");
 	BUG_ON(in_atomic());
 	return 0;

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLQHw0>; Sun, 17 Dec 2000 02:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbQLQHwQ>; Sun, 17 Dec 2000 02:52:16 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:55761 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129345AbQLQHwE>; Sun, 17 Dec 2000 02:52:04 -0500
Message-ID: <3A3C6A58.25B73FAD@uow.edu.au>
Date: Sun, 17 Dec 2000 18:25:12 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
In-Reply-To: <20001217034928.A410@ppc.vc.cvut.cz> <Pine.LNX.4.10.10012161859340.23256-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 17 Dec 2000, Petr Vandrovec wrote:
> >   my 2.4.0-test13-pre1 just stopped answering to my keystrokes.
> > I've found that it is looping in tqueue_bh and flush_to_ldisc
> > still again and again.
> 
> Thanks, I think you found the big problem with test12.
> 
> > Is current run_task_queue() behavior intentional, or is it
> > only bug introduced by changing task queue to list based
> > implementation?
> 
> It's a bug.
> 
> Ho humm. I'll have to check what the proper fix is. Right now the rule is
> that nobody can _ever_ remove himself from a task queue, although there is
> one bad user that does exactly that, and that means that it should be ok
> to just cache the "next" pointer in run_task_queue(), and make it look
> something like
> 

How about this?

- Create a private copy of the list, zap the original and then
  walk the list in privacy.  New list additions will then go
  onto the next instantiation.

- Make the function non-inline.  It's too big.  Semi-randomly
  chose softirq.c for this.  Shrinks kernel by ~2k.

  The test for list emptiness outside the spinlock is racy,
  but this doesn't matter.

- Make the commentary slightly less inaccurate.

- As we walk the list, set the entries to point to NULL.  This
  will force an oops from anyone who tries to remove entries
  during or after the walk.

- If anyone wants to remove a live entry from a list that's OK, but
  they should do it by locking the list and walking it under the
  lock to verify that the entry is still on it.  If you find it
  then fine: delete it.  If you didn't find it then your callback
  could currently be running.  Beware.




--- linux-2.4.0-test13-pre2/include/linux/tqueue.h	Tue Dec 12 19:24:23 2000
+++ linux-akpm/include/linux/tqueue.h	Sun Dec 17 18:09:19 2000
@@ -53,22 +53,22 @@
  * To implement your own list of active bottom halfs, use the following
  * two definitions:
  *
- * DECLARE_TASK_QUEUE(my_bh);
- * struct tq_struct run_my_bh = {
- * 	routine: (void (*)(void *)) run_task_queue,
- *	data: &my_bh
+ * DECLARE_TASK_QUEUE(my_tqueue);
+ * struct tq_struct my_task = {
+ * 	routine: (void (*)(void *)) my_routine,
+ *	data: &my_data
  * };
  *
- * To activate a bottom half on your list, use:
+ * To activate a bottom half on a list, use:
  *
- *     queue_task(tq_pointer, &my_bh);
+ *	queue_task(&my_task, &my_tqueue);
  *
- * To run the bottom halfs on your list put them on the immediate list by:
+ * To later run the queued tasks use
  *
- *     queue_task(&run_my_bh, &tq_immediate);
+ *	run_task_queue(&my_tqueue);
  *
- * This allows you to do deferred procession.  For example, you could
- * have a bottom half list tq_timer, which is marked active by the timer
+ * This allows you to do deferred processing.  For example, you could
+ * have a task queue called tq_timer, which is executed within the timer
  * interrupt.
  */
 
@@ -78,8 +78,7 @@
  * Queue a task on a tq.  Return non-zero if it was successfully
  * added.
  */
-static inline int queue_task(struct tq_struct *bh_pointer,
-			   task_queue *bh_list)
+static inline int queue_task(struct tq_struct *bh_pointer, task_queue *bh_list)
 {
 	int ret = 0;
 	if (!test_and_set_bit(0,&bh_pointer->sync)) {
@@ -95,32 +94,13 @@
 /*
  * Call all "bottom halfs" on a given list.
  */
-static inline void run_task_queue(task_queue *list)
-{
-	while (!list_empty(list)) {
-		unsigned long flags;
-		struct list_head *next;
-
-		spin_lock_irqsave(&tqueue_lock, flags);
-		next = list->next;
-		if (next != list) {
-			void *arg;
-			void (*f) (void *);
-			struct tq_struct *p;
 
-			list_del(next);
-			p = list_entry(next, struct tq_struct, list);
-			arg = p->data;
-			f = p->routine;
-			p->sync = 0;
-			spin_unlock_irqrestore(&tqueue_lock, flags);
+extern void __run_task_queue(task_queue *list);
 
-			if (f)
-				f(arg);
-			continue;
-		}
-		spin_unlock_irqrestore(&tqueue_lock, flags);
-	}
+static inline void run_task_queue(task_queue *list)
+{
+	if (TQ_ACTIVE(*list))
+		__run_task_queue(list);
 }
 
 #endif /* _LINUX_TQUEUE_H */
--- linux-2.4.0-test13-pre2/kernel/softirq.c	Sun Oct 15 01:27:46 2000
+++ linux-akpm/kernel/softirq.c	Sun Dec 17 17:50:01 2000
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/tqueue.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -288,4 +289,28 @@
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
 }
 
+void __run_task_queue(task_queue *list)
+{
+	struct list_head head, *next;
+	unsigned long flags;
 
+	spin_lock_irqsave(&tqueue_lock, flags);
+	list_add(&head, list);
+	list_del_init(list);
+	spin_unlock_irqrestore(&tqueue_lock, flags);
+
+	next = head.next;
+	while (next != &head) {
+		void (*f) (void *);
+		struct tq_struct *p;
+
+		p = list_entry(next, struct tq_struct, list);
+		next = next->next;
+		/* Debug: force an oops from people who delete entries */
+		next->prev->next = next->prev->prev = 0;
+		f = p->routine;
+		p->sync = 0;
+		if (f)
+			f(p->data);
+	}
+}
--- linux-2.4.0-test13-pre2/kernel/ksyms.c	Tue Dec 12 19:24:23 2000
+++ linux-akpm/kernel/ksyms.c	Sun Dec 17 17:50:41 2000
@@ -524,6 +524,7 @@
 EXPORT_SYMBOL(remove_bh);
 EXPORT_SYMBOL(tasklet_init);
 EXPORT_SYMBOL(tasklet_kill);
+EXPORT_SYMBOL(__run_task_queue);
 
 /* init task, for moving kthread roots - ought to export a function ?? */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

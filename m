Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129622AbRAaXMw>; Wed, 31 Jan 2001 18:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129620AbRAaXMn>; Wed, 31 Jan 2001 18:12:43 -0500
Received: from hermes.mixx.net ([212.84.196.2]:20740 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129622AbRAaXMa>;
	Wed, 31 Jan 2001 18:12:30 -0500
Message-ID: <3A789B63.3CAB63C0@innominate.de>
Date: Thu, 01 Feb 2001 00:10:27 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [RFC] New Improved Cleaner Whiter Timer Interface
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an improved timer interface as suggested by Rusty and elaborated
by me.  It turned out that the original problem I set out to solve was
already solved (and this approach would not have solved it anyway) but
there is a compelling reason for taking this seriously: there are four
fewer spinlock ops per timer cycle on SMP.  UP is slightly faster too,
though the difference isn't nearly as dramatic.  There are two changes
from the existing interface:

  1) Rescheduling is done by run_timer_list, not by the timer itself. 
The timer event returns a value indicating how far in the future it
should be rescheduled, 0 => don't reschedule (one-shot).

  2) The parameter passed to timer->event is (struct timer *), not long
int data, allowing the timer to identify itself and perhaps modify its
data or event field.

To ease the pain of this incompatible interface, this patch retains
compatibility with the old style interface, and the cost of this is just
a one test.

The second of the two patches below shows typical usage.

--- ../2.4.1.clean/include/linux/timer.h	Tue Jan 30 08:24:55 2001
+++ ./include/linux/timer.h	Wed Jan 31 23:32:24 2001
@@ -22,6 +22,7 @@
 	unsigned long expires;
 	unsigned long data;
 	void (*function)(unsigned long);
+	unsigned long (*event)(unsigned long data);
 };
 
 extern void add_timer(struct timer_list * timer);
@@ -49,6 +50,7 @@
 static inline void init_timer(struct timer_list * timer)
 {
 	timer->list.next = timer->list.prev = NULL;
+	timer->event = NULL; /* can get rid of this */
 }
 
 static inline int timer_pending (const struct timer_list * timer)
--- ../2.4.1.clean/kernel/timer.c	Sun Dec 10 18:53:19 2000
+++ ./kernel/timer.c	Wed Jan 31 23:32:24 2001
@@ -299,21 +299,26 @@
 repeat:
 		head = tv1.vec + tv1.index;
 		curr = head->next;
-		if (curr != head) {
-			struct timer_list *timer;
-			void (*fn)(unsigned long);
-			unsigned long data;
-
-			timer = list_entry(curr, struct timer_list, list);
- 			fn = timer->function;
- 			data= timer->data;
-
+ 		if (curr != head) {
+			struct timer_list *timer = list_entry(curr, struct timer_list,
list);
 			detach_timer(timer);
 			timer->list.next = timer->list.prev = NULL;
 			timer_enter(timer);
-			spin_unlock_irq(&timerlist_lock);
-			fn(data);
-			spin_lock_irq(&timerlist_lock);
+			if (timer->event)
+			{
+				unsigned long requeue = timer->event(timer);
+				if (requeue)
+				{
+					timer->expires += requeue;
+					internal_add_timer(timer);
+				}
+			}
+			else
+			{
+				spin_unlock_irq(&timerlist_lock);
+				timer->function(timer->data); /* this should die */
+				spin_lock_irq(&timerlist_lock);
+			}
 			timer_exit();
 			goto repeat;
 		}

-------------
Sample usage:
-------------

--- ../2.4.1.clean/fs/buffer.c	Mon Jan 15 21:42:32 2001
+++ ./fs/buffer.c	Wed Jan 31 23:32:24 2001
@@ -2792,9 +2792,23 @@
 	}
 }
 
+unsigned long foo_event (struct timer_list *timer)
+{
+	printk ("Foo %i\n", timer->data);
+	return timer->data--? HZ: 0;
+}
+
 static int __init bdflush_init(void)
 {
 	DECLARE_MUTEX_LOCKED(sem);
+
+	/* New timer interface demo */
+	static struct timer_list foo_timer;
+	init_timer (&foo_timer);
+	foo_timer.event = foo_event;
+	foo_timer.data = 10;
+	add_timer (&foo_timer);
+
 	kernel_thread(bdflush, &sem, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	down(&sem);
 	kernel_thread(kupdate, &sem, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

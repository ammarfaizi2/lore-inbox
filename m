Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRBBBP5>; Thu, 1 Feb 2001 20:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbRBBBPr>; Thu, 1 Feb 2001 20:15:47 -0500
Received: from hermes.mixx.net ([212.84.196.2]:53508 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129191AbRBBBP1>;
	Thu, 1 Feb 2001 20:15:27 -0500
Message-ID: <3A7A09B7.75C3DFA6@innominate.de>
Date: Fri, 02 Feb 2001 02:13:27 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Improved Cleaner Whiter Timer Interface
In-Reply-To: <3A789B63.3CAB63C0@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ->event interface holds the timerlist_lock across the entire
->event call invocation there is no SMP timer add-back race and the
timer_enter/exit mechanism isn't needed, so more baggage can go.  The
timer_enter/exit is therefore moved off the ->event patch to the legacy
path.  Normal del_timer is all that's needed to delete an ->event style
timer.

The only problem with this is, with the timerlist_lock held all the way
through the ->event execution there is bound to be more contention. 
This is only a temporary problem: run_timer_list is going to be per-cpu
anyway, with a per-cpu spinlock.

The (trivially) updated patch:

--- ../2.4.1.clean/include/linux/timer.h	Tue Jan 30 08:24:55 2001
+++ ./include/linux/timer.h	Fri Feb  2 01:02:02 2001
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
+	timer->event = NULL; /* not needed if no ->function */
 }
 
 static inline int timer_pending (const struct timer_list * timer)
--- ../2.4.1.clean/kernel/timer.c	Sun Dec 10 18:53:19 2000
+++ ./kernel/timer.c	Fri Feb  2 01:02:02 2001
@@ -299,22 +299,27 @@
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
-			timer_enter(timer);
-			spin_unlock_irq(&timerlist_lock);
-			fn(data);
-			spin_lock_irq(&timerlist_lock);
-			timer_exit();
+			if (timer->event)
+			{
+				unsigned long requeue = timer->event(timer);
+				if (requeue)
+				{
+					timer->expires = timer_jiffies + requeue;
+					internal_add_timer(timer);
+				}
+			}
+			else
+			{
+				timer_enter(timer);
+				spin_unlock_irq(&timerlist_lock);
+				timer->function(timer->data); /* this should die */
+				spin_lock_irq(&timerlist_lock);
+				timer_exit();
+			}
 			goto repeat;
 		}
 		++timer_jiffies; 

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

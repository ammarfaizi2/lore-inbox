Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130694AbRA3V0m>; Tue, 30 Jan 2001 16:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131904AbRA3V0c>; Tue, 30 Jan 2001 16:26:32 -0500
Received: from hermes.mixx.net ([212.84.196.2]:16903 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130694AbRA3V0Q>;
	Tue, 30 Jan 2001 16:26:16 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Manfred Spraul <manfred@colorfullife.com>,
        Rusty Russell <rusty@linuxcare.com.au>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [RFC] New Improved Stronger Whiter Timers (was: Kernel Janitor)
Date: Tue, 30 Jan 2001 22:22:01 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <E14NPEr-0005LR-00@halfway> <01013021114409.28895@gimli>
In-Reply-To: <01013021114409.28895@gimli>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <0101302224070B.28895@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Manfred Spraul wrote:
> This one is an UP and SMP race:
> 
>   spin_unlock_irq(&timerlist_lock); 
> + if (timer->event) 
> + { 
> + if ((requeue = timer->event(data))) 
> + { 
> + timer->expires += requeue; 
> + internal_add_timer(timer); 
> + } 
> + } 
> + else 
> + timer->function(data); /* bad old way */ 
>   spin_lock_irq(&timerlist_lock); 
> 
> internal_add_timer assumes that the timerlist_lock is acquired.

Yes, oops, here is the fix.

--- ../2.4.1.clean/include/linux/timer.h	Tue Jan 30 08:24:55 2001
+++ ./include/linux/timer.h	Tue Jan 30 21:52:58 2001
@@ -22,6 +22,7 @@
 	unsigned long expires;
 	unsigned long data;
 	void (*function)(unsigned long);
+	unsigned long (*event)(unsigned long data);
 };
 
 extern void add_timer(struct timer_list * timer);
@@ -49,6 +50,9 @@
 static inline void init_timer(struct timer_list * timer)
 {
 	timer->list.next = timer->list.prev = NULL;
+	timer->function = NULL;
+	timer->event = NULL;
+	timer->data = 0;
 }
 
 static inline int timer_pending (const struct timer_list * timer)
--- ../2.4.1.clean/kernel/timer.c	Sun Dec 10 18:53:19 2000
+++ ./kernel/timer.c	Tue Jan 30 22:09:09 2001
@@ -301,19 +301,30 @@
 		curr = head->next;
 		if (curr != head) {
 			struct timer_list *timer;
-			void (*fn)(unsigned long);
-			unsigned long data;
+			unsigned long data, requeue;
 
 			timer = list_entry(curr, struct timer_list, list);
- 			fn = timer->function;
  			data= timer->data;
 
 			detach_timer(timer);
 			timer->list.next = timer->list.prev = NULL;
 			timer_enter(timer);
 			spin_unlock_irq(&timerlist_lock);
-			fn(data);
-			spin_lock_irq(&timerlist_lock);
+			if (timer->event)
+			{
+				requeue = timer->event(data);
+				spin_lock_irq(&timerlist_lock);
+				if (requeue)
+				{
+					timer->expires += requeue;
+					internal_add_timer(timer);
+				}
+			}
+			else
+			{
+				timer->function(data); /* bad old way */
+				spin_lock_irq(&timerlist_lock);
+			}
 			timer_exit();
 			goto repeat;
 		}

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

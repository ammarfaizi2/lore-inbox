Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRA3UOD>; Tue, 30 Jan 2001 15:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRA3UNx>; Tue, 30 Jan 2001 15:13:53 -0500
Received: from hermes.mixx.net ([212.84.196.2]:33285 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129763AbRA3UNv>;
	Tue, 30 Jan 2001 15:13:51 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Rusty Russell <rusty@linuxcare.com.au>
Subject: [RFC] New Improved Stronger Whiter Timers (was: Kernel Janitor)
Date: Tue, 30 Jan 2001 20:37:53 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <E14NPEr-0005LR-00@halfway>
In-Reply-To: <E14NPEr-0005LR-00@halfway>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01013021114409.28895@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Rusty Russell wrote:
> In message <3A74451F.DA29FD17@uow.edu.au> you write:
> > 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html
> > 
> > A lot of the timer deletion races are hard to fix because of
> > the deadlock problem.
> 
> Hmmm...
> 
> 	For 2.5, changing the timer interface to disallow mod_timer or
> add_timer (equivalent) on self, and making the timerfn return num
> jiffies to next run (0 = don't rerun) would solve this, right?
> I don't see a maintainable way of solving this otherwise,
> 
> 	Of course, kfree'ing the timer struct and returning non-zero
> would be a *bug*...

Here's a patch that implements your idea together with a hack by me to
make it work with existing code: ->event is non-null for the new
behaviour, null for the broken behavior.  The new behaviour is that
timers don't re-add themselves anymore, run_timer_list does, so when
you kill a timer it stays dead.

--- 2.4.1.clean/include/linux/timer.h	Tue Jan 30 08:24:55 2001
+++ 2.4.1/include/linux/timer.h	Tue Jan 30 20:59:01 2001
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
--- 2.4.1.clean/kernel/timer.c	Sun Dec 10 18:53:19 2000
+++ 2.4.1/kernel/timer.c	Tue Jan 30 20:59:01 2001
@@ -301,18 +301,25 @@
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
+			if (timer->event)
+			{
+				if ((requeue = timer->event(data)))
+				{
+					timer->expires += requeue;
+					internal_add_timer(timer);
+				}
+			}
+			else
+				timer->function(data); /* bad old way */
 			spin_lock_irq(&timerlist_lock);
 			timer_exit();
 			goto repeat;

-------------------
Here's some test code.  It kprintS a 10-step countdown during init:

--- 2.4.1.clean/fs/buffer.c	Mon Jan 15 21:42:32 2001
+++ 2.4.1/fs/buffer.c	Tue Jan 30 20:59:01 2001
@@ -2792,9 +2792,22 @@
 	}
 }
 
+struct timer_list foo_timer;
+
+unsigned long foo_event (unsigned long data)
+{
+	printk ("Foo %i\n", foo_timer.data);
+	return --foo_timer.data? HZ: 0;
+}
+
 static int __init bdflush_init(void)
 {
 	DECLARE_MUTEX_LOCKED(sem);
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

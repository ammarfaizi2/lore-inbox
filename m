Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWARJCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWARJCu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWARJCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:02:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55776 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030204AbWARJCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:02:48 -0500
Date: Wed, 18 Jan 2006 10:02:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ntl@pobox.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
       michael@ellerman.id.au, linuxppc64-dev@ozlabs.org, serue@us.ibm.com,
       paulus@au1.ibm.com, torvalds@osdl.org
Subject: [patch] work around ppc64 bootup bug by making mutex-debugging save/restore irqs
Message-ID: <20060118090243.GA15165@elte.hu>
References: <200601180032.46867.michael@ellerman.id.au> <20060117140050.GA13188@elte.hu> <200601181119.39872.michael@ellerman.id.au> <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org> <20060118072815.GR2846@localhost.localdomain> <20060117233734.506c2f2e.akpm@osdl.org> <20060118080828.GA2324@elte.hu> <20060118002459.3bc8f75a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118002459.3bc8f75a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Does it hide bugs that dont normally trigger 
> > during bootups on real hardware, but which could trigger on e.g. UML or 
> > on Xen? I really think such ugly workarounds are not justified, if other 
> > arches can get their act together. Would you make such an exception for 
> > other arches too, like ARM?
> 
> Don't care really, as long as a) the problems don't hit -mm or 
> mainline and b) someone else fixes them.  Yes, it'd be nice to fix 
> these things, and we might even find real bugs.  Perhaps things are 
> better now, but I suspect it's a can of worms.

patch to mutex code below.

-- 

it seems ppc64 wants to lock mutexes in early bootup code, with 
interrupts disabled, and they expect interrupts to stay disabled, else 
they crash.

work this bug around by making mutex debugging variants save/restore irq 
flags.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/mutex-debug.c |   12 ++++++------
 kernel/mutex-debug.h |   25 +++++--------------------
 kernel/mutex.c       |   21 ++++++++++++---------
 kernel/mutex.h       |    6 ++++--
 4 files changed, 27 insertions(+), 37 deletions(-)

Index: linux/kernel/mutex-debug.c
===================================================================
--- linux.orig/kernel/mutex-debug.c
+++ linux/kernel/mutex-debug.c
@@ -153,13 +153,13 @@ next:
 			continue;
 		count++;
 		cursor = curr->next;
-		debug_spin_lock_restore(&debug_mutex_lock, flags);
+		debug_spin_unlock_restore(&debug_mutex_lock, flags);
 
 		printk("\n#%03d:            ", count);
 		printk_lock(lock, filter ? 0 : 1);
 		goto next;
 	}
-	debug_spin_lock_restore(&debug_mutex_lock, flags);
+	debug_spin_unlock_restore(&debug_mutex_lock, flags);
 	printk("\n");
 }
 
@@ -316,7 +316,7 @@ void mutex_debug_check_no_locks_held(str
 			continue;
 		list_del_init(curr);
 		DEBUG_OFF();
-		debug_spin_lock_restore(&debug_mutex_lock, flags);
+		debug_spin_unlock_restore(&debug_mutex_lock, flags);
 
 		printk("BUG: %s/%d, lock held at task exit time!\n",
 			task->comm, task->pid);
@@ -325,7 +325,7 @@ void mutex_debug_check_no_locks_held(str
 			printk("exiting task is not even the owner??\n");
 		return;
 	}
-	debug_spin_lock_restore(&debug_mutex_lock, flags);
+	debug_spin_unlock_restore(&debug_mutex_lock, flags);
 }
 
 /*
@@ -352,7 +352,7 @@ void mutex_debug_check_no_locks_freed(co
 			continue;
 		list_del_init(curr);
 		DEBUG_OFF();
-		debug_spin_lock_restore(&debug_mutex_lock, flags);
+		debug_spin_unlock_restore(&debug_mutex_lock, flags);
 
 		printk("BUG: %s/%d, active lock [%p(%p-%p)] freed!\n",
 			current->comm, current->pid, lock, from, to);
@@ -362,7 +362,7 @@ void mutex_debug_check_no_locks_freed(co
 			printk("freeing task is not even the owner??\n");
 		return;
 	}
-	debug_spin_lock_restore(&debug_mutex_lock, flags);
+	debug_spin_unlock_restore(&debug_mutex_lock, flags);
 }
 
 /*
Index: linux/kernel/mutex-debug.h
===================================================================
--- linux.orig/kernel/mutex-debug.h
+++ linux/kernel/mutex-debug.h
@@ -46,21 +46,6 @@ extern void mutex_remove_waiter(struct m
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name);
 
-#define debug_spin_lock(lock)				\
-	do {						\
-		local_irq_disable();			\
-		if (debug_mutex_on)			\
-			spin_lock(lock);		\
-	} while (0)
-
-#define debug_spin_unlock(lock)				\
-	do {						\
-		if (debug_mutex_on)			\
-			spin_unlock(lock);		\
-		local_irq_enable();			\
-		preempt_check_resched();		\
-	} while (0)
-
 #define debug_spin_lock_save(lock, flags)		\
 	do {						\
 		local_irq_save(flags);			\
@@ -68,7 +53,7 @@ extern void debug_mutex_init(struct mute
 			spin_lock(lock);		\
 	} while (0)
 
-#define debug_spin_lock_restore(lock, flags)		\
+#define debug_spin_unlock_restore(lock, flags)		\
 	do {						\
 		if (debug_mutex_on)			\
 			spin_unlock(lock);		\
@@ -76,20 +61,20 @@ extern void debug_mutex_init(struct mute
 		preempt_check_resched();		\
 	} while (0)
 
-#define spin_lock_mutex(lock)				\
+#define spin_lock_mutex(lock, flags)			\
 	do {						\
 		struct mutex *l = container_of(lock, struct mutex, wait_lock); \
 							\
 		DEBUG_WARN_ON(in_interrupt());		\
-		debug_spin_lock(&debug_mutex_lock);	\
+		debug_spin_lock_save(&debug_mutex_lock, flags); \
 		spin_lock(lock);			\
 		DEBUG_WARN_ON(l->magic != l);		\
 	} while (0)
 
-#define spin_unlock_mutex(lock)				\
+#define spin_unlock_mutex(lock, flags)			\
 	do {						\
 		spin_unlock(lock);			\
-		debug_spin_unlock(&debug_mutex_lock);	\
+		debug_spin_unlock_restore(&debug_mutex_lock, flags);	\
 	} while (0)
 
 #define DEBUG_OFF()					\
Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -125,10 +125,11 @@ __mutex_lock_common(struct mutex *lock, 
 	struct task_struct *task = current;
 	struct mutex_waiter waiter;
 	unsigned int old_val;
+	unsigned long flags;
 
 	debug_mutex_init_waiter(&waiter);
 
-	spin_lock_mutex(&lock->wait_lock);
+	spin_lock_mutex(&lock->wait_lock, flags);
 
 	debug_mutex_add_waiter(lock, &waiter, task->thread_info, ip);
 
@@ -157,7 +158,7 @@ __mutex_lock_common(struct mutex *lock, 
 		if (unlikely(state == TASK_INTERRUPTIBLE &&
 						signal_pending(task))) {
 			mutex_remove_waiter(lock, &waiter, task->thread_info);
-			spin_unlock_mutex(&lock->wait_lock);
+			spin_unlock_mutex(&lock->wait_lock, flags);
 
 			debug_mutex_free_waiter(&waiter);
 			return -EINTR;
@@ -165,9 +166,9 @@ __mutex_lock_common(struct mutex *lock, 
 		__set_task_state(task, state);
 
 		/* didnt get the lock, go to sleep: */
-		spin_unlock_mutex(&lock->wait_lock);
+		spin_unlock_mutex(&lock->wait_lock, flags);
 		schedule();
-		spin_lock_mutex(&lock->wait_lock);
+		spin_lock_mutex(&lock->wait_lock, flags);
 	}
 
 	/* got the lock - rejoice! */
@@ -178,7 +179,7 @@ __mutex_lock_common(struct mutex *lock, 
 	if (likely(list_empty(&lock->wait_list)))
 		atomic_set(&lock->count, 0);
 
-	spin_unlock_mutex(&lock->wait_lock);
+	spin_unlock_mutex(&lock->wait_lock, flags);
 
 	debug_mutex_free_waiter(&waiter);
 
@@ -203,10 +204,11 @@ static fastcall noinline void
 __mutex_unlock_slowpath(atomic_t *lock_count __IP_DECL__)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
+	unsigned long flags;
 
 	DEBUG_WARN_ON(lock->owner != current_thread_info());
 
-	spin_lock_mutex(&lock->wait_lock);
+	spin_lock_mutex(&lock->wait_lock, flags);
 
 	/*
 	 * some architectures leave the lock unlocked in the fastpath failure
@@ -231,7 +233,7 @@ __mutex_unlock_slowpath(atomic_t *lock_c
 
 	debug_mutex_clear_owner(lock);
 
-	spin_unlock_mutex(&lock->wait_lock);
+	spin_unlock_mutex(&lock->wait_lock, flags);
 }
 
 /*
@@ -276,9 +278,10 @@ __mutex_lock_interruptible_slowpath(atom
 static inline int __mutex_trylock_slowpath(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
+	unsigned long flags;
 	int prev;
 
-	spin_lock_mutex(&lock->wait_lock);
+	spin_lock_mutex(&lock->wait_lock, flags);
 
 	prev = atomic_xchg(&lock->count, -1);
 	if (likely(prev == 1))
@@ -287,7 +290,7 @@ static inline int __mutex_trylock_slowpa
 	if (likely(list_empty(&lock->wait_list)))
 		atomic_set(&lock->count, 0);
 
-	spin_unlock_mutex(&lock->wait_lock);
+	spin_unlock_mutex(&lock->wait_lock, flags);
 
 	return prev == 1;
 }
Index: linux/kernel/mutex.h
===================================================================
--- linux.orig/kernel/mutex.h
+++ linux/kernel/mutex.h
@@ -9,8 +9,10 @@
  * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
 
-#define spin_lock_mutex(lock)			spin_lock(lock)
-#define spin_unlock_mutex(lock)			spin_unlock(lock)
+#define spin_lock_mutex(lock, flags) \
+		do { spin_lock(lock); (void)(flags); } while (0)
+#define spin_unlock_mutex(lock, flags) \
+		do { spin_unlock(lock); (void)(flags); } while (0)
 #define mutex_remove_waiter(lock, waiter, ti) \
 		__list_del((waiter)->list.prev, (waiter)->list.next)
 

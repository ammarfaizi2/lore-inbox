Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVF0JvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVF0JvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVF0JvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:51:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45263 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261602AbVF0Ju6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:50:58 -0400
Date: Mon, 27 Jun 2005 11:48:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org
Subject: [patch] spinlock-debug fix
Message-ID: <20050627094844.GA16357@elte.hu>
References: <fa.h6rvsi4.j68fhk@ifi.uio.no> <42BFA05B.1090208@reub.net> <20050627002429.40231fdf.akpm@osdl.org> <42BFAF1F.8050201@reub.net> <20050627012226.450bc86d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627012226.450bc86d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> >  > Anyway, scary trace.  It look like some spinlock is thought to be in the
> >  > wrong state in schedule().  Send the .config, please.
> > 
> >  Now online at  http://www.reub.net/kernel/.config
> 
> Me too.
> 
> BUG: spinlock recursion on CPU#0, swapper/0, c120d520             
>  [<c01039ed>] dump_stack+0x19/0x20                   
>  [<c01d9af2>] spin_bug+0x42/0x54  
>  [<c01d9bfa>] _raw_spin_lock+0x3e/0x84
>  [<c031d0ad>] _spin_lock+0x9/0x10     
>  [<c031b9e9>] schedule+0x479/0xbc8
>  [<c0100cb4>] cpu_idle+0x88/0x8c  
>  [<c01002c1>] rest_init+0x21/0x28
>  [<c0442899>] start_kernel+0x151/0x158
>  [<c010020f>] 0xc010020f              
> Kernel panic - not syncing: bad locking
> 
> The bug is in the new spinlock debugging code itself.  Ingo, can you 
> test that .config please?

couldnt reproduce it on an UP box, nor on an SMP/HT 2/4-way box, but it 
finally triggered on a 2-way SMP box.

the bug is that current->pid is not a unique identifier on SMP (doh!).  

The patch below fixes the bug - which also happens to be a speedup for 
the debugging code, as the ->pid dereferencing does not have to be done 
anymore. Also, i've disabled the panicing for now.

	Ingo

- change owner_pid to owner, to fix bad pid uniqueness assumption on SMP
- some more debug output printed
- dont panic for now

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/spinlock_types.h |   16 ++++++++++------
 kernel/sched.c                 |    2 +-
 lib/spinlock_debug.c           |   30 +++++++++++++++++++-----------
 3 files changed, 30 insertions(+), 18 deletions(-)

Index: linux/include/linux/spinlock_types.h
===================================================================
--- linux.orig/include/linux/spinlock_types.h
+++ linux/include/linux/spinlock_types.h
@@ -21,11 +21,12 @@ typedef struct {
 	unsigned int break_lock;
 #endif
 #ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_pid, owner_cpu;
+	unsigned int magic, owner_cpu;
+	void *owner;
 #endif
 } spinlock_t;
 
-#define SPINLOCK_MAGIC  0xdead4ead
+#define SPINLOCK_MAGIC		0xdead4ead
 
 typedef struct {
 	raw_rwlock_t raw_lock;
@@ -33,22 +34,25 @@ typedef struct {
 	unsigned int break_lock;
 #endif
 #ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_pid, owner_cpu;
+	unsigned int magic, owner_cpu;
+	void *owner;
 #endif
 } rwlock_t;
 
-#define RWLOCK_MAGIC	0xdeaf1eed
+#define RWLOCK_MAGIC		0xdeaf1eed
+
+#define SPINLOCK_OWNER_INIT	((void *)-1L)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 # define SPIN_LOCK_UNLOCKED						\
 	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED,	\
 				.magic = SPINLOCK_MAGIC,		\
-				.owner_pid = -1,			\
+				.owner = SPINLOCK_OWNER_INIT,		\
 				.owner_cpu = -1 }
 #define RW_LOCK_UNLOCKED						\
 	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED,	\
 				.magic = RWLOCK_MAGIC,			\
-				.owner_pid = -1,			\
+				.owner = SPINLOCK_OWNER_INIT,		\
 				.owner_cpu = -1 }
 #else
 # define SPIN_LOCK_UNLOCKED \
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -1604,7 +1604,7 @@ static inline void finish_task_switch(ru
 	prev_task_flags = prev->flags;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner_pid = current->pid;
+	rq->lock.owner = current;
 #endif
 	finish_arch_switch(prev);
 	finish_lock_switch(rq, prev);
Index: linux/lib/spinlock_debug.c
===================================================================
--- linux.orig/lib/spinlock_debug.c
+++ linux/lib/spinlock_debug.c
@@ -14,16 +14,24 @@
 static void spin_bug(spinlock_t *lock, const char *msg)
 {
 	static long print_once = 1;
+	struct task_struct *owner = NULL;
 
 	if (xchg(&print_once, 0)) {
-		printk("BUG: spinlock %s on CPU#%d, %s/%d, %p\n", msg,
-			smp_processor_id(), current->comm, current->pid, lock);
+		if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
+			owner = lock->owner;
+		printk("BUG: spinlock %s on CPU#%d, %s/%d\n",
+			msg, smp_processor_id(), current->comm, current->pid);
+		printk(" lock: %p, .magic: %08x, .owner: %s/%d, .owner_cpu: %d\n",
+			lock, lock->magic,
+			owner ? owner->comm : "<none>",
+			owner ? owner->pid : -1,
+			lock->owner_cpu);
 		dump_stack();
 #ifdef CONFIG_SMP
 		/*
 		 * We cannot continue on SMP:
 		 */
-		panic("bad locking");
+//		panic("bad locking");
 #endif
 	}
 }
@@ -33,7 +41,7 @@ static void spin_bug(spinlock_t *lock, c
 static inline void debug_spin_lock_before(spinlock_t *lock)
 {
 	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
-	SPIN_BUG_ON(lock->owner_pid == current->pid, lock, "recursion");
+	SPIN_BUG_ON(lock->owner == current, lock, "recursion");
 	SPIN_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
@@ -41,17 +49,17 @@ static inline void debug_spin_lock_befor
 static inline void debug_spin_lock_after(spinlock_t *lock)
 {
 	lock->owner_cpu = raw_smp_processor_id();
-	lock->owner_pid = current->pid;
+	lock->owner = current;
 }
 
 static inline void debug_spin_unlock(spinlock_t *lock)
 {
 	SPIN_BUG_ON(lock->magic != SPINLOCK_MAGIC, lock, "bad magic");
 	SPIN_BUG_ON(!spin_is_locked(lock), lock, "already unlocked");
-	SPIN_BUG_ON(lock->owner_pid != current->pid, lock, "wrong owner");
+	SPIN_BUG_ON(lock->owner != current, lock, "wrong owner");
 	SPIN_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
 							lock, "wrong CPU");
-	lock->owner_pid = -1;
+	lock->owner = SPINLOCK_OWNER_INIT;
 	lock->owner_cpu = -1;
 }
 
@@ -176,7 +184,7 @@ void _raw_read_unlock(rwlock_t *lock)
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
-	RWLOCK_BUG_ON(lock->owner_pid == current->pid, lock, "recursion");
+	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
 	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
@@ -184,16 +192,16 @@ static inline void debug_write_lock_befo
 static inline void debug_write_lock_after(rwlock_t *lock)
 {
 	lock->owner_cpu = raw_smp_processor_id();
-	lock->owner_pid = current->pid;
+	lock->owner = current;
 }
 
 static inline void debug_write_unlock(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
-	RWLOCK_BUG_ON(lock->owner_pid != current->pid, lock, "wrong owner");
+	RWLOCK_BUG_ON(lock->owner != current, lock, "wrong owner");
 	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
 							lock, "wrong CPU");
-	lock->owner_pid = -1;
+	lock->owner = SPINLOCK_OWNER_INIT;
 	lock->owner_cpu = -1;
 }
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVLSBix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVLSBix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVLSBix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:38:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39143 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030223AbVLSBiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:38:51 -0500
Date: Mon, 19 Dec 2005 02:38:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: [patch 07/15] Generic Mutex Subsystem, mutex-debug-more.patch
Message-ID: <20051219013807.GC28038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


more mutex debugging: check for held locks during memory freeing,
task exit, enable sysrq printouts, etc.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 arch/i386/mm/pageattr.c |    3 +++
 drivers/char/sysrq.c    |   19 +++++++++++++++++++
 include/linux/mm.h      |   11 +++++++++++
 include/linux/sched.h   |   11 +++++++++++
 kernel/exit.c           |    4 ++++
 kernel/sched.c          |    1 +
 lib/spinlock_debug.c    |   18 ++++++++++--------
 mm/page_alloc.c         |    3 +++
 mm/slab.c               |    5 +++++
 9 files changed, 67 insertions(+), 8 deletions(-)

Index: linux/arch/i386/mm/pageattr.c
===================================================================
--- linux.orig/arch/i386/mm/pageattr.c
+++ linux/arch/i386/mm/pageattr.c
@@ -207,6 +207,9 @@ void kernel_map_pages(struct page *page,
 {
 	if (PageHighMem(page))
 		return;
+	if (!enable)
+		check_no_locks_freed(page_address(page), page_address(page+numpages));
+
 	/* the return value is ignored - the calls cannot fail,
 	 * large pages are disabled at boot time.
 	 */
Index: linux/drivers/char/sysrq.c
===================================================================
--- linux.orig/drivers/char/sysrq.c
+++ linux/drivers/char/sysrq.c
@@ -153,6 +153,21 @@ static struct sysrq_key_op sysrq_mountro
 
 /* END SYNC SYSRQ HANDLERS BLOCK */
 
+#ifdef CONFIG_DEBUG_MUTEXESS
+
+static void
+sysrq_handle_showlocks(int key, struct pt_regs *pt_regs, struct tty_struct *tty)
+{
+	show_all_locks();
+}
+
+static struct sysrq_key_op sysrq_showlocks_op = {
+	.handler	= sysrq_handle_showlocks,
+	.help_msg	= "show-all-locks(D)",
+	.action_msg	= "Show Locks Held",
+};
+
+#endif
 
 /* SHOW SYSRQ HANDLERS BLOCK */
 
@@ -294,7 +309,11 @@ static struct sysrq_key_op *sysrq_key_ta
 #else
 /* c */	NULL,
 #endif
+#ifdef CONFIG_DEBUG_MUTEXESS
+/* d */ &sysrq_showlocks_op,
+#else
 /* d */ NULL,
+#endif
 /* e */	&sysrq_term_op,
 /* f */	&sysrq_moom_op,
 /* g */	NULL,
Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h
+++ linux/include/linux/mm.h
@@ -973,10 +973,21 @@ static inline void vm_stat_account(struc
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_DEBUG_MUTEXESS
+ extern int check_no_locks_freed(const void *from, const void *to);
+#else
+ static inline int check_no_locks_freed(const void *from, const void *to)
+ {
+	return 0;
+ }
+#endif
+
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)
 {
+	if (!PageHighMem(page) && !enable)
+		check_no_locks_freed(page_address(page), page_address(page+numpages));
 }
 #endif
 
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -186,6 +186,17 @@ extern cpumask_t nohz_cpu_mask;
 
 extern void show_state(void);
 extern void show_regs(struct pt_regs *);
+#ifdef CONFIG_DEBUG_MUTEXESS
+  extern void deadlock_trace_off(void);
+  extern void show_held_locks(struct task_struct *filter);
+  extern void check_no_held_locks(struct task_struct *task);
+  extern void show_all_locks(void);
+#else
+# define deadlock_trace_off()		do { } while (0)
+# define show_held_locks(p)		do { } while (0)
+# define check_no_held_locks(task)	do { } while (0)
+# define show_all_locks()		do { } while (0)
+#endif
 
 /*
  * TASK is a pointer to the task whose backtrace we want to see (or NULL for current
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c
+++ linux/kernel/exit.c
@@ -870,6 +870,10 @@ fastcall NORET_TYPE void do_exit(long co
 	mpol_free(tsk->mempolicy);
 	tsk->mempolicy = NULL;
 #endif
+	/*
+	 * If DEBUG_MUTEXESS is on, make sure we are holding no locks:
+	 */
+	check_no_held_locks(tsk);
 
 	/* PF_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -4379,6 +4379,7 @@ void show_state(void)
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	show_all_locks();
 }
 
 /**
Index: linux/lib/spinlock_debug.c
===================================================================
--- linux.orig/lib/spinlock_debug.c
+++ linux/lib/spinlock_debug.c
@@ -20,7 +20,8 @@ static void spin_bug(spinlock_t *lock, c
 		if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
 			owner = lock->owner;
 		printk("BUG: spinlock %s on CPU#%d, %s/%d\n",
-			msg, smp_processor_id(), current->comm, current->pid);
+			msg, raw_smp_processor_id(),
+			current->comm, current->pid);
 		printk(" lock: %p, .magic: %08x, .owner: %s/%d, .owner_cpu: %d\n",
 			lock, lock->magic,
 			owner ? owner->comm : "<none>",
@@ -78,8 +79,8 @@ static void __spin_lock_debug(spinlock_t
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: spinlock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
-					lock);
+				raw_smp_processor_id(), current->comm,
+				current->pid, lock);
 			dump_stack();
 		}
 	}
@@ -120,7 +121,8 @@ static void rwlock_bug(rwlock_t *lock, c
 
 	if (xchg(&print_once, 0)) {
 		printk("BUG: rwlock %s on CPU#%d, %s/%d, %p\n", msg,
-			smp_processor_id(), current->comm, current->pid, lock);
+			raw_smp_processor_id(), current->comm,
+			current->pid, lock);
 		dump_stack();
 #ifdef CONFIG_SMP
 		/*
@@ -148,8 +150,8 @@ static void __read_lock_debug(rwlock_t *
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: read-lock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
-					lock);
+				raw_smp_processor_id(), current->comm,
+				current->pid, lock);
 			dump_stack();
 		}
 	}
@@ -220,8 +222,8 @@ static void __write_lock_debug(rwlock_t 
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: write-lock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
-					lock);
+				raw_smp_processor_id(), current->comm,
+				current->pid, lock);
 			dump_stack();
 		}
 	}
Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -400,6 +400,9 @@ void __free_pages_ok(struct page *page, 
 	int reserved = 0;
 
 	arch_free_page(page, order);
+	if (!PageHighMem(page))
+		check_no_locks_freed(page_address(page),
+			page_address(page+(1<<order)));
 
 #ifndef CONFIG_MMU
 	if (order > 0)
Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -3038,6 +3038,11 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = page_get_cache(virt_to_page(objp));
+#ifdef CONFIG_DEADLOCK_DETECT
+	if (check_no_locks_freed(objp, objp+cache_size(c)))
+		printk("slab %s[%p] (%d), obj: %p\n",
+			c->name, c, c->objsize, objp);
+#endif
 	__cache_free(c, (void*)objp);
 	local_irq_restore(flags);
 }

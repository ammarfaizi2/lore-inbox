Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVL0ORe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVL0ORe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 09:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVL0ORb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 09:17:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:22423 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932327AbVL0OQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 09:16:55 -0500
Date: Tue, 27 Dec 2005 15:16:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 10/11] mutex subsystem, more debugging code
Message-ID: <20051227141626.GK6660@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more mutex debugging: check for held locks during memory freeing,
task exit, enable sysrq printouts, etc.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 arch/i386/mm/pageattr.c |    4 ++++
 drivers/char/sysrq.c    |   19 +++++++++++++++++++
 include/linux/mm.h      |    4 ++++
 kernel/exit.c           |    5 +++++
 kernel/sched.c          |    1 +
 mm/page_alloc.c         |    3 +++
 mm/slab.c               |    1 +
 7 files changed, 37 insertions(+)

Index: linux/arch/i386/mm/pageattr.c
===================================================================
--- linux.orig/arch/i386/mm/pageattr.c
+++ linux/arch/i386/mm/pageattr.c
@@ -207,6 +207,10 @@ void kernel_map_pages(struct page *page,
 {
 	if (PageHighMem(page))
 		return;
+	if (!enable)
+		mutex_debug_check_no_locks_freed(page_address(page),
+						 page_address(page+numpages));
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
 
+#ifdef CONFIG_DEBUG_MUTEXES
+
+static void
+sysrq_handle_showlocks(int key, struct pt_regs *pt_regs, struct tty_struct *tty)
+{
+	mutex_debug_show_all_locks();
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
+#ifdef CONFIG_DEBUG_MUTEXES
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
@@ -13,6 +13,7 @@
 #include <linux/rbtree.h>
 #include <linux/prio_tree.h>
 #include <linux/fs.h>
+#include <linux/mutex.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -977,6 +978,9 @@ static inline void vm_stat_account(struc
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable)
 {
+	if (!PageHighMem(page) && !enable)
+		mutex_debug_check_no_locks_freed(page_address(page),
+						 page_address(page + numpages));
 }
 #endif
 
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c
+++ linux/kernel/exit.c
@@ -29,6 +29,7 @@
 #include <linux/syscalls.h>
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
+#include <linux/mutex.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -870,6 +871,10 @@ fastcall NORET_TYPE void do_exit(long co
 	mpol_free(tsk->mempolicy);
 	tsk->mempolicy = NULL;
 #endif
+	/*
+	 * If DEBUG_MUTEXES is on, make sure we are holding no locks:
+	 */
+	mutex_debug_check_no_locks_held(tsk);
 
 	/* PF_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -4379,6 +4379,7 @@ void show_state(void)
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	mutex_debug_show_all_locks();
 }
 
 /**
Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -400,6 +400,9 @@ void __free_pages_ok(struct page *page, 
 	int reserved = 0;
 
 	arch_free_page(page, order);
+	if (!PageHighMem(page))
+		mutex_debug_check_no_locks_freed(page_address(page),
+			page_address(page+(1<<order)));
 
 #ifndef CONFIG_MMU
 	if (order > 0)
Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -3038,6 +3038,7 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = page_get_cache(virt_to_page(objp));
+	mutex_debug_check_no_locks_freed(objp, objp+obj_reallen(c));
 	__cache_free(c, (void*)objp);
 	local_irq_restore(flags);
 }

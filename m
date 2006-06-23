Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWFWNY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWFWNY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWFWNY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:24:28 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:37451 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750771AbWFWNY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:24:27 -0400
Date: Fri, 23 Jun 2006 15:23:55 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [patch 1/4] lock validator: provide common print_ip_sym()
Message-ID: <20060623132355.GE9446@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Provide a common print_ip_sym() function that prints the passed instruction
pointer as well as the symbol belonging to it. Avoids adding a bunch of
#ifdef CONFIG_64BIT in order to get the printk format right on 32/64 bit
platforms.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/linux/kallsyms.h |   14 ++++++++++++++
 kernel/lockdep.c         |   38 ++++++++++++++------------------------
 kernel/stacktrace.c      |    4 +---
 3 files changed, 29 insertions(+), 27 deletions(-)

Index: linux-2.6.17-mm1/include/linux/kallsyms.h
===================================================================
--- linux-2.6.17-mm1.orig/include/linux/kallsyms.h
+++ linux-2.6.17-mm1/include/linux/kallsyms.h
@@ -63,4 +63,18 @@ do {						\
 	__print_symbol(fmt, addr);		\
 } while(0)
 
+#ifndef CONFIG_64BIT
+#define print_ip_sym(ip)		\
+do {					\
+	printk("[<%08lx>]", ip);	\
+	print_symbol(" %s\n", ip);	\
+} while(0)
+#else
+#define print_ip_sym(ip)		\
+do {					\
+	printk("[<%016lx>]", ip);	\
+	print_symbol(" %s\n", ip);	\
+} while(0)
+#endif
+
 #endif /*_LINUX_KALLSYMS_H*/
Index: linux-2.6.17-mm1/kernel/lockdep.c
===================================================================
--- linux-2.6.17-mm1.orig/kernel/lockdep.c
+++ linux-2.6.17-mm1/kernel/lockdep.c
@@ -311,12 +311,6 @@ static const char *usage_str[] =
 	[LOCK_ENABLED_HARDIRQS_READ] =	"hardirq-on-R",
 };
 
-static void printk_sym(unsigned long ip)
-{
-	printk(" [<%08lx>]", ip);
-	print_symbol(" %s\n", ip);
-}
-
 const char * __get_key_name(struct lockdep_subtype_key *key, char *str)
 {
 	unsigned long offs, size;
@@ -413,8 +407,8 @@ static void print_lockdep_cache(struct l
 static void print_lock(struct held_lock *hlock)
 {
 	print_lock_name(hlock->type);
-	printk(", at:");
-	printk_sym(hlock->acquire_ip);
+	printk(", at: ");
+	print_ip_sym(hlock->acquire_ip);
 }
 
 void lockdep_print_held_locks(struct task_struct *curr)
@@ -468,8 +462,8 @@ void print_lock_type_header(struct lock_
 	printk(" }\n");
 
 	print_spaces(depth);
-	printk(" ... key      at:");
-	printk_sym((unsigned long)type->key);
+	printk(" ... key      at: ");
+	print_ip_sym((unsigned long)type->key);
 }
 
 /*
@@ -1508,18 +1502,14 @@ check_usage_backwards(struct task_struct
 static inline void print_irqtrace_events(struct task_struct *curr)
 {
 	printk("irq event stamp: %u\n", curr->irq_events);
-	printk("hardirqs last  enabled at (%u): [<%08lx>]",
-		curr->hardirq_enable_event, curr->hardirq_enable_ip);
-	print_symbol(" %s\n", curr->hardirq_enable_ip);
-	printk("hardirqs last disabled at (%u): [<%08lx>]",
-		curr->hardirq_disable_event, curr->hardirq_disable_ip);
-	print_symbol(" %s\n", curr->hardirq_disable_ip);
-	printk("softirqs last  enabled at (%u): [<%08lx>]",
-		curr->softirq_enable_event, curr->softirq_enable_ip);
-	print_symbol(" %s\n", curr->softirq_enable_ip);
-	printk("softirqs last disabled at (%u): [<%08lx>]",
-		curr->softirq_disable_event, curr->softirq_disable_ip);
-	print_symbol(" %s\n", curr->softirq_disable_ip);
+	printk("hardirqs last  enabled at (%u): ", curr->hardirq_enable_event);
+	print_ip_sym(curr->hardirq_enable_ip);
+	printk("hardirqs last disabled at (%u): ", curr->hardirq_disable_event);
+	print_ip_sym(curr->hardirq_disable_ip);
+	printk("softirqs last  enabled at (%u): ", curr->softirq_enable_event);
+	print_ip_sym(curr->softirq_enable_ip);
+	printk("softirqs last disabled at (%u): ", curr->softirq_disable_event);
+	print_ip_sym(curr->softirq_disable_ip);
 }
 
 #else
@@ -2262,7 +2252,7 @@ print_unlock_order_bug(struct task_struc
 		curr->comm, curr->pid);
 	print_lockdep_cache(lock);
 	printk(") at:\n");
-	printk_sym(ip);
+	print_ip_sym(ip);
 	printk("but the next lock to release is:\n");
 	print_lock(hlock);
 	printk("\nother info that might help us debug this:\n");
@@ -2292,7 +2282,7 @@ print_unlock_inbalance_bug(struct task_s
 		curr->comm, curr->pid);
 	print_lockdep_cache(lock);
 	printk(") at:\n");
-	printk_sym(ip);
+	print_ip_sym(ip);
 	printk("but there are no more locks to release!\n");
 	printk("\nother info that might help us debug this:\n");
 	lockdep_print_held_locks(curr);
Index: linux-2.6.17-mm1/kernel/stacktrace.c
===================================================================
--- linux-2.6.17-mm1.orig/kernel/stacktrace.c
+++ linux-2.6.17-mm1/kernel/stacktrace.c
@@ -18,9 +18,7 @@ void print_stack_trace(struct stack_trac
 
 		for (j = 0; j < spaces + 1; j++)
 			printk(" ");
-
-		printk("[<%08lx>]", ip);
-		print_symbol(" %s\n", ip);
+		print_ip_sym(ip);
 	}
 }
 

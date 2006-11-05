Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161716AbWKEUgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161716AbWKEUgc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161714AbWKEUgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:36:31 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:16019 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161716AbWKEUg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:36:29 -0500
Subject: [PATCH] lockdep: name some old style locks
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, arjan <arjan@infradead.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 21:36:21 +0100
Message-Id: <1162758981.14695.21.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Name some of the remaning 'old_style_spin_init' locks

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/i386/kernel/traps.c       |    2 +-
 include/asm-i386/rwsem.h       |    4 ++--
 include/linux/init_task.h      |    2 +-
 include/linux/mutex.h          |    2 +-
 include/linux/rtmutex.h        |    2 +-
 include/linux/rwsem-spinlock.h |    3 ++-
 include/linux/sunrpc/sched.h   |    4 ++--
 kernel/acct.c                  |    3 ++-
 kernel/irq/handle.c            |    2 +-
 net/sunrpc/svcauth.c           |    3 ++-
 security/keys/process_keys.c   |    2 +-
 11 files changed, 16 insertions(+), 13 deletions(-)

Index: linux-2.6-twins/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6-twins.orig/arch/i386/kernel/traps.c	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/arch/i386/kernel/traps.c	2006-11-05 21:04:17.000000000 +0100
@@ -448,7 +448,7 @@ void die(const char * str, struct pt_reg
 		u32 lock_owner;
 		int lock_owner_depth;
 	} die = {
-		.lock =			SPIN_LOCK_UNLOCKED,
+		.lock =			__SPIN_LOCK_UNLOCKED(die.lock),
 		.lock_owner =		-1,
 		.lock_owner_depth =	0
 	};
Index: linux-2.6-twins/include/asm-i386/rwsem.h
===================================================================
--- linux-2.6-twins.orig/include/asm-i386/rwsem.h	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/include/asm-i386/rwsem.h	2006-11-05 21:06:06.000000000 +0100
@@ -75,8 +75,8 @@ struct rw_semaphore {
 
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEP_MAP_INIT(name) }
+{ RWSEM_UNLOCKED_VALUE, __SPIN_LOCK_UNLOCKED((name).wait_lock), \
+  LIST_HEAD_INIT((name).wait_list) __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
Index: linux-2.6-twins/include/linux/init_task.h
===================================================================
--- linux-2.6-twins.orig/include/linux/init_task.h	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/include/linux/init_task.h	2006-11-05 21:04:17.000000000 +0100
@@ -73,7 +73,7 @@
 extern struct nsproxy init_nsproxy;
 #define INIT_NSPROXY(nsproxy) {						\
 	.count		= ATOMIC_INIT(1),				\
-	.nslock		= SPIN_LOCK_UNLOCKED,				\
+	.nslock		= __SPIN_LOCK_UNLOCKED(nsproxy.nslock),		\
 	.uts_ns		= &init_uts_ns,					\
 	.namespace	= NULL,						\
 	INIT_IPC_NS(ipc_ns)						\
Index: linux-2.6-twins/include/linux/mutex.h
===================================================================
--- linux-2.6-twins.orig/include/linux/mutex.h	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/include/linux/mutex.h	2006-11-05 21:04:17.000000000 +0100
@@ -94,7 +94,7 @@ do {							\
 
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .count = ATOMIC_INIT(1) \
-		, .wait_lock = SPIN_LOCK_UNLOCKED \
+		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
 		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
 		__DEBUG_MUTEX_INITIALIZER(lockname) \
 		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
Index: linux-2.6-twins/include/linux/rtmutex.h
===================================================================
--- linux-2.6-twins.orig/include/linux/rtmutex.h	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/include/linux/rtmutex.h	2006-11-05 21:04:17.000000000 +0100
@@ -63,7 +63,7 @@ struct hrtimer_sleeper;
 #endif
 
 #define __RT_MUTEX_INITIALIZER(mutexname) \
-	{ .wait_lock = SPIN_LOCK_UNLOCKED \
+	{ .wait_lock = __SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
 	, .wait_list = PLIST_HEAD_INIT(mutexname.wait_list, mutexname.wait_lock) \
 	, .owner = NULL \
 	__DEBUG_RT_MUTEX_INITIALIZER(mutexname)}
Index: linux-2.6-twins/include/linux/rwsem-spinlock.h
===================================================================
--- linux-2.6-twins.orig/include/linux/rwsem-spinlock.h	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/include/linux/rwsem-spinlock.h	2006-11-05 21:07:13.000000000 +0100
@@ -44,7 +44,8 @@ struct rw_semaphore {
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEP_MAP_INIT(name) }
+{ 0, __SPIN_LOCK_UNLOCKED(name.wait_lock), LIST_HEAD_INIT((name).wait_list) \
+  __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
Index: linux-2.6-twins/include/linux/sunrpc/sched.h
===================================================================
--- linux-2.6-twins.orig/include/linux/sunrpc/sched.h	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/include/linux/sunrpc/sched.h	2006-11-05 21:04:17.000000000 +0100
@@ -222,7 +222,7 @@ struct rpc_wait_queue {
 
 #ifndef RPC_DEBUG
 # define RPC_WAITQ_INIT(var,qname) { \
-		.lock = SPIN_LOCK_UNLOCKED, \
+		.lock = __SPIN_LOCK_UNLOCKED(var.lock), \
 		.tasks = { \
 			[0] = LIST_HEAD_INIT(var.tasks[0]), \
 			[1] = LIST_HEAD_INIT(var.tasks[1]), \
@@ -231,7 +231,7 @@ struct rpc_wait_queue {
 	}
 #else
 # define RPC_WAITQ_INIT(var,qname) { \
-		.lock = SPIN_LOCK_UNLOCKED, \
+		.lock = __SPIN_LOCK_UNLOCKED(var.lock), \
 		.tasks = { \
 			[0] = LIST_HEAD_INIT(var.tasks[0]), \
 			[1] = LIST_HEAD_INIT(var.tasks[1]), \
Index: linux-2.6-twins/kernel/acct.c
===================================================================
--- linux-2.6-twins.orig/kernel/acct.c	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/kernel/acct.c	2006-11-05 21:08:15.000000000 +0100
@@ -89,7 +89,8 @@ struct acct_glbs {
 	struct timer_list	timer;
 };
 
-static struct acct_glbs acct_globals __cacheline_aligned = {SPIN_LOCK_UNLOCKED};
+static struct acct_glbs acct_globals __cacheline_aligned =
+	{__SPIN_LOCK_UNLOCKED(acct_globals.lock)};
 
 /*
  * Called whenever the timer says to check the free space.
Index: linux-2.6-twins/kernel/irq/handle.c
===================================================================
--- linux-2.6-twins.orig/kernel/irq/handle.c	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/kernel/irq/handle.c	2006-11-05 21:04:17.000000000 +0100
@@ -54,7 +54,7 @@ struct irq_desc irq_desc[NR_IRQS] __cach
 		.chip = &no_irq_chip,
 		.handle_irq = handle_bad_irq,
 		.depth = 1,
-		.lock = SPIN_LOCK_UNLOCKED,
+		.lock = __SPIN_LOCK_UNLOCKED(irq_desc->lock),
 #ifdef CONFIG_SMP
 		.affinity = CPU_MASK_ALL
 #endif
Index: linux-2.6-twins/net/sunrpc/svcauth.c
===================================================================
--- linux-2.6-twins.orig/net/sunrpc/svcauth.c	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/net/sunrpc/svcauth.c	2006-11-05 21:08:48.000000000 +0100
@@ -119,7 +119,8 @@ EXPORT_SYMBOL(svc_auth_unregister);
 #define	DN_HASHMASK	(DN_HASHMAX-1)
 
 static struct hlist_head	auth_domain_table[DN_HASHMAX];
-static spinlock_t	auth_domain_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t	auth_domain_lock =
+	__SPIN_LOCK_UNLOCKED(auth_domain_lock);
 
 void auth_domain_put(struct auth_domain *dom)
 {
Index: linux-2.6-twins/security/keys/process_keys.c
===================================================================
--- linux-2.6-twins.orig/security/keys/process_keys.c	2006-11-05 21:04:13.000000000 +0100
+++ linux-2.6-twins/security/keys/process_keys.c	2006-11-05 21:04:17.000000000 +0100
@@ -27,7 +27,7 @@ static DEFINE_MUTEX(key_session_mutex);
 struct key_user root_key_user = {
 	.usage		= ATOMIC_INIT(3),
 	.consq		= LIST_HEAD_INIT(root_key_user.consq),
-	.lock		= SPIN_LOCK_UNLOCKED,
+	.lock		= __SPIN_LOCK_UNLOCKED(root_key_user.lock),
 	.nkeys		= ATOMIC_INIT(2),
 	.nikeys		= ATOMIC_INIT(2),
 	.uid		= 0,



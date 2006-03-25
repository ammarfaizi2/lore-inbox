Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWCYSu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWCYSu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWCYSuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:50:00 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44755 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932237AbWCYStT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:49:19 -0500
Date: Sat, 25 Mar 2006 19:46:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 09/10] PI-futex: rt-mutex futex API
Message-ID: <20060325184642.GJ16724@elte.hu>
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

From: Ingo Molnar <mingo@elte.hu>

add proxy-locking rt-mutex functionality needed by pi-futexes.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 include/linux/rtmutex_internal.h |    8 +++++
 kernel/rtmutex.c                 |   55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

Index: linux-pi-futex.mm.q/include/linux/rtmutex_internal.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/rtmutex_internal.h
+++ linux-pi-futex.mm.q/include/linux/rtmutex_internal.h
@@ -176,4 +176,12 @@ static inline void mark_rt_mutex_waiters
 
 #endif
 
+/*
+ * PI-futex support (proxy locking functions, etc.):
+ */
+extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
+extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
+				       struct task_struct *proxy_owner);
+extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
+				  struct task_struct *proxy_owner);
 #endif
Index: linux-pi-futex.mm.q/kernel/rtmutex.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/rtmutex.c
+++ linux-pi-futex.mm.q/kernel/rtmutex.c
@@ -940,3 +940,58 @@ void fastcall __rt_mutex_init(struct rt_
 	debug_rt_mutex_init(lock, name);
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
+
+/**
+ * rt_mutex_init_proxy_locked - initialize and lock a rt_mutex on behalf of a
+ *				proxy owner
+ *
+ * @lock: 	the rt_mutex to be locked
+ * @proxy_owner:the task to set as owner
+ *
+ * No locking. Caller has to do serializing itself
+ * Special API call for PI-futex support
+ */
+void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
+				struct task_struct *proxy_owner)
+{
+	__rt_mutex_init(lock, NULL);
+	debug_rt_mutex_lock(lock __RET_IP__);
+	rt_mutex_set_owner(lock, proxy_owner, 0);
+	rt_mutex_deadlock_account_lock(lock, proxy_owner);
+}
+
+/**
+ * rt_mutex_proxy_unlock - release a lock on behalf of owner
+ *
+ * @lock: 	the rt_mutex to be locked
+ *
+ * No locking. Caller has to do serializing itself
+ * Special API call for PI-futex support
+ */
+void rt_mutex_proxy_unlock(struct rt_mutex *lock,
+			   struct task_struct *proxy_owner)
+{
+	debug_rt_mutex_proxy_unlock(lock);
+	rt_mutex_set_owner(lock, NULL, 0);
+	rt_mutex_deadlock_account_unlock(proxy_owner);
+}
+
+/**
+ * rt_mutex_next_owner - return the next owner of the lock
+ *
+ * @lock: the rt lock query
+ *
+ * Returns the next owner of the lock or NULL
+ *
+ * Caller has to serialize against other accessors to the lock
+ * itself.
+ *
+ * Special API call for PI-futex support
+ */
+struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock)
+{
+	if (!rt_mutex_has_waiters(lock))
+		return NULL;
+
+	return rt_mutex_top_waiter(lock)->task;
+}

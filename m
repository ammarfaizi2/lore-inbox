Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUGNEyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUGNEyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 00:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUGNEyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 00:54:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37095 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266905AbUGNEyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 00:54:40 -0400
Date: Wed, 14 Jul 2004 10:23:50 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dipankar@in.ibm.com
Subject: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040714045345.GA1220@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally, refcounting technique is used to avoid or minimise
lock holding time for individual objects part of a collection.  The
'collection' of such objects (lists/arrays/etc) are proteced by traditional
locks such as spinlocks/reader-writer locks.  These locks protect
access to the collection data structure (...walking the objects part of
the collection, adding/deleting objects to the collection). Access to 
individual objects are protected through the refcounting mechanism.  

It makes sense for performance sake to make access to a read-mostly 
collection of objects lock-free with RCU techniques.  Introduction of RCU 
in place of traditional locking to protect such a collection creates some 
refcounting issues.  These issues come up because, with RCU, unlike 
traditional locking, writers and readers could execute concurrently.  

The attatched patch provides infrastructure for refcounting of objects
in a rcu protected collection.

This infrastructure was a result of our go at making the fd lookup lockfree.
fget right now holds the struct files_struct.file_lock to get the 
struct file pointer of the requested fd from the process' fd array.
The spinlock in fget is used to serialise read access to the 
files_struct.fd[] and incrementing the refcount.  We can save on the 
spin_lock and spin_unlock on the fd array lookup if reference can be 
taken on the struct file object in a safe and lock free manner 
(under rcu_readlock/rcu_readunlock and rcu on the update side).  This 
optimization should improve performance for threaded io intensive workloads.  
A patch to make use of the lockfree refcounting infrastructure to do 
just that follows. With the lockfree fd lookup patch, tiobench performance 
increases by 13% for sequential reads, 21 % for random reads on a 4 
processor pIII xeon.

Comments welcome.

Thanks,
Kiran

Signed off by: Ravikiran Thirumalai <kiran@in.ibm.com>

---

diff -ruN -X dontdiff linux-2.6.6/include/linux/refcount.h refcount-2.6.6/include/linux/refcount.h
--- linux-2.6.6/include/linux/refcount.h	1970-01-01 05:30:00.000000000 +0530
+++ refcount-2.6.6/include/linux/refcount.h	2004-05-24 18:31:25.523860952 +0530
@@ -0,0 +1,244 @@
+/* 
+ * Refcounter framework for elements of lists/arrays protected by
+ * RCU.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2004
+ *
+ * Author: Ravikiran Thirumalai <kiran@in.ibm.com>
+ * Credits: Dipankar Sarma <dipankar@in.ibm.com>.  refcount_get_rcu has
+ *	    been abstracted out from Dipankar's implementation of rcu based
+ *	    fd management.
+ * 
+ * Refcounting on elements of  lists which are protected by traditional
+ * reader/writer spinlocks or semaphores are straight forward as in:
+ * 
+ * 1.					2.
+ * add()				search_and_reference()
+ * {					{
+ * 	alloc_object				read_lock(&list_lock);
+ *	...					search_for_element
+ *	refcount_init(&el->rc)			refcount_get(&el->rc);	
+ *	write_lock(&list_lock);			...
+ *	add_element				read_unlock(&list_lock);
+ *	...					...
+ *	write_unlock(&list_lock);	}
+ * }					
+ *
+ * 3.					4.
+ * release_referenced()			delete()
+ * {					{
+ *	...				write_lock(&list_lock);
+ *	if (refcount_put(&el->rc))	...
+ *		start_cleanup_object	...
+ *		free_object		delete_element
+ *	...				write_unlock(&list_lock);
+ * }					...
+ *					if (refcount_put(&el->rc))
+ *						start_cleanup_object
+ *						free_object
+ *					}
+ *
+ * If this list/array is made lock free using rcu as in changing the 
+ * write_lock in add() and delete() to spin_lock and changing read_lock
+ * in search_and_reference to rcu_read_lock(), the refcount_get in 
+ * search_and_reference could potentially hold reference to an element which
+ * has already been deleted from the list/array.  refcount_get_rcu takes
+ * care of this scenario. search_and_reference should look as;
+ * 2. 
+ * search_and_reference()
+ * {
+ *	rcu_read_lock();
+ *	search_for_element
+ *	if (!refcount_get_rcu(&el->rc)) {
+ *		rcu_read_unlock();
+ *		return FAIL;
+ *	}
+ *	...
+ *	...
+ *	rcu_read_unlock();
+ * }
+ * 
+ * Of course, free_object after refcount_put should be batched using call_rcu.
+ * Sometimes, reference to the element need to be obtained in the 
+ * update (write) stream.  In such cases, refcount_get_rcu might be an overkill
+ * since the spinlock serialising list updates are held. refcount_get
+ * is to be used in such cases.  
+ * Note: Eventhough these refcount primitives can be used for lists which
+ * are protected by traditional locking, if the arch doesn't have cmpxchg,
+ * there might be extra penalties in refcount_get.
+ *
+ */
+
+#ifndef _LINUX_REFCOUNT_H
+#define _LINUX_REFCOUNT_H
+#ifdef  __KERNEL__
+
+#include <asm/atomic.h>
+#include <asm/system.h>
+
+typedef struct { atomic_t count; } refcount_t;
+
+/* 
+ * Refcount primitives for lists/array elements protected by traditional
+ * locking
+ */
+
+static inline void refcount_init(refcount_t *rc)	
+{
+	atomic_set(&rc->count, 1);
+}
+
+static inline int refcount_put(refcount_t *rc)
+{
+	return atomic_dec_and_test(&rc->count);
+}
+
+static inline void refcount_dec(refcount_t *rc)
+{
+	atomic_dec(&rc->count);
+}
+
+static inline int refcount_put_and_lock(refcount_t *rc, spinlock_t *lock)
+{
+	return atomic_dec_and_lock(&rc->count, lock);
+}
+
+static inline int refcount_read(refcount_t *rc)
+{
+	return atomic_read(&rc->count);
+}
+
+#ifdef __HAVE_ARCH_CMPXCHG
+
+static inline void refcount_get(refcount_t *rc)
+{
+	atomic_inc(&rc->count);
+}
+
+/* 
+ * Refcount primitives for lists/array elements protected by rcu
+ */
+
+/* 
+ * cmpxchg is needed on UP too, if deletions to the list/array can happen
+ * in interrupt context.
+ */
+static inline int refcount_get_rcu(refcount_t *rc)
+{
+	int c, old;
+	c = atomic_read(&rc->count);
+	while ( c && (old = cmpxchg(&rc->count.counter, c, c+1)) != c) 
+		c = old;
+	return c;
+}
+
+#else /* !__HAVE_ARCH_CMPXCHG */
+
+/* 
+ * We use an array of spinlocks for the refcounts -- similar to ones in sparc
+ * 32 bit atomic_t implementations, and a hash function similar to that
+ * for our refcounting needs.
+ * Can't help multiprocessors which donot have cmpxchg :(
+ */
+
+#ifdef	CONFIG_SMP
+#define REFCOUNT_HASH_SIZE	4
+#define REFCOUNT_HASH(r) \
+	(&__refcount_hash[(((unsigned long)r)>>8) & (REFCOUNT_HASH_SIZE-1)])
+#else
+#define	REFCOUNT_HASH_SIZE	1
+#define REFCOUNT_HASH(r) 	&__refcount_hash[0]
+#endif /* CONFIG_SMP */
+
+extern spinlock_t __refcount_hash[REFCOUNT_HASH_SIZE]
+
+static inline void refcount_init(refcoun_t *rc)	
+{
+	unsigned long flags;
+	spin_lock_irqsave(REFCOUNT_HASH(rc), flags);
+	rc->count.counter = 1;
+	spin_unlock_irqrestore((REFCOUNT_HASH(rc), flags);
+}
+
+static inline int refcount_put(refcount_t *rc)
+{
+	unsigned long flags;
+	spin_lock_irqsave(REFCOUNT_HASH(rc), flags);
+	rc->count.counter--;
+	if (!rc->count.counter) {
+		spin_unlock_irqrestore((REFCOUNT_HASH(rc), flags);
+		return 1;
+	} else {
+		spin_unlock_irqrestore((REFCOUNT_HASH(rc), flags);
+		return 0;
+	}
+}
+
+static inline void refcount_dec(refcount_t *rc)
+{
+	unsigned long flags;
+	spin_lock_irqsave(REFCOUNT_HASH(rc), flags);
+	rc->count.counter--;
+	spin_unlock_irqrestore((REFCOUNT_HASH(rc), flags);
+}
+
+static inline int refcount_put_and_locked(refcount_t *rc, spinlock_t *lock)
+{
+	unsigned long flags;
+	spin_lock(lock);
+	spin_lock_irqsave(REFCOUNT_HASH(rc), flags);
+	rc->count.counter--;
+	if (!rc->count.counter) {
+		spin_unlock_irqrestore((REFCOUNT_HASH(rc), flags);
+		return 1;
+	} else {
+		spin_unlock_irqrestore((REFCOUNT_HASH(rc), flags);
+		spin_unlock(lock)
+		return 0;
+	}
+}
+/* Spinlocks are not needed in this case, if atomic_read is used */
+static inline int refcount_read(refcount_t *rc)
+{
+	return atomic_read(&rc->count.counter);
+}
+
+static inline void refcount_get(refcount_t *rc)
+{
+	unsigned long flags;
+	spin_lock_irqsave(REFCOUNT_HASH(rc), flags);
+	rc->count++;
+	spin_unlock_irqrestore((REFCOUNT_HASH(rc), flags);
+}
+
+static inline int refcount_get_rcu(refcount_t *rc)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(REFCOUNT_HASH(rc), flags);
+	if (rc->count.counter) 
+		ret = rc->count.counter++;
+	else
+		ret = 0;
+	spin_unlock_irqrestore((REFCOUNT_HASH(rc), flags);
+	return ret;
+}
+
+#endif /* __HAVE_ARCH_CMPXCHG */
+
+#endif
+#endif /* _LINUX_REFCOUNT_H */
diff -ruN -X dontdiff linux-2.6.6/kernel/rcupdate.c refcount-2.6.6/kernel/rcupdate.c
--- linux-2.6.6/kernel/rcupdate.c	2004-05-10 08:01:58.000000000 +0530
+++ refcount-2.6.6/kernel/rcupdate.c	2004-05-24 15:41:15.000000000 +0530
@@ -44,6 +44,7 @@
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
+#include <linux/refcount.h>
 
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
@@ -325,6 +326,17 @@
 	wait_for_completion(&completion);
 }
 
+/**
+ * spinlock_t array for arches which donot have cmpxchg.  This is for
+ * rcu based refcounting stuff.
+ */
+
+#ifndef __HAVE_ARCH_CMPXCHG
+spinlock_t __refcount_hash[REFCOUNT_HASH_SIZE] = {
+	[0 ... (REFCOUNT_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
+};
+EXPORT_SYMBOL(__refcount_hash);
+#endif
 
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(synchronize_kernel);

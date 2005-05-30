Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVE3K6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVE3K6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVE3K6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:58:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39308 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261402AbVE3K5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:57:25 -0400
Date: Mon, 30 May 2005 16:25:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc: patch 2/6] rcuref APIs
Message-ID: <20050530105528.GC5534@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050530105042.GA5534@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530105042.GA5534@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds a set of primitives to do reference counting for objects
that are looked up without locks using RCU.

Signed-off-by: Ravikiran Thirumalai <kiran_th@gmail.com>
Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 Documentation/RCU/rcuref.txt |   74 ++++++++++++++
 include/linux/rcuref.h       |  215 +++++++++++++++++++++++++++++++++++++++++++
 kernel/rcupdate.c            |   14 ++
 3 files changed, 303 insertions(+)

diff -puN /dev/null Documentation/RCU/rcuref.txt
--- /dev/null	2005-05-29 07:21:53.853378272 +0530
+++ linux-2.6.12-rc5-fd-dipankar/Documentation/RCU/rcuref.txt	2005-05-29 18:54:06.000000000 +0530
@@ -0,0 +1,74 @@
+Refcounter framework for elements of lists/arrays protected by
+RCU.
+
+Refcounting on elements of  lists which are protected by traditional
+reader/writer spinlocks or semaphores are straight forward as in:
+
+1.					2.
+add()					search_and_reference()
+{					{
+	alloc_object				read_lock(&list_lock);
+	...					search_for_element
+	atomic_set(&el->rc, 1);			atomic_inc(&el->rc);	
+	write_lock(&list_lock);			...
+	add_element				read_unlock(&list_lock);
+	...					...
+	write_unlock(&list_lock);	}
+}					
+
+3.					4.
+release_referenced()			delete()
+{					{
+	...				write_lock(&list_lock);
+	atomic_dec(&el->rc, relfunc)	...
+	...				delete_element
+}					write_unlock(&list_lock);
+ 					...
+					if (atomic_dec_and_test(&el->rc))
+						kfree(el);
+					...
+					}
+
+If this list/array is made lock free using rcu as in changing the 
+write_lock in add() and delete() to spin_lock and changing read_lock
+in search_and_reference to rcu_read_lock(), the rcuref_get in 
+search_and_reference could potentially hold reference to an element which
+has already been deleted from the list/array.  rcuref_lf_get_rcu takes
+care of this scenario. search_and_reference should look as;
+
+1.					2.
+add()					search_and_reference()
+{					{
+ 	alloc_object				rcu_read_lock();
+	...					search_for_element
+	atomic_set(&el->rc, 1);			if (rcuref_inc_lf(&el->rc)) {
+	write_lock(&list_lock);				rcu_read_unlock();
+							return FAIL;
+	add_element				}
+	...					...
+	write_unlock(&list_lock);		rcu_read_unlock();
+}					}
+3.					4.
+release_referenced()			delete()
+{					{
+	...				write_lock(&list_lock);
+	rcuref_dec(&el->rc, relfunc)	...
+	...				delete_element
+}					write_unlock(&list_lock);
+ 					...
+					if (rcuref_dec_and_test(&el->rc))
+						call_rcu(&el->head, el_free);
+					...
+					}
+ 
+Sometimes, reference to the element need to be obtained in the 
+update (write) stream.  In such cases, rcuref_inc_lf might be an overkill
+since the spinlock serialising list updates are held. rcuref_inc
+is to be used in such cases.  
+For arches which do not have cmpxchg rcuref_inc_lf 
+api uses a hashed spinlock implementation and the same hashed spinlock 
+is acquired in all rcuref_xxx primitives to preserve atomicity.
+Note: Use rcuref_inc api only if you need to use rcuref_inc_lf on the
+refcounter atleast at one place.  Mixing rcuref_inc and atomic_xxx api
+might lead to races. rcuref_inc_lf() must be used in lockfree
+RCU critical sections only.
diff -puN /dev/null include/linux/rcuref.h
--- /dev/null	2005-05-29 07:21:53.853378272 +0530
+++ linux-2.6.12-rc5-fd-dipankar/include/linux/rcuref.h	2005-05-29 18:54:06.000000000 +0530
@@ -0,0 +1,215 @@
+/*
+ * rcuref.h
+ *
+ * Reference counting for elements of lists/arrays protected by
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
+ * Copyright (C) IBM Corporation, 2005
+ *
+ * Author: Dipankar Sarma <dipankar@in.ibm.com>
+ *	   Ravikiran Thirumalai <kiran_th@gmail.com>
+ *
+ * See Documentation/RCU/rcuref.txt for detailed user guide.
+ *
+ */
+
+#ifndef _RCUREF_H_
+#define _RCUREF_H_
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <asm/atomic.h>
+
+/*
+ * These APIs work on traditional atomic_t counters used in the
+ * kernel for reference counting. Under special circumstances
+ * where a lock-free get() operation races with a put() operation
+ * these APIs can be used. See Documentation/RCU/rcuref.txt.
+ */
+
+#ifdef __HAVE_ARCH_CMPXCHG
+
+/**
+ * rcuref_inc - increment refcount for object.
+ * @rcuref: reference counter in the object in question.
+ * 
+ * This should be used only for objects where we use RCU and 
+ * use the rcuref_inc_lf() api to acquire a reference
+ * in a lock-free reader-side critical section.
+ */
+static inline void rcuref_inc(atomic_t *rcuref)
+{
+	atomic_inc(rcuref);
+}
+
+/**
+ * rcuref_dec - decrement refcount for object.
+ * @rcuref: reference counter in the object in question.
+ * 
+ * This should be used only for objects where we use RCU and
+ * use the rcuref_inc_lf() api to acquire a reference
+ * in a lock-free reader-side critical section.
+ */
+static inline void rcuref_dec(atomic_t *rcuref)
+{
+	atomic_dec(rcuref);
+}
+
+/**
+ * rcuref_dec_and_test - decrement refcount for object and test
+ * @rcuref: reference counter in the object.
+ * @release: pointer to the function that will clean up the object
+ *	     when the last reference to the object is released.
+ *	     This pointer is required.
+ *
+ * Decrement the refcount, and if 0, return 1. Else return 0.
+ * 
+ * This should be used only for objects where we use RCU and
+ * use the rcuref_inc_lf() api to acquire a reference
+ * in a lock-free reader-side critical section.
+ */
+static inline int rcuref_dec_and_test(atomic_t *rcuref)
+{
+	return atomic_dec_and_test(rcuref);
+}
+
+/* 
+ * cmpxchg is needed on UP too, if deletions to the list/array can happen
+ * in interrupt context.
+ */
+
+/**
+ * rcuref_inc_lf - Take reference to an object in a read-side
+ * critical section protected by RCU.
+ * @rcuref: reference counter in the object in question.
+ *
+ * Try and increment the refcount by 1.  The increment might fail if
+ * the reference counter has been through a 1 to 0 transition and 
+ * is no longer part of the lock-free list.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+static inline int rcuref_inc_lf(atomic_t *rcuref)
+{
+	int c, old;
+	c = atomic_read(rcuref);
+	while (c && (old = cmpxchg(&rcuref->counter, c, c + 1)) != c)
+		c = old;
+	return c;
+}
+
+#else				/* !__HAVE_ARCH_CMPXCHG */
+
+/*
+ * Use a hash table of locks to protect the reference count
+ * since cmpxchg is not available in this arch.
+ */
+#ifdef	CONFIG_SMP
+#define RCUREF_HASH_SIZE	4
+#define RCUREF_HASH(k) \
+	(&__rcuref_hash[(((unsigned long)k)>>8) & (RCUREF_HASH_SIZE-1)])
+#else
+#define	RCUREF_HASH_SIZE	1
+#define RCUREF_HASH(k) 	&__rcuref_hash[0]
+#endif				/* CONFIG_SMP */
+
+/**
+ * rcuref_inc - increment refcount for object.
+ * @rcuref: reference counter in the object in question.
+ * 
+ * This should be used only for objects where we use RCU and
+ * use the rcuref_inc_lf() api to acquire a reference in a lock-free
+ * reader-side critical section.
+ */
+static inline void rcuref_inc(atomic_t *rcuref)
+{
+	unsigned long flags;
+	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
+	rcuref->counter += 1;
+	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
+}
+
+/**
+ * rcuref_dec - decrement refcount for object.
+ * @rcuref: reference counter in the object in question.
+ * 
+ * This should be used only for objects where we use RCU and 
+ * use the rcuref_inc_lf() api to acquire a reference in a lock-free
+ * reader-side critical section.
+ */
+static inline void rcuref_inc(atomic_t *rcuref)
+{
+	unsigned long flags;
+	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
+	rcuref->counter -= 1;
+	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
+}
+
+/**
+ * rcuref_dec_and_test - decrement refcount for object and test
+ * @rcuref: reference counter in the object.
+ * @release: pointer to the function that will clean up the object
+ *	     when the last reference to the object is released.
+ *	     This pointer is required.
+ *
+ * Decrement the refcount, and if 0, return 1. Else return 0.
+ * 
+ * This should be used only for objects where we use RCU and
+ * use the rcuref_inc_lf() api to acquire a reference in a lock-free
+ * reader-side critical section.
+ */
+static inline int rcuref_dec_and_test(atomic_t *rcuref)
+{
+	unsigned long flags;
+	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
+	rcuref->refcount.counter--;
+	if (!rcuref->counter) {
+		spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
+		return 1;
+	} else {
+		spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
+		return 0;
+	}
+}
+
+/**
+ * rcuref_inc_lf - Take reference to an object of a lock-free collection
+ * by traversing a lock-free list/array.
+ * @rcuref: reference counter in the object in question.
+ *
+ * Try and increment the refcount by 1.  The increment might fail if
+ * the reference counter has been through a 1 to 0 transition and 
+ * object is no longer part of the lock-free list.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+static inline int rcuref_inc_lf(atomic_t *rcuref)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
+	if (rcuref->counter)
+		ret = rcuref->counter++;
+	else
+		ret = 0;
+	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
+	return ret;
+}
+
+#endif /* !__HAVE_ARCH_CMPXCHG */
+
+#endif /* __KERNEL__ */
+#endif /* _RCUREF_H_ */
diff -puN kernel/rcupdate.c~rcuref-apis kernel/rcupdate.c
--- linux-2.6.12-rc5-fd/kernel/rcupdate.c~rcuref-apis	2005-05-29 18:54:06.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/kernel/rcupdate.c	2005-05-29 18:54:06.000000000 +0530
@@ -45,6 +45,7 @@
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
+#include <linux/rcuref.h>
 #include <linux/cpu.h>
 
 /* Definition for rcupdate control block. */
@@ -72,6 +73,19 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int maxbatch = 10;
 
+#ifndef __HAVE_ARCH_CMPXCHG
+/* 
+ * We use an array of spinlocks for the rcurefs -- similar to ones in sparc
+ * 32 bit atomic_t implementations, and a hash function similar to that
+ * for our refcounting needs.
+ * Can't help multiprocessors which donot have cmpxchg :(
+ */
+
+static spinlock_t __rcuref_hash[RCUREF_HASH_SIZE] = {
+	[0 ... (RCUREF_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
+};
+#endif
+
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.

_

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUGOGXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUGOGXC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 02:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUGOGXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 02:23:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13496 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266073AbUGOGWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 02:22:06 -0400
Date: Thu, 15 Jul 2004 11:51:04 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       oleg@tv-sign.ru
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040715062102.GA1312@obelix.in.ibm.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714082621.GA4291@in.ibm.com> <20040714142614.GA15742@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714142614.GA15742@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 07:26:14AM -0700, Greg KH wrote:
> ... 
> As kref_put() uses a atomic_t, how can that transistion happen twice?
> 
> What can happen is kref_get() and kref_put() can race if the last
> kref_put() happens at the same time that kref_get().  But that is solved
> by having the caller guarantee that this can not happen (see my 2004 OLS
> paper for more info about this.)

The last kref_put (zero transition) should happen after the refcounted
object is removed from the list, and the removal is serialised
through the traditional rw/spinlock (see my example earlier).
With the traditional lock protection, if the reader has a lock, writer
cannot remove the element from the list and no subsequent last put, or if the 
writer has removed the element, the reader won't even see the elemnt,
when he walks the list..so no question of taking a reference on 
the deleted element.
Lockfree and rcu changes all this.  Hence, we need refcount_get_rcu.

Now it would have been nice if we did not have to use cmpxchg 
for refcount_get_rcu, or atleast if all arches implemented cmpxchg in
hardware.  Since neither is true, for arches with no cmpxchg, we use
the hashed spinlock method.  When we use hashed spinlock for 
refcount_get_rcu method, we need to use the same spinlock to protect the
refcount for the usual refcount_gets too.  So no atomic_inc for
refcount_gets on arches with no cmpxchg.  
Now why refcount_get when you are using refcount_get_rcu for a refcount one 
might ask. With the fd patch, there are places where the refcount_get 
happens with traditional serialisation, and places where refcount_get 
happens lockfree.  So it makes sense for performance sake to have a 
simple atomic_inc (refcount_get) instead of and the whole cmpxchg shebang
for the same refcounter when traditional locking is held.  Hence the
refcount_get infrastructure.  The whole refcount infrastructure 
provided is _not_ meant for traditinal refcounting ...which kref 
accomplishes.  If it is used for traditional refcounting (i.e refcount_get
on a refcounter is used without any refcount_get_rcus for the same
counter), arches with nocmpxchg will end up using hashed spinlocks for
simple refcount_gets :).  A Note was included in the header file as
a warning:

<in the patch>
 * Note: Eventhough these refcount primitives can be used for lists which
 * are protected by traditional locking, if the arch doesn't have cmpxchg,
 * there might be extra penalties in refcount_get.
</>

To summarise, this infrastructure is not meant to replace kref, or is not 
meant to be used for traditional refcounting.  All primitives are for lockfree
refcounting and associated functions.  And the infrastructure came in 
because there are more than one application to use it. files_struct is one,
fs_struct is another, on which I am working.  There might be more later :).

As Oleg rightly pointed out, the #ifdef __HAVE_ARCH_CMPXCHG  is at the wrong
place.  My bad.  Maybe this confusion wouldn't happen if it was at the
right place to begin with.  Here is the corrected refcount patch.

Thanks,
Kiran


diff -ruN -X dontdiff linux-2.6.7/include/linux/refcount.h files_struct-2.6.7/include/linux/refcount.h
--- linux-2.6.7/include/linux/refcount.h	1970-01-01 05:30:00.000000000 +0530
+++ files_struct-2.6.7/include/linux/refcount.h	2004-07-15 11:13:08.000000000 +0530
@@ -0,0 +1,245 @@
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
+#ifdef __HAVE_ARCH_CMPXCHG
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
+static inline void refcount_init(refcount_t *rc)	
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
diff -ruN -X dontdiff linux-2.6.7/kernel/rcupdate.c files_struct-2.6.7/kernel/rcupdate.c
--- linux-2.6.7/kernel/rcupdate.c	2004-06-16 10:48:38.000000000 +0530
+++ files_struct-2.6.7/kernel/rcupdate.c	2004-07-15 10:56:25.000000000 +0530
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

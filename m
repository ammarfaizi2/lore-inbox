Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUHBKYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUHBKYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUHBKYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:24:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:6031 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266457AbUHBKTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:19:32 -0400
Date: Mon, 2 Aug 2004 15:48:06 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040802101804.GE4385@vitalstatistix.in.ibm.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds kref_lf_xxx api and kref_lf_get_rcu to enable
refcounting of objects part of a lockfree collection.

Thanks,
Kiran


D:
D: kref-lf-2.6.7.patch:
D: This patch depends on the kref shrinkage patches.  This provides
D: infrastructure for lockfree refcounting and adds kref_lf_xxx api
D: for lockfree refcounting.  This patch also changes kref_xxx to 
D: static inlines since kref_xxx are mostly one-two liners
D:

diff -ruN -X /home/kiran/dontdiff linux-2.6.7/include/linux/kref.h test-2.6.7/include/linux/kref.h
--- linux-2.6.7/include/linux/kref.h	2004-08-01 22:37:46.000000000 +0530
+++ test-2.6.7/include/linux/kref.h	2004-08-01 22:50:06.000000000 +0530
@@ -16,16 +16,264 @@
 #define _KREF_H_
 
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <asm/atomic.h>
 
-
 struct kref {
 	atomic_t refcount;
 };
 
-void kref_init(struct kref *kref);
-struct kref *kref_get(struct kref *kref);
-void kref_put(struct kref *kref, void (*release) (struct kref *kref));
+/**
+ * kref_init - initialize object.
+ * @kref: object in question.
+ */
+static inline void kref_init(struct kref *kref)
+{
+	atomic_set(&kref->refcount, 1);
+}
+
+/**
+ * kref_get - increment refcount for object.
+ * @kref: object.
+ */
+static inline struct kref *kref_get(struct kref *kref)
+{
+	WARN_ON(!atomic_read(&kref->refcount));
+	atomic_inc(&kref->refcount);
+	return kref;
+}
+
+/**
+ * kref_put - decrement refcount for object.
+ * @kref: object.
+ * @release: pointer to the function that will clean up the object
+ *	     when the last reference to the object is released.
+ *	     This pointer is required.
+ *
+ * Decrement the refcount, and if 0, call release().
+ */
+static inline void
+kref_put(struct kref *kref, void (*release) (struct kref * kref))
+{
+	if (atomic_dec_and_test(&kref->refcount)) {
+		WARN_ON(release == NULL);
+		pr_debug("kref cleaning up\n");
+		release(kref);
+	}
+}
+
+/**
+ * kref_read - Return the refcount value.
+ * @kref: object.
+ */
+static inline int kref_read(struct kref *kref)
+{
+	return atomic_read(&kref->refcount);
+}
+
+/**
+ * kref_put_last - decrement refcount for object.
+ * @kref: object.
+ *
+ * Decrement the refcount, and if 0 return true.
+ * Returns false otherwise.
+ * Use this only if you cannot use kref_put -- when the
+ * release function of kref_put needs more than just the
+ * refcounted object. Use of kref_put_last when kref_put
+ * can do will be frowned upon.
+ */
+static inline int kref_put_last(struct kref *kref)
+{
+	return atomic_dec_and_test(&kref->refcount);
+}
+
+/* 
+ * Refcounter framework for elements of lists/arrays protected by
+ * RCU.
+ *
+ * Refcounting on elements of  lists which are protected by traditional
+ * reader/writer spinlocks or semaphores are straight forward as in:
+ * 
+ * 1.					2.
+ * add()				search_and_reference()
+ * {					{
+ * 	alloc_object				read_lock(&list_lock);
+ *	...					search_for_element
+ *	kref_init(&el->rc)			kref_get(&el->rc);	
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
+ *	if (kref_put_last(&el->rc))		...
+ *		start_cleanup_object	...
+ *		free_object		delete_element
+ *	...				write_unlock(&list_lock);
+ * }					...
+ *					if (kref_put_last(&el->rc))
+ *						start_cleanup_object
+ *						free_object
+ *					}
+ *
+ * If this list/array is made lock free using rcu as in changing the 
+ * write_lock in add() and delete() to spin_lock and changing read_lock
+ * in search_and_reference to rcu_read_lock(), the kref_get in 
+ * search_and_reference could potentially hold reference to an element which
+ * has already been deleted from the list/array.  kref_lf_get_rcu takes
+ * care of this scenario. search_and_reference should look as;
+ * 2. 
+ * search_and_reference()
+ * {
+ *	rcu_read_lock();
+ *	search_for_element
+ *	if (!kref_lf_get_rcu(&el->rc)) {
+ *		rcu_read_unlock();
+ *		return FAIL;
+ *	}
+ *	...
+ *	...
+ *	rcu_read_unlock();
+ * }
+ * 
+ * Of course, free_object after kref_put_last should be batched using call_rcu.
+ * Sometimes, reference to the element need to be obtained in the 
+ * update (write) stream.  In such cases, kref_lf_get_rcu might be an overkill
+ * since the spinlock serialising list updates are held. kref_lf_get
+ * is to be used in such cases.  
+ * Note: Except for kref_lf_get_rcu, kref_lf_xxx api are the same as 
+ * corresponding kref_xxx api for most arches.  However, for arches which 
+ * donot have cmpxchg kref_lf_xxx api use a hashed spinlock implementation to
+ * implement kref_lf_get_rcu, and acquire the same hashed spinlock for 
+ * kref_lf_get etc to preserve atomicity.
+ * Note: Use kref_lf_xxx api only if you need to use kref_lf_get_rcu on the
+ * refcounter atleast at one place.  Mixing kref_lf_xx and kref_xxx api
+ * might lead to races.
+ *
+ */
+
+#ifdef __HAVE_ARCH_CMPXCHG
+
+#define kref_lf_init kref_init
+#define kref_lf_get kref_get
+#define kref_lf_put kref_put
+#define kref_lf_put_last kref_put_last
+
+/* 
+ * cmpxchg is needed on UP too, if deletions to the list/array can happen
+ * in interrupt context.
+ */
+
+/**
+ * kref_lf_get_rcu - Take reference to an object of a lockfree collection
+ * by traversing a lockfree list/array.
+ * @kref: object.
+ *
+ * Try and increment the refcount by 1.  The increment might fail if
+ * the refcounted object has been through a 1 to 0 transition and 
+ * is no longer part of the lockfree list.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+static inline int kref_lf_get_rcu(struct kref *kref)
+{
+	int c, old;
+	c = atomic_read(&kref->refcount);
+	while (c && (old = cmpxchg(&kref->refcount.counter, c, c + 1)) != c)
+		c = old;
+	return c;
+}
+
+#else				/* !__HAVE_ARCH_CMPXCHG */
+
+#include <linux/spinlock.h>
+
+/* 
+ * We use an array of spinlocks for the krefs -- similar to ones in sparc
+ * 32 bit atomic_t implementations, and a hash function similar to that
+ * for our refcounting needs.
+ * Can't help multiprocessors which donot have cmpxchg :(
+ */
+
+#ifdef	CONFIG_SMP
+#define KREF_HASH_SIZE	4
+#define KREF_HASH(k) \
+	(&__kref_hash[(((unsigned long)k)>>8) & (KREF_HASH_SIZE-1)])
+#else
+#define	KREF_HASH_SIZE	1
+#define KREF_HASH(k) 	&__kref_hash[0]
+#endif				/* CONFIG_SMP */
+
+extern spinlock_t __kref_hash[KREF_HASH_SIZE];
+
+static inline void kref_lf_init(struct kref *kref)
+{
+	unsigned long flags;
+	spin_lock_irqsave(KREF_HASH(kref), flags);
+	kref->refcount.counter = 1;
+	spin_unlock_irqrestore(KREF_HASH(kref), flags);
+}
+
+static inline void kref_lf_get(struct kref *kref)
+{
+	unsigned long flags;
+	spin_lock_irqsave(KREF_HASH(kref), flags);
+	kref->refcount.counter += 1;
+	spin_unlock_irqrestore(KREF_HASH(kref), flags);
+}
+
+static inline void 
+kref_lf_put(struct kref *kref, void (*release) (struct kref * kref))
+{
+	unsigned long flags;
+	spin_lock_irqsave(KREF_HASH(kref), flags);
+	kref->refcount.counter--;
+	if (!kref->refcount.counter) {
+		spin_unlock_irqrestore(KREF_HASH(kref), flags);
+		WARN_ON(release == NULL);
+		pr_debug("kref cleaning up\n");
+		release(kref);
+	} else {
+		spin_unlock_irqrestore(KREF_HASH(kref), flags);
+	}
+}
+
+static inline int kref_lf_put_last(struct kref *kref)
+{
+	unsigned long flags;
+	spin_lock_irqsave(KREF_HASH(kref), flags);
+	kref->refcount.counter--;
+	if (!kref->refcount.counter) {
+		spin_unlock_irqrestore(KREF_HASH(kref), flags);
+		return 1;
+	} else {
+		spin_unlock_irqrestore(KREF_HASH(kref), flags);
+		return 0;
+	}
+}
+
+static inline int kref_lf_get_rcu(struct kref *kref)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(KREF_HASH(kref), flags);
+	if (kref->refcount.counter)
+		ret = kref->refcount.counter++;
+	else
+		ret = 0;
+	spin_unlock_irqrestore(KREF_HASH(kref), flags);
+	return ret;
+}
+
+#endif				/* __HAVE_ARCH_CMPXCHG */
 
+/* Spinlocks are not needed in this case, if atomic_read is used */
+static inline int kref_lf_read(struct kref *kref)
+{
+	return atomic_read(&kref->refcount);
+}
 
-#endif /* _KREF_H_ */
+#endif				/* _KREF_H_ */
diff -ruN -X /home/kiran/dontdiff linux-2.6.7/lib/kref.c test-2.6.7/lib/kref.c
--- linux-2.6.7/lib/kref.c	2004-08-01 22:37:46.000000000 +0530
+++ test-2.6.7/lib/kref.c	2004-08-01 21:41:19.000000000 +0530
@@ -11,49 +11,12 @@
  *
  */
 
-/* #define DEBUG */
-
 #include <linux/kref.h>
 #include <linux/module.h>
 
-/**
- * kref_init - initialize object.
- * @kref: object in question.
- */
-void kref_init(struct kref *kref)
-{
-	atomic_set(&kref->refcount,1);
-}
-
-/**
- * kref_get - increment refcount for object.
- * @kref: object.
- */
-struct kref *kref_get(struct kref *kref)
-{
-	WARN_ON(!atomic_read(&kref->refcount));
-	atomic_inc(&kref->refcount);
-	return kref;
-}
-
-/**
- * kref_put - decrement refcount for object.
- * @kref: object.
- * @release: pointer to the function that will clean up the object
- *	     when the last reference to the object is released.
- *	     This pointer is required.
- *
- * Decrement the refcount, and if 0, call release().
- */
-void kref_put(struct kref *kref, void (*release) (struct kref *kref))
-{
-	WARN_ON(release == NULL);
-	if (atomic_dec_and_test(&kref->refcount)) {
-		pr_debug("kref cleaning up\n");
-		release(kref);
-	}
-}
-
-EXPORT_SYMBOL(kref_init);
-EXPORT_SYMBOL(kref_get);
-EXPORT_SYMBOL(kref_put);
+#ifndef __HAVE_ARCH_CMPXCHG
+spinlock_t __kref_hash[KREF_HASH_SIZE] = {
+        [0 ... (KREF_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
+};
+EXPORT_SYMBOL(__kref_hash);
+#endif

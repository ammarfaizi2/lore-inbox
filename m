Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVBZP41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVBZP41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 10:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVBZP41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 10:56:27 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:60322 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261222AbVBZPzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 10:55:42 -0500
Message-ID: <42209BFD.8020908@acm.org>
Date: Sat, 26 Feb 2005 09:55:41 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] New operation for kref to help avoid locks
Content-Type: multipart/mixed;
 boundary="------------070403040704010201080506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070403040704010201080506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg,

This is the patch for krefs that we talked about.  If you don't like it 
but like the docs, feel free just to take the documentation and cut out 
the stuff at the end about the new operation.

Thanks,

-Corey

--------------070403040704010201080506
Content-Type: text/plain;
 name="kref_checked.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kref_checked.diff"

Add a routine to kref that allows the kref_put() routine to be
unserialized even when the get routine attempts to kref_get()
an object without first holding a valid reference to it.  This is
useful in situations where this happens multiple times without
freeing the object, as it will avoid having to do a lock/semaphore
except on the final kref_put().

This also adds some kref documentation to the Documentation
directory.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc4/include/linux/kref.h
===================================================================
--- linux-2.6.11-rc4.orig/include/linux/kref.h
+++ linux-2.6.11-rc4/include/linux/kref.h
@@ -28,5 +28,11 @@
 void kref_get(struct kref *kref);
 void kref_put(struct kref *kref, void (*release) (struct kref *kref));
 
+/* Get a kref if the count is not already zero.  This can be used to
+   avoid a lock in the routine that calls kref_put().  Returns 1 if
+   successful or zero if the count was already zero.  See
+   Documentation/kref.txt for details on how to use this. */
+int kref_get_with_check(struct kref *kref);
+
 #endif /* __KERNEL__ */
 #endif /* _KREF_H_ */
Index: linux-2.6.11-rc4/lib/kref.c
===================================================================
--- linux-2.6.11-rc4.orig/lib/kref.c
+++ linux-2.6.11-rc4/lib/kref.c
@@ -52,6 +52,21 @@
 		release(kref);
 }
 
+/**
+ * kref_get_with_check - increment refcount if the refcount is not already 0.
+ * @kref: object.
+ */
+int kref_get_with_check(struct kref *kref)
+{
+	atomic_inc(&kref->refcount);
+	if (atomic_read(&kref->refcount) == 1) {
+		atomic_dec(&kref->refcount);
+		return 0;
+	}
+	return 1;
+}
+
 EXPORT_SYMBOL(kref_init);
 EXPORT_SYMBOL(kref_get);
 EXPORT_SYMBOL(kref_put);
+EXPORT_SYMBOL(kref_get_with_check);
Index: linux-2.6.11-rc4/Documentation/kref.txt
===================================================================
--- /dev/null
+++ linux-2.6.11-rc4/Documentation/kref.txt
@@ -0,0 +1,274 @@
+krefs allow you to add reference counters to your objects.  If you
+have objects that are used in multiple places and passed around, and
+you don't have refcounts, your code is almost certainly broken.  If
+you want refcounts, krefs are the way to go.
+
+To use a kref, add a one to your data structures like:
+
+struct my_data
+{
+	.
+	.
+	struct kref refcount;
+	.
+	.
+};
+
+The kref can occur anywhere within the data structure.
+
+You must initialize the kref after you allocate it.  To do this, call
+kref init as so:
+
+     struct my_data *data;
+
+     data = kmalloc(sizeof(*data), GFP_KERNEL);
+     if (!data)
+            return -ENOMEM;
+     kref_init(&data->refcount);
+
+This sets the refcount in the kref to 1.
+
+Once you have a refcount, you must follow the following rules:
+
+1) If you make a non-temporary copy of a pointer, especially if
+   it can be passed to another thread of execution, you must
+   increment the refcount with kref_get() before passing it off:
+       kref_get(&data->refcount);
+   If you already have a valid pointer to a kref-ed structure (the
+   refcount cannot go to zero) you may do this without a lock.
+
+2) When you are done with a pointer, you must call kref_put():
+       kref_put(&data->refcount, data_release);
+   If this is the last reference to the pointer, the release
+   routine will be called.  If the code never tries to get
+   a valid pointer to a kref-ed structure without already
+   holding a valid pointer, it is safe to do this without
+   a lock.
+
+3) If the code attempts to gain a reference to a kref-ed structure
+   without already holding a valid pointer, it must serialize access
+   where a kref_put() cannot occur during the kref_get(), and the
+   structure must remain valid during the kref_get().
+
+For example, if you allocate some data and then pass it to another
+thread to process:
+
+void data_release(struct kref *ref)
+{
+	struct my_data *data = container_of(ref, struct my_data, refcount);
+	kfree(data);
+}
+
+void more_data_handling(void *cb_data)
+{
+	struct my_data *data = cb_data;
+	.
+	. do stuff with data here
+	.
+	kref_put(data, data_release);
+}
+
+void my_data_handler(void)
+{
+	int rv = 0;
+	struct my_data *data;
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	kref_init(&data->refcount);
+
+	kref_get(&data->refcount);
+	rv = kthread_run(more_data_handling, data, "more_data_handling");
+	if (rv) {
+	        kref_put(&data->refcount);
+		goto out;
+	}
+
+	.
+	. do stuff with data here
+	.
+ out:
+	kref_put(data, data_release);
+	return rv;
+}
+
+This way, it doesn't matter what order the two threads handle the
+data, the put handles knowing when the data is free and releasing it.
+The kref_get() does not require a lock, since we already have a valid
+pointer that we own a refcount for.  The put needs no lock because
+nothing tries to get the data without already holding a pointer.
+
+Note that the "before" in rule 1 is very important.  You should never
+do something like:
+
+	rv = kthread_run(more_data_handling, data, "more_data_handling");
+	if (rv)
+		goto out;
+	else
+		/* BAD BAD BAD - get is after the handoff */
+		kref_get(&data->refcount);
+
+Don't assume you know what you are doing and use the above construct.
+First of all, you may not know what you are doing.  Second, you may
+know what you are doing (there are some situations where locking is
+involved where the above may be legal) but someone else who doesn't
+know what they are doing may change the code or copy the code.  It's
+bad style.  Don't do it.
+
+There are some situations where you can optimize the gets and puts.
+For instance, if you are done with an object and enqueuing it for
+something else or passing it off to something else, there is no reason
+to do a get then a put:
+
+	/* Silly extra get and put */
+	kref_get(&obj->ref);
+	enqueue(obj);
+	kref_put(&obj->ref, obj_cleanup);
+
+Just do the enqueue.  A comment about this is always welcome:
+
+	enqueue(obj);
+	/* We are done with obj, so we pass our refcount off
+	   to the queue.  DON'T TOUCH obj AFTER HERE! */
+
+The last rule (rule 3) is the nastiest one to handle.  Say, for
+instance, you have a list of items that are each kref-ed, and you wish
+to get the first one.  You can't just pull the first item off the list
+and kref_get() it.  That violates rule 3 because you are not already
+holding a valid pointer.  You must add locks or semaphores.  For
+instance:
+
+static DECLARE_MUTEX(sem);
+static LIST_HEAD(q);
+struct my_data
+{
+	struct kref      refcount;
+	struct list_head link;
+};
+
+static struct my_data *get_entry()
+{
+	struct my_data *entry = NULL;
+	down(&sem);
+	if (!list_empty(&q)) {
+		entry = container_of(q.next, struct my_q_entry, link);
+		kref_get(&entry->refcount);
+	}
+	up(&sem);
+	return entry;
+}
+
+static void put_entry(struct my_data *entry)
+{
+	down(&sem);
+	kref_put(&entry->refcount);
+	list_del(&entry->link);
+	up(&sem);
+}
+
+
+There is one exception to rule 3.  kref_get_with_check() can be used
+to avoid a lock/semaphore in your routines that call kref_put(), except
+in the case that release is called.  It is useful in situations where
+you might be trying to get an object that might have just gone free,
+as in our list example above.
+
+For instance, suppose you have a queue of items to process in your
+driver.  The head of the queue is the current item being worked on.
+You driver has timers, interrupts, and user context threads that may
+all attempt to claim the head of the queue.
+
+So you define three routines, get_working_entry(), put_entry(), and
+entry_completed(), one to get the current queue entry that is being
+worked on, one to tell the system you are done working on that
+entry for now, and one to tell that the entry is completed and
+should be dequeued.  Here is some example code:
+
+static LIST_HEAD(q);
+DEFINE_SPINLOCK(q_lock);
+
+struct my_q_entry
+{
+	struct list_head link;
+	struct kref      refcount;
+	char             data[10];
+	void (*done)(struct my_q_entry *);
+};
+
+struct my_q_entry *get_working_entry(void)
+{
+	unsigned long     flags;
+	struct my_q_entry *entry = NULL;
+
+	spin_lock_irqsave(&q_lock, flags);
+ retry:
+	if (!list_empty(&q)) {
+		entry = container_of(q.next, struct my_q_entry, link);
+		if (!kref_get_with_check(&entry->refcount)) {
+			/* Entry's refcount has been deleted, but it
+			 * has not yet been removed from the list.  We
+			 * raced with put_entry and are between the
+			 * kref_put() decrementing the count and the
+			 * release routine claiming the lock.  Just
+			 * remove it and retry. */
+			list_del(&entry->link);
+			entry = NULL;
+			goto retry;
+		}
+	}
+	spin_lock_irqrestore(&q_lock, flags);
+	return entry;
+}
+
+void release_entry(struct kref *ref)
+{
+	unsigned long     flags;
+	struct my_q_entry *entry = container_of(ref, struct my_q_entry,
+						refcount);
+
+	spin_lock_irqsave(&q_lock, flags);
+	list_del(&entry->link);
+	spin_lock_irqrestore(&q_lock, flags);
+	entry->done(entry);
+
+	entry = get_working_entry();
+	if (entry) {
+		/* Start next entry here. */
+	}
+	put_entry(entry)
+}
+
+void put_entry(struct my_q_entry *entry)
+{
+	kref_put(&entry->refcount, release_entry);
+}
+
+void entry_completed(struct my_q_entry *entry)
+{
+	kref_put(&entry->refcount, release_entry);
+}
+
+
+Note that there is no lock around kref_put(), which should avoid a
+lock on most put operations, except for the last one.  This works
+because if kref_put() sets the refcount to zero, one and only one
+thread of execution can be doing the kref_get().  If the kref_get()
+beats the kref_put(), everything is fine, the get routine has a
+valid entry.  If the kref_put() beats the kref_get(), the kref
+value will be zero and kref_get_with_check() will fail, but the
+release_entry() code will block on the spinlock.  So the entry will
+be dequeued and everything still works.
+
+This is generally only useful when you expect do have this happen many
+times for a single object.  If 99% of the time you have one get and
+one put, it's probably not worth the complexity.  If you generally
+have 20 gets and puts, it saves 19 locking operations, which is
+probably worth it.
+
+Other than this, normal kref rules apply.  You can do a kref_get()
+without a lock if you are holding a valid kref pointer.  
+
+
+Corey Minyard <minyard@acm.org>
+
+A lot of this was lifted from Greg KH's OLS presentation on krefs.

--------------070403040704010201080506--

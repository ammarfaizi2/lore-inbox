Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbVIXCrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVIXCrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 22:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVIXCrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 22:47:15 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:42319 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751374AbVIXCrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 22:47:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=rym6gqfp9pvedcfcafhQBy3SlmXQB83c5PrY8IhMTDWZwxzpninxl3WfZKs+a+CaEtSIKqAPs3yxVkawWXzuZTd3k1UCv8w/5HzPFlyUY7Y239Z0IhKlW7qfD75a+Ab7QlbBUXdsplCeR6in9785bZWaUAQVgjhAumSeJUArcJY=  ;
Message-ID: <4334BE56.3050001@yahoo.com.au>
Date: Sat, 24 Sep 2005 12:47:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH 3/4] convert rcuref
References: <4334BCF3.1010908@yahoo.com.au> <4334BDC6.9000301@yahoo.com.au>
In-Reply-To: <4334BDC6.9000301@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------000501030503080707050000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501030503080707050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/4

-- 
SUSE Labs, Novell Inc.


--------------000501030503080707050000
Content-Type: text/plain;
 name="rcu-file-use-atomic-primitives.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rcu-file-use-atomic-primitives.patch"

Use atomic_inc_not_zero for rcu files instead of specal case rcuref.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/rcuref.h
===================================================================
--- linux-2.6.orig/include/linux/rcuref.h
+++ /dev/null
@@ -1,220 +0,0 @@
-/*
- * rcuref.h
- *
- * Reference counting for elements of lists/arrays protected by
- * RCU.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- * Copyright (C) IBM Corporation, 2005
- *
- * Author: Dipankar Sarma <dipankar@in.ibm.com>
- *	   Ravikiran Thirumalai <kiran_th@gmail.com>
- *
- * See Documentation/RCU/rcuref.txt for detailed user guide.
- *
- */
-
-#ifndef _RCUREF_H_
-#define _RCUREF_H_
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-
-/*
- * These APIs work on traditional atomic_t counters used in the
- * kernel for reference counting. Under special circumstances
- * where a lock-free get() operation races with a put() operation
- * these APIs can be used. See Documentation/RCU/rcuref.txt.
- */
-
-#ifdef __HAVE_ARCH_CMPXCHG
-
-/**
- * rcuref_inc - increment refcount for object.
- * @rcuref: reference counter in the object in question.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference
- * in a lock-free reader-side critical section.
- */
-static inline void rcuref_inc(atomic_t *rcuref)
-{
-	atomic_inc(rcuref);
-}
-
-/**
- * rcuref_dec - decrement refcount for object.
- * @rcuref: reference counter in the object in question.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference
- * in a lock-free reader-side critical section.
- */
-static inline void rcuref_dec(atomic_t *rcuref)
-{
-	atomic_dec(rcuref);
-}
-
-/**
- * rcuref_dec_and_test - decrement refcount for object and test
- * @rcuref: reference counter in the object.
- * @release: pointer to the function that will clean up the object
- *	     when the last reference to the object is released.
- *	     This pointer is required.
- *
- * Decrement the refcount, and if 0, return 1. Else return 0.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference
- * in a lock-free reader-side critical section.
- */
-static inline int rcuref_dec_and_test(atomic_t *rcuref)
-{
-	return atomic_dec_and_test(rcuref);
-}
-
-/*
- * cmpxchg is needed on UP too, if deletions to the list/array can happen
- * in interrupt context.
- */
-
-/**
- * rcuref_inc_lf - Take reference to an object in a read-side
- * critical section protected by RCU.
- * @rcuref: reference counter in the object in question.
- *
- * Try and increment the refcount by 1.  The increment might fail if
- * the reference counter has been through a 1 to 0 transition and
- * is no longer part of the lock-free list.
- * Returns non-zero on successful increment and zero otherwise.
- */
-static inline int rcuref_inc_lf(atomic_t *rcuref)
-{
-	int c, old;
-	c = atomic_read(rcuref);
-	while (c && (old = cmpxchg(&rcuref->counter, c, c + 1)) != c)
-		c = old;
-	return c;
-}
-
-#else				/* !__HAVE_ARCH_CMPXCHG */
-
-extern spinlock_t __rcuref_hash[];
-
-/*
- * Use a hash table of locks to protect the reference count
- * since cmpxchg is not available in this arch.
- */
-#ifdef	CONFIG_SMP
-#define RCUREF_HASH_SIZE	4
-#define RCUREF_HASH(k) \
-	(&__rcuref_hash[(((unsigned long)k)>>8) & (RCUREF_HASH_SIZE-1)])
-#else
-#define	RCUREF_HASH_SIZE	1
-#define RCUREF_HASH(k) 	&__rcuref_hash[0]
-#endif				/* CONFIG_SMP */
-
-/**
- * rcuref_inc - increment refcount for object.
- * @rcuref: reference counter in the object in question.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference in a lock-free
- * reader-side critical section.
- */
-static inline void rcuref_inc(atomic_t *rcuref)
-{
-	unsigned long flags;
-	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
-	rcuref->counter += 1;
-	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-}
-
-/**
- * rcuref_dec - decrement refcount for object.
- * @rcuref: reference counter in the object in question.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference in a lock-free
- * reader-side critical section.
- */
-static inline void rcuref_dec(atomic_t *rcuref)
-{
-	unsigned long flags;
-	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
-	rcuref->counter -= 1;
-	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-}
-
-/**
- * rcuref_dec_and_test - decrement refcount for object and test
- * @rcuref: reference counter in the object.
- * @release: pointer to the function that will clean up the object
- *	     when the last reference to the object is released.
- *	     This pointer is required.
- *
- * Decrement the refcount, and if 0, return 1. Else return 0.
- *
- * This should be used only for objects where we use RCU and
- * use the rcuref_inc_lf() api to acquire a reference in a lock-free
- * reader-side critical section.
- */
-static inline int rcuref_dec_and_test(atomic_t *rcuref)
-{
-	unsigned long flags;
-	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
-	rcuref->counter--;
-	if (!rcuref->counter) {
-		spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-		return 1;
-	} else {
-		spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-		return 0;
-	}
-}
-
-/**
- * rcuref_inc_lf - Take reference to an object of a lock-free collection
- * by traversing a lock-free list/array.
- * @rcuref: reference counter in the object in question.
- *
- * Try and increment the refcount by 1.  The increment might fail if
- * the reference counter has been through a 1 to 0 transition and
- * object is no longer part of the lock-free list.
- * Returns non-zero on successful increment and zero otherwise.
- */
-static inline int rcuref_inc_lf(atomic_t *rcuref)
-{
-	int ret;
-	unsigned long flags;
-	spin_lock_irqsave(RCUREF_HASH(rcuref), flags);
-	if (rcuref->counter)
-		ret = rcuref->counter++;
-	else
-		ret = 0;
-	spin_unlock_irqrestore(RCUREF_HASH(rcuref), flags);
-	return ret;
-}
-
-
-#endif /* !__HAVE_ARCH_CMPXCHG */
-
-#endif /* __KERNEL__ */
-#endif /* _RCUREF_H_ */
Index: linux-2.6/fs/aio.c
===================================================================
--- linux-2.6.orig/fs/aio.c
+++ linux-2.6/fs/aio.c
@@ -29,7 +29,6 @@
 #include <linux/highmem.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
-#include <linux/rcuref.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -500,7 +499,7 @@ static int __aio_put_req(struct kioctx *
 	/* Must be done under the lock to serialise against cancellation.
 	 * Call this aio_fput as it duplicates fput via the fput_work.
 	 */
-	if (unlikely(rcuref_dec_and_test(&req->ki_filp->f_count))) {
+	if (unlikely(atomic_dec_and_test(&req->ki_filp->f_count))) {
 		get_ioctx(ctx);
 		spin_lock(&fput_lock);
 		list_add(&req->ki_list, &fput_head);
Index: linux-2.6/fs/file_table.c
===================================================================
--- linux-2.6.orig/fs/file_table.c
+++ linux-2.6/fs/file_table.c
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(get_empty_filp);
 
 void fastcall fput(struct file *file)
 {
-	if (rcuref_dec_and_test(&file->f_count))
+	if (atomic_dec_and_test(&file->f_count))
 		__fput(file);
 }
 
@@ -166,7 +166,7 @@ struct file fastcall *fget(unsigned int 
 	rcu_read_lock();
 	file = fcheck_files(files, fd);
 	if (file) {
-		if (!rcuref_inc_lf(&file->f_count)) {
+		if (!atomic_inc_not_zero(&file->f_count)) {
 			/* File object ref couldn't be taken */
 			rcu_read_unlock();
 			return NULL;
@@ -198,7 +198,7 @@ struct file fastcall *fget_light(unsigne
 		rcu_read_lock();
 		file = fcheck_files(files, fd);
 		if (file) {
-			if (rcuref_inc_lf(&file->f_count))
+			if (atomic_inc_not_zero(&file->f_count))
 				*fput_needed = 1;
 			else
 				/* Didn't get the reference, someone's freed */
@@ -213,7 +213,7 @@ struct file fastcall *fget_light(unsigne
 
 void put_filp(struct file *file)
 {
-	if (rcuref_dec_and_test(&file->f_count)) {
+	if (atomic_dec_and_test(&file->f_count)) {
 		security_file_free(file);
 		file_kill(file);
 		file_free(file);
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -9,7 +9,6 @@
 #include <linux/config.h>
 #include <linux/limits.h>
 #include <linux/ioctl.h>
-#include <linux/rcuref.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -604,7 +603,7 @@ extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
 #define file_list_unlock() spin_unlock(&files_lock);
 
-#define get_file(x)	rcuref_inc(&(x)->f_count)
+#define get_file(x)	atomic_inc(&(x)->f_count)
 #define file_count(x)	atomic_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
Index: linux-2.6/Documentation/RCU/rcuref.txt
===================================================================
--- linux-2.6.orig/Documentation/RCU/rcuref.txt
+++ linux-2.6/Documentation/RCU/rcuref.txt
@@ -1,74 +1,67 @@
-Refcounter framework for elements of lists/arrays protected by
-RCU.
+Refcounter design for elements of lists/arrays protected by RCU.
 
 Refcounting on elements of  lists which are protected by traditional
 reader/writer spinlocks or semaphores are straight forward as in:
 
-1.					2.
-add()					search_and_reference()
-{					{
-	alloc_object				read_lock(&list_lock);
-	...					search_for_element
-	atomic_set(&el->rc, 1);			atomic_inc(&el->rc);
-	write_lock(&list_lock);			...
-	add_element				read_unlock(&list_lock);
-	...					...
-	write_unlock(&list_lock);	}
+1.				2.
+add()				search_and_reference()
+{				{
+    alloc_object		    read_lock(&list_lock);
+    ...				    search_for_element
+    atomic_set(&el->rc, 1);	    atomic_inc(&el->rc);
+    write_lock(&list_lock);	     ...
+    add_element			    read_unlock(&list_lock);
+    ...				    ...
+    write_unlock(&list_lock);	}
 }
 
 3.					4.
 release_referenced()			delete()
 {					{
-	...				write_lock(&list_lock);
-	atomic_dec(&el->rc, relfunc)	...
-	...				delete_element
-}					write_unlock(&list_lock);
- 					...
-					if (atomic_dec_and_test(&el->rc))
-						kfree(el);
-					...
+    ...					    write_lock(&list_lock);
+    atomic_dec(&el->rc, relfunc)	    ...
+    ...					    delete_element
+}					    write_unlock(&list_lock);
+ 					    ...
+					    if (atomic_dec_and_test(&el->rc))
+					        kfree(el);
+					    ...
 					}
 
 If this list/array is made lock free using rcu as in changing the
 write_lock in add() and delete() to spin_lock and changing read_lock
-in search_and_reference to rcu_read_lock(), the rcuref_get in
+in search_and_reference to rcu_read_lock(), the atomic_get in
 search_and_reference could potentially hold reference to an element which
-has already been deleted from the list/array.  rcuref_lf_get_rcu takes
+has already been deleted from the list/array.  atomic_inc_not_zero takes
 care of this scenario. search_and_reference should look as;
 
 1.					2.
 add()					search_and_reference()
 {					{
- 	alloc_object				rcu_read_lock();
-	...					search_for_element
-	atomic_set(&el->rc, 1);			if (rcuref_inc_lf(&el->rc)) {
-	write_lock(&list_lock);				rcu_read_unlock();
-							return FAIL;
-	add_element				}
-	...					...
-	write_unlock(&list_lock);		rcu_read_unlock();
+    alloc_object			    rcu_read_lock();
+    ...					    search_for_element
+    atomic_set(&el->rc, 1);		    if (atomic_inc_not_zero(&el->rc)) {
+    write_lock(&list_lock);		        rcu_read_unlock();
+					        return FAIL;
+    add_element				    }
+    ...					    ...
+    write_unlock(&list_lock);		    rcu_read_unlock();
 }					}
 3.					4.
 release_referenced()			delete()
 {					{
-	...				write_lock(&list_lock);
-	rcuref_dec(&el->rc, relfunc)	...
-	...				delete_element
-}					write_unlock(&list_lock);
- 					...
-					if (rcuref_dec_and_test(&el->rc))
-						call_rcu(&el->head, el_free);
-					...
+    ...					    write_lock(&list_lock);
+    atomic_dec(&el->rc, relfunc)	    ...
+    ...					    delete_element
+}					    write_unlock(&list_lock);
+ 					    ...
+					    if (atomic_dec_and_test(&el->rc))
+					        call_rcu(&el->head, el_free);
+					    ...
 					}
 
 Sometimes, reference to the element need to be obtained in the
-update (write) stream.  In such cases, rcuref_inc_lf might be an overkill
-since the spinlock serialising list updates are held. rcuref_inc
+update (write) stream.  In such cases, atomic_inc_not_zero might be an
+overkill since the spinlock serialising list updates are held. atomic_inc
 is to be used in such cases.
-For arches which do not have cmpxchg rcuref_inc_lf
-api uses a hashed spinlock implementation and the same hashed spinlock
-is acquired in all rcuref_xxx primitives to preserve atomicity.
-Note: Use rcuref_inc api only if you need to use rcuref_inc_lf on the
-refcounter atleast at one place.  Mixing rcuref_inc and atomic_xxx api
-might lead to races. rcuref_inc_lf() must be used in lockfree
-RCU critical sections only.
+
Index: linux-2.6/kernel/rcupdate.c
===================================================================
--- linux-2.6.orig/kernel/rcupdate.c
+++ linux-2.6/kernel/rcupdate.c
@@ -45,7 +45,6 @@
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
-#include <linux/rcuref.h>
 #include <linux/cpu.h>
 
 /* Definition for rcupdate control block. */
@@ -73,19 +72,6 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 static int maxbatch = 10;
 
-#ifndef __HAVE_ARCH_CMPXCHG
-/*
- * We use an array of spinlocks for the rcurefs -- similar to ones in sparc
- * 32 bit atomic_t implementations, and a hash function similar to that
- * for our refcounting needs.
- * Can't help multiprocessors which donot have cmpxchg :(
- */
-
-spinlock_t __rcuref_hash[RCUREF_HASH_SIZE] = {
-	[0 ... (RCUREF_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
-};
-#endif
-
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.

--------------000501030503080707050000--
Send instant messages to your online friends http://au.messenger.yahoo.com 

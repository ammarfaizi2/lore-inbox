Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbVINOyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbVINOyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVINOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:54:50 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:1726 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965224AbVINOyt (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Sep 2005 10:54:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=ryTa/Yc5RocTiLlvUi8lfVuNvHhbZ9muOjIVH7CDc7zL6uYMA/bZA/I0nPtKvQ1+8xJ5pe8YWeewqLszSX+sfQsFDs74qMYYqwidANSfCC0FdZ9Wvs2hwnayvNLvgg4CHi3nT9SbOBksFKpb5sZ7JW+TrYgX/m6mk67/+8TRWSQ=  ;
Message-ID: <432838E8.5030302@yahoo.com.au>
Date: Thu, 15 Sep 2005 00:51:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH 3/5] rcu file: use atomic primitives
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
In-Reply-To: <4328387E.6050701@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020504090800060904070608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020504090800060904070608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This removes rcuref.h in favour of using the new atomic primitives.
Lightly tested on i386.

-- 
SUSE Labs, Novell Inc.


--------------020504090800060904070608
Content-Type: text/plain;
 name="rcu-file-use-atomic-primitives.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rcu-file-use-atomic-primitives.patch"

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
@@ -31,9 +31,9 @@ release_referenced()			delete()
 
 If this list/array is made lock free using rcu as in changing the
 write_lock in add() and delete() to spin_lock and changing read_lock
-in search_and_reference to rcu_read_lock(), the rcuref_get in
+in search_and_reference to rcu_read_lock(), the atomic_get in
 search_and_reference could potentially hold reference to an element which
-has already been deleted from the list/array.  rcuref_lf_get_rcu takes
+has already been deleted from the list/array.  atomic_inc_not_zero takes
 care of this scenario. search_and_reference should look as;
 
 1.					2.
@@ -41,7 +41,7 @@ add()					search_and_reference()
 {					{
  	alloc_object				rcu_read_lock();
 	...					search_for_element
-	atomic_set(&el->rc, 1);			if (rcuref_inc_lf(&el->rc)) {
+	atomic_set(&el->rc, 1);			if (atomic_inc_not_zero(&el->rc)) {
 	write_lock(&list_lock);				rcu_read_unlock();
 							return FAIL;
 	add_element				}
@@ -52,23 +52,23 @@ add()					search_and_reference()
 release_referenced()			delete()
 {					{
 	...				write_lock(&list_lock);
-	rcuref_dec(&el->rc, relfunc)	...
+	atomic_dec(&el->rc, relfunc)	...
 	...				delete_element
 }					write_unlock(&list_lock);
  					...
-					if (rcuref_dec_and_test(&el->rc))
+					if (atomic_dec_and_test(&el->rc))
 						call_rcu(&el->head, el_free);
 					...
 					}
 
 Sometimes, reference to the element need to be obtained in the
-update (write) stream.  In such cases, rcuref_inc_lf might be an overkill
-since the spinlock serialising list updates are held. rcuref_inc
+update (write) stream.  In such cases, atomic_inc_not_zero might be an overkill
+since the spinlock serialising list updates are held. atomic_inc
 is to be used in such cases.
-For arches which do not have cmpxchg rcuref_inc_lf
+For arches which do not have cmpxchg atomic_inc_not_zero
 api uses a hashed spinlock implementation and the same hashed spinlock
-is acquired in all rcuref_xxx primitives to preserve atomicity.
-Note: Use rcuref_inc api only if you need to use rcuref_inc_lf on the
-refcounter atleast at one place.  Mixing rcuref_inc and atomic_xxx api
-might lead to races. rcuref_inc_lf() must be used in lockfree
+is acquired in all atomic_xxx primitives to preserve atomicity.
+Note: Use atomic_inc api only if you need to use atomic_inc_not_zero on the
+refcounter atleast at one place.  Mixing atomic_inc and atomic_xxx api
+might lead to races. atomic_inc_not_zero() must be used in lockfree
 RCU critical sections only.

--------------020504090800060904070608--
Send instant messages to your online friends http://au.messenger.yahoo.com 

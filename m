Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270732AbTGNR5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270733AbTGNR47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:56:59 -0400
Received: from open.airwire.net ([209.114.220.64]:27176 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270732AbTGNR4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:56:36 -0400
Date: Mon, 14 Jul 2003 14:11:20 -0400
From: Ryan Boder <icanoop@bitwiser.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] static_queue library
Message-ID: <20030714181120.GC2542@bitwiser.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch adds a flexible and efficient queue implementation. I used to end
up implementing something like this for a lot of modules I wrote (usually
with list) so I finally just made a library. I've been using it recently and
it makes life simpler and reduced my bugs. I imagine others will find it
useful also.

There is a small test program for it at
http://www.bitwiser.org/icanoop/Linux/Library/static_queue_test.tar.bz2

I realize we are in testing right now and new features aren't added, but
this is not a feature, it's just a library. It's configurable and not even
enabled by default so it won't step on any other code. It might help clean
up code for 2.6 though.

Please send comments. Also, I cannot tell from the MAINTAINERS file who to
send the patch to. Can anyone tell me?

Ryan 


diff -urN linux-2.6.0-test1/include/linux/static_queue.h linux-2.6.0-test1-icanoop/include/linux/static_queue.h
--- linux-2.6.0-test1/include/linux/static_queue.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.0-test1-icanoop/include/linux/static_queue.h	2003-07-14 11:26:29.000000000 -0400
@@ -0,0 +1,143 @@
+/*****************************************************************************
+ * Copyright 2003 Ryan Boder
+ *
+ * This file is part of Static Queue.
+ *
+ * Static Queue is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * Static Queue is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Static Queue; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *****************************************************************************/
+
+/*****************************************************************************
+ * Static Queue is a simple fixed size queue library for Linux
+ * kernel. It is fast and only does dynamic memory allocation when it
+ * is created and destroyed. It is not thread safe so if you are using
+ * a preemptible kernel make sure to use synchronization. The queue
+ * can contain contiguous data structures of any size. Elements are
+ * passed in and out of the queue with pointers to allow this. The
+ * function names are based on the methods of the STL queue class.
+ *****************************************************************************/
+
+
+#ifndef STATIC_QUEUE_H
+#define STATIC_QUEUE_H
+
+
+/*****************************************************************************
+ * This is the handle to a static queue. This structure is passed to
+ * most of the static queue functions so they know what queue to
+ * operate on. Do not access these variables directly, use the static
+ * queue functions.
+ *****************************************************************************/
+typedef struct static_queue {
+
+    /* The maximum number of elements that can be in the queue. */
+    unsigned int max_number_of_elements;
+
+    /* The size of each element in the queue. */
+    unsigned int element_size;
+    
+    /* The index of the oldest element in the queue. */
+    unsigned int head;
+    
+    /* The index where the next elemet inserted in the queue will
+     * go. */
+    unsigned int tail;
+    
+    /* Marks whether the queue is full or empty when the head is equal
+     * to the tail. This flag is better than making 1 extra storage
+     * space to decide because the type that is stored in the queue
+     * can be big, so it would waste memory. */
+    int is_full;
+
+    /* The space where the elements actually are stored. The elements
+     * are laid out contiguously in memory and can be thought of as an
+     * array of the given element size. */
+    unsigned char* elements;
+    
+} static_queue_t;
+
+
+
+/*****************************************************************************
+ * Creates a static queue. Returns 0 on failure or a valid static
+ * queue handle on success.
+ *****************************************************************************/
+static_queue_t* static_queue_create(unsigned int element_size, unsigned int number_of_elements, int kmalloc_flags);
+
+/*****************************************************************************
+ * Destroys a static queue freeing all it's memory. This function does
+ * not free the memory of the elements in the queue, as that would not
+ * be possible. If you are queuing pointers make sure to empty the
+ * queue and free all it's elements before calling this function.
+ *****************************************************************************/
+void static_queue_destroy(static_queue_t* q);
+
+/*****************************************************************************
+ * Inserts the element at the back of the queue. The element parameter
+ * is a pointer to the actual element, not the element itself. If you
+ * are queuing pointers make sure to pass a pointer to the pointer,
+ * not the pointer itself.  Returns 0 on success or -1 on failure. The
+ * only reason this function can fail is if the queue is full.
+ *****************************************************************************/
+int static_queue_push(static_queue_t* q, void* element);
+
+/*****************************************************************************
+ * Removes the element at the front of the queue. The element
+ * parameter is a pointer to the actual element, not the element
+ * itself. If you are queuing pointers make sure to pass a pointer to
+ * the pointer, not the pointer itself. The reason the element is
+ * returned though a pointer argument instead of the function return
+ * value is to support the queue storing structures. You cannot return
+ * a structure in C. Returns 0 on success or -1 on failure. The only
+ * reason this function can fail is if the queue is empty.
+ *****************************************************************************/
+int static_queue_pop(static_queue_t* q, void* element);
+
+/*****************************************************************************
+ * Returns a pointer to the oldest element in the queue without
+ * actually popping the element from the queue. Returns 0 on failure
+ * or a valid pointer on success.. The only reason this function can
+ * fail is if the queue is empty.
+ *****************************************************************************/
+void* static_queue_front(static_queue_t* q);
+
+/*****************************************************************************
+ * Returns a pointer to the newest element in the queue without
+ * actually popping the element from the queue. Returns 0 on failure
+ * or a valid pointer on success.. The only reason this function can
+ * fail is if the queue is empty.
+ *****************************************************************************/
+void* static_queue_back(static_queue_t* q);
+
+/*****************************************************************************
+ * Returns 1 if the queue is empty, 0 otherwise.
+ *****************************************************************************/
+int static_queue_empty(static_queue_t* q);
+
+/*****************************************************************************
+ * Returns 1 if the queue is full, 0 otherwise.
+ *****************************************************************************/
+int static_queue_full(static_queue_t* q);
+
+/*****************************************************************************
+ * Returns the size of the queue. The size of the number of elements
+ * currently in the queue.
+ *****************************************************************************/
+unsigned int static_queue_size(static_queue_t* q);
+
+
+#endif
+
+
diff -urN linux-2.6.0-test1/kernel/ksyms.c linux-2.6.0-test1-icanoop/kernel/ksyms.c
--- linux-2.6.0-test1/kernel/ksyms.c	2003-07-13 23:28:56.000000000 -0400
+++ linux-2.6.0-test1-icanoop/kernel/ksyms.c	2003-07-14 11:40:25.000000000 -0400
@@ -60,6 +60,7 @@
 #include <linux/backing-dev.h>
 #include <linux/percpu_counter.h>
 #include <asm/checksum.h>
+#include <linux/static_queue.h>
 
 #if defined(CONFIG_PROC_FS)
 #include <linux/proc_fs.h>
@@ -535,6 +536,17 @@
 EXPORT_SYMBOL(single_open);
 EXPORT_SYMBOL(single_release);
 EXPORT_SYMBOL(seq_release_private);
+#ifdef CONFIG_STATIC_QUEUE
+EXPORT_SYMBOL(static_queue_create);
+EXPORT_SYMBOL(static_queue_destroy);
+EXPORT_SYMBOL(static_queue_push);
+EXPORT_SYMBOL(static_queue_pop);
+EXPORT_SYMBOL(static_queue_front);
+EXPORT_SYMBOL(static_queue_back);
+EXPORT_SYMBOL(static_queue_empty);
+EXPORT_SYMBOL(static_queue_full);
+EXPORT_SYMBOL(static_queue_size);
+#endif
 
 /* Program loader interfaces */
 #ifdef CONFIG_MMU
diff -urN linux-2.6.0-test1/lib/Kconfig linux-2.6.0-test1-icanoop/lib/Kconfig
--- linux-2.6.0-test1/lib/Kconfig	2003-07-13 23:34:43.000000000 -0400
+++ linux-2.6.0-test1-icanoop/lib/Kconfig	2003-07-14 11:29:45.000000000 -0400
@@ -26,5 +26,15 @@
 		(PPP_DEFLATE=m || JFFS2_FS=m || CRYPTO_DEFLATE=m)
 	default y if PPP_DEFLATE=y || JFFS2_FS=y || CRYPTO_DEFLATE=y
 
+config STATIC_QUEUE
+    bool "Static Queue support"
+    default n
+    help
+      You can say N here if you do not want static queue support in
+      the kernel. If any code in the kernel is using static queue you
+      must say yes here.
+
+      If unsure, say Y.
+
 endmenu
 
diff -urN linux-2.6.0-test1/lib/Makefile linux-2.6.0-test1-icanoop/lib/Makefile
--- linux-2.6.0-test1/lib/Makefile	2003-07-13 23:29:30.000000000 -0400
+++ linux-2.6.0-test1-icanoop/lib/Makefile	2003-07-14 11:28:49.000000000 -0400
@@ -10,6 +10,7 @@
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_SMP) += percpu_counter.o
+lib-$(CONFIG_STATIC_QUEUE) += static_queue.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   lib-y += dec_and_lock.o
diff -urN linux-2.6.0-test1/lib/static_queue.c linux-2.6.0-test1-icanoop/lib/static_queue.c
--- linux-2.6.0-test1/lib/static_queue.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.0-test1-icanoop/lib/static_queue.c	2003-07-14 11:26:05.000000000 -0400
@@ -0,0 +1,177 @@
+/*****************************************************************************
+ * Copyright 2003 Ryan Boder
+ *
+ * This file is part of Static Queue.
+ *
+ * Static Queue is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * Static Queue is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Static Queue; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *****************************************************************************/
+
+/*****************************************************************************
+ * Static Queue is a simple fixed size queue library for Linux
+ * kernel. It is fast and only does dynamic memory allocation when it
+ * is created and destroyed. It is not thread safe so if you are using
+ * a preemptible kernel make sure to use synchronization. The queue
+ * can contain contiguous data structures of any size. Elements are
+ * passed in and out of the queue with pointers to allow this. The
+ * function names are based on the methods of the STL queue class.
+ *****************************************************************************/
+
+
+#include <linux/module.h>       /* EXPORT_SYMBOL. */
+#include <linux/slab.h>         /* kmalloc and kfree. */
+#include <linux/string.h>       /* memcpy. */
+#include <linux/static_queue.h>
+
+
+
+/*****************************************************************************/
+static_queue_t* static_queue_create(unsigned int element_size, unsigned int number_of_elements, int kmalloc_flags)
+{
+    static_queue_t* q;
+    unsigned int total_memory_size;
+
+
+    /* Figure out the total memory size so that only a single
+     * allocation is needed. */
+    total_memory_size = sizeof(static_queue_t) + element_size * number_of_elements;
+
+    /* Allocate the memory for both the queue handle and the
+     * elements. */
+    q = kmalloc(total_memory_size, kmalloc_flags);
+    if (0 == q)
+        return (static_queue_t*) 0;
+    
+    /* Initialize the queue. */
+    q->max_number_of_elements = number_of_elements;
+    q->element_size = element_size;
+    q->head = 0;
+    q->tail = 0;
+    q->is_full = 0;
+    q->elements = ((unsigned char*) q) + sizeof(static_queue_t);
+
+    return q;
+}
+
+/*****************************************************************************/
+void static_queue_destroy(static_queue_t* q)
+{
+    /* The queue handle and the elements were allocated in the same
+     * buffer so just freeing the handle will free all the memory. */
+    kfree(q);
+}
+
+/*****************************************************************************/
+int static_queue_push(static_queue_t* q, void* element)
+{
+    unsigned char* storage;
+
+
+    /* If the queue is full, nothing can be inserted. */
+    if (static_queue_full(q))
+        return -1;
+    
+    /* Figure out where to store the element. */
+    storage = q->elements + q->tail * q->element_size;
+    
+    /* Copy the element into the storage. */
+    memcpy(storage, element, q->element_size);
+    
+    /* Move the tail forward. */
+    q->tail = (q->tail + 1) % q->max_number_of_elements;
+
+    /* If the queue is now full, set the flag. */
+    if (q->head == q->tail)
+        q->is_full = 1;
+
+    return 0;
+}
+
+/*****************************************************************************/
+int static_queue_pop(static_queue_t* q, void* element)
+{
+    unsigned char* storage;
+
+
+    /* If the queue is empty, nothing can be removed. */
+    if (static_queue_empty(q))
+        return -1;
+
+    /* Figure out where the element is stored. */
+    storage = q->elements + q->head * q->element_size;
+    
+    /* Copy the element into the storage. */
+    memcpy(element, storage, q->element_size);
+
+    /* If the queue was full, clear the flag. */
+    if (q->head == q->tail)
+        q->is_full = 0;    
+
+    /* Move the head forward. */
+    q->head = (q->head + 1) % q->max_number_of_elements;
+
+    return 0;
+}
+
+/****************************************************************************/
+void* static_queue_front(static_queue_t* q)
+{
+    /* If the queue is empty, nothing can be removed. */
+    if (static_queue_empty(q))
+        return (void*) 0;
+    
+    return (void*) (q->elements + q->head * q->element_size);
+}
+
+/****************************************************************************/
+void* static_queue_back(static_queue_t* q)
+{
+    /* If the queue is empty, nothing can be removed. */
+    if (static_queue_empty(q))
+        return (void*) 0;
+
+    return (void*) (q->elements + q->tail - 1 * q->element_size);
+}
+
+/****************************************************************************/
+int static_queue_empty(static_queue_t* q)
+{
+    if (q->head == q->tail && !q->is_full)
+        return 1;
+    else
+        return 0;
+}
+
+/****************************************************************************/
+int static_queue_full(static_queue_t* q)
+{
+    if (q->head == q->tail && q->is_full)
+        return 1;
+    else
+        return 0;
+}
+
+/****************************************************************************/
+unsigned int static_queue_size(static_queue_t* q)
+{
+    if (q->tail > q->head)
+        return q->tail - q->head;
+    else if (q->tail < q->head)
+        return q->tail + q->max_number_of_elements - q->head;
+    else
+        return static_queue_full(q) ? q->max_number_of_elements : 0;
+}
+
+

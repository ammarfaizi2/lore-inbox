Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSJPSt4>; Wed, 16 Oct 2002 14:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJPSt4>; Wed, 16 Oct 2002 14:49:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:45030 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261295AbSJPSty>;
	Wed, 16 Oct 2002 14:49:54 -0400
Date: Thu, 17 Oct 2002 00:31:40 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU helper patchset 2/2
Message-ID: <20021017003140.B2380@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021017002354.A2380@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017002354.A2380@in.ibm.com>; from dipankar@in.ibm.com on Thu, Oct 17, 2002 at 12:23:54AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the second of the RCU helper patchsets -

This adds a set of list macros that make handling of list protected
by RCU simpler. The interfaces added are -

list_add_rcu
list_add_tail_rcu
	- Adds an element by taking care of memory barrier (wmb()).

list_del_rcu
	- Deletes an element but doesn't re-initialize the pointers in
	  the element for supporting RCU based traversal.

list_for_each_rcu
__list_for_each_rcu
	- Traversal of RCU protected list - takes care of memory barriers
	  transparently.

Patch against 2.5.43. Please apply.

Thanks
Dipankar


 list.h |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+)


diff -urN linux-2.5.43-base/include/linux/list.h linux-2.5.43-list_rcu/include/linux/list.h
--- linux-2.5.43-base/include/linux/list.h	Sat Oct 12 23:44:44 2002
+++ linux-2.5.43-list_rcu/include/linux/list.h	Wed Oct 16 23:10:11 2002
@@ -4,6 +4,7 @@
 #if defined(__KERNEL__) || defined(_LVM_H_INCLUDE)
 
 #include <linux/prefetch.h>
+#include <asm/system.h>
 
 /*
  * Simple doubly linked list implementation.
@@ -71,6 +72,49 @@
 }
 
 /*
+ * Insert a new entry between two known consecutive entries. 
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static __inline__ void __list_add_rcu(struct list_head * new,
+	struct list_head * prev,
+	struct list_head * next)
+{
+	new->next = next;
+	new->prev = prev;
+	wmb();
+	next->prev = new;
+	prev->next = new;
+}
+
+/**
+ * list_add_rcu - add a new entry to rcu-protected list
+ * @new: new entry to be added
+ * @head: list head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static __inline__ void list_add_rcu(struct list_head *new, struct list_head *head)
+{
+	__list_add_rcu(new, head, head->next);
+}
+
+/**
+ * list_add_tail_rcu - add a new entry to rcu-protected list
+ * @new: new entry to be added
+ * @head: list head to add it before
+ *
+ * Insert a new entry before the specified head.
+ * This is useful for implementing queues.
+ */
+static __inline__ void list_add_tail_rcu(struct list_head *new, struct list_head *head)
+{
+	__list_add_rcu(new, head->prev, head);
+}
+
+/*
  * Delete a list entry by making the prev/next entries
  * point to each other.
  *
@@ -93,6 +137,17 @@
 {
 	__list_del(entry->prev, entry->next);
 }
+/**
+ * list_del_rcu - deletes entry from list without re-initialization
+ * @entry: the element to delete from the list.
+ * Note: list_empty on entry does not return true after this, 
+ * the entry is in an undefined state. It is useful for RCU based
+ * lockfree traversal.
+ */
+static inline void list_del_rcu(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+}
 
 /**
  * list_del_init - deletes entry from list and reinitialize it.
@@ -240,6 +295,30 @@
 	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
 		     prefetch(pos->member.next))
 
+/**
+ * list_for_each_rcu	-	iterate over an rcu-protected list
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @head:	the head for your list.
+ */
+#define list_for_each_rcu(pos, head) \
+	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
+        	pos = pos->next, ({ read_barrier_depends(); 0;}), prefetch(pos->next))
+        	
+#define __list_for_each_rcu(pos, head) \
+	for (pos = (head)->next; pos != (head); \
+        	pos = pos->next, ({ read_barrier_depends(); 0;}))
+        	
+/**
+ * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
+ *					against removal of list entry
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @n:		another &struct list_head to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define list_for_each_safe_rcu(pos, n, head) \
+	for (pos = (head)->next, n = pos->next; pos != (head); \
+		pos = n, ({ read_barrier_depends(); 0;}), n = pos->next)
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
 #endif

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTE2XoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 19:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTE2XoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 19:44:12 -0400
Received: from holomorphy.com ([66.224.33.161]:33163 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263179AbTE2XoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 19:44:07 -0400
Date: Thu, 29 May 2003 16:57:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Morten Helgesen <morten.helgesen@nextframe.net>,
       linux-kernel@vger.kernel.org
Cc: B.Solarz-Niesluchowski@wsisiz.edu.pl
Subject: Re: list_head debugging patch
Message-ID: <20030529235715.GE8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Morten Helgesen <morten.helgesen@nextframe.net>,
	linux-kernel@vger.kernel.org, B.Solarz-Niesluchowski@wsisiz.edu.pl
References: <20030529130807.GH19818@holomorphy.com> <200305292158.52311.morten.helgesen@nextframe.net> <20030529201337.GC8978@holomorphy.com> <200305292303.19946.morten.helgesen@nextframe.net> <20030529210908.GD8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529210908.GD8978@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 22:13, William Lee Irwin III wrote:
>>> Same thing; nuke the __list_head_check() check in list_empty()
>>> please.

On Thu, May 29, 2003 at 11:03:19PM +0200, Morten Helgesen wrote:
>> Ok, after having nuked __list_head_check() in list_empty() I can`t 
>> seem to trigger any more list corruption on this box.

On Thu, May 29, 2003 at 02:09:08PM -0700, William Lee Irwin III wrote:
> Well, that's a hopeful sign; at some point maybe IDE will stop oopsing
> on me with it.

This time fixed up for list_emptY() and list_for_each*_safe()


--- linux-2.5.70/include/linux/list.h	2003-05-26 18:00:41.000000000 -0700
+++ pgcl-2.5.70-2/include/linux/list.h	2003-05-29 14:26:39.000000000 -0700
@@ -30,6 +30,22 @@
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
 } while (0)
 
+static inline void __list_head_check(const struct list_head *elem)
+{
+	if (elem->prev->next != elem) {
+		printk(KERN_CRIT "elem = %p, elem->prev = %p, "
+					"elem->prev->next = %p\n",
+					elem, elem->prev, elem->prev->next);
+		BUG();
+	}
+	if (elem->next->prev != elem) {
+		printk(KERN_CRIT "elem = %p, elem->next = %p, "
+				"elem->next->prev = %p\n",
+				elem, elem->next, elem->next->prev);
+		BUG();
+	}
+}
+
 /*
  * Insert a new entry between two known consecutive entries. 
  *
@@ -56,6 +72,7 @@
  */
 static inline void list_add(struct list_head *new, struct list_head *head)
 {
+	__list_head_check(head);
 	__list_add(new, head, head->next);
 }
 
@@ -69,6 +86,7 @@
  */
 static inline void list_add_tail(struct list_head *new, struct list_head *head)
 {
+	__list_head_check(head);
 	__list_add(new, head->prev, head);
 }
 
@@ -136,7 +154,10 @@
  */
 static inline void list_del(struct list_head *entry)
 {
+	__list_head_check(entry);
 	__list_del(entry->prev, entry->next);
+	entry->prev = (void *)0x7c7c7c7c;
+	entry->next = (void *)0x8d8d8d8d;
 }
 /**
  * list_del_rcu - deletes entry from list without re-initialization
@@ -156,6 +177,7 @@
  */
 static inline void list_del_init(struct list_head *entry)
 {
+	__list_head_check(entry);
 	__list_del(entry->prev, entry->next);
 	INIT_LIST_HEAD(entry); 
 }
@@ -167,6 +189,8 @@
  */
 static inline void list_move(struct list_head *list, struct list_head *head)
 {
+	__list_head_check(list);
+	__list_head_check(head);
         __list_del(list->prev, list->next);
         list_add(list, head);
 }
@@ -179,6 +203,8 @@
 static inline void list_move_tail(struct list_head *list,
 				  struct list_head *head)
 {
+	__list_head_check(list);
+	__list_head_check(head);
         __list_del(list->prev, list->next);
         list_add_tail(list, head);
 }
@@ -199,6 +225,9 @@
 	struct list_head *last = list->prev;
 	struct list_head *at = head->next;
 
+	__list_head_check(head);
+	__list_head_check(list);
+
 	first->prev = head;
 	head->next = first;
 
@@ -213,6 +242,8 @@
  */
 static inline void list_splice(struct list_head *list, struct list_head *head)
 {
+	__list_head_check(list);
+	__list_head_check(head);
 	if (!list_empty(list))
 		__list_splice(list, head);
 }
@@ -227,6 +258,8 @@
 static inline void list_splice_init(struct list_head *list,
 				    struct list_head *head)
 {
+	__list_head_check(list);
+	__list_head_check(head);
 	if (!list_empty(list)) {
 		__list_splice(list, head);
 		INIT_LIST_HEAD(list);
@@ -248,8 +281,9 @@
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
-	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
-        	pos = pos->next, prefetch(pos->next))
+	for (pos = (head)->next, prefetch((pos)->next); pos != (head);	\
+		__list_head_check(pos), __list_head_check(head),	\
+        	pos = (pos)->next, prefetch((pos)->next))
 
 /**
  * __list_for_each	-	iterate over a list
@@ -262,7 +296,11 @@
  * or 1 entry) most of the time.
  */
 #define __list_for_each(pos, head) \
-	for (pos = (head)->next; pos != (head); pos = pos->next)
+	for (pos = (head)->next;					\
+		pos != (head);						\
+		__list_head_check(pos),					\
+		__list_head_check(head),				\
+		pos = pos->next)
 
 /**
  * list_for_each_prev	-	iterate over a list backwards
@@ -270,8 +308,9 @@
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
-	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
-        	pos = pos->prev, prefetch(pos->prev))
+	for (pos = (head)->prev, prefetch((pos)->prev); pos != (head);	\
+		__list_head_check(pos), __list_head_check(head),	\
+        	pos = (pos)->prev, prefetch((pos)->prev))
         	
 /**
  * list_for_each_safe	-	iterate over a list safe against removal of list entry
@@ -280,8 +319,9 @@
  * @head:	the head for your list.
  */
 #define list_for_each_safe(pos, n, head) \
-	for (pos = (head)->next, n = pos->next; pos != (head); \
-		pos = n, n = pos->next)
+	for (pos = (head)->next, n = (pos)->next; pos != (head);	\
+		__list_head_check(n), __list_head_check(head),		\
+		pos = n, n = (pos)->next)
 
 /**
  * list_for_each_entry	-	iterate over list of given type
@@ -290,11 +330,28 @@
  * @member:	the name of the list_struct within the struct.
  */
 #define list_for_each_entry(pos, head, member)				\
-	for (pos = list_entry((head)->next, typeof(*pos), member),	\
-		     prefetch(pos->member.next);			\
-	     &pos->member != (head); 					\
-	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
-		     prefetch(pos->member.next))
+	for (pos = list_entry((head)->next, typeof(*(pos)), member),	\
+		     prefetch((pos)->member.next);			\
+	     &(pos)->member != (head); 					\
+	     pos = list_entry((pos)->member.next, typeof(*(pos)), member),\
+		     __list_head_check(head),				\
+		     __list_head_check(&(pos)->member),			\
+		     prefetch((pos)->member.next))
+
+/**
+ * list_for_each_entry_prev	-	iterate over a list backwards
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_prev(pos, head, member)			\
+	for (pos = list_entry((head)->prev, typeof(*(pos)), member),	\
+		     prefetch((pos)->member.prev);			\
+	     &(pos)->member != (head); 					\
+	     pos = list_entry((pos)->member.prev, typeof(*(pos)), member),\
+		     __list_head_check(head),				\
+		     __list_head_check(&(pos)->member),			\
+		     prefetch((pos)->member.prev))
 
 /**
  * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
@@ -304,10 +361,11 @@
  * @member:	the name of the list_struct within the struct.
  */
 #define list_for_each_entry_safe(pos, n, head, member)			\
-	for (pos = list_entry((head)->next, typeof(*pos), member),	\
-		n = list_entry(pos->member.next, typeof(*pos), member);	\
-	     &pos->member != (head); 					\
-	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
+	for (pos = list_entry((head)->next, typeof(*(pos)), member),	\
+		n = list_entry((pos)->member.next, typeof(*(pos)), member);\
+	     &(pos)->member != (head); 					\
+	     __list_head_check(head), __list_head_check(&(n)->member),	\
+	     pos = n, n = list_entry((n)->member.next, typeof(*(n)), member))
 
 /**
  * list_for_each_rcu	-	iterate over an rcu-protected list
@@ -401,9 +459,15 @@
 {
 	if (n->pprev)
 		__hlist_del(n);
+	n->next = (void *)0x9e9e9e9e;
+	n->pprev = (void *)0xafafafaf;
 }
 
-#define hlist_del_rcu hlist_del  /* list_del_rcu is identical too? */
+static __inline__ void hlist_del_rcu(struct hlist_node *n)
+{
+	if (n->pprev)
+		__hlist_del(n);
+}
 
 static __inline__ void hlist_del_init(struct hlist_node *n) 
 {

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263546AbSITUsA>; Fri, 20 Sep 2002 16:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263554AbSITUsA>; Fri, 20 Sep 2002 16:48:00 -0400
Received: from bitchcake.off.net ([216.138.242.5]:9863 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S263546AbSITUr6>;
	Fri, 20 Sep 2002 16:47:58 -0400
Date: Fri, 20 Sep 2002 16:53:04 -0400
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] list_head debugging?
Message-ID: <20020920165304.A4588@bitchcake.off.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A friend recently was bitten by passing a list_head from list_for_each
to a code path that later moved the list_head around.  Does the attached
patch re-create some debugging wheel that's hiding off in a corner
somewhere?

Beyond catching the obvious use of uninitialized things, it also seems
to catch double adds, double deletes, and simple deletes of 'pos' in
list_for_each.  it even seems to bark about the seemingly hard-to-detect
movement of 'pos' from the iterating list to another, but probably only
in the rare case where you're unconditionally moving all 'pos' in the
loop body.  (you eventually iterate into the second list's head and try
to add it to itself)

I've only played with this in userspace but am glad to pretty it up with
CONFIG_s and bring it into 2.5 if people care.  its against 2.4.mumble.

-- 
 zach

--- ./list.h.debug	Thu Sep 19 15:58:47 2002
+++ ./list.h	Fri Sep 20 13:43:21 2002
@@ -21,6 +21,25 @@
 
 typedef struct list_head list_t;
 
+#define LIST_HEAD_DEBUGGING
+#ifdef LIST_HEAD_DEBUGGING
+
+static inline void __list_valid(struct list_head *list)
+{
+	BUG_ON(list == NULL);
+	BUG_ON(list->next == NULL);
+	BUG_ON(list->prev == NULL);
+	BUG_ON(list->next->prev != list);
+	BUG_ON(list->prev->next != list);
+	BUG_ON((list->next == list) && (list->prev != list));
+	BUG_ON((list->prev == list) && (list->next != list));
+}
+#else 
+
+#define __list_valid(args...)
+
+#endif
+
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
@@ -56,7 +75,9 @@
  */
 static __inline__ void list_add(struct list_head *new, struct list_head *head)
 {
+	__list_valid(head);
 	__list_add(new, head, head->next);
+	__list_valid(new);
 }
 
 /**
@@ -69,7 +90,9 @@
  */
 static __inline__ void list_add_tail(struct list_head *new, struct list_head *head)
 {
+	__list_valid(head);
 	__list_add(new, head->prev, head);
+	__list_valid(new);
 }
 
 /*
@@ -93,6 +116,7 @@
  */
 static __inline__ void list_del(struct list_head *entry)
 {
+	__list_valid(entry);
 	__list_del(entry->prev, entry->next);
 }
 
@@ -102,6 +126,7 @@
  */
 static __inline__ void list_del_init(struct list_head *entry)
 {
+	__list_valid(entry);
 	__list_del(entry->prev, entry->next);
 	INIT_LIST_HEAD(entry); 
 }
@@ -112,6 +137,7 @@
  */
 static __inline__ int list_empty(struct list_head *head)
 {
+	__list_valid(head);
 	return head->next == head;
 }
 
@@ -124,6 +150,9 @@
 {
 	struct list_head *first = list->next;
 
+	__list_valid(list);
+	__list_valid(head);
+
 	if (first != list) {
 		struct list_head *last = list->prev;
 		struct list_head *at = head->next;
@@ -150,9 +179,10 @@
  * @pos:	the &struct list_head to use as a loop counter.
  * @head:	the head for your list.
  */
-#define list_for_each(pos, head) \
-	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
-        	pos = pos->next, prefetch(pos->next))
+#define list_for_each(pos, head) 			\
+	for (pos = (head)->next, prefetch(pos->next); \
+		__list_valid(pos), pos != (head); 	\
+        	__list_valid(pos), pos = pos->next, prefetch(pos->next))
         	
 /**
  * list_for_each_safe	-	iterate over a list safe against removal of list entry
@@ -170,8 +200,9 @@
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
-	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
-        	pos = pos->prev, prefetch(pos->prev))
+	for (pos = (head)->prev, prefetch(pos->prev); \
+		__list_valid(pos), pos != (head); \
+        	__list_valid(pos), pos = pos->prev, prefetch(pos->prev))
         	
 
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */

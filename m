Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319047AbSH2AMJ>; Wed, 28 Aug 2002 20:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSH2AMJ>; Wed, 28 Aug 2002 20:12:09 -0400
Received: from verein.lst.de ([212.34.181.86]:60173 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S319047AbSH2AMD>;
	Wed, 28 Aug 2002 20:12:03 -0400
Date: Thu, 29 Aug 2002 02:16:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] list.h update (resent again)
Message-ID: <20020829021616.A9715@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates list.h to the 2.5 version, including

 - list_t typedef
 - static inline insead of static __inline__
 - list_move/list_move_tail
 - list_splice_init


--- linux-2.4.20-pre5/include/linux/list.h	Thu Aug 29 02:58:49 2002
+++ linux/include/linux/list.h	Thu Aug 29 03:07:35 2002
@@ -19,10 +19,12 @@ struct list_head {
 	struct list_head *next, *prev;
 };
 
+typedef struct list_head list_t;
+
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
-	struct list_head name = LIST_HEAD_INIT(name)
+	list_t name = LIST_HEAD_INIT(name)
 
 #define INIT_LIST_HEAD(ptr) do { \
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
@@ -34,9 +36,7 @@ struct list_head {
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static __inline__ void __list_add(struct list_head * new,
-	struct list_head * prev,
-	struct list_head * next)
+static inline void __list_add(list_t *new, list_t *prev, list_t *next)
 {
 	next->prev = new;
 	new->next = next;
@@ -52,7 +52,7 @@ static __inline__ void __list_add(struct
  * Insert a new entry after the specified head.
  * This is good for implementing stacks.
  */
-static __inline__ void list_add(struct list_head *new, struct list_head *head)
+static inline void list_add(list_t *new, list_t *head)
 {
 	__list_add(new, head, head->next);
 }
@@ -65,7 +65,7 @@ static __inline__ void list_add(struct l
  * Insert a new entry before the specified head.
  * This is useful for implementing queues.
  */
-static __inline__ void list_add_tail(struct list_head *new, struct list_head *head)
+static inline void list_add_tail(list_t *new, list_t *head)
 {
 	__list_add(new, head->prev, head);
 }
@@ -77,8 +77,7 @@ static __inline__ void list_add_tail(str
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static __inline__ void __list_del(struct list_head * prev,
-				  struct list_head * next)
+static inline void __list_del(list_t * prev, list_t * next)
 {
 	next->prev = prev;
 	prev->next = next;
@@ -89,54 +88,96 @@ static __inline__ void __list_del(struct
  * @entry: the element to delete from the list.
  * Note: list_empty on entry does not return true after this, the entry is in an undefined state.
  */
-static __inline__ void list_del(struct list_head *entry)
+static inline void list_del(list_t *entry)
 {
 	__list_del(entry->prev, entry->next);
+	entry->next = (void *) 0;
+	entry->prev = (void *) 0;
 }
 
 /**
  * list_del_init - deletes entry from list and reinitialize it.
  * @entry: the element to delete from the list.
  */
-static __inline__ void list_del_init(struct list_head *entry)
+static inline void list_del_init(list_t *entry)
 {
 	__list_del(entry->prev, entry->next);
 	INIT_LIST_HEAD(entry); 
 }
 
 /**
+ * list_move - delete from one list and add as another's head
+ * @list: the entry to move
+ * @head: the head that will precede our entry
+ */
+static inline void list_move(list_t *list, list_t *head)
+{
+        __list_del(list->prev, list->next);
+        list_add(list, head);
+}
+
+/**
+ * list_move_tail - delete from one list and add as another's tail
+ * @list: the entry to move
+ * @head: the head that will follow our entry
+ */
+static inline void list_move_tail(list_t *list, list_t *head)
+{
+        __list_del(list->prev, list->next);
+        list_add_tail(list, head);
+}
+
+/**
  * list_empty - tests whether a list is empty
  * @head: the list to test.
  */
-static __inline__ int list_empty(struct list_head *head)
+static inline int list_empty(list_t *head)
 {
 	return head->next == head;
 }
 
+static inline void __list_splice(list_t *list, list_t *head)
+{
+	list_t *first = list->next;
+	list_t *last = list->prev;
+	list_t *at = head->next;
+
+	first->prev = head;
+	head->next = first;
+
+	last->next = at;
+	at->prev = last;
+}
+
 /**
  * list_splice - join two lists
  * @list: the new list to add.
  * @head: the place to add it in the first list.
  */
-static __inline__ void list_splice(struct list_head *list, struct list_head *head)
+static inline void list_splice(list_t *list, list_t *head)
 {
-	struct list_head *first = list->next;
-
-	if (first != list) {
-		struct list_head *last = list->prev;
-		struct list_head *at = head->next;
-
-		first->prev = head;
-		head->next = first;
+	if (!list_empty(list))
+		__list_splice(list, head);
+}
 
-		last->next = at;
-		at->prev = last;
+/**
+ * list_splice_init - join two lists and reinitialise the emptied list.
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_init(list_t *list, list_t *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head);
+		INIT_LIST_HEAD(list);
 	}
 }
 
 /**
  * list_entry - get the struct for this entry
- * @ptr:	the &struct list_head pointer.
+ * @ptr:	the &list_t pointer.
  * @type:	the type of the struct this is embedded in.
  * @member:	the name of the list_struct within the struct.
  */
@@ -145,17 +186,25 @@ static __inline__ void list_splice(struc
 
 /**
  * list_for_each	-	iterate over a list
- * @pos:	the &struct list_head to use as a loop counter.
+ * @pos:	the &list_t to use as a loop counter.
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
 	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
         	pos = pos->next, prefetch(pos->next))
+/**
+ * list_for_each_prev	-	iterate over a list backwards
+ * @pos:	the &list_t to use as a loop counter.
+ * @head:	the head for your list.
+ */
+#define list_for_each_prev(pos, head) \
+	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
+        	pos = pos->prev, prefetch(pos->prev))
         	
 /**
  * list_for_each_safe	-	iterate over a list safe against removal of list entry
- * @pos:	the &struct list_head to use as a loop counter.
- * @n:		another &struct list_head to use as temporary storage
+ * @pos:	the &list_t to use as a loop counter.
+ * @n:		another &list_t to use as temporary storage
  * @head:	the head for your list.
  */
 #define list_for_each_safe(pos, n, head) \
@@ -163,16 +212,6 @@ static __inline__ void list_splice(struc
 		pos = n, n = pos->next)
 
 /**
- * list_for_each_prev	-	iterate over a list in reverse order
- * @pos:	the &struct list_head to use as a loop counter.
- * @head:	the head for your list.
- */
-#define list_for_each_prev(pos, head) \
-	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
-        	pos = pos->prev, prefetch(pos->prev))
-        	
-
-/**
  * list_for_each_entry	-	iterate over list of given type
  * @pos:	the type * to use as a loop counter.
  * @head:	the head for your list.

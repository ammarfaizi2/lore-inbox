Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSFJPaJ>; Mon, 10 Jun 2002 11:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSFJPaI>; Mon, 10 Jun 2002 11:30:08 -0400
Received: from pop.gmx.net ([213.165.64.20]:61571 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S310190AbSFJPaG>;
	Mon, 10 Jun 2002 11:30:06 -0400
Date: Mon, 10 Jun 2002 18:28:24 +0300
From: Dan Aloni <da-x@gmx.net>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.21 - list.h cleanup
Message-ID: <20020610152824.GC9581@callisto.yi.org>
In-Reply-To: <Pine.LNX.4.44.0206090508330.22407-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0206090641330.24893-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.5.21 vanilla. 

 + replace __inline__ with inline.
 + use list_t intead of struct list_head (no bytes we harmed, bla.. bla..)
 + add the new list_move and list_move_tail mutators as inline functions.

--- linux-2.5.21/include/linux/list.h	Mon Jun 10 17:28:26 2002
+++ linux-2.5.21/include/linux/list.h	Mon Jun 10 18:08:58 2002
@@ -24,7 +24,7 @@
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
-	struct list_head name = LIST_HEAD_INIT(name)
+	list_t name = LIST_HEAD_INIT(name)
 
 #define INIT_LIST_HEAD(ptr) do { \
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
@@ -36,9 +36,7 @@
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
@@ -54,7 +52,7 @@
  * Insert a new entry after the specified head.
  * This is good for implementing stacks.
  */
-static __inline__ void list_add(struct list_head *new, struct list_head *head)
+static inline void list_add(list_t *new, list_t *head)
 {
 	__list_add(new, head, head->next);
 }
@@ -67,7 +65,7 @@
  * Insert a new entry before the specified head.
  * This is useful for implementing queues.
  */
-static __inline__ void list_add_tail(struct list_head *new, struct list_head *head)
+static inline void list_add_tail(list_t *new, list_t *head)
 {
 	__list_add(new, head->prev, head);
 }
@@ -79,8 +77,7 @@
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static __inline__ void __list_del(struct list_head * prev,
-				  struct list_head * next)
+static inline void __list_del(list_t * prev, list_t * next)
 {
 	next->prev = prev;
 	prev->next = next;
@@ -91,7 +88,7 @@
  * @entry: the element to delete from the list.
  * Note: list_empty on entry does not return true after this, the entry is in an undefined state.
  */
-static __inline__ void list_del(struct list_head *entry)
+static inline void list_del(list_t *entry)
 {
 	__list_del(entry->prev, entry->next);
 	entry->next = (void *) 0;
@@ -102,17 +99,39 @@
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
@@ -122,13 +141,13 @@
  * @list: the new list to add.
  * @head: the place to add it in the first list.
  */
-static __inline__ void list_splice(struct list_head *list, struct list_head *head)
+static inline void list_splice(list_t *list, list_t *head)
 {
-	struct list_head *first = list->next;
+	list_t *first = list->next;
 
 	if (first != list) {
-		struct list_head *last = list->prev;
-		struct list_head *at = head->next;
+		list_t *last = list->prev;
+		list_t *at = head->next;
 
 		first->prev = head;
 		head->next = first;
@@ -140,7 +159,7 @@
 
 /**
  * list_entry - get the struct for this entry
- * @ptr:	the &struct list_head pointer.
+ * @ptr:	the &list_t pointer.
  * @type:	the type of the struct this is embedded in.
  * @member:	the name of the list_struct within the struct.
  */
@@ -149,7 +168,7 @@
 
 /**
  * list_for_each	-	iterate over a list
- * @pos:	the &struct list_head to use as a loop counter.
+ * @pos:	the &list_t to use as a loop counter.
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
@@ -157,7 +176,7 @@
         	pos = pos->next, prefetch(pos->next))
 /**
  * list_for_each_prev	-	iterate over a list backwards
- * @pos:	the &struct list_head to use as a loop counter.
+ * @pos:	the &list_t to use as a loop counter.
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
@@ -166,8 +185,8 @@
         	
 /**
  * list_for_each_safe	-	iterate over a list safe against removal of list entry
- * @pos:	the &struct list_head to use as a loop counter.
- * @n:		another &struct list_head to use as temporary storage
+ * @pos:	the &list_t to use as a loop counter.
+ * @n:		another &list_t to use as temporary storage
  * @head:	the head for your list.
  */
 #define list_for_each_safe(pos, n, head) \


-- 
Dan Aloni
da-x@gmx.net

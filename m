Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSIBFr2>; Mon, 2 Sep 2002 01:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSIBFr2>; Mon, 2 Sep 2002 01:47:28 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:7187
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S315454AbSIBFrZ>; Mon, 2 Sep 2002 01:47:25 -0400
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
From: Robert Love <rml@tech9.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: <20020902003318.7CB682C092@lists.samba.org>
References: <20020902003318.7CB682C092@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Sep 2002 01:51:54 -0400
Message-Id: <1030945918.939.3143.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-02 at 01:23, Rusty Russell wrote:

> This week, it spread to SCTP.
> 
> "struct list_head" isn't a great name, but having two names for
> everything is yet another bar to reading kernel source.

I am all for your cleanup here, but two nits:

Why not rename list_head while at it?  I would vote for just "struct
list" ... the name is long, and I like my lines to fit 80 columns.

Second, if we want to force people to change, we should remove "list_t"
too to prevent new uses creeping in.  Plus, like Linus says, it is often
to break stuff and cleanup the mess...

The attached patch implements the above.  A

	s/list_t/struct list/ and s/struct list_head/struct list/

over the rest of the kernel will complete the job.

	Robert Love

diff -urN linux-2.5.33/include/linux/list.h linux/include/linux/list.h
--- linux-2.5.33/include/linux/list.h	Sun Sep 01 15:26:31 2002
+++ linux/include/linux/list.h	Mon Sep  2 01:44:43 2002
@@ -15,16 +15,14 @@
  * using the generic single-entry routines.
  */
 
-struct list_head {
-	struct list_head *next, *prev;
+struct list {
+	struct list *next, *prev;
 };
 
-typedef struct list_head list_t;
-
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
-	list_t name = LIST_HEAD_INIT(name)
+	struct list name = LIST_HEAD_INIT(name)
 
 #define INIT_LIST_HEAD(ptr) do { \
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
@@ -36,7 +34,8 @@
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static inline void __list_add(list_t *new, list_t *prev, list_t *next)
+static inline void __list_add(struct list *new, struct list *prev,
+			      struct list *next)
 {
 	next->prev = new;
 	new->next = next;
@@ -52,7 +51,7 @@
  * Insert a new entry after the specified head.
  * This is good for implementing stacks.
  */
-static inline void list_add(list_t *new, list_t *head)
+static inline void list_add(struct list *new, struct list *head)
 {
 	__list_add(new, head, head->next);
 }
@@ -65,7 +64,7 @@
  * Insert a new entry before the specified head.
  * This is useful for implementing queues.
  */
-static inline void list_add_tail(list_t *new, list_t *head)
+static inline void list_add_tail(struct list *new, struct list *head)
 {
 	__list_add(new, head->prev, head);
 }
@@ -77,7 +76,7 @@
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static inline void __list_del(list_t * prev, list_t * next)
+static inline void __list_del(struct list * prev, struct list * next)
 {
 	next->prev = prev;
 	prev->next = next;
@@ -88,7 +87,7 @@
  * @entry: the element to delete from the list.
  * Note: list_empty on entry does not return true after this, the entry is in an undefined state.
  */
-static inline void list_del(list_t *entry)
+static inline void list_del(struct list *entry)
 {
 	__list_del(entry->prev, entry->next);
 	entry->next = (void *) 0;
@@ -99,7 +98,7 @@
  * list_del_init - deletes entry from list and reinitialize it.
  * @entry: the element to delete from the list.
  */
-static inline void list_del_init(list_t *entry)
+static inline void list_del_init(struct list *entry)
 {
 	__list_del(entry->prev, entry->next);
 	INIT_LIST_HEAD(entry); 
@@ -110,7 +109,7 @@
  * @list: the entry to move
  * @head: the head that will precede our entry
  */
-static inline void list_move(list_t *list, list_t *head)
+static inline void list_move(struct list *list, struct list *head)
 {
         __list_del(list->prev, list->next);
         list_add(list, head);
@@ -121,7 +120,7 @@
  * @list: the entry to move
  * @head: the head that will follow our entry
  */
-static inline void list_move_tail(list_t *list, list_t *head)
+static inline void list_move_tail(struct list *list, struct list *head)
 {
         __list_del(list->prev, list->next);
         list_add_tail(list, head);
@@ -131,16 +130,16 @@
  * list_empty - tests whether a list is empty
  * @head: the list to test.
  */
-static inline int list_empty(list_t *head)
+static inline int list_empty(struct list *head)
 {
 	return head->next == head;
 }
 
-static inline void __list_splice(list_t *list, list_t *head)
+static inline void __list_splice(struct list *list, struct list *head)
 {
-	list_t *first = list->next;
-	list_t *last = list->prev;
-	list_t *at = head->next;
+	struct list *first = list->next;
+	struct list *last = list->prev;
+	struct list *at = head->next;
 
 	first->prev = head;
 	head->next = first;
@@ -154,7 +153,7 @@
  * @list: the new list to add.
  * @head: the place to add it in the first list.
  */
-static inline void list_splice(list_t *list, list_t *head)
+static inline void list_splice(struct list *list, struct list *head)
 {
 	if (!list_empty(list))
 		__list_splice(list, head);
@@ -167,7 +166,7 @@
  *
  * The list at @list is reinitialised
  */
-static inline void list_splice_init(list_t *list, list_t *head)
+static inline void list_splice_init(struct list *list, struct list *head)
 {
 	if (!list_empty(list)) {
 		__list_splice(list, head);
@@ -177,7 +176,7 @@
 
 /**
  * list_entry - get the struct for this entry
- * @ptr:	the &list_t pointer.
+ * @ptr:	the struct list pointer.
  * @type:	the type of the struct this is embedded in.
  * @member:	the name of the list_struct within the struct.
  */
@@ -186,7 +185,7 @@
 
 /**
  * list_for_each	-	iterate over a list
- * @pos:	the &list_t to use as a loop counter.
+ * @pos:	the pointer to a struct list to use as a loop counter.
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
@@ -194,7 +193,7 @@
         	pos = pos->next, prefetch(pos->next))
 /**
  * list_for_each_prev	-	iterate over a list backwards
- * @pos:	the &list_t to use as a loop counter.
+ * @pos:	the pointer to a struct list to use as a loop counter.
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
@@ -203,8 +202,8 @@
         	
 /**
  * list_for_each_safe	-	iterate over a list safe against removal of list entry
- * @pos:	the &list_t to use as a loop counter.
- * @n:		another &list_t to use as temporary storage
+ * @pos:	the pointer to a struct list to use as a loop counter.
+ * @n:		another pointer to a struct list to use as temporary storage
  * @head:	the head for your list.
  */
 #define list_for_each_safe(pos, n, head) \



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVFUCkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVFUCkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVFUCi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:38:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:26596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261692AbVFTW7p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:45 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Add initial implementation of klist helpers.
In-Reply-To: <1119308364515@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:25 -0700
Message-Id: <1119308365601@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add initial implementation of klist helpers.

This klist interface provides a couple of structures that wrap around
struct list_head to provide explicit list "head" (struct klist) and
list "node" (struct klist_node) objects. For struct klist, a spinlock
is included that protects access to the actual list itself. struct
klist_node provides a pointer to the klist that owns it and a kref
reference count that indicates the number of current users of that node
in the list.

The entire point is to provide an interface for iterating over a list
that is safe and allows for modification of the list during the
iteration (e.g. insertion and removal), including modification of the
current node on the list.

It works using a 3rd object type - struct klist_iter - that is declared
and initialized before an iteration. klist_next() is used to acquire the
next element in the list. It returns NULL if there are no more items.
This klist interface provides a couple of structures that wrap around
struct list_head to provide explicit list "head" (struct klist) and
list "node" (struct klist_node) objects. For struct klist, a spinlock
is included that protects access to the actual list itself. struct
klist_node provides a pointer to the klist that owns it and a kref
reference count that indicates the number of current users of that node
in the list.

The entire point is to provide an interface for iterating over a list
that is safe and allows for modification of the list during the
iteration (e.g. insertion and removal), including modification of the
current node on the list.

It works using a 3rd object type - struct klist_iter - that is declared
and initialized before an iteration. klist_next() is used to acquire the
next element in the list. It returns NULL if there are no more items.
Internally, that routine takes the klist's lock, decrements the reference
count of the previous klist_node and increments the count of the next
klist_node. It then drops the lock and returns.

There are primitives for adding and removing nodes to/from a klist.
When deleting, klist_del() will simply decrement the reference count.
Only when the count goes to 0 is the node removed from the list.
klist_remove() will try to delete the node from the list and block
until it is actually removed. This is useful for objects (like devices)
that have been removed from the system and must be freed (but must wait
until all accessors have finished).

Internally, that routine takes the klist's lock, decrements the reference
count of the previous klist_node and increments the count of the next
klist_node. It then drops the lock and returns.

There are primitives for adding and removing nodes to/from a klist.
When deleting, klist_del() will simply decrement the reference count.
Only when the count goes to 0 is the node removed from the list.
klist_remove() will try to delete the node from the list and block
until it is actually removed. This is useful for objects (like devices)
that have been removed from the system and must be freed (but must wait
until all accessors have finished).

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/include/linux/klist.h b/include/linux/klist.h

---
commit 9a19fea43616066561e221359596ce532e631395
tree f776bee1bcb1051bf75323b65fa887347412409e
parent 6034a080f98b0bbc0a058e2ac65a538f75cffeee
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 11:45:16 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:14 -0700

 include/linux/klist.h |   53 ++++++++++
 lib/Makefile          |    7 +
 lib/klist.c           |  248 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+), 3 deletions(-)

diff --git a/include/linux/klist.h b/include/linux/klist.h
new file mode 100644
--- /dev/null
+++ b/include/linux/klist.h
@@ -0,0 +1,53 @@
+/*
+ *	klist.h - Some generic list helpers, extending struct list_head a bit.
+ *
+ *	Implementations are found in lib/klist.c
+ *
+ *
+ *	Copyright (C) 2005 Patrick Mochel
+ *
+ *	This file is rleased under the GPL v2.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+
+
+struct klist {
+	spinlock_t		k_lock;
+	struct list_head	k_list;
+};
+
+
+extern void klist_init(struct klist * k);
+
+
+struct klist_node {
+	struct klist		* n_klist;
+	struct list_head	n_node;
+	struct kref		n_ref;
+	struct completion	n_removed;
+};
+
+extern void klist_add_tail(struct klist * k, struct klist_node * n);
+extern void klist_add_head(struct klist * k, struct klist_node * n);
+
+extern void klist_del(struct klist_node * n);
+extern void klist_remove(struct klist_node * n);
+
+
+struct klist_iter {
+	struct klist		* i_klist;
+	struct list_head	* i_head;
+	struct klist_node	* i_cur;
+};
+
+
+extern void klist_iter_init(struct klist * k, struct klist_iter * i);
+extern void klist_iter_init_node(struct klist * k, struct klist_iter * i, 
+				 struct klist_node * n);
+extern void klist_iter_exit(struct klist_iter * i);
+extern struct klist_node * klist_next(struct klist_iter * i);
+
diff --git a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -4,9 +4,10 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o kref.o idr.o div64.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o prio_tree.o sha1.o \
-	 halfmd4.o
+	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
+	 sha1.o halfmd4.o
+
+lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
 obj-y += sort.o parser.o
 
diff --git a/lib/klist.c b/lib/klist.c
new file mode 100644
--- /dev/null
+++ b/lib/klist.c
@@ -0,0 +1,248 @@
+/*
+ *	klist.c - Routines for manipulating klists.
+ *
+ *
+ *	This klist interface provides a couple of structures that wrap around 
+ *	struct list_head to provide explicit list "head" (struct klist) and 
+ *	list "node" (struct klist_node) objects. For struct klist, a spinlock
+ *	is included that protects access to the actual list itself. struct 
+ *	klist_node provides a pointer to the klist that owns it and a kref
+ *	reference count that indicates the number of current users of that node
+ *	in the list.
+ *
+ *	The entire point is to provide an interface for iterating over a list
+ *	that is safe and allows for modification of the list during the
+ *	iteration (e.g. insertion and removal), including modification of the
+ *	current node on the list.
+ *
+ *	It works using a 3rd object type - struct klist_iter - that is declared
+ *	and initialized before an iteration. klist_next() is used to acquire the
+ *	next element in the list. It returns NULL if there are no more items.
+ *	Internally, that routine takes the klist's lock, decrements the reference
+ *	count of the previous klist_node and increments the count of the next
+ *	klist_node. It then drops the lock and returns.
+ *
+ *	There are primitives for adding and removing nodes to/from a klist. 
+ *	When deleting, klist_del() will simply decrement the reference count. 
+ *	Only when the count goes to 0 is the node removed from the list. 
+ *	klist_remove() will try to delete the node from the list and block
+ *	until it is actually removed. This is useful for objects (like devices)
+ *	that have been removed from the system and must be freed (but must wait
+ *	until all accessors have finished).
+ *
+ *	Copyright (C) 2005 Patrick Mochel
+ *
+ *	This file is released under the GPL v2.
+ */
+
+#include <linux/klist.h>
+#include <linux/module.h>
+
+
+/**
+ *	klist_init - Initialize a klist structure. 
+ *	@k:	The klist we're initializing.
+ */
+
+void klist_init(struct klist * k)
+{
+	INIT_LIST_HEAD(&k->k_list);
+	spin_lock_init(&k->k_lock);
+}
+
+EXPORT_SYMBOL_GPL(klist_init);
+
+
+static void add_head(struct klist * k, struct klist_node * n)
+{
+	spin_lock(&k->k_lock);
+	list_add(&n->n_node, &k->k_list);
+	spin_unlock(&k->k_lock);
+}
+
+static void add_tail(struct klist * k, struct klist_node * n)
+{
+	spin_lock(&k->k_lock);
+	list_add_tail(&n->n_node, &k->k_list);
+	spin_unlock(&k->k_lock);
+}
+
+
+static void klist_node_init(struct klist * k, struct klist_node * n)
+{
+	INIT_LIST_HEAD(&n->n_node);
+	init_completion(&n->n_removed);
+	kref_init(&n->n_ref);
+	n->n_klist = k;
+}
+
+
+/**
+ *	klist_add_head - Initialize a klist_node and add it to front.
+ *	@k:	klist it's going on.
+ *	@n:	node we're adding.
+ */
+
+void klist_add_head(struct klist * k, struct klist_node * n)
+{
+	klist_node_init(k, n);
+	add_head(k, n);
+}
+
+EXPORT_SYMBOL_GPL(klist_add_head);
+
+
+/**
+ *	klist_add_tail - Initialize a klist_node and add it to back.
+ *	@k:	klist it's going on.
+ *	@n:	node we're adding.
+ */
+
+void klist_add_tail(struct klist * k, struct klist_node * n)
+{
+	klist_node_init(k, n);
+	add_tail(k, n);
+}
+
+EXPORT_SYMBOL_GPL(klist_add_tail);
+
+
+static void klist_release(struct kref * kref)
+{
+	struct klist_node * n = container_of(kref, struct klist_node, n_ref);
+	list_del(&n->n_node);
+	complete(&n->n_removed);
+}
+
+static int klist_dec_and_del(struct klist_node * n)
+{
+	return kref_put(&n->n_ref, klist_release);
+}
+
+
+/**
+ *	klist_del - Decrement the reference count of node and try to remove.
+ *	@n:	node we're deleting.
+ */
+
+void klist_del(struct klist_node * n)
+{
+	struct klist * k = n->n_klist;
+
+	spin_lock(&k->k_lock);
+	klist_dec_and_del(n);
+	spin_unlock(&k->k_lock);
+}
+
+EXPORT_SYMBOL_GPL(klist_del);
+
+
+/**
+ *	klist_remove - Decrement the refcount of node and wait for it to go away.
+ *	@n:	node we're removing.
+ */
+
+void klist_remove(struct klist_node * n)
+{
+	spin_lock(&n->n_klist->k_lock);
+	klist_dec_and_del(n);
+	spin_unlock(&n->n_klist->k_lock);
+	wait_for_completion(&n->n_removed);
+}
+
+EXPORT_SYMBOL_GPL(klist_remove);
+
+
+/**
+ *	klist_iter_init_node - Initialize a klist_iter structure.
+ *	@k:	klist we're iterating.
+ *	@i:	klist_iter we're filling.
+ *	@n:	node to start with.
+ *
+ *	Similar to klist_iter_init(), but starts the action off with @n, 
+ *	instead of with the list head.
+ */
+
+void klist_iter_init_node(struct klist * k, struct klist_iter * i, struct klist_node * n)
+{
+	i->i_klist = k;
+	i->i_head = &k->k_list;
+	i->i_cur = n;
+}
+
+EXPORT_SYMBOL_GPL(klist_iter_init_node);
+
+
+/**
+ *	klist_iter_init - Iniitalize a klist_iter structure.
+ *	@k:	klist we're iterating.
+ *	@i:	klist_iter structure we're filling.
+ *
+ *	Similar to klist_iter_init_node(), but start with the list head.
+ */
+
+void klist_iter_init(struct klist * k, struct klist_iter * i)
+{
+	klist_iter_init_node(k, i, NULL);
+}
+
+EXPORT_SYMBOL_GPL(klist_iter_init);
+
+
+/**
+ *	klist_iter_exit - Finish a list iteration.
+ *	@i:	Iterator structure.
+ *
+ *	Must be called when done iterating over list, as it decrements the 
+ *	refcount of the current node. Necessary in case iteration exited before
+ *	the end of the list was reached, and always good form.
+ */
+
+void klist_iter_exit(struct klist_iter * i)
+{
+	if (i->i_cur) {
+		klist_del(i->i_cur);
+		i->i_cur = NULL;
+	}
+}
+
+EXPORT_SYMBOL_GPL(klist_iter_exit);
+
+
+static struct klist_node * to_klist_node(struct list_head * n)
+{
+	return container_of(n, struct klist_node, n_node);
+}
+
+
+/**
+ *	klist_next - Ante up next node in list.
+ *	@i:	Iterator structure.
+ *
+ *	First grab list lock. Decrement the reference count of the previous
+ *	node, if there was one. Grab the next node, increment its reference 
+ *	count, drop the lock, and return that next node.
+ */
+
+struct klist_node * klist_next(struct klist_iter * i)
+{
+	struct list_head * next;
+	struct klist_node * knode = NULL;
+
+	spin_lock(&i->i_klist->k_lock);
+	if (i->i_cur) {
+		next = i->i_cur->n_node.next;
+		klist_dec_and_del(i->i_cur);
+	} else
+		next = i->i_head->next;
+
+	if (next != i->i_head) {
+		knode = to_klist_node(next);
+		kref_get(&knode->n_ref);
+	}
+	i->i_cur = knode;
+	spin_unlock(&i->i_klist->k_lock);
+	return knode;
+}
+
+EXPORT_SYMBOL_GPL(klist_next);


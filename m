Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262131AbSIYWop>; Wed, 25 Sep 2002 18:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262132AbSIYWop>; Wed, 25 Sep 2002 18:44:45 -0400
Received: from pD9E23B17.dip.t-dialin.net ([217.226.59.23]:57826 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S262131AbSIYWol>; Wed, 25 Sep 2002 18:44:41 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH][2.5] Single linked lists for Linux,v2
X-Mailer: Lightweight Patch Manager
Message-ID: <20020925225026.96C153@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Wed, 25 Sep 2002 22:50:26 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again single linked lists...

--- /dev/null	Wed Dec 31 17:00:00 1969
+++ slist-2.5/include/linux/slist.h	Wed Sep 25 16:47:26 2002
@@ -0,0 +1,109 @@
+#ifdef __KERNEL__
+#ifndef _LINUX_SLIST_H
+#define _LINUX_SLIST_H
+
+#include <asm/processor.h>
+
+/*
+ * Type-safe single linked list helper-functions.
+ * (originally taken from list.h)
+ *
+ * Thomas 'Dent' Mirlacher, Daniel Phillips,
+ * Andreas Borgk, Thunder from the hill
+ */
+
+#define INIT_SLIST_HEAD(name)			\
+	(name->next = name)
+
+#define SLIST_HEAD(type,name)			\
+	typeof(type) name = INIT_SLIST_HEAD(name)
+
+/**
+ * slist_add_front - add a new entry at the first slot, moving the old head
+ *		     to the second slot
+ * @new:	new entry to be added
+ * @head:	head of the single linked list
+ *
+ * Insert a new entry before the specified head.
+ * This is good for implementing stacks.
+ */
+
+#define slist_add_front(_new, _head)		\
+do {						\
+	(_new)->next = (_head);			\
+	(_head) = (_new);			\
+} while (0)
+
+
+
+/**
+ * slist_add - add a new entry
+ * @new:       new entry to be added
+ * @head:      head of the single linked list
+ *
+ * Insert a new entry before the specified head.
+ * This is good for implementing stacks.
+ *
+ * Careful: if you do this concurrently, _head
+ * might get into nirvana...
+ */
+#define slist_add(_new, _head)			\
+do {						\
+	(_new)->next = (_head)->next;		\
+	(_head)->next = (_new);			\
+	(_new) = (_head);			\
+} while (0)
+
+/**
+ * slist_del -	remove an entry from list
+ * @head:	head to remove it from
+ * @entry:	entry to be removed
+ */
+#define slist_del(_head, _entry)		\
+do {						\
+	(_head)->next = (_entry)->next;		\
+	(_entry)->next = NULL;			\
+} while (0)
+
+/**
+ * slist_del_single -	untag a list from an entry
+ * @list:	list entry to be untagged
+ */
+#define slist_del_single(_list)			\
+	((_list)->next = NULL)
+
+/**
+ * slist_pop	-	pop out list entry
+ * @list:	entry to be popped out
+ *
+ * Pop out an entry from a list.
+ */
+#define slist_pop(_list) ({			\
+	typeof(_list) _NODE_ = _list;		\
+	if (_list) {				\
+	    (_list) = (_list)->next;		\
+	    _NODE_->next = NULL;		\
+	}					\
+	_NODE_; })
+
+/**
+ * slist_for_each	-	iterate over a list
+ * @pos:	the pointer to use as a loop counter.
+ * @head:	the head for your list (this is also the first entry).
+ */
+#define slist_for_each(pos, head)				\
+	for (pos = head; pos && ({ prefetch(pos->next); 1; });	\
+	    pos = pos->next)
+
+/**
+ * slist_for_each_del	-	iterate over a list, popping off entries
+ * @pos:       the pointer to use as a loop counter.
+ * @head:      the head for your list (this is also the first entry).
+ */
+#define slist_for_each_del(pos, head)			\
+	for (pos = slist_pop(head); pos &&		\
+    	    ({ prefetch(pos->next); 1; });		\
+	    pos = slist_pop(head))
+
+#endif /* _LINUX_SLIST_H */
+#endif /* __KERNEL__ */

-- 
Lightweight Patch Manager, without pine.
If you have any objections (apart from who I am), tell me


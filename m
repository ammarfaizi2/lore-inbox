Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSIZRfh>; Thu, 26 Sep 2002 13:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbSIZRfh>; Thu, 26 Sep 2002 13:35:37 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:48103 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261381AbSIZRfe>; Thu, 26 Sep 2002 13:35:34 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>
Subject: [PATCH][2.5] Single linked lists for Linux, overly complicated v2
X-Mailer: Lightweight Patch Manager
Message-ID: <20020926174124.64E112@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Thu, 26 Sep 2002 17:41:24 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This time  I've taken care of  the various comments.  It's not exactly
been cool, but I saw where  my details conflicted. NULL is supposed to
be NULL.

One more for: slist_for_each_round()

slist_del*()  is still  overly complicated.  Shall I  resume  the easy
version of it?

--- /dev/null	Wed Dec 31 17:00:00 1969
+++ slist-2.5/include/linux/slist.h	Thu Sep 26 11:34:55 2002
@@ -0,0 +1,154 @@
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
+ * Andreas Bogk, Thunder from the hill
+ */
+
+#define INIT_SLIST_HEAD(name)			\
+	(name->next = name)
+
+#define SLIST_HEAD_INIT(name)			\
+	{ .next = NULL; }
+
+#define SLIST_HEAD(type,name)			\
+	typeof(type) name = SLIST_HEAD_INIT(name)
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
+#define slist_add_front(_new_in, _head_in)	\
+do {						\
+	typeof(_head_in) _head = _head_in,	\
+		    _new = _new_in;		\
+	_new->next = _head;			\
+	_head = _new;				\
+} while (0)
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
+#define slist_add(_new_in, _head_in)		\
+do {						\
+	typeof(_head_in) _head = (_head_in),	\
+		    _new = (_new_in);		\
+	_new->next = _head->next;		\
+	_head->next = _new;			\
+	_new = _head;				\
+} while (0)
+
+/**
+ * slist_del -	remove an entry from list
+ * @head:	head to remove it from
+ * @entry:	entry to be removed
+ */
+#define slist_del(_entry_in)				\
+({							\
+	typeof(_entry_in) _entry = (_entry_in), _head =	\
+	    kmalloc(sizeof(_entry), GFP_KERNEL), _free;	\
+	if (_head) {					\
+	    memcpy(_head, (_entry), sizeof(_entry));	\
+	    _free = (_entry);				\
+	    (_entry) = (_entry)->next;			\
+	    kfree(_free);				\
+	    _head->next = NULL;				\
+	    _head;					\
+	} else						\
+	    NULL;					\
+})
+
+/**
+ * slist_del_init -	remove an entry from list and initialize it
+ * @head:	head to remove it from
+ * @entry:	entry to be removed
+ */
+#define slist_del_init(_entry)				\
+({							\
+	typeof(_entry_in) _entry = (_entry_in), _head =	\
+	    kmalloc(sizeof(_entry), GFP_KERNEL), _free;	\
+	if (_head) {					\
+	    memcpy(_head, (_entry), sizeof(_entry));	\
+	    _free = (_entry);				\
+	    (_entry) = (_entry)->next;			\
+	    kfree(_free);				\
+	    _head->next = _head;			\
+	    _head;					\
+	} else						\
+	    NULL;					\
+})
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
+#define slist_pop(_list_in) ({			\
+	typeof(_list_in) _list = (_list_in),	\
+		    _NODE_ = _list;		\
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
+ * slist_for_each_round	-	iterate over a round list
+ * @pos:	the pointer to use as a loop counter.
+ * @head:	the head for your list (this is also the first entry).
+ */
+#define slist_for_each(pos, head)			\
+	for (pos = head; pos && pos != head &&		\
+	    ({ prefetch(pos->next); 1; });		\
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


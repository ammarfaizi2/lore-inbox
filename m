Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262764AbSI1J3X>; Sat, 28 Sep 2002 05:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbSI1J20>; Sat, 28 Sep 2002 05:28:26 -0400
Received: from pD9E23260.dip.t-dialin.net ([217.226.50.96]:57478 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S262764AbSI1J17>; Sat, 28 Sep 2002 05:27:59 -0400
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Tomas Szepe <szepe@pinerecords.com>,
       Zach Brown <zab@zaboo.net>
Subject: [PATCH][2.5] Single linked headed lists for Linux, v3
X-Mailer: Lightweight Patch Manager
Message-ID: <20020928093335.E7A794@hawkeye.luckynet.adm>
MIME-Version: 1.0
User-Agent: Lightweight Patch Manager/1.04
Date: Sat, 28 Sep 2002 09:33:35 +0000
X-Priority: I really don't care.
Content-Type: text/plain; charset=US-ASCII
Organization: Lightweight Networking
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /dev/null	Wed Dec 31 17:00:00 1969
+++ slist-2.5/include/linux/shlist.h	Sat Sep 28 03:31:18 2002
@@ -0,0 +1,196 @@
+#ifdef __KERNEL__
+#ifndef _LINUX_SLIST_H
+#define _LINUX_SLIST_H
+
+#include <asm/processor.h>
+
+/*
+ * Type-preserving  single  linked  headed list  helper-functions  for
+ * circular and linear lists. (Code originally taken from list.h)
+ *
+ * Thomas 'Dent' Mirlacher, Daniel Phillips, Thunder from the hill
+ */
+
+/******************************************************************************
+ * Common stuff 
+ *****************************************************************************/
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
+ * slist_add - add a new entry after the list head
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
+ * slist_del -	remove an entry from a list, walking the list from the head
+ * @head:	list head, where the walking will start
+ * @entry:	entry to be removed
+ */
+#define slist_del(_entry_in,_head_in)			\
+do {							\
+	typeof(_entry_in) _entry = (_entry_in),		\
+			  _head  = (_head_in);		\
+	if (_head == _entry) {				\
+		_head = _entry->next;			\
+		slist_del_single(_entry);		\
+	} else {					\
+		typeof(_entry) _pos, _prev=_head;	\
+		while (_prev && (_pos = _prev->next)) {	\
+			if (_pos == _entry) {		\
+				_prev->next = _pos->next;\
+				slist_del_single(_pos);	\
+				break;			\
+			}				\
+			_prev = _pos;			\
+			if (_prev == _head) break;	\
+		}					\
+		/* Entry is not on list. BUG? --ct */	\
+	}						\
+} while (0)
+
+/**
+ * slist_del_quick -	(re)move an entry from list
+ * @buf:	a storage area, just as long as the entry
+ * @entry:	entry to be removed
+ */
+#define slist_del_quick(_entry_in,_buf_in)		\
+do {							\
+	typeof(_entry_in) _entry = (_entry_in),		\
+			  _buf = (_buf_in), _free;	\
+	_free = _entry->next;				\
+	memcpy(_buf, _entry, sizeof(_entry));		\
+	memcpy(_entry, _free, sizeof(_entry));		\
+	memcpy(_buf, _free, sizeof(_entry));		\
+	slist_del_single(_entry);			\
+} while (0)
+
+/******************************************************************************
+ * Linear specific
+ *****************************************************************************/
+
+#define INIT_SLIST_HEAD(name)			\
+	(name->next = NULL)
+
+#define SLIST_HEAD_INIT(name)			\
+	{ .next = NULL; }
+
+#define SLIST_HEAD(type,name)			\
+	typeof(type) name = SLIST_HEAD_INIT(name)
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
+/******************************************************************************
+ * Circular specific
+ *****************************************************************************/
+
+#define INIT_SLIST_LOOP(name)			\
+	(name->next = name)
+
+#define SLIST_LOOP_INIT(name)			\
+	{ .next = name; }
+
+#define SLIST_LOOP(type,name)			\
+	typeof(type) name = SLIST_LOOP_INIT(name);
+
+/**
+ * slist_del_init -	remove an entry from list and initialize it
+ * @head:	head to remove it from
+ * @entry:	entry to be removed
+ */
+#define slist_del_init(_entry_in)			\
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
+ * slist_for_each_circular	-	iterate over a circular list
+ * @pos:	the pointer to use as a loop counter.
+ * @head:	the head for your list (this is also the first entry).
+ */
+#define slist_for_each_circular(pos, head)		\
+	for (pos = head; pos && pos != head &&		\
+	    ({ prefetch(pos->next); 1; });		\
+	    pos = pos->next)
+
+#endif /* _LINUX_SLIST_H */
+#endif /* __KERNEL__ */

-- 
Lightweight Patch Manager, without pine.
If you have any objections (apart from who I am), tell me


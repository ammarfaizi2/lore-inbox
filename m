Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUBKG2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUBKG2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:28:52 -0500
Received: from dictum-ext.geekmail.cc ([204.239.179.245]:13484 "EHLO
	mailer01.geekmail.cc") by vger.kernel.org with ESMTP
	id S263513AbUBKG2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:28:36 -0500
Message-ID: <4029CB7E.4030003@swapped.cc>
Date: Tue, 10 Feb 2004 22:28:14 -0800
From: Alex Pankratov <ap@swapped.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: acme@conectiva.com.br, ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6] [2/2] hlist: remove IFs from hlist functions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2

--------------------

diff -NuprX dontdiff linux-2.6.2/include/linux/list.h 
linux-2.6.2.hlist/include/linux/list.h
--- linux-2.6.2/include/linux/list.h	2004-02-10 12:35:57.000000000 -0800
+++ linux-2.6.2.hlist/include/linux/list.h	2004-02-10 14:57:09.000000000 
-0800
@@ -434,10 +434,12 @@ struct hlist_node {
  	struct hlist_node *next, **pprev;
  };

-#define HLIST_HEAD_INIT { .first = NULL }
-#define HLIST_HEAD(name) struct hlist_head name = {  .first = NULL }
-#define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
-#define INIT_HLIST_NODE(ptr) ((ptr)->next = NULL, (ptr)->pprev = NULL)
+extern struct hlist_node hlist_null; /* shared tail sentinel */
+
+#define HLIST_HEAD_INIT { .first = &hlist_null }
+#define HLIST_HEAD(name) struct hlist_head name = {  .first = &hlist_null }
+#define INIT_HLIST_HEAD(ptr) ((ptr)->first = &hlist_null)
+#define INIT_HLIST_NODE(ptr) ((ptr)->next = &hlist_null, (ptr)->pprev = 
NULL)

  static __inline__ void hlist_node_init(struct hlist_node *h)
  {
@@ -446,7 +448,7 @@ static __inline__ void hlist_node_init(s

  static __inline__ int hlist_last(const struct hlist_node *h)
  {
-	return !h->next;
+	return h->next == &hlist_null;
  }

  static __inline__ int hlist_unhashed(const struct hlist_node *h)
@@ -456,7 +458,7 @@ static __inline__ int hlist_unhashed(con

  static __inline__ int hlist_empty(const struct hlist_head *h)
  {
-	return !h->first;
+	return h->first == &hlist_null;
  }

  static __inline__ void __hlist_del(struct hlist_node *n)
@@ -464,8 +466,7 @@ static __inline__ void __hlist_del(struc
  	struct hlist_node *next = n->next;
  	struct hlist_node **pprev = n->pprev;
  	*pprev = next;
-	if (next)
-		next->pprev = pprev;
+	next->pprev = pprev;
  }

  static __inline__ void hlist_del(struct hlist_node *n)
@@ -506,8 +507,7 @@ static __inline__ void hlist_add_head(st
  {
  	struct hlist_node *first = h->first;
  	n->next = first;
-	if (first)
-		first->pprev = &n->next;
+	first->pprev = &n->next;
  	h->first = n;
  	n->pprev = &h->first;
  }
@@ -518,8 +518,7 @@ static __inline__ void hlist_add_head_rc
  	n->next = first;
  	n->pprev = &h->first;
  	smp_wmb();
-	if (first)
-		first->pprev = &n->next;
+	first->pprev = &n->next;
  	h->first = n;
  }

@@ -542,16 +541,15 @@ static __inline__ void hlist_add_after(s

  #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
  #define hlist_entry_safe(ptr, type, member) \
-	((ptr) == 0 ? NULL : container_of(ptr,type,member))
+	((ptr) == &hlist_null ? NULL : container_of(ptr,type,member))

-/* Cannot easily do prefetch unfortunately */
  #define hlist_for_each(pos, head) \
-	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
-	     pos = pos->next)
+	for (pos = (head)->first, prefetch(pos->next); pos != &hlist_null; \
+	     pos = pos->next, prefetch(pos->next))

  #define hlist_for_each_safe(pos, n, head) \
-	for (pos = (head)->first; n = pos ? pos->next : 0, pos; \
-	     pos = n)
+	for (pos = (head)->first, n = pos->next; pos != &hlist_null; \
+	     pos = n, n = pos->next)

  /**
   * hlist_for_each_entry	- iterate over list of given type
@@ -561,10 +559,10 @@ static __inline__ void hlist_add_after(s
   * @member:	the name of the hlist_node within the struct.
   */
  #define hlist_for_each_entry(tpos, pos, head, member)			 \
-	for (pos = (head)->first;					 \
-	     pos && ({ prefetch(pos->next); 1;}) &&			 \
+	for (pos = (head)->first, prefetch(pos->next);			 \
+	     pos != &hlist_null &&					 \
  		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = pos->next)
+	     pos = pos->next, prefetch(pos->next))

  /**
   * hlist_for_each_entry_continue - iterate over a hlist continuing 
after existing point
@@ -573,10 +571,10 @@ static __inline__ void hlist_add_after(s
   * @member:	the name of the hlist_node within the struct.
   */
  #define hlist_for_each_entry_continue(tpos, pos, member)		 \
-	for (pos = (pos)->next;						 \
-	     pos && ({ prefetch(pos->next); 1;}) &&			 \
+	for (pos = (pos)->next, prefetch(pos->next);			 \
+	     pos != &hlist_null &&					 \
  		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = pos->next)
+	     pos = pos->next, prefetch(pos->next))

  /**
   * hlist_for_each_entry_from - iterate over a hlist continuing from 
existing point
@@ -585,9 +583,10 @@ static __inline__ void hlist_add_after(s
   * @member:	the name of the hlist_node within the struct.
   */
  #define hlist_for_each_entry_from(tpos, pos, member)			 \
-	for (; pos && ({ prefetch(pos->next); 1;}) &&			 \
+	for (prefetch(pos->next); 					 \
+		pos != &hlist_null &&					 \
  		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = pos->next)
+	     pos = pos->next, prefetch(pos->next))

  /**
   * hlist_for_each_entry_safe - iterate over list of given type safe 
against removal of list entry
@@ -598,10 +597,10 @@ static __inline__ void hlist_add_after(s
   * @member:	the name of the hlist_node within the struct.
   */
  #define hlist_for_each_entry_safe(tpos, pos, n, head, member) 		 \
-	for (pos = (head)->first;					 \
-	     pos && ({ n = pos->next; 1; }) && 				 \
+	for (pos = (head)->first, n = pos->next;			 \
+	     pos != &hlist_null && 					 \
  		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = n)
+	     pos = n, n = pos->next)
  #else
  #warning "don't include kernel headers in userspace"
  #endif /* __KERNEL__ */
diff -NuprX dontdiff linux-2.6.2/lib/Makefile linux-2.6.2.hlist/lib/Makefile
--- linux-2.6.2/lib/Makefile	2004-02-03 19:43:07.000000000 -0800
+++ linux-2.6.2.hlist/lib/Makefile	2004-02-10 13:03:23.000000000 -0800
@@ -6,7 +6,7 @@
  lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
  	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
  	 kobject.o idr.o div64.o parser.o int_sqrt.o mask.o \
-	 bitmap.o extable.o
+	 bitmap.o extable.o list.o

  lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
  lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -NuprX dontdiff linux-2.6.2/lib/list.c linux-2.6.2.hlist/lib/list.c
--- linux-2.6.2/lib/list.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.2.hlist/lib/list.c	2004-02-10 13:03:08.000000000 -0800
@@ -0,0 +1,10 @@
+#include <linux/module.h>
+#include <linux/list.h>
+
+/*
+ *	shared tail sentinel for hlists
+ */
+struct hlist_node hlist_null;
+
+EXPORT_SYMBOL(hlist_null);
+

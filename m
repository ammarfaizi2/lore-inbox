Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWAMAoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWAMAoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWAMAoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:44:14 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:60055 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932480AbWAMAoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:44:14 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Message-Id: <20060113004356.11419.50021.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH] [list.h] don't evaluate macro args multiple times
Date: Thu, 12 Jan 2006 16:43:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[list.h] don't evaluate macro args multiple times

I noticed that list.h init functions were evaluating macro arguments multiple
times and thought it might be nice to protect the unsuspecting caller.
Converting the macros to inline functions seems to reduce code size, too.  A
i386 defconfig build with gcc 3.3.3 from fc4:

   text    data     bss     dec     hex filename
3573148  565664  188828 4327640  4208d8 vmlinux.before
3572177  565664  188828 4326669  42050d vmlinux

add/remove: 0/0 grow/shrink: 11/144 up/down: 88/-1016 (-928)

There was no difference in checkstack output.

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 include/linux/list.h |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

Index: 2.6.15-git8-misc/include/linux/list.h
===================================================================
--- 2.6.15-git8-misc.orig/include/linux/list.h	2006-01-12 15:27:37.442709075 -0800
+++ 2.6.15-git8-misc/include/linux/list.h	2006-01-12 15:46:03.907589898 -0800
@@ -34,9 +34,11 @@
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
-#define INIT_LIST_HEAD(ptr) do { \
-	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
-} while (0)
+static inline void INIT_LIST_HEAD(struct list_head *list)
+{
+	list->next = list;
+	list->prev = list;
+}
 
 /*
  * Insert a new entry between two known consecutive entries.
@@ -534,7 +536,11 @@
 #define HLIST_HEAD_INIT { .first = NULL }
 #define HLIST_HEAD(name) struct hlist_head name = {  .first = NULL }
 #define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
-#define INIT_HLIST_NODE(ptr) ((ptr)->next = NULL, (ptr)->pprev = NULL)
+static inline void INIT_HLIST_NODE(struct hlist_node *h)
+{
+	h->next = NULL;
+	h->pprev = NULL;
+}
 
 static inline int hlist_unhashed(const struct hlist_node *h)
 {

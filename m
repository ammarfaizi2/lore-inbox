Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbULYQNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbULYQNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 11:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbULYQNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 11:13:07 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:32693 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261525AbULYQM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 11:12:57 -0500
Message-ID: <41CDA035.BF574176@tv-sign.ru>
Date: Sat, 25 Dec 2004 20:15:33 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] optimize prefetch() usage in list_for_each_xxx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch changes list_for_each_xxx iterators

from:
	for (pos = (head)->next, prefetch(pos->next);
	     pos != (head);
             pos = pos->next, prefetch(pos->next))
to:
	for (pos = (head)->next;
	     prefetch(pos->next), pos != (head);
             pos = pos->next)

Reduces my vmlinux .text size by 4401 bytes.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10/include/linux/list.h~	2004-11-15 17:12:20.000000000 +0300
+++ 2.6.10/include/linux/list.h	2004-12-25 21:46:56.379911176 +0300
@@ -326,8 +326,8 @@
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
-	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
-        	pos = pos->next, prefetch(pos->next))
+	for (pos = (head)->next; prefetch(pos->next), pos != (head); \
+        	pos = pos->next)
 
 /**
  * __list_for_each	-	iterate over a list
@@ -348,8 +348,8 @@
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
-	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
-        	pos = pos->prev, prefetch(pos->prev))
+	for (pos = (head)->prev; prefetch(pos->prev), pos != (head); \
+        	pos = pos->prev)
 
 /**
  * list_for_each_safe	-	iterate over a list safe against removal of list entry
@@ -368,11 +368,9 @@
  * @member:	the name of the list_struct within the struct.
  */
 #define list_for_each_entry(pos, head, member)				\
-	for (pos = list_entry((head)->next, typeof(*pos), member),	\
-		     prefetch(pos->member.next);			\
-	     &pos->member != (head); 					\
-	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
-		     prefetch(pos->member.next))
+	for (pos = list_entry((head)->next, typeof(*pos), member);	\
+	     prefetch(pos->member.next), &pos->member != (head); 	\
+	     pos = list_entry(pos->member.next, typeof(*pos), member))
 
 /**
  * list_for_each_entry_reverse - iterate backwards over list of given type.
@@ -381,11 +379,9 @@
  * @member:	the name of the list_struct within the struct.
  */
 #define list_for_each_entry_reverse(pos, head, member)			\
-	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
-		     prefetch(pos->member.prev);			\
-	     &pos->member != (head); 					\
-	     pos = list_entry(pos->member.prev, typeof(*pos), member),	\
-		     prefetch(pos->member.prev))
+	for (pos = list_entry((head)->prev, typeof(*pos), member);	\
+	     prefetch(pos->member.prev), &pos->member != (head); 	\
+	     pos = list_entry(pos->member.prev, typeof(*pos), member))
 
 /**
  * list_prepare_entry - prepare a pos entry for use as a start point in
@@ -405,11 +401,9 @@
  * @member:	the name of the list_struct within the struct.
  */
 #define list_for_each_entry_continue(pos, head, member) 		\
-	for (pos = list_entry(pos->member.next, typeof(*pos), member),	\
-		     prefetch(pos->member.next);			\
-	     &pos->member != (head);					\
-	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
-		     prefetch(pos->member.next))
+	for (pos = list_entry(pos->member.next, typeof(*pos), member);	\
+	     prefetch(pos->member.next), &pos->member != (head);	\
+	     pos = list_entry(pos->member.next, typeof(*pos), member))
 
 /**
  * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
@@ -434,8 +428,8 @@
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define list_for_each_rcu(pos, head) \
-	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
-        	pos = rcu_dereference(pos->next), prefetch(pos->next))
+	for (pos = (head)->next; prefetch(pos->next), pos != (head); \
+        	pos = rcu_dereference(pos->next))
 
 #define __list_for_each_rcu(pos, head) \
 	for (pos = (head)->next; pos != (head); \
@@ -467,12 +461,10 @@
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define list_for_each_entry_rcu(pos, head, member)			\
-	for (pos = list_entry((head)->next, typeof(*pos), member),	\
-		     prefetch(pos->member.next);			\
-	     &pos->member != (head); 					\
+	for (pos = list_entry((head)->next, typeof(*pos), member);	\
+	     prefetch(pos->member.next), &pos->member != (head); 	\
 	     pos = rcu_dereference(list_entry(pos->member.next, 	\
-					typeof(*pos), member)),		\
-		     prefetch(pos->member.next))
+					typeof(*pos), member)))
 
 
 /**
@@ -486,8 +478,8 @@
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define list_for_each_continue_rcu(pos, head) \
-	for ((pos) = (pos)->next, prefetch((pos)->next); (pos) != (head); \
-        	(pos) = rcu_dereference((pos)->next), prefetch((pos)->next))
+	for ((pos) = (pos)->next; prefetch((pos)->next), (pos) != (head); \
+        	(pos) = rcu_dereference((pos)->next))
 
 /*
  * Double linked lists with a single pointer list head.

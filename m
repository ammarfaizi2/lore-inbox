Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbTGKNo3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269968AbTGKNo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:44:29 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:39112 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S269967AbTGKNoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:44:25 -0400
To: <akpm@osdl.org>
Subject: [PATCH 2.5.75mm1] rbtree branch access
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 11 Jul 2003 16:26:43 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S269967AbTGKNoZ/20030711134425Z+25123@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

	Here is a patch to bring more functionnalities in rbtree.

Regards,
Fabian

Fabian Frederick
	-rbtree : add branch erase
	-rbtree : add get last node

--- linux-2.5.75mm1/include/linux/rbtree.h	2003-07-10 22:08:08.000000000 +0200
+++ linux-2.5.75mm1ff1/include/linux/rbtree.h	2003-07-11 14:42:14.000000000 +0200
@@ -118,11 +118,12 @@ struct rb_root
 
 extern void rb_insert_color(struct rb_node *, struct rb_root *);
 extern void rb_erase(struct rb_node *, struct rb_root *);
-
+extern void rb_erase_branch(struct rb_node *, struct rb_root *);
 /* Find logical next and previous nodes in a tree */
 extern struct rb_node *rb_next(struct rb_node *);
 extern struct rb_node *rb_prev(struct rb_node *);
-extern struct rb_node *rb_first(struct rb_root *);
+extern struct rb_node *rb_first(struct rb_root *); /* get first node in sort order */
+extern struct rb_node *rb_last(struct rb_root *);  /* get last node in sort order */
 
 /* Fast replacement of a single node without remove/rebalance/add/rebalance */
 extern void rb_replace_node(struct rb_node *victim, struct rb_node *new, 
--- linux-2.5.75mm1/lib/rbtree.c	2003-07-10 22:12:09.000000000 +0200
+++ linux-2.5.75mm1ff1/lib/rbtree.c	2003-07-11 15:20:54.000000000 +0200
@@ -2,6 +2,8 @@
   Red Black Trees
   (C) 1999  Andrea Arcangeli <andrea@suse.de>
   (C) 2002  David Woodhouse <dwmw2@infradead.org>
+
+  07/2003  branch access - Fabian Frederick <ffrederick@users.sourceforge.net>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
@@ -221,6 +223,18 @@ static void __rb_erase_color(struct rb_n
 		node->rb_color = RB_BLACK;
 }
 
+void rb_erase_branch(struct rb_node *node, struct rb_root *root)
+{
+
+ if(node->rb_left)
+	  return rb_erase_branch(node->rb_left, root);
+     else if (node->rb_right) 
+		return rb_erase_branch(node->rb_right, root);
+	   else return rb_erase(node, root);
+
+}
+
+EXPORT_SYMBOL(rb_erase_branch);
 void rb_erase(struct rb_node *node, struct rb_root *root)
 {
 	struct rb_node *child, *parent;
@@ -312,6 +326,17 @@ struct rb_node *rb_first(struct rb_root 
 }
 EXPORT_SYMBOL(rb_first);
 
+struct rb_node *rb_last(struct rb_root *root)
+{
+	struct rb_node *n;
+	n=root->rb_node;
+	if (!n)
+		return 0;
+	while(n->rb_right)
+		n = n->rb_right;
+	return n;
+}
+EXPORT_SYMBOL (rb_last);
 struct rb_node *rb_next(struct rb_node *node)
 {
 	/* If we have a right-hand child, go down and then left as far


___________________________________




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVCYGIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVCYGIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVCYFyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:54:54 -0500
Received: from digitalimplant.org ([64.62.235.95]:3539 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261402AbVCYFym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:54:42 -0500
Date: Thu, 24 Mar 2005 21:54:33 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [3/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242151000.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2241, 2005-03-24 12:58:57-08:00, mochel@digitalimplant.org
  [klist] add klist_node_attached() to determine if a node is on a list or not.


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/include/linux/klist.h b/include/linux/klist.h
--- a/include/linux/klist.h	2005-03-24 20:33:45 -08:00
+++ b/include/linux/klist.h	2005-03-24 20:33:45 -08:00
@@ -37,6 +37,8 @@
 extern void klist_del(struct klist_node * n);
 extern void klist_remove(struct klist_node * n);

+extern int klist_node_attached(struct klist_node * n);
+

 struct klist_iter {
 	struct klist		* i_klist;
diff -Nru a/lib/klist.c b/lib/klist.c
--- a/lib/klist.c	2005-03-24 20:33:45 -08:00
+++ b/lib/klist.c	2005-03-24 20:33:45 -08:00
@@ -112,6 +112,7 @@
 	struct klist_node * n = container_of(kref, struct klist_node, n_ref);
 	list_del(&n->n_node);
 	complete(&n->n_removed);
+	n->n_klist = NULL;
 }

 static int klist_dec_and_del(struct klist_node * n)
@@ -154,6 +155,19 @@


 /**
+ *	klist_node_attached - Say whether a node is bound to a list or not.
+ *	@n:	Node that we're testing.
+ */
+
+int klist_node_attached(struct klist_node * n)
+{
+	return (n->n_klist != NULL);
+}
+
+EXPORT_SYMBOL_GPL(klist_node_attached);
+
+
+/**
  *	klist_iter_init_node - Initialize a klist_iter structure.
  *	@k:	klist we're iterating.
  *	@i:	klist_iter we're filling.
@@ -246,3 +260,5 @@
 }

 EXPORT_SYMBOL_GPL(klist_next);
+
+

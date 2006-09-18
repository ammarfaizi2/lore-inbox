Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWIRU2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWIRU2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWIRU2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:28:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:17938 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964881AbWIRU2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:28:07 -0400
Date: Mon, 18 Sep 2006 16:28:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] Don't call put methods while holding a spinlock
Message-ID: <Pine.LNX.4.44L0.0609181624290.7192-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The klist utility routines currently call _put methods while holding a
spinlock.  This is of course illegal; a put routine could try to
unregister a device and hence need to sleep.

No problems have arisen until now because in many cases klist removals
were done synchronously, so the _put methods were never actually used.
In other cases we may simply have been lucky.

This patch (as784) reworks the klist routines so that _put methods are
called only _after_ the klist's spinlock has been released.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: mm2/lib/klist.c
===================================================================
--- mm2.orig/lib/klist.c
+++ mm2/lib/klist.c
@@ -123,12 +123,10 @@ EXPORT_SYMBOL_GPL(klist_add_tail);
 static void klist_release(struct kref * kref)
 {
 	struct klist_node * n = container_of(kref, struct klist_node, n_ref);
-	void (*put)(struct klist_node *) = n->n_klist->put;
+
 	list_del(&n->n_node);
 	complete(&n->n_removed);
 	n->n_klist = NULL;
-	if (put)
-		put(n);
 }
 
 static int klist_dec_and_del(struct klist_node * n)
@@ -145,10 +143,14 @@ static int klist_dec_and_del(struct klis
 void klist_del(struct klist_node * n)
 {
 	struct klist * k = n->n_klist;
+	void (*put)(struct klist_node *) = k->put;
 
 	spin_lock(&k->k_lock);
-	klist_dec_and_del(n);
+	if (!klist_dec_and_del(n))
+		put = NULL;
 	spin_unlock(&k->k_lock);
+	if (put)
+		put(n);
 }
 
 EXPORT_SYMBOL_GPL(klist_del);
@@ -161,10 +163,7 @@ EXPORT_SYMBOL_GPL(klist_del);
 
 void klist_remove(struct klist_node * n)
 {
-	struct klist * k = n->n_klist;
-	spin_lock(&k->k_lock);
-	klist_dec_and_del(n);
-	spin_unlock(&k->k_lock);
+	klist_del(n);
 	wait_for_completion(&n->n_removed);
 }
 
@@ -260,12 +259,15 @@ static struct klist_node * to_klist_node
 struct klist_node * klist_next(struct klist_iter * i)
 {
 	struct list_head * next;
+	struct klist_node * lnode = i->i_cur;
 	struct klist_node * knode = NULL;
+	void (*put)(struct klist_node *) = i->i_klist->put;
 
 	spin_lock(&i->i_klist->k_lock);
-	if (i->i_cur) {
-		next = i->i_cur->n_node.next;
-		klist_dec_and_del(i->i_cur);
+	if (lnode) {
+		next = lnode->n_node.next;
+		if (!klist_dec_and_del(lnode))
+			put = NULL;
 	} else
 		next = i->i_head->next;
 
@@ -275,6 +277,8 @@ struct klist_node * klist_next(struct kl
 	}
 	i->i_cur = knode;
 	spin_unlock(&i->i_klist->k_lock);
+	if (put && lnode)
+		put(lnode);
 	return knode;
 }
 


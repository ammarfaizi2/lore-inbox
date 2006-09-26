Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWIZFku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWIZFku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWIZFkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:40:46 -0400
Received: from mail.suse.de ([195.135.220.2]:4322 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751479AbWIZFke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:34 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 47/47] Driver core: Don't call put methods while holding a spinlock
Date: Mon, 25 Sep 2006 22:38:07 -0700
Message-Id: <11592492364054-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249232139-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com> <11592492193773-gi
 t-send-email-greg@kroah.com> <11592492221573-git-send-email-greg@kroah.com> <1159249226922-git-send-email-greg@kroah.com> <115924922922-git-send-email-greg@kroah.com> <1159249232139-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

The klist utility routines currently call _put methods while holding a
spinlock.  This is of course illegal; a put routine could try to
unregister a device and hence need to sleep.

No problems have arisen until now because in many cases klist removals
were done synchronously, so the _put methods were never actually used.
In other cases we may simply have been lucky.

This patch (as784) reworks the klist routines so that _put methods are
called only _after_ the klist's spinlock has been released.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 lib/klist.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/lib/klist.c b/lib/klist.c
index 9c94f0b..120bd17 100644
--- a/lib/klist.c
+++ b/lib/klist.c
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
 
-- 
1.4.2.1


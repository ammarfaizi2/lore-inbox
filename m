Return-Path: <linux-kernel-owner+w=401wt.eu-S965140AbWL2Xqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWL2Xqv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWL2Xqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:46:51 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:45681 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965140AbWL2Xqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:46:50 -0500
Message-Id: <200612292341.kBTNfUqs005544@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/6] UML - Lock the irqs_to_free list
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Dec 2006 18:41:30 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix (i.e. add some) the locking around the irqs_to_free list.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/chan_kern.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/chan_kern.c	2006-12-29 15:27:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/chan_kern.c	2006-12-29 16:38:43.000000000 -0500
@@ -222,15 +222,28 @@ void enable_chan(struct line *line)
 	}
 }
 
+/* Items are added in IRQ context, when free_irq can't be called, and
+ * removed in process context, when it can.
+ * This handles interrupt sources which disappear, and which need to
+ * be permanently disabled.  This is discovered in IRQ context, but
+ * the freeing of the IRQ must be done later.
+ */
+static DEFINE_SPINLOCK(irqs_to_free_lock);
 static LIST_HEAD(irqs_to_free);
 
 void free_irqs(void)
 {
 	struct chan *chan;
+	LIST_HEAD(list);
+	struct list_head *ele;
+
+	spin_lock_irq(&irqs_to_free_lock);
+	list_splice_init(&irqs_to_free, &list);
+	INIT_LIST_HEAD(&irqs_to_free);
+	spin_unlock_irq(&irqs_to_free_lock);
 
-	while(!list_empty(&irqs_to_free)){
-		chan = list_entry(irqs_to_free.next, struct chan, free_list);
-		list_del(&chan->free_list);
+	list_for_each(ele, &list){
+		chan = list_entry(ele, struct chan, free_list);
 
 		if(chan->input)
 			free_irq(chan->line->driver->read_irq, chan);
@@ -246,7 +259,9 @@ static void close_one_chan(struct chan *
 		return;
 
 	if(delay_free_irq){
+		spin_lock_irq(&irqs_to_free_lock);
 		list_add(&chan->free_list, &irqs_to_free);
+		spin_unlock_irq(&irqs_to_free_lock);
 	}
 	else {
 		if(chan->input)


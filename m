Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWEKSAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWEKSAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWEKSAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:00:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:29711 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030406AbWEKSAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:00:36 -0400
Date: Thu, 11 May 2006 14:00:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow raw_notifier callouts to unregister themselves 
Message-ID: <Pine.LNX.4.44L0.0605111353210.5834-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since raw_notifier chains don't benefit from any centralized locking
protections, they shouldn't suffer from the associated limitations.  
Under some circumstances it might make sense for a raw_notifier callout
routine to unregister itself from the notifier chain.  This patch (as678)
changes the notifier core to allow for such things.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: linux-2.6.17-rc3/kernel/sys.c
===================================================================
--- linux-2.6.17-rc3.orig/kernel/sys.c
+++ linux-2.6.17-rc3/kernel/sys.c
@@ -132,14 +132,15 @@ static int __kprobes notifier_call_chain
 		unsigned long val, void *v)
 {
 	int ret = NOTIFY_DONE;
-	struct notifier_block *nb;
+	struct notifier_block *nb, *next_nb;
 
 	nb = rcu_dereference(*nl);
 	while (nb) {
+		next_nb = rcu_dereference(nb->next);
 		ret = nb->notifier_call(nb, val, v);
 		if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
 			break;
-		nb = rcu_dereference(nb->next);
+		nb = next_nb;
 	}
 	return ret;
 }


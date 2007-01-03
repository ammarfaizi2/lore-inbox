Return-Path: <linux-kernel-owner+w=401wt.eu-S1750870AbXACP1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbXACP1l (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbXACP1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:27:41 -0500
Received: from mta16.mail.adelphia.net ([68.168.78.211]:45033 "EHLO
	mta16.adelphia.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbXACP1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:27:40 -0500
Date: Wed, 3 Jan 2007 09:27:38 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Carol Hebert <cah@us.ibm.com>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] add an RCU version of list splicing
Message-ID: <20070103152738.GA16063@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is in support of the IPMI driver.  I have tested this
with the IPMI driver changes coming in the next patch.

Add a list_splice_init_rcu() function to splice an RCU-protected list
into another list.  This takes the sync function as an argument, so
one would do something like:

	INIT_LIST_HEAD(&list);
	list_splice_init_rcu(&source, &dest, synchronize_rcu);

The idea being to keep the RCU API proliferation down to a dull roar.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Corey Minyard <minyard@acm.org>
---

 list.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

Index: linux-2.6.19/include/linux/list.h
===================================================================
--- linux-2.6.19.orig/include/linux/list.h	2006-11-29 15:57:37.000000000 -0600
+++ linux-2.6.19/include/linux/list.h	2006-12-30 12:47:07.000000000 -0600
@@ -360,6 +360,63 @@
 }
 
 /**
+ * list_splice_init_rcu - splice an RCU-protected list into an existing list.
+ * @list:	the RCU-protected list to splice
+ * @head:	the place in the list to splice the first list into
+ * @sync:	function to sync: synchronize_rcu(), synchronize_sched(), ...
+ *
+ * @head can be RCU-read traversed concurrently with this function.
+ *
+ * Note that this function blocks.
+ *
+ * Important note: the caller must take whatever action is necessary to
+ *	prevent any other updates to @head.  In principle, it is possible
+ *	to modify the list as soon as sync() begins execution.
+ *	If this sort of thing becomes necessary, an alternative version
+ *	based on call_rcu() could be created.  But only if -really-
+ *	needed -- there is no shortage of RCU API members.
+ */
+static inline void list_splice_init_rcu(struct list_head *list,
+					struct list_head *head,
+					void (*sync)(void))
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *at = head->next;
+
+	might_sleep();
+	if (list_empty(head))
+		return;
+
+	/* "first" and "last" tracking list, so initialize it. */
+
+	INIT_LIST_HEAD(list);
+
+	/*
+	 * At this point, the list body still points to the source list.
+	 * Wait for any readers to finish using the list before splicing
+	 * the list body into the new list.  Any new readers will see
+	 * an empty list.
+	 */
+
+	sync();
+
+	/*
+	 * Readers are finished with the source list, so perform splice.
+	 * The order is important if the new list is global and accessible
+	 * to concurrent RCU readers.  Note that RCU readers are not
+	 * permitted to traverse the prev pointers without excluding
+	 * this function.
+	 */
+
+	last->next = at;
+	smp_wmb();
+	head->next = first;
+	first->prev = head;
+	at->prev = last;
+}
+
+/**
  * list_entry - get the struct for this entry
  * @ptr:	the &struct list_head pointer.
  * @type:	the type of the struct this is embedded in.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268662AbUIQKRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268662AbUIQKRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268663AbUIQKRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:17:55 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:42477 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S268662AbUIQKRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:17:51 -0400
Date: Fri, 17 Sep 2004 19:19:42 +0900 (JST)
Message-Id: <200409171019.i8HAJgYV002200@mailsv.bs1.fc.nec.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kaigai@ak.jp.nec.com, paulmck@us.ibm.com,
       dipankar@in.ibm.com
Subject: [PATCH] list_replace_rcu() in include/linux/list.h
From: kaigai@ak.jp.nec.com (Kaigai Kohei)
X-Mailer: mnews [version 1.22PL1] 2000-02/15(Tue)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

* list_replace_rcu-2.6.9-rc2.patch
This attached patch adds list_replace_rcu() to include/linux/list.h
for atomic updating operations according to RCU-model.

void list_replace_rcu(struct list_head *old, struct list_head *new)

The 'old' element is detached from the linked list, and the 'new'
element is inserted to the same point of the linked list concurrently.

This patch is necessary for the performance improvement of SELinux.
See, http://lkml.org/lkml/2004/8/16/54
       (Subject: RCU issue with SELinux)
     http://lkml.org/lkml/2004/8/30/63
       (Subject: [PATCH]SELinux performance improvement by RCU)

Please apply.

Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
--------
Kai Gai <kaigai@ak.jp.nec.com>


--- linux-2.6.9-rc2/include/linux/list.h	2004-09-13 14:32:48.000000000 +0900
+++ linux-2.6.9-rc2.rcu/include/linux/list.h	2004-09-16 14:53:39.000000000 +0900
@@ -194,8 +194,23 @@
 	__list_del(entry->prev, entry->next);
 	entry->prev = LIST_POISON2;
 }
 
+/*
+ * list_replace_rcu - replace old entry by new onw from list
+ * @old : the element to be replaced from the list.
+ * @new : the new element to insert to the list.
+ * 
+ * The old entry will be replaced to the new entry atomically.
+ */
+static inline void list_replace_rcu(struct list_head *old, struct list_head *new){
+	new->next = old->next;
+	new->prev = old->prev;
+	smp_wmb();
+	new->next->prev = new;
+	new->prev->next = new;
+}
+
 /**
  * list_del_init - deletes entry from list and reinitialize it.
  * @entry: the element to delete from the list.
  */

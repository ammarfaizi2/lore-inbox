Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWEQVkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWEQVkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWEQVkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 17:40:18 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:2746 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751146AbWEQVkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 17:40:17 -0400
Date: Thu, 18 May 2006 05:40:17 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] list: introduce list_replace() helper
Message-ID: <20060518014017.GA888@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

list_replace() is similar to list_replace_rcu(), but
unlike list_replace_rcu() it

	could be used when list_empty(old) == 1

	doesn't use barriers

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.17-rc4/include/linux/list.h~1_REPLACE	2006-05-18 03:29:13.000000000 +0400
+++ 2.6.17-rc4/include/linux/list.h	2006-05-18 03:38:13.000000000 +0400
@@ -197,12 +197,35 @@ static inline void list_del_rcu(struct l
 	entry->prev = LIST_POISON2;
 }
 
+/**
+ * list_replace - replace old entry by new one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ * Note: if 'old' was empty, it will be overwritten.
+ */
+static inline void list_replace(struct list_head *old,
+				struct list_head *new)
+{
+	new->next = old->next;
+	new->next->prev = new;
+	new->prev = old->prev;
+	new->prev->next = new;
+}
+
+static inline void list_replace_init(struct list_head *old,
+					struct list_head *new)
+{
+	list_replace(old, new);
+	INIT_LIST_HEAD(old);
+}
+
 /*
  * list_replace_rcu - replace old entry by new one
  * @old : the element to be replaced
  * @new : the new element to insert
  *
  * The old entry will be replaced with the new entry atomically.
+ * Note: 'old' should not be empty.
  */
 static inline void list_replace_rcu(struct list_head *old,
 				struct list_head *new)


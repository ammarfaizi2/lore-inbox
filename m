Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWHDCPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWHDCPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWHDCPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:15:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:62999 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030288AbWHDCPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:15:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ToNL3s+bcARd+JTpvlDCfdD+HI2PweZSrR6fUX1qOWtFke+pTwLEL6IETKn1X0W48s8pp9J/8HzxsLtAEac4305r3Iv0fUZagzBwN0z2FkF0Iey30RXYUAB9vQxMkRk3aKMl7IWv68+MtanebJHkxMicamk7yyzpFljqv0VnL7A=
Message-ID: <5c49b0ed0608031915g2c1fc44ch623a7657b994bf9c@mail.gmail.com>
Date: Thu, 3 Aug 2006 19:15:15 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jens Axboe" <axboe@suse.de>
Subject: [PATCH -mm] [2/3] add list_merge to list.h
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

list_merge behaves like list_splice, except it can be used with
headless lists.  that is, the resulting list will have @head
immediately preceeding @list.

This is used by the contig list feature in the Elevator I/O scheduler

Signed-off-by: Nate Diller <nate.diller@gmail.com>

---
 list.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
---

diff -urpN -X dontdiff linux-2.6.18-rc1-mm2/include/linux/list.h
linux-dput/include/linux/list.h
--- linux-2.6.18-rc1-mm2/include/linux/list.h	2006-07-18
15:00:53.000000000 -0700
+++ linux-dput/include/linux/list.h	2006-08-03 18:42:00.000000000 -0700
@@ -357,6 +357,27 @@ static inline void list_splice_init(stru
 	}
 }

+/**
+ * list_merge - merge two headless lists
+ * @list: the new list to merge.
+ * @head: the place to add it in the first list.
+ *
+ * This is similar to list_splice(), except it merges every item onto @list,
+ * not excluding @head itself.  It is a noop if @head already immediately
+ * preceeds @list.
+ */
+static inline void list_merge(struct list_head *list, struct list_head *head)
+{
+	struct list_head *last = list->prev;
+	struct list_head *at = head->next;
+
+	list->prev = head;
+	head->next = list;
+
+	last->next = at;
+	at->prev = last;
+}
+
 /**
  * list_entry - get the struct for this entry
  * @ptr:	the &struct list_head pointer.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbSJCXbu>; Thu, 3 Oct 2002 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJCXbu>; Thu, 3 Oct 2002 19:31:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28552 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261431AbSJCXbt>;
	Thu, 3 Oct 2002 19:31:49 -0400
Importance: Normal
Sensitivity: 
Subject: [PATCH] add safe version of list_for_each_entry() to list.h
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF9EDF8472.CDE2D9D8-ON85256C47.0080772B@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 3 Oct 2002 18:42:09 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/03/2002 07:36:57 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider adding the following patch to list.h.

The following patch adds list_for_each_entry_safe() and
list_member() to list.h.

- List_for_each_entry_safe adds a removal-safe version of this macro.
- List_member indicates if the container object is currently in a list.

Thanks.
Mark

diff -Naur old/include/linux/list.h new/include/linux/list.h
--- old/include/linux/list.h  Thu Oct  3 18:06:42 2002
+++ new/include/linux/list.h  Thu Oct  3 18:10:46 2002
@@ -137,6 +137,15 @@
      return head->next == head;
 }

+/**
+ * list_member - tests whether a list member is currently on a list
+ * @member:      member to evaulate
+ */
+static inline int list_member(struct list_head *member)
+{
+     return ((!member->next || !member->prev) ? 0 : 1);
+}
+
 static inline void __list_splice(struct list_head *list,
                         struct list_head *head)
 {
@@ -241,6 +250,20 @@
           pos = list_entry(pos->member.next, typeof(*pos), member),    \
                 prefetch(pos->member.next))

+/**
+ * list_for_each_entry_safe -      iterate over list safe against removal of list entry
+ * @pos:        the type * to use as a loop counter.
+ * @n:                 another type * to use as temporary storage
+ * @head:       the head for your list.
+ * @member:     the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)                      \
+        for (pos = list_entry((head)->next, typeof(*pos), member),          \
+               n = list_entry(pos->member.next, typeof(*pos), member); \
+           &pos->member != (head);                             \
+           pos = n,                                                    \
+               n = list_entry(pos->member.next, typeof(*pos), member))
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */

 #endif



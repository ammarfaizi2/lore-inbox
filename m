Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSHUKaj>; Wed, 21 Aug 2002 06:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSHUKaj>; Wed, 21 Aug 2002 06:30:39 -0400
Received: from dp.samba.org ([66.70.73.150]:27104 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318182AbSHUKai>;
	Wed, 21 Aug 2002 06:30:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] list_for_each_entry
Date: Wed, 21 Aug 2002 19:39:02 +1000
Message-Id: <20020821053509.4D5F32C0B3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using two variables all the time is pissing me off:

	struct list_head *i;
	list_for_each(i, &head) {
		struct foo *f = list_entry(i, struct foo, list);
		...
	}

Much nicer is:
	struct foo *f;
	list_for_each_entry(f, &head, list) {
		...
	}

Asm code produced is identical.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: list_for_each_entry patch
Author: Rusty Russell
Status: Trivial

D: This adds list_for_each_entry, which is the equivalent of
D: list_for_each and list_entry, except only one variable is needed.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.19/include/linux/list.h working-2.4.19-conntrack-fast/include/linux/list.h
--- linux-2.4.19/include/linux/list.h	2002-08-21 18:14:34.000000000 +1000
+++ working-2.4.19-conntrack-fast/include/linux/list.h	2002-08-21 19:35:09.000000000 +1000
@@ -171,6 +171,18 @@ static __inline__ void list_splice(struc
 	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
         	pos = pos->prev, prefetch(pos->prev))
         	
+/**
+ * list_for_each_entry	-	iterate over list of given type
+ * @pos:	the type * to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		     prefetch(pos->member.next);			\
+	     &pos->member != (head); 					\
+	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
+		     prefetch(pos->member.next))
 
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 

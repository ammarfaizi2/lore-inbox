Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbSI2Jlv>; Sun, 29 Sep 2002 05:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262433AbSI2Jlv>; Sun, 29 Sep 2002 05:41:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27264 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262432AbSI2Jlv>;
	Sun, 29 Sep 2002 05:41:51 -0400
Date: Sun, 29 Sep 2002 11:56:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] futex-fix-2.5.39-A1
Message-ID: <Pine.LNX.4.44.0209291153570.15288-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes one more race left in the new futex hashing code,
which triggers if a futex waiter gets a signal after it has been woken up
but before it actually wakes up.

	Ingo

--- linux/kernel/futex.c.orig	Sun Sep 29 11:42:35 2002
+++ linux/kernel/futex.c	Sun Sep 29 11:48:16 2002
@@ -151,13 +151,13 @@
 	struct futex_q *q = container_of(vcache, struct futex_q, vcache);
 	struct list_head *head = hash_futex(new_page, q->offset);
 
-	BUG_ON(list_empty(&q->list));
-
 	spin_lock(&futex_lock);
 
-	q->page = new_page;
-	list_del_init(&q->list);
-	list_add_tail(&q->list, head);
+	if (!list_empty(&q->list)) {
+		q->page = new_page;
+		list_del(&q->list);
+		list_add_tail(&q->list, head);
+	}
 
 	spin_unlock(&futex_lock);
 }


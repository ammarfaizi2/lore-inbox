Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317630AbSFIPqF>; Sun, 9 Jun 2002 11:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317631AbSFIPqE>; Sun, 9 Jun 2002 11:46:04 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:41725 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317630AbSFIPqC>; Sun, 9 Jun 2002 11:46:02 -0400
Date: Sun, 9 Jun 2002 17:45:53 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
cc: Martin Dalecki <dalecki@evision-ventures.com>
Subject: [PATCH] adding slist.h: simple single-linked-list helper functions
Message-ID: <Pine.GSO.4.05.10206091735180.16366-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this patch adds slist.h, a header-file providing simple single-linked-list
helper functions.

especially slist_for_each will improve:
	o readability
	o performance (due to the use of prefetch())
wherever it's used

please apply,

	tm

diff -Nru a/include/linux/slist.h b/include/linux/slist.h
--- /dev/null   Wed Dec 31 16:00:00 1969
+++ b/include/linux/slist.h     Sun Jun  9 22:32:55 2002
@@ -0,0 +1,57 @@
+#ifndef _LINUX_SLIST_H
+#define _LINUX_SLIST_H
+
+#if defined(__KERNEL__)
+
+#include <linux/prefetch.h>
+
+/*
+ * Simple single linked list helper-functions.
+ * (taken from list.h)
+ */
+
+/**
+ * slist_add_front - add a new entry at the first slot, moving the old head
+ *                     to the second slot
+ * @new:       new entry to be added
+ * @head:      head of the single linked list
+ *
+ * Insert a new entry before the specified head.
+ * This is good for implementing stacks.
+ */
+
+#define slist_add_front(_new, _head)   \
+do {                                   \
+       _new->next = _head;             \
+       _head = _new->next;             \
+} while (0)
+
+
+/**
+ * slist_add - add a new entry
+ * @new:       new entry to be added
+ * @head:      head of the single linked list
+ *
+ * Insert a new entry before the specified head.
+ * This is good for implementing stacks.
+ */
+
+#define slist_add(_new, _head)         \
+do {                                   \
+       _new->next = _head->next;       \
+       _head->next = _new;             \
+} while (0)
+
+
+/**
+ * slist_for_each      -       iterate over a list
+ * @pos:       the pointer to use as a loop counter.
+ * @head:      the head for your list (this is also the first entry).
+ */
+#define slist_for_each(pos, head) \
+       for (pos = head, prefetch(pos->next); pos; \
+               pos = pos->next, prefetch(pos->next))
+
+
+#endif /* __KERNEL__ */
+
+#endif

-- 
in some way i do, and in some way i don't.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264354AbUD0VWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbUD0VWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbUD0VWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:22:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:50063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264354AbUD0VVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:21:45 -0400
Date: Tue, 27 Apr 2004 14:21:36 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eliminate large inline's in skbuff
Message-Id: <20040427142136.35b521d5@dell_ss3.pdx.osdl.net>
In-Reply-To: <Xine.LNX.4.44.0404212046490.20483-100000@thoron.boston.redhat.com>
References: <200404212226.28350.vda@port.imtp.ilyichevsk.odessa.ua>
	<Xine.LNX.4.44.0404212046490.20483-100000@thoron.boston.redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This takes the suggestion and makes all the locked skb_ stuff, not inline.
It showed a 3% performance improvement when doing single TCP stream over 1G
Ethernet between SMP machines. Test was average of 10 iterations of
iperf for 30 seconds and SUT was 4 way Xeon.  Http performance difference
was not noticeable (less than the std. deviation of the test runs).

diff -Nru a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h	Tue Apr 27 10:40:45 2004
+++ b/include/linux/skbuff.h	Tue Apr 27 10:40:45 2004
@@ -511,6 +511,7 @@
  *
  *	A buffer cannot be placed on two lists at the same time.
  */
+extern void skb_queue_head(struct sk_buff_head *list, struct sk_buff *newsk);
 static inline void __skb_queue_head(struct sk_buff_head *list,
 				    struct sk_buff *newsk)
 {
@@ -525,28 +526,6 @@
 	next->prev  = prev->next = newsk;
 }
 
-
-/**
- *	skb_queue_head - queue a buffer at the list head
- *	@list: list to use
- *	@newsk: buffer to queue
- *
- *	Queue a buffer at the start of the list. This function takes the
- *	list lock and can be used safely with other locking &sk_buff functions
- *	safely.
- *
- *	A buffer cannot be placed on two lists at the same time.
- */
-static inline void skb_queue_head(struct sk_buff_head *list,
-				  struct sk_buff *newsk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&list->lock, flags);
-	__skb_queue_head(list, newsk);
-	spin_unlock_irqrestore(&list->lock, flags);
-}
-
 /**
  *	__skb_queue_tail - queue a buffer at the list tail
  *	@list: list to use
@@ -557,6 +536,7 @@
  *
  *	A buffer cannot be placed on two lists at the same time.
  */
+extern void skb_queue_tail(struct sk_buff_head *list, struct sk_buff *newsk);
 static inline void __skb_queue_tail(struct sk_buff_head *list,
 				   struct sk_buff *newsk)
 {
@@ -571,26 +551,6 @@
 	next->prev  = prev->next = newsk;
 }
 
-/**
- *	skb_queue_tail - queue a buffer at the list tail
- *	@list: list to use
- *	@newsk: buffer to queue
- *
- *	Queue a buffer at the tail of the list. This function takes the
- *	list lock and can be used safely with other locking &sk_buff functions
- *	safely.
- *
- *	A buffer cannot be placed on two lists at the same time.
- */
-static inline void skb_queue_tail(struct sk_buff_head *list,
-				  struct sk_buff *newsk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&list->lock, flags);
-	__skb_queue_tail(list, newsk);
-	spin_unlock_irqrestore(&list->lock, flags);
-}
 
 /**
  *	__skb_dequeue - remove from the head of the queue
@@ -600,6 +560,7 @@
  *	so must be used with appropriate locks held only. The head item is
  *	returned or %NULL if the list is empty.
  */
+extern struct sk_buff *skb_dequeue(struct sk_buff_head *list);
 static inline struct sk_buff *__skb_dequeue(struct sk_buff_head *list)
 {
 	struct sk_buff *next, *prev, *result;
@@ -619,30 +580,11 @@
 	return result;
 }
 
-/**
- *	skb_dequeue - remove from the head of the queue
- *	@list: list to dequeue from
- *
- *	Remove the head of the list. The list lock is taken so the function
- *	may be used safely with other locking list functions. The head item is
- *	returned or %NULL if the list is empty.
- */
-
-static inline struct sk_buff *skb_dequeue(struct sk_buff_head *list)
-{
-	unsigned long flags;
-	struct sk_buff *result;
-
-	spin_lock_irqsave(&list->lock, flags);
-	result = __skb_dequeue(list);
-	spin_unlock_irqrestore(&list->lock, flags);
-	return result;
-}
 
 /*
  *	Insert a packet on a list.
  */
-
+extern void        skb_insert(struct sk_buff *old, struct sk_buff *newsk);
 static inline void __skb_insert(struct sk_buff *newsk,
 				struct sk_buff *prev, struct sk_buff *next,
 				struct sk_buff_head *list)
@@ -654,58 +596,20 @@
 	list->qlen++;
 }
 
-/**
- *	skb_insert	-	insert a buffer
- *	@old: buffer to insert before
- *	@newsk: buffer to insert
- *
- *	Place a packet before a given packet in a list. The list locks are taken
- *	and this function is atomic with respect to other list locked calls
- *	A buffer cannot be placed on two lists at the same time.
- */
-
-static inline void skb_insert(struct sk_buff *old, struct sk_buff *newsk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&old->list->lock, flags);
-	__skb_insert(newsk, old->prev, old, old->list);
-	spin_unlock_irqrestore(&old->list->lock, flags);
-}
-
 /*
  *	Place a packet after a given packet in a list.
  */
-
+extern void	   skb_append(struct sk_buff *old, struct sk_buff *newsk);
 static inline void __skb_append(struct sk_buff *old, struct sk_buff *newsk)
 {
 	__skb_insert(newsk, old, old->next, old->list);
 }
 
-/**
- *	skb_append	-	append a buffer
- *	@old: buffer to insert after
- *	@newsk: buffer to insert
- *
- *	Place a packet after a given packet in a list. The list locks are taken
- *	and this function is atomic with respect to other list locked calls.
- *	A buffer cannot be placed on two lists at the same time.
- */
-
-
-static inline void skb_append(struct sk_buff *old, struct sk_buff *newsk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&old->list->lock, flags);
-	__skb_append(old, newsk);
-	spin_unlock_irqrestore(&old->list->lock, flags);
-}
-
 /*
  * remove sk_buff from list. _Must_ be called atomically, and with
  * the list known..
  */
+extern void	   skb_unlink(struct sk_buff *skb);
 static inline void __skb_unlink(struct sk_buff *skb, struct sk_buff_head *list)
 {
 	struct sk_buff *next, *prev;
@@ -719,31 +623,6 @@
 	prev->next = next;
 }
 
-/**
- *	skb_unlink	-	remove a buffer from a list
- *	@skb: buffer to remove
- *
- *	Place a packet after a given packet in a list. The list locks are taken
- *	and this function is atomic with respect to other list locked calls
- *
- *	Works even without knowing the list it is sitting on, which can be
- *	handy at times. It also means that THE LIST MUST EXIST when you
- *	unlink. Thus a list must have its contents unlinked before it is
- *	destroyed.
- */
-static inline void skb_unlink(struct sk_buff *skb)
-{
-	struct sk_buff_head *list = skb->list;
-
-	if (list) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&list->lock, flags);
-		if (skb->list == list)
-			__skb_unlink(skb, skb->list);
-		spin_unlock_irqrestore(&list->lock, flags);
-	}
-}
 
 /* XXX: more streamlined implementation */
 
@@ -755,6 +634,7 @@
  *	so must be used with appropriate locks held only. The tail item is
  *	returned or %NULL if the list is empty.
  */
+extern struct sk_buff *skb_dequeue_tail(struct sk_buff_head *list);
 static inline struct sk_buff *__skb_dequeue_tail(struct sk_buff_head *list)
 {
 	struct sk_buff *skb = skb_peek_tail(list);
@@ -763,24 +643,6 @@
 	return skb;
 }
 
-/**
- *	skb_dequeue_tail - remove from the tail of the queue
- *	@list: list to dequeue from
- *
- *	Remove the tail of the list. The list lock is taken so the function
- *	may be used safely with other locking list functions. The tail item is
- *	returned or %NULL if the list is empty.
- */
-static inline struct sk_buff *skb_dequeue_tail(struct sk_buff_head *list)
-{
-	unsigned long flags;
-	struct sk_buff *result;
-
-	spin_lock_irqsave(&list->lock, flags);
-	result = __skb_dequeue_tail(list);
-	spin_unlock_irqrestore(&list->lock, flags);
-	return result;
-}
 
 static inline int skb_is_nonlinear(const struct sk_buff *skb)
 {
@@ -1012,21 +874,6 @@
 }
 
 /**
- *	skb_queue_purge - empty a list
- *	@list: list to empty
- *
- *	Delete all buffers on an &sk_buff list. Each buffer is removed from
- *	the list and one reference dropped. This function takes the list
- *	lock and is atomic with respect to other list locking functions.
- */
-static inline void skb_queue_purge(struct sk_buff_head *list)
-{
-	struct sk_buff *skb;
-	while ((skb = skb_dequeue(list)) != NULL)
-		kfree_skb(skb);
-}
-
-/**
  *	__skb_queue_purge - empty a list
  *	@list: list to empty
  *
@@ -1034,6 +881,7 @@
  *	the list and one reference dropped. This function does not take the
  *	list lock and the caller must hold the relevant locks to use it.
  */
+extern void skb_queue_purge(struct sk_buff_head *list);
 static inline void __skb_queue_purge(struct sk_buff_head *list)
 {
 	struct sk_buff *skb;
diff -Nru a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c	Tue Apr 27 10:40:45 2004
+++ b/net/core/skbuff.c	Tue Apr 27 10:40:45 2004
@@ -1091,6 +1091,165 @@
 	}
 }
 
+/**
+ *	skb_dequeue - remove from the head of the queue
+ *	@list: list to dequeue from
+ *
+ *	Remove the head of the list. The list lock is taken so the function
+ *	may be used safely with other locking list functions. The head item is
+ *	returned or %NULL if the list is empty.
+ */
+
+struct sk_buff *skb_dequeue(struct sk_buff_head *list)
+{
+	unsigned long flags;
+	struct sk_buff *result;
+
+	spin_lock_irqsave(&list->lock, flags);
+	result = __skb_dequeue(list);
+	spin_unlock_irqrestore(&list->lock, flags);
+	return result;
+}
+
+/**
+ *	skb_dequeue_tail - remove from the tail of the queue
+ *	@list: list to dequeue from
+ *
+ *	Remove the tail of the list. The list lock is taken so the function
+ *	may be used safely with other locking list functions. The tail item is
+ *	returned or %NULL if the list is empty.
+ */
+struct sk_buff *skb_dequeue_tail(struct sk_buff_head *list)
+{
+	unsigned long flags;
+	struct sk_buff *result;
+
+	spin_lock_irqsave(&list->lock, flags);
+	result = __skb_dequeue_tail(list);
+	spin_unlock_irqrestore(&list->lock, flags);
+	return result;
+}
+
+/**
+ *	skb_queue_purge - empty a list
+ *	@list: list to empty
+ *
+ *	Delete all buffers on an &sk_buff list. Each buffer is removed from
+ *	the list and one reference dropped. This function takes the list
+ *	lock and is atomic with respect to other list locking functions.
+ */
+void skb_queue_purge(struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+	while ((skb = skb_dequeue(list)) != NULL)
+		kfree_skb(skb);
+}
+
+/**
+ *	skb_queue_head - queue a buffer at the list head
+ *	@list: list to use
+ *	@newsk: buffer to queue
+ *
+ *	Queue a buffer at the start of the list. This function takes the
+ *	list lock and can be used safely with other locking &sk_buff functions
+ *	safely.
+ *
+ *	A buffer cannot be placed on two lists at the same time.
+ */
+void skb_queue_head(struct sk_buff_head *list, struct sk_buff *newsk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&list->lock, flags);
+	__skb_queue_head(list, newsk);
+	spin_unlock_irqrestore(&list->lock, flags);
+}
+
+/**
+ *	skb_queue_tail - queue a buffer at the list tail
+ *	@list: list to use
+ *	@newsk: buffer to queue
+ *
+ *	Queue a buffer at the tail of the list. This function takes the
+ *	list lock and can be used safely with other locking &sk_buff functions
+ *	safely.
+ *
+ *	A buffer cannot be placed on two lists at the same time.
+ */
+void skb_queue_tail(struct sk_buff_head *list, struct sk_buff *newsk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&list->lock, flags);
+	__skb_queue_tail(list, newsk);
+	spin_unlock_irqrestore(&list->lock, flags);
+}
+/**
+ *	skb_unlink	-	remove a buffer from a list
+ *	@skb: buffer to remove
+ *
+ *	Place a packet after a given packet in a list. The list locks are taken
+ *	and this function is atomic with respect to other list locked calls
+ *
+ *	Works even without knowing the list it is sitting on, which can be
+ *	handy at times. It also means that THE LIST MUST EXIST when you
+ *	unlink. Thus a list must have its contents unlinked before it is
+ *	destroyed.
+ */
+void skb_unlink(struct sk_buff *skb)
+{
+	struct sk_buff_head *list = skb->list;
+
+	if (list) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&list->lock, flags);
+		if (skb->list == list)
+			__skb_unlink(skb, skb->list);
+		spin_unlock_irqrestore(&list->lock, flags);
+	}
+}
+
+
+/**
+ *	skb_append	-	append a buffer
+ *	@old: buffer to insert after
+ *	@newsk: buffer to insert
+ *
+ *	Place a packet after a given packet in a list. The list locks are taken
+ *	and this function is atomic with respect to other list locked calls.
+ *	A buffer cannot be placed on two lists at the same time.
+ */
+
+void skb_append(struct sk_buff *old, struct sk_buff *newsk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&old->list->lock, flags);
+	__skb_append(old, newsk);
+	spin_unlock_irqrestore(&old->list->lock, flags);
+}
+
+
+/**
+ *	skb_insert	-	insert a buffer
+ *	@old: buffer to insert before
+ *	@newsk: buffer to insert
+ *
+ *	Place a packet before a given packet in a list. The list locks are taken
+ *	and this function is atomic with respect to other list locked calls
+ *	A buffer cannot be placed on two lists at the same time.
+ */
+
+void skb_insert(struct sk_buff *old, struct sk_buff *newsk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&old->list->lock, flags);
+	__skb_insert(newsk, old->prev, old, old->list);
+	spin_unlock_irqrestore(&old->list->lock, flags);
+}
+
 #if 0
 /*
  * 	Tune the memory allocator for a new MTU size.
@@ -1133,3 +1292,11 @@
 EXPORT_SYMBOL(skb_pad);
 EXPORT_SYMBOL(skb_realloc_headroom);
 EXPORT_SYMBOL(skb_under_panic);
+EXPORT_SYMBOL(skb_dequeue);
+EXPORT_SYMBOL(skb_dequeue_tail);
+EXPORT_SYMBOL(skb_insert);
+EXPORT_SYMBOL(skb_queue_purge);
+EXPORT_SYMBOL(skb_queue_head);
+EXPORT_SYMBOL(skb_queue_tail);
+EXPORT_SYMBOL(skb_unlink);
+EXPORT_SYMBOL(skb_append);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWE2V0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWE2V0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWE2V0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:39 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:26859 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751368AbWE2V0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:33 -0400
Date: Mon, 29 May 2006 23:26:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 47/61] lock validator: special locking: skb_queue_head_init()
Message-ID: <20060529212654.GU3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (multi-initialized) locking code to the lock validator.
Has no effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
---
 include/linux/skbuff.h |    7 +------
 net/core/skbuff.c      |    9 +++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)

Index: linux/include/linux/skbuff.h
===================================================================
--- linux.orig/include/linux/skbuff.h
+++ linux/include/linux/skbuff.h
@@ -584,12 +584,7 @@ static inline __u32 skb_queue_len(const 
 	return list_->qlen;
 }
 
-static inline void skb_queue_head_init(struct sk_buff_head *list)
-{
-	spin_lock_init(&list->lock);
-	list->prev = list->next = (struct sk_buff *)list;
-	list->qlen = 0;
-}
+extern void skb_queue_head_init(struct sk_buff_head *list);
 
 /*
  *	Insert an sk_buff at the start of a list.
Index: linux/net/core/skbuff.c
===================================================================
--- linux.orig/net/core/skbuff.c
+++ linux/net/core/skbuff.c
@@ -71,6 +71,15 @@
 static kmem_cache_t *skbuff_head_cache __read_mostly;
 static kmem_cache_t *skbuff_fclone_cache __read_mostly;
 
+void skb_queue_head_init(struct sk_buff_head *list)
+{
+	spin_lock_init(&list->lock);
+	list->prev = list->next = (struct sk_buff *)list;
+	list->qlen = 0;
+}
+
+EXPORT_SYMBOL(skb_queue_head_init);
+
 /*
  *	Keep out-of-line to prevent kernel bloat.
  *	__builtin_return_address is not used because it is not always

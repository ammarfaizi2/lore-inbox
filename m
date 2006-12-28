Return-Path: <linux-kernel-owner+w=401wt.eu-S964980AbWL1Ieg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWL1Ieg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWL1Ieg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:34:36 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:43921 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964974AbWL1Iee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:34:34 -0500
Date: Thu, 28 Dec 2006 14:09:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [FSAIO][PATCH 3/8] Routines to initialize and test a wait bit key
Message-ID: <20061228083900.GC6971@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


init_wait_bit_key() initializes the key field in an already 
allocated wait bit structure, useful for async wait bit support.
Also separate out the wait bit test to a common routine which
can be used by different kinds of wakeup callbacks.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 linux-2.6.20-rc1-root/include/linux/wait.h |   24 ++++++++++++++++++++++++
 linux-2.6.20-rc1-root/kernel/wait.c        |   11 ++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff -puN include/linux/wait.h~init-wait-bit-key include/linux/wait.h
--- linux-2.6.20-rc1/include/linux/wait.h~init-wait-bit-key	2006-12-21 08:45:46.000000000 +0530
+++ linux-2.6.20-rc1-root/include/linux/wait.h	2006-12-21 08:45:46.000000000 +0530
@@ -108,6 +108,17 @@ static inline int waitqueue_active(wait_
 	return !list_empty(&q->task_list);
 }
 
+static inline int test_wait_bit_key(wait_queue_t *wait,
+				struct wait_bit_key *key)
+{
+	struct wait_bit_queue *wait_bit
+		= container_of(wait, struct wait_bit_queue, wait);
+
+	return (wait_bit->key.flags == key->flags &&
+			wait_bit->key.bit_nr == key->bit_nr &&
+			!test_bit(key->bit_nr, key->flags));
+}
+
 /*
  * Used to distinguish between sync and async io wait context:
  * sync i/o typically specifies a NULL wait queue entry or a wait
@@ -416,6 +427,19 @@ int wake_bit_function(wait_queue_t *wait
 		INIT_LIST_HEAD(&(wait)->task_list);			\
 	} while (0)
 
+#define init_wait_bit_key(waitbit, word, bit)				\
+	do {								\
+		(waitbit)->key.flags = word;				\
+		(waitbit)->key.bit_nr = bit;				\
+	} while (0)
+
+#define init_wait_bit_task(waitbit, tsk)				\
+	do {								\
+		(waitbit)->wait.private = tsk;				\
+		(waitbit)->wait.func = wake_bit_function;		\
+		INIT_LIST_HEAD(&(waitbit)->wait.task_list);		\
+	} while (0)
+
 /**
  * wait_on_bit - wait for a bit to be cleared
  * @word: the word being waited on, a kernel virtual address
diff -puN kernel/wait.c~init-wait-bit-key kernel/wait.c
--- linux-2.6.20-rc1/kernel/wait.c~init-wait-bit-key	2006-12-21 08:45:46.000000000 +0530
+++ linux-2.6.20-rc1-root/kernel/wait.c	2006-12-28 09:32:44.000000000 +0530
@@ -139,16 +139,9 @@ EXPORT_SYMBOL(autoremove_wake_function);
 
 int wake_bit_function(wait_queue_t *wait, unsigned mode, int sync, void *arg)
 {
-	struct wait_bit_key *key = arg;
-	struct wait_bit_queue *wait_bit
-		= container_of(wait, struct wait_bit_queue, wait);
-
-	if (wait_bit->key.flags != key->flags ||
-			wait_bit->key.bit_nr != key->bit_nr ||
-			test_bit(key->bit_nr, key->flags))
+	if (!test_wait_bit_key(wait, arg))
 		return 0;
-	else
-		return autoremove_wake_function(wait, mode, sync, key);
+	return autoremove_wake_function(wait, mode, sync, arg);
 }
 EXPORT_SYMBOL(wake_bit_function);
 
_
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


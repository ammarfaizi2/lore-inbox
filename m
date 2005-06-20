Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVFTQVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVFTQVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVFTQTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:19:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22510 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261377AbVFTQS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:18:56 -0400
Date: Mon, 20 Jun 2005 21:58:11 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 3/6] Interfaces to initialize and to test a wait_bit key
Message-ID: <20050620162811.GC5380@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620160126.GA5271@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 09:31:26PM +0530, Suparna Bhattacharya wrote:
> patches to update AIO for filtered wakeups:
> 
>> Updated to apply to 2.6.12-rc6


init_wait_bit_key() initializes the key field in an already 
allocated wait bit structure, useful for async wait bit support.
Also separate out the wait bit test to a common routine which
can be used by different kinds of wakeup callbacks.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 linux-2.6.9-rc1-mm4-suparna/include/linux/wait.h |   17 +++++++++++++++++
 linux-2.6.9-rc1-mm4-suparna/kernel/wait.c        |   11 ++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff -puN include/linux/wait.h~init-wait-bit-key include/linux/wait.h
--- linux-2.6.9-rc1-mm4/include/linux/wait.h~init-wait-bit-key	2004-09-14 16:00:46.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/include/linux/wait.h	2004-09-15 15:33:51.000000000 +0530
@@ -103,6 +103,17 @@ static inline int waitqueue_active(wait_
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
@@ -344,6 +359,19 @@ int wake_bit_function(wait_queue_t *wait
 		(wait)->task = current;					\
 		(wait)->func = autoremove_wake_function;		\
 		INIT_LIST_HEAD(&(wait)->task_list);			\
+	} while (0)
+
+#define init_wait_bit_key(waitbit, word, bit)				\
+	do {								\
+		(waitbit)->key.flags = word;				\
+		(waitbit)->key.bit_nr = bit;				\
+	} while (0)
+
+#define init_wait_bit_task(waitbit, tsk)				\
+	do {								\
+		(waitbit)->wait.task = tsk;				\
+		(waitbit)->wait.func = wake_bit_function;		\
+		INIT_LIST_HEAD(&(waitbit)->wait.task_list);		\
 	} while (0)
 
 /**
diff -puN kernel/wait.c~init-wait-bit-key kernel/wait.c
--- linux-2.6.9-rc1-mm4/kernel/wait.c~init-wait-bit-key	2004-09-15 12:14:03.000000000 +0530
+++ linux-2.6.9-rc1-mm4-suparna/kernel/wait.c	2004-09-15 15:33:05.000000000 +0530
@@ -132,16 +132,9 @@ EXPORT_SYMBOL(autoremove_wake_function);
 
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


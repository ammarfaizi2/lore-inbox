Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbUKCJKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbUKCJKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbUKCJJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:09:34 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:26836 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261494AbUKCJHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:07:01 -0500
Date: Wed, 3 Nov 2004 14:45:49 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: Re: [PATCH 3/6] Interfaces to init and to test wait bit key
Message-ID: <20041103091549.GC5737@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041103091036.GA4041@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103091036.GA4041@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:40:36PM +0530, Suparna Bhattacharya wrote:
> 
> The series of patches that follow integrate AIO with 
> William Lee Irwin's wait bit changes, to support asynchronous
> page waits.
> 
> [1] modify-wait-bit-action-args.patch
> 	Add a wait queue arg to the wait_bit action() routine
> 
> [2] lock_page_slow.patch
> 	Rename __lock_page to lock_page_slow
> 
> [3] init-wait-bit-key.patch
> 	Interfaces to init and to test wait bit key
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

-------------------------------------------------------------

init_wait_bit_key() initializes the key field in an already 
allocated wait bit structure, useful for async wait bit support.
Also separate out the wait bit test to a common routine which
can be used by different kinds of wakeup callbacks.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

diff -puN include/linux/wait.h~init-wait-bit-key include/linux/wait.h


 linux-2.6.10-rc1-suparna/include/linux/wait.h |   30 +++++++++++++++++++++++---
 linux-2.6.10-rc1-suparna/kernel/wait.c        |   11 +--------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff -puN include/linux/wait.h~init-wait-bit-key include/linux/wait.h
--- linux-2.6.10-rc1/include/linux/wait.h~init-wait-bit-key	2004-11-03 14:35:07.000000000 +0530
+++ linux-2.6.10-rc1-suparna/include/linux/wait.h	2004-11-03 14:35:07.000000000 +0530
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
@@ -348,9 +359,22 @@ int wake_bit_function(wait_queue_t *wait
 
 #define init_wait(wait)							\
 	do {								\
-		wait->task = current;					\
-		wait->func = autoremove_wake_function;			\
-		INIT_LIST_HEAD(&wait->task_list);			\
+		(wait)->task = current;					\
+		(wait)->func = autoremove_wake_function;		\
+		INIT_LIST_HEAD(&(wait)->task_list);			\
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
--- linux-2.6.10-rc1/kernel/wait.c~init-wait-bit-key	2004-11-03 14:35:07.000000000 +0530
+++ linux-2.6.10-rc1-suparna/kernel/wait.c	2004-11-03 14:35:07.000000000 +0530
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

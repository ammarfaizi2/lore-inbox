Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVLOPva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVLOPva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLOPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:51:30 -0500
Received: from kanga.kvack.org ([66.96.29.28]:28066 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750771AbVLOPv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:51:29 -0500
Date: Thu, 15 Dec 2005 10:43:57 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: akpm@odsl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [AIO] reorder kiocb structure elements to make sync iocb setup faster
Message-ID: <20051215154357.GC2444@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below reorders members of the kiocb structure to make sync kiocb 
setup faster.  By setting the elements sequentially, the write combining 
buffers on the CPU are able to combine the writes into a single burst, 
which results in fewer cache cycles being consumed, freeing them up for 
other code.  This results in a 10-20KB/s[*] increase on the bw_unix part 
of LMbench on my test system.

		-ben

* - The improvement varies based on what other patches are in the system, 
    as there are a number of bottlenecks, so this number is not absolutely 
    accurate.

Signed-off-by: Benjamin LaHaise <benjamin.c.lahaise@intel.com>
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 49fd376..00c8efa 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -94,26 +94,27 @@ struct kiocb {
 	ssize_t			(*ki_retry)(struct kiocb *);
 	void			(*ki_dtor)(struct kiocb *);
 
-	struct list_head	ki_list;	/* the aio core uses this
-						 * for cancellation */
-
 	union {
 		void __user		*user;
 		struct task_struct	*tsk;
 	} ki_obj;
+
 	__u64			ki_user_data;	/* user's data for completion */
+	wait_queue_t		ki_wait;
 	loff_t			ki_pos;
+
+	void			*private;
 	/* State that we remember to be able to restart/retry  */
 	unsigned short		ki_opcode;
 	size_t			ki_nbytes; 	/* copy of iocb->aio_nbytes */
 	char 			__user *ki_buf;	/* remaining iocb->aio_buf */
 	size_t			ki_left; 	/* remaining bytes */
-	wait_queue_t		ki_wait;
 	long			ki_retried; 	/* just for testing */
 	long			ki_kicked; 	/* just for testing */
 	long			ki_queued; 	/* just for testing */
 
-	void			*private;
+	struct list_head	ki_list;	/* the aio core uses this
+						 * for cancellation */
 };
 
 #define is_sync_kiocb(iocb)	((iocb)->ki_key == KIOCB_SYNC_KEY)
@@ -126,6 +127,7 @@ struct kiocb {
 		(x)->ki_filp = (filp);			\
 		(x)->ki_ctx = NULL;			\
 		(x)->ki_cancel = NULL;			\
+		(x)->ki_retry = NULL;			\
 		(x)->ki_dtor = NULL;			\
 		(x)->ki_obj.tsk = tsk;			\
 		(x)->ki_user_data = 0;                  \
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.

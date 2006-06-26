Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933246AbWFZXNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933246AbWFZXNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933239AbWFZWiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:18 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:61343 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933224AbWFZWiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:02 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 15/32] [Suspend2] Submit batched i/o.
Date: Tue, 27 Jun 2006 08:38:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223759.4376.71912.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submit a group of pages that have been batched up.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   42 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 4d489f4..07db518 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -514,3 +514,45 @@ static int submit(int rw, struct io_info
 	return error;
 }
 
+/* 
+ * submit a batch. The submit function can wait on I/O, so we have
+ * simple locking to avoid infinite recursion.
+ */
+static int submit_batched(void)
+{
+	static int running_already = 0;
+	struct io_info *first;
+	unsigned long flags;
+	int num_submitted = 0;
+
+	running_already = 1;
+	spin_lock_irqsave(&ioinfo_submit_lock, flags);
+	while(!list_empty(&ioinfo_submit_batch)) {
+		first = list_entry(ioinfo_submit_batch.next, struct io_info,
+									list);
+
+		BUG_ON(!test_and_clear_bit(IO_AWAITING_SUBMIT, &first->flags));
+
+		list_del_init(&first->list);
+
+		atomic_dec(&submit_batch);
+
+		spin_unlock_irqrestore(&ioinfo_submit_lock, flags);
+
+		if (test_bit(IO_AWAITING_READ, &first->flags))
+			submit(READ, first);
+		else
+			submit(WRITE, first);
+
+		spin_lock_irqsave(&ioinfo_submit_lock, flags);
+		
+		num_submitted++;
+		if (num_submitted == submit_batch_size)
+			break;
+	}
+	spin_unlock_irqrestore(&ioinfo_submit_lock, flags);
+	running_already = 0;
+
+	return num_submitted;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

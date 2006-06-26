Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933239AbWFZXNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933239AbWFZXNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933231AbWFZWiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:16 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:61855 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933234AbWFZWiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:06 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 16/32] [Suspend2] Add page io to a batch.
Date: Tue, 27 Jun 2006 08:38:05 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223802.4376.56397.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a page to the current batch. If the batch becomes full as a result,
submit it.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 07db518..728df04 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -556,3 +556,20 @@ static int submit_batched(void)
 	return num_submitted;
 }
 
+static void add_to_batch(struct io_info *io_info)
+{
+	unsigned long flags;
+
+	set_bit(IO_AWAITING_SUBMIT, &io_info->flags);
+
+	/* Put our prepared I/O struct on the batch list. */
+	spin_lock_irqsave(&ioinfo_submit_lock, flags);
+	list_add_tail(&io_info->list, &ioinfo_submit_batch);
+	spin_unlock_irqrestore(&ioinfo_submit_lock, flags);
+
+	atomic_inc(&submit_batch);
+
+	if (atomic_read(&submit_batch) >= submit_batch_size)
+		submit_batched();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933224AbWFZWiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933224AbWFZWiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933229AbWFZWiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:21 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:60319 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933226AbWFZWhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/32] [Suspend2] Suspend bio completion.
Date: Tue, 27 Jun 2006 08:37:52 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223751.4376.9450.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routine called in an interrupt context when block io completes. We move the
io_info struct from the busy list to the ready-for-cleanup list.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index a1fcacb..288718c 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -436,3 +436,30 @@ static void suspend_cleanup_readahead(in
 	return;
 }
 
+/*
+ * suspend_end_bio
+ *
+ * Description:	Function called by block driver from interrupt context when I/O
+ * 		is completed. This is the reason we use spinlocks in
+ * 		manipulating the io_info lists. 		
+ * 		Nearly the fs/buffer.c version, but we want to mark the page as 
+ * 		done in our own structures too.
+ */
+
+static int suspend_end_bio(struct bio *bio, unsigned int num, int err)
+{
+	struct io_info *io_info = bio->bi_private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioinfo_busy_lock, flags);
+	list_del_init(&io_info->list);
+	spin_unlock_irqrestore(&ioinfo_busy_lock, flags);
+
+	set_bit(IO_AWAITING_CLEANUP, &io_info->flags);
+		
+	spin_lock_irqsave(&ioinfo_ready_lock, flags);
+	list_add_tail(&io_info->list, &ioinfo_ready_for_cleanup);
+	spin_unlock_irqrestore(&ioinfo_ready_lock, flags);
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

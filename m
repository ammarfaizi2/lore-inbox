Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933242AbWFZWiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242AbWFZWiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933231AbWFZWhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:45 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:56735 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933226AbWFZWh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:29 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/32] [Suspend2] Cleanup some completed I/O
Date: Tue, 27 Jun 2006 08:37:27 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223726.4376.59210.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iterate through the read_for_cleanup list, cleaning up a maximum of
submit_batch_size completed pages.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 037535b..cfff687 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -229,7 +229,7 @@ static void __suspend_bio_cleanup_one(st
 	io_info->flags = 0;
 }
 
-/* suspend_bio_cleanup_one
+/* __suspend_io_cleanup
  */
 
 static int suspend_bio_cleanup_one(void *data)
@@ -275,3 +275,38 @@ static int suspend_bio_cleanup_one(void 
 	return 0;
 }
 
+/* suspend_cleanup_some_completed_io
+ *
+ * NB: This is designed so that multiple callers can be in here simultaneously.
+ */
+
+static void suspend_cleanup_some_completed_io(void)
+{
+	int num_cleaned = 0;
+	struct io_info *first;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioinfo_ready_lock, flags);
+	while(!list_empty(&ioinfo_ready_for_cleanup)) {
+		int result;
+		first = list_entry(ioinfo_ready_for_cleanup.next,
+				struct io_info, list);
+
+		BUG_ON(!test_and_clear_bit(IO_AWAITING_CLEANUP, &first->flags));
+
+		list_del_init(&first->list);
+
+		spin_unlock_irqrestore(&ioinfo_ready_lock, flags);
+
+		result = suspend_bio_cleanup_one((void *) first);
+
+		spin_lock_irqsave(&ioinfo_ready_lock, flags);
+		if (result)
+			continue;
+		num_cleaned++;
+		if (num_cleaned == submit_batch_size)
+			break;
+	}
+	spin_unlock_irqrestore(&ioinfo_ready_lock, flags);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933258AbWFZXO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933258AbWFZXO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933249AbWFZXNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:13:54 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:63391 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933236AbWFZWiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:17 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 19/32] [Suspend2] Do i/o on a page.
Date: Tue, 27 Jun 2006 08:38:15 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223814.4376.69386.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perform i/o on a page, possibly waiting for completion.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   44 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 0d01483..555d4fa 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -722,3 +722,47 @@ static struct io_info *start_one(int rw,
 	return io_info;
 }
 
+static int suspend_do_io(int rw, 
+		struct submit_params *submit_info, int syncio)
+{
+	struct io_info *io_info;
+
+	if(!submit_info->dev) {
+		printk("Suspend_do_io: submit_info->dev is NULL!\n");
+		return 1;
+	}
+	
+	io_info = start_one(rw, submit_info);
+
+	if (!io_info) {
+		printk("Unable to allocate an io_info struct.\n");
+		return 1;
+	} else if (syncio)
+		wait_on_one_page(io_info);
+
+	/* If we were the only one, clean everything up */
+	if (!atomic_read(&outstanding_io))
+		suspend_finish_all_io();
+	return 0;
+} 
+
+/* We used to use bread here, but it doesn't correctly handle
+ * blocksize != PAGE_SIZE. Now we create a submit_info to get the data we
+ * want and use our normal routines (synchronously).
+ */
+
+static int suspend_bdev_page_io(int rw, struct block_device *bdev, long pos,
+		struct page *page)
+{
+	struct submit_params submit_info;
+
+	if (!bdev)
+		return 0;
+
+	submit_info.page = page;
+	submit_info.dev = bdev;
+	submit_info.block[0] = pos;
+	submit_info.readahead_index = -1;
+	return suspend_do_io(rw, &submit_info, 1);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933341AbWFZWqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933341AbWFZWqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933338AbWFZWq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:46:27 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:49847 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933344AbWFZWmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:09 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 18/28] [Suspend2] Invalidate swapwriter image.
Date: Tue, 27 Jun 2006 08:42:07 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224206.4975.55643.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Invalidate an image stored on swap.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   55 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 9d806a5..ba1761b 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -750,3 +750,58 @@ static int swapwriter_read_header_cleanu
 	return 0;
 }
 
+/* swapwriter_invalidate_image
+ * 
+ */
+static int swapwriter_invalidate_image(void)
+{
+	union p_diskpage cur;
+	int result = 0;
+	char newsig[11];
+	
+	cur.address = get_zeroed_page(GFP_ATOMIC);
+	if (!cur.address) {
+		printk("Unable to allocate a page for restoring the swap signature.\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * If nr_suspends == 0, we must be booting, so no swap pages
+	 * will be recorded as used yet.
+	 */
+
+	if (nr_suspends > 0)
+		swapwriter_release_storage();
+
+	/* 
+	 * We don't do a sanity check here: we want to restore the swap 
+	 * whatever version of kernel made the suspend image.
+	 * 
+	 * We need to write swap, but swap may not be enabled so
+	 * we write the device directly
+	 */
+	
+	suspend_bio_ops.bdev_page_io(READ, resume_block_device,
+			resume_firstblock,
+			virt_to_page(cur.pointer));
+
+	result = parse_signature(cur.pointer->swh.magic.magic, 1);
+		
+	if (result < 4)
+		goto out;
+
+	strncpy(newsig, cur.pointer->swh.magic.magic, 10);
+	newsig[10] = 0;
+
+	suspend_bio_ops.bdev_page_io(WRITE, resume_block_device,
+			resume_firstblock,
+			virt_to_page(cur.pointer));
+
+	if (!nr_suspends)
+		printk(KERN_WARNING name_suspend "Image invalidated.\n");
+out:
+	suspend_bio_ops.finish_all_io();
+	free_page(cur.address);
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

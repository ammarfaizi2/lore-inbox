Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933352AbWFZWoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352AbWFZWoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933348AbWFZWnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:43:01 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:52407 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933345AbWFZWm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:26 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 23/28] [Suspend2] Swapwriter mark resume attempted.
Date: Tue, 27 Jun 2006 08:42:25 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224223.4975.2499.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark in the signature of a swap image that we've attempted to resume from
this image before.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 7342cb2..683797a 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -926,3 +926,44 @@ static int swapwriter_image_exists(void)
 	return 1;
 }
 
+/*
+ * Mark resume attempted.
+ *
+ * Record that we tried to resume from this image.
+ */
+
+static void swapwriter_mark_resume_attempted(void)
+{
+	union p_diskpage diskpage;
+	int signature_found;
+	
+	if (!resume_dev_t) {
+		printk("Not even trying to record attempt at resuming"
+				" because resume_dev_t is not set.\n");
+		return;
+	}
+	
+	diskpage.address = get_zeroed_page(GFP_ATOMIC);
+
+	suspend_bio_ops.bdev_page_io(READ, resume_block_device,
+			resume_firstblock,
+			virt_to_page(diskpage.ptr));
+	signature_found = parse_signature(diskpage.pointer->swh.magic.magic, 0);
+
+	switch (signature_found) {
+		case 12:
+		case 13:
+			diskpage.pointer->swh.magic.magic[5] |= 0x80;
+			break;
+	}
+	
+	suspend_bio_ops.bdev_page_io(WRITE, resume_block_device,
+			resume_firstblock,
+			virt_to_page(diskpage.ptr));
+	suspend_bio_ops.finish_all_io();
+	free_page(diskpage.address);
+	
+	close_bdevs();
+	return;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

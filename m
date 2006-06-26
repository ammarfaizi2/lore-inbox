Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933353AbWFZWpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933353AbWFZWpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbWFZWpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:45:06 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:51895 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933339AbWFZWmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:23 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 22/28] [Suspend2] Does a swapwriter image exist?
Date: Tue, 27 Jun 2006 08:42:21 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224219.4975.31296.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return whether there is an image at the location currently pointed to by
resume2=.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   54 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index ba6ed75..7342cb2 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -872,3 +872,57 @@ static unsigned long swapwriter_storage_
 	return result;
 }
 
+/*
+ * Image_exists
+ */
+
+static int swapwriter_image_exists(void)
+{
+	int signature_found;
+	union p_diskpage diskpage;
+	
+	if (!resume_dev_t) {
+		printk("Not even trying to read header "
+				"because resume_dev_t is not set.\n");
+		return 0;
+	}
+	
+	if (!resume_block_device &&
+	    IS_ERR(resume_block_device = open_bdev(MAX_SWAPFILES, resume_dev_t)))
+		return 0;
+
+	diskpage.address = get_zeroed_page(GFP_ATOMIC);
+
+	suspend_bio_ops.bdev_page_io(READ, resume_block_device,
+			resume_firstblock,
+			virt_to_page(diskpage.ptr));
+	suspend_bio_ops.finish_all_io();
+
+	signature_found = parse_signature(diskpage.pointer->swh.magic.magic, 0);
+	free_page(diskpage.address);
+
+	if (signature_found < 2) {
+		return 0;	/* Normal swap space */
+	} else if (signature_found == -1) {
+		printk(KERN_ERR name_suspend
+			"Unable to find a signature. Could you have moved "
+			"a swap file?\n");
+		return 0;
+	} else if (signature_found < 6) {
+		if ((!(test_suspend_state(SUSPEND_NORESUME_SPECIFIED)))
+				&& suspend_early_boot_message(1,
+				SUSPEND_CONTINUE_REQ,
+				"Detected the signature of an alternate "
+				"implementation.\n"))
+			set_suspend_state(SUSPEND_NORESUME_SPECIFIED);
+		return 0;
+	} else if ((signature_found >> 1) != SIGNATURE_VER) {
+		if ((!(test_suspend_state(SUSPEND_NORESUME_SPECIFIED))) &&
+			suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+			 "Found a different style suspend image signature."))
+			set_suspend_state(SUSPEND_NORESUME_SPECIFIED);
+	}
+
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

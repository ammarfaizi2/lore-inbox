Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933365AbWFZWrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933365AbWFZWrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933335AbWFZWrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:47:01 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:49335 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933332AbWFZWmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:06 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 17/28] [Suspend2] Swapwriter read image header init/cleanup.
Date: Tue, 27 Jun 2006 08:42:04 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224202.4975.63796.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialisation and clean up routines for reading the image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |  116 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index b005f8b..9d806a5 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -634,3 +634,119 @@ static int swapwriter_write_header_clean
 	return result;
 }
 
+/* ------------------------- HEADER READING ------------------------- */
+
+/*
+ * read_header_init()
+ * 
+ * Description:
+ * 1. Attempt to read the device specified with resume2=.
+ * 2. Check the contents of the swap header for our signature.
+ * 3. Warn, ignore, reset and/or continue as appropriate.
+ * 4. If continuing, read the swapwriter configuration section
+ *    of the header and set up block device info so we can read
+ *    the rest of the header & image.
+ *
+ * Returns:
+ * May not return if user choose to reboot at a warning.
+ * -EINVAL if cannot resume at this time. Booting should continue
+ * normally.
+ */
+
+static int swapwriter_read_header_init(void)
+{
+	int i;
+	
+	BUG_ON(!resume_block_device);
+	BUG_ON(!resume_dev_t);
+
+	suspend_header_bytes_used = 0;
+
+	suspend_writer_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+
+	BUG_ON(!suspend_writer_buffer);
+
+	if (!header_dev_t) {
+		printk("read_header_init called when we haven't "
+				"verified there is an image!\n");
+		return -EINVAL;
+	}
+
+	/* 
+	 * If the header is not on the resume_dev_t, get the resume device first.
+	 */
+	if (header_dev_t != resume_dev_t) {
+		header_block_device = open_bdev(MAX_SWAPFILES + 1,
+				header_dev_t);
+
+		if (IS_ERR(header_block_device))
+			return PTR_ERR(header_block_device);
+	} else
+		header_block_device = resume_block_device;
+
+	/* 
+	 * Read swapwriter configuration.
+	 * Headerblock size taken into account already.
+	 */
+	suspend_bio_ops.bdev_page_io(READ, header_block_device,
+			headerblock << 3,
+			virt_to_page((unsigned long) suspend_writer_buffer));
+	
+	memcpy(&suspend_writer_posn_save, suspend_writer_buffer, 3 * sizeof(struct extent_iterate_saved_state));
+	
+	suspend_writer_buffer_posn = 3 * sizeof(struct extent_iterate_saved_state);
+	suspend_header_bytes_used += 3 * sizeof(struct extent_iterate_saved_state);
+	
+	memcpy(&devinfo, suspend_writer_buffer + suspend_writer_buffer_posn, sizeof(devinfo));
+	
+	suspend_writer_buffer_posn += sizeof(devinfo);
+	suspend_header_bytes_used += sizeof(devinfo);
+
+	/* Restore device info */
+	for (i = 0; i < MAX_SWAPFILES; i++) {
+		dev_t thisdevice = devinfo[i].dev_t;
+		struct block_device *result;
+
+		devinfo[i].bdev = NULL;
+
+		if (!thisdevice)
+			continue;
+
+		if (thisdevice == resume_dev_t) {
+			devinfo[i].bdev = resume_block_device;
+			bdev_info_list[i] = bdev_info_list[MAX_SWAPFILES];
+			BUG_ON(!bdev_info_list[i]);
+			bdev_info_list[MAX_SWAPFILES] = NULL;
+			continue;
+		}
+
+		if (thisdevice == header_dev_t) {
+			devinfo[i].bdev = header_block_device;
+			bdev_info_list[i] = bdev_info_list[MAX_SWAPFILES + 1];
+			BUG_ON(!bdev_info_list[i]);
+			bdev_info_list[MAX_SWAPFILES + 1] = NULL;
+			continue;
+		}
+
+		result = open_bdev(i, thisdevice);
+		if (IS_ERR(result)) {
+			close_bdevs();
+			return PTR_ERR(result);
+		}
+	}
+
+	suspend_extent_state_goto_start(&suspend_writer_posn);
+	suspend_bio_ops.set_extra_page_forward();
+
+	for (i = 0; i < MAX_SWAPFILES; i++)
+		suspend_load_extent_chain(&block_chain[i]);
+
+	return 0;
+}
+
+static int swapwriter_read_header_cleanup(void)
+{
+	free_page((unsigned long) suspend_writer_buffer);
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

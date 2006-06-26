Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933301AbWFZW4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933301AbWFZW4Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933295AbWFZWk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:40:29 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:27319 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933294AbWFZWkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:09 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 19/35] [Suspend2] Filewriter header reading initialisation.
Date: Tue, 27 Jun 2006 08:40:07 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224006.4685.9113.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shared initialisation when reading a filewriter image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   62 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 1dd082f..da50422 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -594,3 +594,65 @@ static int file_init(void)
 	return 0;
 }
 
+/*
+ * read_header_init()
+ * 
+ * Ramdisk support based heavily on init/do_mounts_rd.c
+ *
+ * Description:
+ * 1. Attempt to read the device specified with resume2=.
+ * 2. Check the contents of the header for our signature.
+ * 3. Warn, ignore, reset and/or continue as appropriate.
+ * 4. If continuing, read the filewriter configuration section
+ *    of the header and set up block device info so we can read
+ *    the rest of the header & image.
+ *
+ * Returns:
+ * May not return if user choose to reboot at a warning.
+ * -EINVAL if cannot resume at this time. Booting should continue
+ * normally.
+ */
+
+static int filewriter_read_header_init(void)
+{
+	int result;
+	struct block_device *tmp;
+
+	suspend_writer_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	
+	if (test_suspend_state(SUSPEND_TRY_RESUME_RD))
+		result = rd_init();
+	else
+		result = file_init();
+	
+	if (result) {
+		printk("Filewriter read header init: Failed to initialise "
+				"reading the first page of data.\n");
+		return result;
+	}
+
+	memcpy(&suspend_writer_posn_save,
+	       suspend_writer_buffer + suspend_writer_buffer_posn,
+	       sizeof(suspend_writer_posn_save));
+	
+	suspend_writer_buffer_posn += sizeof(suspend_writer_posn_save);
+
+	tmp = devinfo.bdev;
+
+	memcpy(&devinfo,
+	       suspend_writer_buffer + suspend_writer_buffer_posn,
+	       sizeof(devinfo));
+
+	devinfo.bdev = tmp;
+	suspend_writer_buffer_posn += sizeof(devinfo);
+
+	suspend_extent_state_goto_start(&suspend_writer_posn);
+	suspend_bio_ops.set_extra_page_forward();
+
+	suspend_header_bytes_used = suspend_writer_buffer_posn;
+
+	suspend_load_extent_chain(&block_chain);
+	
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

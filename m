Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933273AbWFZWmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933273AbWFZWmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933339AbWFZWmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:11 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:48311 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933340AbWFZWmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 16/28] [Suspend2] Initialise/cleanup writing the header.
Date: Tue, 27 Jun 2006 08:42:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224159.4975.15477.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialisation and cleanup routines used when writing the image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   89 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index efd08ca..b005f8b 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -545,3 +545,92 @@ static int swapwriter_allocate_storage(i
 	return result;
 }
 
+static int swapwriter_write_header_init(void)
+{
+	int i, result;
+	struct swap_info_struct *si;
+
+	suspend_header_bytes_used = 0;
+	
+	suspend_extent_state_goto_start(&suspend_writer_posn);
+	/* Forward one page will be done prior to the read */
+
+	for (i = 0; i < MAX_SWAPFILES; i++) {
+		si = get_swap_info_struct(i);
+		if (si->swap_file)
+			devinfo[i].dev_t = si->bdev->bd_dev;
+		else
+			devinfo[i].dev_t = (dev_t) 0;
+	}
+
+	suspend_writer_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	if (!suspend_writer_buffer) {
+		printk("Failed to get swapwriter buffer.\n");
+		return -ENOMEM;
+	}
+
+	suspend_writer_buffer_posn = 0;
+
+	/* Info needed to bootstrap goes at the start of the header.
+	 * First we save the positions and devinfo, including the number
+	 * of header pages. Then we save the structs containing data needed
+	 * for reading the header pages back.
+	 * Note that even if header pages take more than one page, when we
+	 * read back the info, we will have restored the location of the
+	 * next header page by the time we go to use it.
+	 */
+
+	if ((result = suspend_bio_ops.rw_header_chunk(WRITE,
+			&swapwriterops,
+			(char *) &suspend_writer_posn_save, 
+			sizeof(suspend_writer_posn_save))))
+		return result;
+
+	if ((result = suspend_bio_ops.rw_header_chunk(WRITE,
+			&swapwriterops,
+			(char *) &devinfo, sizeof(devinfo))))
+		return result;
+
+	for (i=0; i < MAX_SWAPFILES; i++)
+		suspend_serialise_extent_chain(&swapwriterops, &block_chain[i]);
+
+	return 0;
+}
+
+static int swapwriter_write_header_cleanup(void)
+{
+	int result;
+	struct swap_info_struct *si;
+
+	/* Write any unsaved data */
+	if (suspend_writer_buffer_posn)
+		suspend_bio_ops.write_header_chunk_finish();
+
+	suspend_bio_ops.finish_all_io();
+
+	suspend_extent_state_goto_start(&suspend_writer_posn);
+	suspend_bio_ops.forward_one_page();
+
+	/* Adjust swap header */
+	suspend_bio_ops.bdev_page_io(READ, resume_block_device,
+			resume_firstblock,
+			virt_to_page(suspend_writer_buffer));
+
+	si = get_swap_info_struct(suspend_writer_posn.current_chain);
+	result = prepare_signature(si->bdev->bd_dev,
+			suspend_writer_posn.current_offset,
+		((union swap_header *) suspend_writer_buffer)->magic.magic);
+		
+	if (!result)
+		suspend_bio_ops.bdev_page_io(WRITE, resume_block_device,
+			resume_firstblock,
+			virt_to_page(suspend_writer_buffer));
+
+	free_page((unsigned long) suspend_writer_buffer);
+	suspend_writer_buffer = NULL;
+	
+	suspend_bio_ops.finish_all_io();
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

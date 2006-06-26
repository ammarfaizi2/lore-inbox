Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933253AbWFZXBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253AbWFZXBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933280AbWFZXAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:00:24 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:25783 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933253AbWFZWj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:59 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 16/35] [Suspend2] Filewriter header writing init/cleanup.
Date: Tue, 27 Jun 2006 08:39:57 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223956.4685.8862.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialisation and cleanup routines for writing the image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   64 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index cdc0261..46527f1 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -480,3 +480,67 @@ static int filewriter_allocate_storage(i
 	return result;
 }
 
+static int filewriter_write_header_init(void)
+{
+	suspend_extent_state_goto_start(&suspend_writer_posn);
+
+	suspend_writer_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	suspend_writer_buffer_posn = suspend_header_bytes_used = 0;
+
+	/* Info needed to bootstrap goes at the start of the header.
+	 * First we save the basic info needed for reading, including the number
+	 * of header pages. Then we save the structs containing data needed
+	 * for reading the header pages back.
+	 * Note that even if header pages take more than one page, when we
+	 * read back the info, we will have restored the location of the
+	 * next header page by the time we go to use it.
+	 */
+
+	suspend_bio_ops.rw_header_chunk(WRITE, &filewriterops,
+			(char *) &suspend_writer_posn_save, 
+			sizeof(suspend_writer_posn_save));
+
+	suspend_bio_ops.rw_header_chunk(WRITE, &filewriterops,
+			(char *) &devinfo, sizeof(devinfo));
+
+	suspend_serialise_extent_chain(&filewriterops, &block_chain);
+	
+	return 0;
+}
+
+static int filewriter_write_header_cleanup(void)
+{
+	struct filewriter_header *header;
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
+	/* Adjust image header */
+	suspend_bio_ops.bdev_page_io(READ, filewriter_target_bdev,
+			target_firstblock,
+			virt_to_page(suspend_writer_buffer));
+
+	header = (struct filewriter_header *) suspend_writer_buffer;
+
+	prepare_signature(header,
+			suspend_writer_posn.current_offset <<
+			devinfo.bmap_shift);
+		
+	suspend_bio_ops.bdev_page_io(WRITE, filewriter_target_bdev,
+			target_firstblock,
+			virt_to_page(suspend_writer_buffer));
+
+	free_page((unsigned long) suspend_writer_buffer);
+	suspend_writer_buffer = NULL;
+	
+	suspend_bio_ops.finish_all_io();
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

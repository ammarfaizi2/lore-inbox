Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933229AbWFZWiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933229AbWFZWiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933243AbWFZWiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:19 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:60831 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933229AbWFZWh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:59 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 14/32] [Suspend2] Submit io on a page.
Date: Tue, 27 Jun 2006 08:37:57 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223754.4376.9056.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given a struct io_info, allocate and populate a struct bio for the page,
link it to the struct io_info and submit the i/o.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   51 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 288718c..4d489f4 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -463,3 +463,54 @@ static int suspend_end_bio(struct bio *b
 	return 0;
 }
 
+/**
+ *	submit - submit BIO request.
+ *	@rw:	READ or WRITE.
+ *	@io_info: IO info structure.
+ *
+ * 	Based on Patrick's pmdisk code from long ago:
+ *	"Straight from the textbook - allocate and initialize the bio.
+ *	If we're writing, make sure the page is marked as dirty.
+ *	Then submit it and carry on."
+ *
+ *	With a twist, though - we handle block_size != PAGE_SIZE.
+ *	Caller has already checked that our page is not fragmented.
+ */
+
+static int submit(int rw, struct io_info *io_info)
+{
+	int error = 0;
+	struct bio *bio = NULL;
+	unsigned long flags;
+
+	while (!bio) {
+		bio = bio_alloc(GFP_ATOMIC,1);
+		if (!bio)
+			do_bio_wait(4);
+	}
+
+	bio->bi_bdev = io_info->dev;
+	bio->bi_sector = io_info->block[0];
+	bio->bi_private = io_info;
+	bio->bi_end_io = suspend_end_bio;
+	io_info->sys_struct = bio;
+
+	if (bio_add_page(bio, io_info->buffer_page, PAGE_SIZE, 0) < PAGE_SIZE) {
+		printk("ERROR: adding page to bio at %lld\n",
+				(unsigned long long) io_info->block[0]);
+		bio_put(bio);
+		return -EFAULT;
+	}
+
+	if (rw == WRITE)
+		bio_set_pages_dirty(bio);
+
+	spin_lock_irqsave(&ioinfo_busy_lock, flags);
+	list_add_tail(&io_info->list, &ioinfo_busy);
+	spin_unlock_irqrestore(&ioinfo_busy_lock, flags);
+	
+	submit_bio(rw,bio);
+
+	return error;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

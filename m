Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933248AbWFZXP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933248AbWFZXP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933252AbWFZXPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:15:07 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:62879 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933227AbWFZWiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:13 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 18/32] [Suspend2] Prepare to do i/o on a page.
Date: Tue, 27 Jun 2006 08:38:12 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223810.4376.40313.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to do i/o on a page, either directly submitting the resulting
io_info struct, or adding it to a batch.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   90 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 48a2d09..0d01483 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -632,3 +632,93 @@ static struct io_info *get_io_info_struc
 	return this;
 }
 
+/*
+ * start_one
+ *
+ * Description:	Prepare and start a read or write operation.
+ * 		Note that we use our own buffer for reading or writing.
+ * 		This simplifies doing readahead and asynchronous writing.
+ * 		We can begin a read without knowing the location into which
+ * 		the data will eventually be placed, and the buffer passed
+ * 		for a write can be reused immediately (essential for the
+ * 		modules system).
+ * 		Failure? What's that?
+ * Returns:	The io_info struct created.
+ */
+static struct io_info *start_one(int rw, struct submit_params *submit_info)
+{
+	struct io_info *io_info = get_io_info_struct();
+	unsigned long buffer_virt = 0;
+	char *to, *from;
+	struct page *buffer_page;
+
+	if (!io_info)
+		return NULL;
+
+	/* Get our local buffer */
+	suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 1,
+			"Start_IO: [%p]", io_info);
+	
+	/* Copy settings to the io_info struct */
+	io_info->data_page = submit_info->page;
+	io_info->readahead_index = submit_info->readahead_index;
+
+	if (io_info->readahead_index == -1) {
+		while (!(buffer_virt = get_zeroed_page(GFP_ATOMIC)))
+			do_bio_wait(5);
+
+		atomic_inc(&buffer_allocs);
+		suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 0,
+				"[ALLOC BUFFER]->%d",
+				real_nr_free_pages());
+		buffer_page = virt_to_page(buffer_virt);
+	
+		io_info->buffer_page = buffer_page;
+	} else {
+		unsigned long flags;
+		int index = io_info->readahead_index / BITS_PER_LONG;
+		int bit = io_info->readahead_index - index * BITS_PER_LONG;
+
+		spin_lock_irqsave(&suspend_readahead_flags_lock, flags);
+		clear_bit(bit, &suspend_readahead_flags[index]);
+		spin_unlock_irqrestore(&suspend_readahead_flags_lock, flags);
+
+		io_info->buffer_page = buffer_page = submit_info->page;
+	}
+
+	/* If writing, copy our data. The data is probably in
+	 * lowmem, but we cannot be certain. If there is no
+	 * compression/encryption, we might be passed the
+	 * actual source page's address. */
+	if (rw == WRITE) {
+		to = (char *) buffer_virt;
+		from = kmap_atomic(io_info->data_page, KM_USER1);
+		memcpy(to, from, PAGE_SIZE);
+		kunmap_atomic(from, KM_USER1);
+	}
+
+	/* Submit the page */
+	get_page(buffer_page);
+	
+	io_info->dev = submit_info->dev;
+	io_info->block[0] = submit_info->block[0];
+
+	if (rw == READ)
+		set_bit(IO_AWAITING_READ, &io_info->flags);
+
+	suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 1,
+			"-> (PRE BRW) %d\n",
+			real_nr_free_pages());
+
+	if (submit_batch_size > 1)
+		add_to_batch(io_info);
+	else
+	 	submit(rw, io_info);
+	
+	atomic_inc(&outstanding_io);
+	if (atomic_read(&outstanding_io) > max_outstanding_io)
+		max_outstanding_io++;
+	
+	return io_info;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

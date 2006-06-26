Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933241AbWFZWiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241AbWFZWiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933227AbWFZWhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:37:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:56223 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933224AbWFZWh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:26 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/32] [Suspend2] Cleanup one page.
Date: Tue, 27 Jun 2006 08:37:24 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223722.4376.34259.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up upon completion of the I/O for a page.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   96 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 09682c4..037535b 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -179,3 +179,99 @@ static void suspend_check_io_stats(void)
 			nr_schedule_calls[i]);
 }
 
+/*
+ * __suspend_bio_cleanup_one
+ * 
+ * Description: Clean up after completing I/O on a page.
+ * Arguments:	struct io_info:	Data for I/O to be completed.
+ */
+static void __suspend_bio_cleanup_one(struct io_info *io_info)
+{
+	struct page *buffer_page;
+	struct page *data_page;
+	char *buffer_address, *data_address;
+	int reading;
+
+	buffer_page = io_info->buffer_page;
+	data_page = io_info->data_page;
+
+	reading = test_bit(IO_AWAITING_READ, &io_info->flags);
+	suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 0,
+		"Cleanup IO: [%p]\n", 
+		io_info);
+
+	if (reading && io_info->readahead_index == -1) {
+		/*
+		 * Copy the page we read into the buffer our caller provided.
+		 */
+		data_address = (char *) kmap(data_page);
+		buffer_address = (char *) kmap(buffer_page);
+		memcpy(data_address, buffer_address, PAGE_SIZE);
+		kunmap(data_page);
+		kunmap(buffer_page);
+	
+	}
+
+	if (!reading || io_info->readahead_index == -1) {
+		/* Sanity check */
+		if (page_count(buffer_page) != 2)
+			printk(KERN_EMERG "Cleanup IO: Page count on page %p"
+					" is %d. Not good!\n",
+					buffer_page, page_count(buffer_page));
+		put_page(buffer_page);
+		__free_page(buffer_page);
+		atomic_inc(&buffer_frees);
+	} else
+		put_page(buffer_page);
+	
+	bio_put(io_info->sys_struct);
+	io_info->sys_struct = NULL;
+	io_info->flags = 0;
+}
+
+/* suspend_bio_cleanup_one
+ */
+
+static int suspend_bio_cleanup_one(void *data)
+{
+	struct io_info *io_info = (struct io_info *) data;
+	int readahead_index;
+	unsigned long flags;
+
+	/*
+	 * If this I/O was a readahead, remember its index.
+	 */
+	readahead_index = io_info->readahead_index;
+
+	/*
+	 * Add it to the free list.
+	 */
+	list_del_init(&io_info->list);
+	
+	/*
+	 * Do the cleanup.
+	 */
+	__suspend_bio_cleanup_one(io_info);
+
+	/*
+	 * Record the readahead as done.
+	 */
+	if (readahead_index > -1) {
+		int index = readahead_index/BITS_PER_LONG;
+		int bit = readahead_index - (index * BITS_PER_LONG);
+		spin_lock_irqsave(&suspend_readahead_flags_lock, flags);
+		set_bit(bit, &suspend_readahead_flags[index]);
+		spin_unlock_irqrestore(&suspend_readahead_flags_lock, flags);
+	}
+
+	spin_lock_irqsave(&ioinfo_free_lock, flags);
+	list_add_tail(&io_info->list, &ioinfo_free);
+	spin_unlock_irqrestore(&ioinfo_free_lock, flags);
+	
+	/* Important: Must be last thing we do to avoid a race with
+	 * finish_all_io when using keventd to do the cleanup */
+	atomic_dec(&outstanding_io);
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWFZXK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWFZXK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933255AbWFZWi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:59 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:1440 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933247AbWFZWil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 26/32] [Suspend2] Read a page of the image.
Date: Tue, 27 Jun 2006 08:38:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223838.4376.47773.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read a page of the image, using readahead if synchronous i/o is requested.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   63 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index c746f9f..c095eac 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -856,3 +856,66 @@ static int suspend_rw_page(int rw, struc
 	return 0;
 }
 
+static int suspend_bio_read_chunk(struct page *buffer_page, int sync)
+{
+	static int last_result;
+	unsigned long *virt;
+
+	if (sync == SUSPEND_ASYNC)
+		return suspend_rw_page(READ, buffer_page, -1, sync, 0);
+
+	/* Start new readahead while we wait for our page */
+	if (readahead_index == -1) {
+		last_result = 0;
+		readahead_index = readahead_submit_index = 0;
+	}
+
+	/* Start a new readahead? */
+	if (last_result) {
+		/* We failed to submit a read, and have cleaned up
+		 * all the readahead previously submitted */
+		if (readahead_submit_index == readahead_index)
+			return -EPERM;
+		goto wait;
+	}
+	
+	do {
+		if (suspend_prepare_readahead(readahead_submit_index))
+			break;
+
+		last_result = suspend_rw_page(
+			READ,
+			suspend_readahead_pages[readahead_submit_index], 
+			readahead_submit_index, SUSPEND_ASYNC, 0);
+		if (last_result) {
+			printk("Begin read chunk for page %d returned %d.\n",
+				readahead_submit_index, last_result);
+			suspend_cleanup_readahead(readahead_submit_index);
+			break;
+		}
+
+		readahead_submit_index++;
+
+		if (readahead_submit_index == MAX_OUTSTANDING_IO)
+			readahead_submit_index = 0;
+
+	} while((!last_result) && (readahead_submit_index != readahead_index) &&
+			(!suspend_readahead_ready(readahead_index)));
+
+wait:
+	suspend_wait_on_readahead(readahead_index);
+
+	virt = kmap_atomic(buffer_page, KM_USER1);
+	memcpy(virt, page_address(suspend_readahead_pages[readahead_index]),
+			PAGE_SIZE);
+	kunmap_atomic(virt, KM_USER1);
+
+	suspend_cleanup_readahead(readahead_index);
+
+	readahead_index++;
+	if (readahead_index == MAX_OUTSTANDING_IO)
+		readahead_index = 0;
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

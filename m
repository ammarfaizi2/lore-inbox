Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933277AbWFZWjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277AbWFZWjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933264AbWFZWjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:12 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:15543 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933248AbWFZWiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 29/32] [Suspend2] Read or write a chunk of the header.
Date: Tue, 27 Jun 2006 08:38:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223848.4376.4607.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submit a buffer with data to write, or a buffer to be filled. In contrast
to the functions for the main portion of the image, the buffer is normally
less than a full page.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   67 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index f881fc7..e822b19 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -961,3 +961,70 @@ static int suspend_write_chunk(struct pa
 	return suspend_rw_page(WRITE, buffer_page, -1, 0, 0);
 }
 
+static int suspend_rw_header_chunk(int rw, struct suspend_module_ops *owner,
+		char *buffer, int buffer_size)
+{
+	int bytes_left = buffer_size;
+	
+	if (owner) {
+		owner->header_used += buffer_size;
+		if (owner->header_used > owner->header_requested) {
+			printk(KERN_EMERG "Suspend2 module %s is using more"
+				"header space (%lu) than it requested (%lu).\n",
+				owner->name,
+				owner->header_used,
+				owner->header_requested);
+			BUG();
+		}
+	}
+
+	/* Read a chunk of the header */
+	while (bytes_left) {
+		char *source_start = buffer + buffer_size - bytes_left;
+		char *dest_start = suspend_writer_buffer + suspend_writer_buffer_posn;
+		int capacity = PAGE_SIZE - suspend_writer_buffer_posn;
+		char *to = rw ? dest_start : source_start;
+		char *from = rw ? source_start : dest_start;
+
+		if (bytes_left <= capacity) {
+			if (test_debug_state(SUSPEND_HEADER))
+				printk("Copy %d bytes %d-%d from %p to %p.\n",
+						bytes_left,
+						suspend_header_bytes_used,
+						suspend_header_bytes_used + bytes_left,
+						from, to);
+			memcpy(to, from, bytes_left);
+			suspend_writer_buffer_posn += bytes_left;
+			suspend_header_bytes_used += bytes_left;
+			return rw ? 0 : buffer_size;
+		}
+
+		/* Next to read the next page */
+		if (test_debug_state(SUSPEND_HEADER))
+			printk("Copy %d bytes (%d-%d) from %p to %p.\n",
+					capacity,
+					suspend_header_bytes_used,
+					suspend_header_bytes_used + capacity,
+					from, to);
+		memcpy(to, from, capacity);
+		bytes_left -= capacity;
+		suspend_header_bytes_used += capacity;
+
+		if (rw == READ && test_suspend_state(SUSPEND_TRY_RESUME_RD))
+			sys_read(suspend_read_fd,
+				suspend_writer_buffer, BLOCK_SIZE);
+		else {
+			if (suspend_rw_page(rw,
+					virt_to_page(suspend_writer_buffer),
+					-1, !rw,
+					test_debug_state(SUSPEND_HEADER)))
+				return -EIO;
+		}
+
+		suspend_writer_buffer_posn = 0;
+		suspend_cond_pause(0, NULL);
+	}
+
+	return rw ? 0 : buffer_size;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

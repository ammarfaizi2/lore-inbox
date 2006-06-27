Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWF0FOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWF0FOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933396AbWF0Ehm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:42 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:22742 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933392AbWF0Ehf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:35 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/13] [Suspend2] Compression write routines.
Date: Tue, 27 Jun 2006 14:37:34 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043732.14320.33665.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines used in compressing pages and passing them to the next module.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   87 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 44d46be..db3bca3 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -188,3 +188,90 @@ static int suspend_compress_rw_init(int 
 	return 0;
 }
 
+/* 
+ * suspend_compress_write()
+ * @u8*:		Output buffer to be written.
+ * @unsigned int:	Length of buffer.
+ *
+ * Helper function for write_chunk. Write the compressed data.
+ * Return: Int.	Result to be passed back to caller.
+ */
+static int suspend_compress_write (u8 *buffer, unsigned int len)
+{
+	int ret;
+
+	bytes_out += len;
+
+	while (len + bufofs > PAGE_SIZE) {
+		unsigned int chunk = PAGE_SIZE - bufofs;
+		memcpy (local_buffer + bufofs, buffer, chunk);
+		buffer += chunk;
+		len -= chunk;
+		bufofs = 0;
+		if ((ret = next_driver->write_chunk(virt_to_page(local_buffer))) < 0)
+			return ret;
+	}
+	memcpy (local_buffer + bufofs, buffer, len);
+	bufofs += len;
+	return 0;
+}
+
+/* 
+ * suspend_compress_write_chunk()
+ *
+ * Compress a page of data, buffering output and passing on filled
+ * pages to the next module in the pipeline.
+ * 
+ * Buffer_page:	Pointer to a buffer of size PAGE_SIZE, containing
+ * data to be compressed.
+ *
+ * Returns:	0 on success. Otherwise the error is that returned by later
+ * 		modules, -ECHILD if we have a broken pipeline or -EIO if
+ * 		zlib errs.
+ */
+static int suspend_compress_write_chunk(struct page *buffer_page)
+{
+	int ret; 
+	unsigned int len;
+	u16 len_written;
+	char *buffer_start;
+	
+	if (!suspend_compressor_transform)
+		return next_driver->write_chunk(buffer_page);
+
+	buffer_start = kmap(buffer_page);
+
+	bytes_in += PAGE_SIZE;
+
+	len = PAGE_SIZE;
+
+	ret = crypto_comp_compress(suspend_compressor_transform,
+			buffer_start, PAGE_SIZE,
+			page_buffer, &len);
+	
+	if (ret) {
+		printk("Compression failed.\n");
+		goto failure;
+	}
+	
+	len_written = (u16) len;
+		
+	if ((ret = suspend_compress_write((u8 *)&len_written, 2)) >= 0) {
+		if ((ret = suspend_compress_write((u8 *) &position, sizeof(position))))
+			return -EIO;
+		if (len < PAGE_SIZE) { /* some compression */
+			position += len;
+			ret = suspend_compress_write(page_buffer, len);
+		} else {
+			ret = suspend_compress_write(buffer_start, PAGE_SIZE);
+			position += PAGE_SIZE;
+		}
+	}
+	position += 2 + sizeof(int);
+
+
+failure:
+	kunmap(buffer_page);
+	return ret;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

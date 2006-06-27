Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933395AbWF0Ehl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933395AbWF0Ehl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933394AbWF0Ehl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:41 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:23254 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933393AbWF0Ehj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:39 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/13] [Suspend2] Compression read routines.
Date: Tue, 27 Jun 2006 14:37:37 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043736.14320.18159.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines used to obtain data from the next module, decompress it and return
a page full to the caller.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |  100 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index db3bca3..5193423 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -275,3 +275,103 @@ failure:
 	return ret;
 }
 
+/* 
+ * suspend_compress_read()
+ * @buffer: u8 *. Address of the buffer.
+ * @len: unsigned int. Length.
+ *
+ * Description:	Read data into compression buffer.
+ * Returns:	int:		Result of reading the image chunk.
+ */
+static int suspend_compress_read (u8 *buffer, unsigned int len)
+{
+	int ret;
+
+	while (len + bufofs > PAGE_SIZE) {
+		unsigned int chunk = PAGE_SIZE - bufofs;
+		memcpy(buffer, local_buffer + bufofs, chunk);
+		buffer += chunk;
+		len -= chunk;
+		bufofs = 0;
+		if ((ret = next_driver->read_chunk(
+				virt_to_page(local_buffer), SUSPEND_SYNC)) < 0) {
+			return ret;
+		}
+	}
+	memcpy (buffer, local_buffer + bufofs, len);
+	bufofs += len;
+	return 0;
+}
+
+/* 
+ * suspend_compress_read_chunk()
+ * @buffer_page: struct page *. Pointer to a buffer of size PAGE_SIZE.
+ * @sync:	int. Whether the previous module (or core) wants its data synchronously.
+ *
+ * Retrieve data from later modules and decompress it until the input buffer
+ * is filled.
+ * Zero if successful. Error condition from me or from downstream on failure.
+ */
+static int suspend_compress_read_chunk(struct page *buffer_page, int sync)
+{
+	int ret, position_saved; 
+	unsigned int len;
+	u16 len_written;
+	char *buffer_start;
+
+	if (!suspend_compressor_transform)
+		return next_driver->read_chunk(buffer_page, SUSPEND_ASYNC);
+
+	/* 
+	 * All our reads must be synchronous - we can't decompress
+	 * data that hasn't been read yet.
+	 */
+
+	buffer_start = kmap(buffer_page);
+
+	if ((ret = suspend_compress_read ((u8 *)&len_written, 2)) >= 0) {
+		len = (unsigned int) len_written;
+		ret = suspend_compress_read((u8 *) &position_saved, sizeof(position_saved));
+		if (ret)
+			return ret;
+
+		if (position != position_saved) {
+			printk("Position saved (%d) != position I'm at now (%d).\n",
+					position_saved, position);
+			BUG_ON(1);
+		}
+		if (len >= PAGE_SIZE) { /* uncompressed */
+			ret = suspend_compress_read(buffer_start, PAGE_SIZE);
+			if (ret)
+				return ret;
+
+			position += PAGE_SIZE;
+		} else { /* compressed */
+			if ((ret = suspend_compress_read(page_buffer, len)) >= 0) {
+				int outlen = PAGE_SIZE;
+				/* Important note.
+				 *
+				 * For Deflate, decompression return values may represent
+				 * errors. Deflate complains when everything is alright, so
+				 * we ignore the errors unless the number of output bytes is
+				 * not PAGE_SIZE.
+				 */
+				crypto_comp_decompress(suspend_compressor_transform, 
+						page_buffer, len,
+						buffer_start, &outlen);
+				if (outlen != PAGE_SIZE) {
+					printk("Decompression yielded %d bytes instead of %ld.\n", outlen, PAGE_SIZE);
+					ret = -EIO;
+				} else
+					ret = 0;
+			}
+			position += len;
+		}
+		position += 2 + sizeof(int);
+	} else
+		printk("Compress_read returned %d.", ret);
+	kunmap(buffer_page);
+	return ret;
+}
+
+

--
Nigel Cunningham		nigel at suspend2 dot net

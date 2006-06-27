Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWF0FN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWF0FN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933392AbWF0Ehn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:43 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:22230 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933391AbWF0Ehc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:32 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/13] [Suspend2] Compression initialise & cleanup routines.
Date: Tue, 27 Jun 2006 14:37:30 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043729.14320.41284.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These routines handle the initialisation and cleanup for compression,
invoking the buffer allocation and cryptoapi setup routines.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 470644f..44d46be 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -129,3 +129,62 @@ static int suspend_compress_crypto_prepa
 	return 0;
 }
 
+/* 
+ * suspend_compress_write_cleanup(): Write unflushed data and free workspace.
+ * 
+ * Returns: Result of writing last page.
+ */
+static int suspend_compress_rw_cleanup(int rw)
+{
+	int ret = 0;
+	
+	if (rw == WRITE && suspend_compressor_transform)
+		ret = next_driver->write_chunk(virt_to_page(local_buffer));
+
+	suspend_compress_cleanup();
+	suspend_compress_free_local_buffer();
+
+	return ret;
+}
+
+/* 
+ * suspend_compress_rw_init()
+ * @stream_number:	Ignored.
+ *
+ * Allocate buffers and prepare to compress data.
+ * Returns: Zero on success, -ENOMEM if unable to vmalloc.
+ */
+static int suspend_compress_rw_init(int rw, int stream_number)
+{
+	int result;
+	
+	next_driver = suspend_get_next_filter(&suspend_compression_ops);
+
+	if (!next_driver) {
+		printk("Compression Driver: Argh! Nothing follows me in"
+				" the pipeline!");
+		return -ECHILD;
+	}
+
+	if ((result = suspend_compress_crypto_prepare() ||
+	     suspend_compression_ops.disabled))
+		return result;
+	
+	if ((result = suspend_compress_allocate_local_buffer()))
+		return result;
+
+	if (rw == READ)
+		bufofs = PAGE_SIZE;
+	else {
+		/* Only reset the stats if starting to write an image */
+		if (stream_number == 2)
+			bytes_in = bytes_out = 0;
+	
+		bufofs = 0;
+	}
+
+	position = 0;
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

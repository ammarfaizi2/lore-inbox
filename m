Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWF0FN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWF0FN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWF0Ehx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:53 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:24790 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030628AbWF0Eht
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:49 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/13] [Suspend2] Serialisation of compressor configuration in image header.
Date: Tue, 27 Jun 2006 14:37:47 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043746.14320.53907.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines for storing and reloading the compression configuration in an
image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index b8005c7..1398dc5 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -416,4 +416,47 @@ static unsigned long suspend_compress_st
 	return 4 * sizeof(unsigned long) + strlen(suspend_compressor_name) + 1;
 }
 
+/* 
+ * suspend_compress_save_config_info
+ * @buffer: Pointer to a buffer of size PAGE_SIZE.
+ *
+ * Save informaton needed when reloading the image at resume time.
+ * Returns: Number of bytes used for saving our data.
+ */
+static int suspend_compress_save_config_info(char *buffer)
+{
+	int namelen = strlen(suspend_compressor_name) + 1;
+	int total_len;
+	
+	*((unsigned long *) buffer) = bytes_in;
+	*((unsigned long *) (buffer + 1 * sizeof(unsigned long))) = bytes_out;
+	*((unsigned long *) (buffer + 2 * sizeof(unsigned long))) =
+		suspend_expected_compression;
+	*((unsigned long *) (buffer + 3 * sizeof(unsigned long))) = namelen;
+	strncpy(buffer + 4 * sizeof(unsigned long), suspend_compressor_name, 
+								namelen);
+	total_len = 4 * sizeof(unsigned long) + namelen;
+	return total_len;
+}
+
+/* suspend_compress_load_config_info
+ * @buffer: Pointer to the start of the data.
+ * @size: Number of bytes that were saved.
+ *
+ * Description:	Reload information needed for decompressing the image at
+ * resume time.
+ */
+static void suspend_compress_load_config_info(char *buffer, int size)
+{
+	int namelen;
+	
+	bytes_in = *((unsigned long *) buffer);
+	bytes_out = *((unsigned long *) (buffer + 1 * sizeof(unsigned long)));
+	suspend_expected_compression = *((unsigned long *) (buffer + 2 *
+				sizeof(unsigned long)));
+	namelen = *((unsigned long *) (buffer + 3 * sizeof(unsigned long)));
+	strncpy(suspend_compressor_name, buffer + 4 * sizeof(unsigned long),
+			namelen);
+	return;
+}
 

--
Nigel Cunningham		nigel at suspend2 dot net

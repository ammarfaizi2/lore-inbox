Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933389AbWF0EkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389AbWF0EkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWF0Eju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:50 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:29654 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030619AbWF0EiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:19 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/12] [Suspend2] Encrypt a page being written.
Date: Tue, 27 Jun 2006 14:38:17 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043816.14437.68373.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the routine that processes pages being written in the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   51 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index 98b0114..16a275b 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -125,11 +125,13 @@ static int suspend_encrypt_rw_prepare(in
 		return 1;
 	}
 
-	if (!(suspend_encryptor_transform = crypto_alloc_tfm(suspend_encryptor_name,
-					1 << suspend_encryptor_mode))) {
+	suspend_encryptor_transform = crypto_alloc_tfm(suspend_encryptor_name,
+					1 << suspend_encryptor_mode);
+	if (!suspend_encryptor_transform) {
 		printk("Suspend2: Failed to initialise the encryption "
 				"transform (%s, mode %d).\n",
 				suspend_encryptor_name, suspend_encryptor_mode);
+		suspend_encryption_ops.disabled = 1;
 		return 1;
 	}
 
@@ -157,3 +159,48 @@ static int suspend_encrypt_rw_prepare(in
 	return 0;
 }
 
+/* ---- Exported functions ---- */
+
+/* suspend_encrypt_write_chunk()
+ *
+ * Description:	Encrypt a page of data, buffering output and passing on
+ * 		filled pages to the next module in the pipeline.
+ * Arguments:	Buffer_page:	Pointer to a buffer of size PAGE_SIZE, 
+ * 				containing data to be encrypted.
+ * Returns:	0 on success. Otherwise the error is that returned by later
+ * 		modules, -ECHILD if we have a broken pipeline or -EIO if
+ * 		zlib errs.
+ */
+static int suspend_encrypt_write_chunk(struct page *buffer_page)
+{
+	int ret; 
+	unsigned int len;
+	u16 len_written;
+	char *buffer_start;
+	
+	if (!suspend_encryptor_transform)
+		return next_driver->write_chunk(buffer_page);
+
+	buffer_start = kmap(buffer_page);
+	memcpy(page_buffer, buffer_start, PAGE_SIZE);
+	kunmap(buffer_page);
+	
+	bytes_in += PAGE_SIZE;
+
+	len = PAGE_SIZE;
+
+	ret = crypto_cipher_encrypt(suspend_encryptor_transform,
+			suspend_crypt_sg, suspend_crypt_sg, PAGE_SIZE);
+	
+	if (ret) {
+		printk("Encryption failed.\n");
+		return -EIO;
+	}
+	
+	len_written = (u16) len;
+
+	ret = next_driver->write_chunk(virt_to_page(page_buffer));
+
+	return ret;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030670AbWF0Eiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030670AbWF0Eiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030662AbWF0Eip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:45 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30678 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030630AbWF0Ei0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:26 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/12] [Suspend2] Decrypt a page in the image.
Date: Tue, 27 Jun 2006 14:38:23 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043822.14437.47583.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for decrypting a page being read from the storage.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index 9b7dd93..cd26e84 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -238,3 +238,44 @@ static int suspend_encrypt_rw_init(int r
 	return 0;
 }
 
+/* suspend_encrypt_read_chunk()
+ *
+ * Description:	Retrieve data from later modules and deencrypt it until the
+ * 		input buffer is filled.
+ * Arguments:	Buffer_start: 	Pointer to a buffer of size PAGE_SIZE.
+ * 		Sync:		Whether the previous module (or core) wants its
+ * 				data synchronously.
+ * Returns:	Zero if successful. Error condition from me or from downstream
+ * 		on failure.
+ */
+static int suspend_encrypt_read_chunk(struct page *buffer_page, int sync)
+{
+	int ret; 
+	char *buffer_start;
+
+	if (!suspend_encryptor_transform)
+		return next_driver->read_chunk(buffer_page, sync);
+
+	/* 
+	 * All our reads must be synchronous - we can't deencrypt
+	 * data that hasn't been read yet.
+	 */
+
+	if ((ret = next_driver->read_chunk(
+			virt_to_page(page_buffer), SUSPEND_SYNC)) < 0) {
+		printk("Failed to read an encrypted block.\n");
+		return ret;
+	}
+
+	ret = crypto_cipher_decrypt(suspend_encryptor_transform,
+			suspend_crypt_sg, suspend_crypt_sg, PAGE_SIZE);
+
+	if (ret)
+		printk("Decrypt function returned %d.\n", ret);
+
+	buffer_start = kmap(buffer_page);
+	memcpy(buffer_start, page_buffer, PAGE_SIZE);
+	kunmap(buffer_page);
+	return ret;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

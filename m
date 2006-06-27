Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933312AbWF0EkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933312AbWF0EkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbWF0Ejv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:39:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:29142 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030651AbWF0EiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:15 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/12] [Suspend2] Encryption rw init & cleanup routines.
Date: Tue, 27 Jun 2006 14:38:14 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043812.14437.95293.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines for preparing to read or write an image, and cleaning up
afterwards.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   61 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index 45d325d..98b0114 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -96,3 +96,64 @@ static void free_local_buffer(void)
 	page_buffer = NULL;
 }
 
+/* suspend_encrypt_rw_cleanup
+ *
+ * Description:	Frees memory allocated for our labours.
+ */
+static int suspend_encrypt_rw_cleanup(int rw)
+{
+	if (suspend_encryptor_transform) {
+		crypto_free_tfm(suspend_encryptor_transform);
+		suspend_encryptor_transform = NULL;
+	}
+
+	free_local_buffer();
+
+	return 0;
+}
+
+/* suspend_crypto_prepare
+ *
+ * Description:	Prepare to do some work by allocating buffers and transforms.
+ * Returns:	Int: Zero if successful, 1 otherwise.
+ */
+static int suspend_encrypt_rw_prepare(int rw)
+{
+	if (!*suspend_encryptor_name) {
+		printk("Suspend2: Encryptor enabled but no name set.\n");
+		suspend_encryption_ops.disabled = 1;
+		return 1;
+	}
+
+	if (!(suspend_encryptor_transform = crypto_alloc_tfm(suspend_encryptor_name,
+					1 << suspend_encryptor_mode))) {
+		printk("Suspend2: Failed to initialise the encryption "
+				"transform (%s, mode %d).\n",
+				suspend_encryptor_name, suspend_encryptor_mode);
+		return 1;
+	}
+
+	if (rw == READ)
+		bufofs = PAGE_SIZE;
+	else
+		bufofs = 0;
+
+	suspend_key_len = strlen(suspend_encryptor_key);
+
+	if (crypto_cipher_setkey(suspend_encryptor_transform, suspend_encryptor_key, 
+				suspend_key_len)) {
+		printk("%d is an invalid key length for cipher %s.\n",
+					suspend_key_len,
+					suspend_encryptor_name);
+		return 1;
+	}
+	
+	if (rw != READ) {
+		crypto_cipher_set_iv(suspend_encryptor_transform,
+				suspend_encryptor_iv,
+				crypto_tfm_alg_ivsize(suspend_encryptor_transform));
+	}
+		
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

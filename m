Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030660AbWF0Eij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030660AbWF0Eij (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030663AbWF0Eij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:39 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32214 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030660AbWF0Eif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:35 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/12] [Suspend2] Encryption configuration serialisation.
Date: Tue, 27 Jun 2006 14:38:34 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043832.14437.73527.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines to read and write the encryption module configuration in an
image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   83 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index d12eb47..1664b82 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -316,4 +316,87 @@ static unsigned long suspend_encrypt_sto
 		 (4 + strlen(suspend_encryptor_key) +
 		  strlen(suspend_encryptor_iv)) : 0);
 }
+	
+/* suspend_encrypt_save_config_info
+ *
+ * Description:	Save informaton needed when reloading the image at resume time.
+ * Arguments:	Buffer:		Pointer to a buffer of size PAGE_SIZE.
+ * Returns:	Number of bytes used for saving our data.
+ */
+static int suspend_encrypt_save_config_info(char *buffer)
+{
+	int buf_offset, str_size;
 
+	str_size = strlen(suspend_encryptor_name);
+	*buffer = (char) str_size;
+	strncpy(buffer + 1, suspend_encryptor_name, str_size + 1);
+	buf_offset = str_size + 2;
+
+	*(buffer + buf_offset) = (char) suspend_encryptor_mode;
+	buf_offset++;
+
+	*(buffer + buf_offset) = (char) suspend_encryptor_save_key_and_iv;
+	buf_offset++;
+
+	if (suspend_encryptor_save_key_and_iv) {
+		
+		str_size = strlen(suspend_encryptor_key);
+		*(buffer + buf_offset) = (char) str_size;
+		strncpy(buffer + buf_offset + 1, suspend_encryptor_key, str_size + 1);
+
+		buf_offset+= str_size + 2;
+
+		str_size = strlen(suspend_encryptor_iv);
+		*(buffer + buf_offset) = (char) str_size;
+		strncpy(buffer + buf_offset + 1, suspend_encryptor_iv, str_size + 1);
+
+		buf_offset += str_size + 2;
+	}
+
+	return buf_offset;
+}
+
+/* suspend_encrypt_load_config_info
+ *
+ * Description:	Reload information needed for deencrypting the image at 
+ * 		resume time.
+ * Arguments:	Buffer:		Pointer to the start of the data.
+ *		Size:		Number of bytes that were saved.
+ */
+static void suspend_encrypt_load_config_info(char *buffer, int size)
+{
+	int buf_offset, str_size;
+
+	str_size = (int) *buffer;
+	strncpy(suspend_encryptor_name, buffer + 1, str_size + 1);
+	buf_offset = str_size + 2;
+	
+	suspend_encryptor_mode = (int) *(buffer + buf_offset);
+	buf_offset++;
+
+	suspend_encryptor_save_key_and_iv = (int) *(buffer + buf_offset);
+	buf_offset++;
+
+	if (suspend_encryptor_save_key_and_iv) {
+		str_size = (int) *(buffer + buf_offset);
+		strncpy(suspend_encryptor_key, buffer + buf_offset + 1, str_size + 1);
+
+		buf_offset+= str_size + 2;
+
+		str_size = (int) *(buffer + buf_offset);
+		strncpy(suspend_encryptor_iv, buffer + buf_offset + 1, str_size + 1);
+
+		buf_offset += str_size + 2;
+	} else {
+		*suspend_encryptor_key = 0;
+		*suspend_encryptor_iv = 0;
+	}
+	
+	if (buf_offset != size) {
+		printk("Suspend Encryptor config info size mismatch (%d != %d): settings ignored.\n",
+				buf_offset, size);
+		*suspend_encryptor_key = 0;
+		*suspend_encryptor_iv = 0;
+	}
+	return;
+}

--
Nigel Cunningham		nigel at suspend2 dot net

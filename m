Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030659AbWF0Eiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030659AbWF0Eiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030630AbWF0Eir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30166 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030647AbWF0EiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:21 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/12] [Suspend2] Prepare to encrypt or decrypt a stream of pages.
Date: Tue, 27 Jun 2006 14:38:20 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043819.14437.79032.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This routine adds initialisation code for encrypting or decrypting a stream
of pages in the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index 16a275b..9b7dd93 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -204,3 +204,37 @@ static int suspend_encrypt_write_chunk(s
 	return ret;
 }
 
+/* rw_init()
+ *
+ * Description:	Prepare to read a new stream of data.
+ * Arguments:	int: Section of image about to be read.
+ * Returns:	int: Zero on success, error number otherwise.
+ */
+static int suspend_encrypt_rw_init(int rw, int stream_number)
+{
+	int result;
+
+	next_driver = suspend_get_next_filter(&suspend_encryption_ops);
+
+	if (!next_driver) {
+		printk("Encryption Driver: Argh! I'm at the end of the pipeline!");
+		return -ECHILD;
+	}
+	
+	if ((result = suspend_encrypt_rw_prepare(rw))) {
+		set_result_state(SUSPEND_ENCRYPTION_SETUP_FAILED);
+		suspend_encrypt_rw_cleanup(rw);
+		return result;
+	}
+	
+	if ((result = allocate_local_buffer()))
+		return result;
+
+	if (rw == WRITE && stream_number == 2)
+		bytes_in = bytes_out = 0;
+	
+	bufofs = (rw == READ) ? PAGE_SIZE : 0;
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWF0FN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWF0FN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933394AbWF0Ehp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:45 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:21718 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933389AbWF0Eh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:28 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/13] [Suspend2] Compression cryptoapi initialisation and cleanup.
Date: Tue, 27 Jun 2006 14:37:27 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043726.14320.63837.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the routines for preparing cryptoapi for suspend2 use and cleaning it
up.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 3d222b3..470644f 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -92,3 +92,40 @@ static inline void suspend_compress_free
 	page_buffer = NULL;
 }
 
+/* 
+ * suspend_compress_cleanup
+ *
+ * Frees memory allocated for our labours.
+ */
+static void suspend_compress_cleanup(void)
+{
+	if (suspend_compressor_transform) {
+		crypto_free_tfm(suspend_compressor_transform);
+		suspend_compressor_transform = NULL;
+	}
+}
+
+/* 
+ * suspend_crypto_prepare
+ *
+ * Prepare to do some work by allocating buffers and transforms.
+ * Returns: Int: Zero. Even if we can't set up compression, we still
+ * seek to suspend.
+ */
+static int suspend_compress_crypto_prepare(void)
+{
+	if (!*suspend_compressor_name) {
+		printk("Suspend2: Compression enabled but no compressor name set.\n");
+		suspend_compression_ops.disabled = 1;
+		return 0;
+	}
+
+	if (!(suspend_compressor_transform = crypto_alloc_tfm(suspend_compressor_name, 0))) {
+		printk("Suspend2: Failed to initialise the %s compression transform.\n",
+				suspend_compressor_name);
+		return 1;
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030630AbWF0Ei4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030630AbWF0Ei4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbWF0EiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:19 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:28630 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030649AbWF0EiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/12] [Suspend2] Encryption buffer allocation.
Date: Tue, 27 Jun 2006 14:38:10 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043809.14437.61345.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for allocating and freeing buffers used for encryption.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   51 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index a90d3ca..45d325d 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -45,3 +45,54 @@ static unsigned int bufofs;
 
 static struct scatterlist suspend_crypt_sg[PAGE_SIZE/8];
        
+/* ---- Local buffer management ---- */
+
+/* allocate_local_buffer
+ *
+ * Description:	Allocates a page of memory for buffering output.
+ * Returns:	Int: Zero if successful, -ENONEM otherwise.
+ */
+static int allocate_local_buffer(void)
+{
+	if (!page_buffer) {
+		int i, remainder;
+		
+		page_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	
+		if (!page_buffer) {
+			printk(KERN_ERR
+				"Failed to allocate the page buffer for "
+				"suspend2 encryption driver.\n");
+			return -ENOMEM;
+		}
+
+		for (i=0; i < (PAGE_SIZE / suspend_key_len); i++) {
+			suspend_crypt_sg[i].page = virt_to_page(page_buffer);
+			suspend_crypt_sg[i].offset = suspend_key_len * i;
+			suspend_crypt_sg[i].length = suspend_key_len;
+		}
+		
+		remainder = PAGE_SIZE % suspend_key_len;
+
+		if (remainder) {
+			suspend_crypt_sg[i].page = virt_to_page(page_buffer);
+			suspend_crypt_sg[i].offset = suspend_key_len * i;
+			suspend_crypt_sg[i].length = remainder;
+		}
+	}
+
+	return 0;
+}
+
+/* free_local_buffer
+ *
+ * Description:	Frees memory allocated for buffering output.
+ */
+static void free_local_buffer(void)
+{
+	if (page_buffer)
+		free_page((unsigned long) page_buffer);
+
+	page_buffer = NULL;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

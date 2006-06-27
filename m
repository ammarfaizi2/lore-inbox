Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030625AbWF0Ehx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030625AbWF0Ehx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030624AbWF0Ehq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:46 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:21206 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933312AbWF0EhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:25 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/13] [Suspend2] Allocate compression buffers.
Date: Tue, 27 Jun 2006 14:37:24 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043722.14320.92176.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The compression module uses a couple of local buffers to cache partially
filled output pages, and to receive the cryptoapi output. These routines
are responsible for allocating and freeing those buffers.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   53 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 72075d7..3d222b3 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -39,3 +39,56 @@ static unsigned int bufofs;
 
 static int position = 0;
        
+/* ---- Local buffer management ---- */
+
+/* 
+ * suspend_compress_allocate_local_buffer
+ *
+ * Allocates a page of memory for buffering output.
+ * Int: Zero if successful, -ENONEM otherwise.
+ */
+static int suspend_compress_allocate_local_buffer(void)
+{
+	if (!local_buffer) {
+		local_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	
+		if (!local_buffer) {
+			printk(KERN_ERR
+				"Failed to allocate the local buffer for "
+				"suspend2 compression driver.\n");
+			return -ENOMEM;
+		}
+	}
+
+	if (!page_buffer) {
+		page_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	
+		if (!page_buffer) {
+			printk(KERN_ERR
+				"Failed to allocate the page buffer for "
+				"suspend2 compression driver.\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/* 
+ * suspend_compress_free_local_buffer
+ *
+ * Frees memory allocated for buffering output.
+ */
+static inline void suspend_compress_free_local_buffer(void)
+{
+	if (local_buffer)
+		free_page((unsigned long) local_buffer);
+
+	local_buffer = NULL;
+
+	if (page_buffer)
+		free_page((unsigned long) page_buffer);
+
+	page_buffer = NULL;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

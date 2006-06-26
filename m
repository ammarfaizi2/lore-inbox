Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933172AbWFZX11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbWFZX11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933182AbWFZWgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:04 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:42399 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933173AbWFZWfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:53 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 19/20] [Suspend2] Prepare an image.
Date: Tue, 27 Jun 2006 08:35:51 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223550.4050.47136.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to prepare everything for suspending. This section of the code does
most of the work - freezing processes, allocating storage, freeing memory
and so on. Once it is complete, we are either going to abort or jump
straight into writing the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   63 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 893ba72..10159e5 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -622,3 +622,66 @@ static int eat_memory(void)
 	return 0;
 }
 
+/* prepare_image
+ *
+ * Entry point to the whole image preparation section.
+ *
+ * We do four things:
+ * - Freeze processes;
+ * - Ensure image size constraints are met;
+ * - Complete all the preparation for saving the image,
+ *   including allocation of storage. The only memory
+ *   that should be needed when we're finished is that
+ *   for actually storing the image (and we know how
+ *   much is needed for that because the modules tell
+ *   us).
+ * - Make sure that all dirty buffers are written out.
+ */
+#define MAX_TRIES 4
+int suspend_prepare_image(void)
+{
+	int result = 1, tries = 0;
+
+	are_frozen = 0;
+
+	header_space_allocated = 0;
+
+	if (attempt_to_freeze())
+		return 1;
+
+	if (!extra_pd1_pages_allowance)
+		get_extra_pd1_allowance();
+
+	storage_available = suspend_active_writer->storage_available();
+
+	if (!storage_available) {
+		printk(KERN_ERR "You need some storage available to be able to suspend.\n");
+		set_result_state(SUSPEND_ABORTED);
+		set_result_state(SUSPEND_NOSTORAGE_AVAILABLE);
+		return 1;
+	}
+
+	do {
+		suspend_prepare_status(CLEAR_BAR, "Preparing Image.");
+	
+		if (eat_memory() || test_result_state(SUSPEND_ABORTED))
+			break;
+
+		result = update_image();
+
+		suspend_cond_pause(0, NULL);
+		
+		tries++;
+
+	} while ((result) && (tries < MAX_TRIES) && (!test_result_state(SUSPEND_ABORTED)) &&
+		(!test_result_state(SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY)));
+
+	if (tries == MAX_TRIES) {
+		abort_suspend("Unable to successfully prepare the image.\n");
+		display_stats(1, 0);
+	}
+
+	suspend_cond_pause(1, "Image preparation complete.");
+
+	return result;
+}

--
Nigel Cunningham		nigel at suspend2 dot net

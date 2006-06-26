Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933201AbWFZWgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201AbWFZWgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933192AbWFZWgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:20 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:39839 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933123AbWFZWfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:37 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 14/20] [Suspend2] Update the image.
Date: Tue, 27 Jun 2006 08:35:35 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223533.4050.88908.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recalculate what is needed in terms of storage and memory, and seek to
fulfil those allocations. The return value indicates whether all of the
prerequisites for moving on to writing the image have been met.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   89 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 4e012a7..a23722d 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -402,3 +402,92 @@ static void try_freeze_processes(void)
 	}
 }
 
+/* update_image
+ *
+ * Allocate [more] memory and storage for the image.
+ */
+static int update_image(void) 
+{ 
+	int result2, param_used;
+
+	suspend_recalculate_image_contents(0);
+
+	/* Include allowance for growth in pagedir1 while writing pagedir 2 */
+	if (suspend_allocate_extra_pagedir_memory(&pagedir1,
+		pagedir1.pageset_size + extra_pd1_pages_allowance,
+				pageset2_sizelow)) {
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_LOW, 1,
+			"Still need to get more pages for pagedir 1.\n");
+		return 1;
+	}
+
+	thaw_processes(FREEZER_KERNEL_THREADS);
+
+	param_used = main_storage_needed(1, 0);
+	if ((result2 = suspend_active_writer->allocate_storage(param_used))) {
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_LOW, 1,
+			"Allocate storage returned %d. Still need to get more"
+			" storage space for the image proper.\n",
+			result2);
+		storage_allocated = suspend_active_writer->storage_allocated();
+		try_freeze_processes();
+		return 1;
+	}
+
+	/* 
+	 * Allocate remaining storage space, if possible, up to the
+	 * maximum we know we'll need. It's okay to allocate the
+	 * maximum if the writer is the swapwriter, but
+	 * we don't want to grab all available space on an NFS share.
+	 * We therefore ignore the expected compression ratio here,
+	 * thereby trying to allocate the maximum image size we could
+	 * need (assuming compression doesn't expand the image), but
+	 * don't complain if we can't get the full amount we're after.
+	 */
+
+	suspend_active_writer->allocate_storage(
+		min(storage_available, main_storage_needed(0, 1)));
+
+	storage_allocated = suspend_active_writer->storage_allocated();
+
+	/* Allocate the header storage after allocating main storage
+	 * so that the overhead for metadata doesn't change the amount
+	 * of storage needed for the header itself.
+	 */
+
+	param_used = header_storage_needed();
+
+	result2 = suspend_active_writer->allocate_header_space(param_used);
+
+	try_freeze_processes();
+
+	if (result2) {
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_LOW, 1,
+			"Still need to get more storage space for header.\n");
+		return 1;
+	}
+
+	header_space_allocated = param_used;
+
+	suspend_recalculate_image_contents(0);
+
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_LOW, 1,
+		"Amount still needed (%d) > 0:%d. Header: %d < %d: %d,"
+		" Storage allocd: %d < %d + %d: %d.\n",
+			amount_needed(0),
+			(amount_needed(0) > 0),
+			header_space_allocated, header_storage_needed(),
+			header_space_allocated < header_storage_needed(),
+		 	storage_allocated,
+			header_storage_needed(), main_storage_needed(1, 1),
+			storage_allocated <
+			(header_storage_needed() + main_storage_needed(1, 1)));
+
+	suspend_cond_pause(0, NULL);
+
+	return ((amount_needed(0) > 0) ||
+		header_space_allocated < header_storage_needed() ||
+		 storage_allocated < 
+		 (header_storage_needed() + main_storage_needed(1, 1)));
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

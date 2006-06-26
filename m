Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933347AbWFZWsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbWFZWsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933333AbWFZWlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:50 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:41143 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933335AbWFZWll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/28] [Suspend2] Allocate swapwriter header space.
Date: Tue, 27 Jun 2006 08:41:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224138.4975.96144.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate space in the allocated storage for the header of the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 7f16bea..8e4221d 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -329,3 +329,34 @@ static int prepare_signature(dev_t bdev,
 	return 0;
 }
 
+static int swapwriter_allocate_storage(int space_requested);
+
+static int swapwriter_allocate_header_space(int space_requested)
+{
+	int i;
+
+	if (!swapextents.size)
+		swapwriter_allocate_storage(space_requested);
+
+	suspend_extent_state_goto_start(&suspend_writer_posn);
+	suspend_bio_ops.forward_one_page(); /* To first page */
+	
+	for (i = 0; i < space_requested; i++) {
+		if (suspend_bio_ops.forward_one_page()) {
+			printk("Out of space while seeking to allocate "
+					"header pages,\n");
+			header_pages_allocated = i;
+			return -ENOSPC;
+		}
+
+	}
+
+	header_pages_allocated = space_requested;
+
+	/* The end of header pages will be the start of pageset 2;
+	 * we are now sitting on the first pageset2 page. */
+	suspend_extent_state_save(&suspend_writer_posn,
+			&suspend_writer_posn_save[2]);
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

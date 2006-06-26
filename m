Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbWFZXeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWFZXeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWFZXeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:34:13 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:36255 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933152AbWFZWfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:12 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/20] [Suspend2] Display image vital statistics.
Date: Tue, 27 Jun 2006 08:35:10 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223509.4050.95237.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Display the vital statistics of the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 5070735..e54865a 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -133,3 +133,39 @@ static int header_storage_needed(void)
 	return ((int) ((bytes + (int) PAGE_SIZE - 1) >> PAGE_SHIFT));
 }
 
+static void display_stats(int always, int sub_extra_pd1_allow)
+{ 
+	char buffer[255];
+	snprintf(buffer, 254, 
+		"Free:%d(%d). Sets:%ld(%ld),%ld(%ld). Header:%d. Nosave:%d-%d=%d. Storage:%lu/%lu(%lu). Needed:%ld|%ld|%ld.\n", 
+		
+		/* Free */
+		nr_free_pages(),
+		nr_free_pages() - nr_free_highpages(),
+		
+		/* Sets */
+		pagedir1.pageset_size, pageset1_sizelow,
+		pagedir2.pageset_size, pageset2_sizelow,
+
+		/* Header */
+		header_storage_needed(),
+
+		/* Nosave */
+		num_nosave, extra_pagedir_pages_allocated,
+		num_nosave - extra_pagedir_pages_allocated,
+
+		/* Storage - converted to pages for comparison */
+		storage_allocated,
+		storage_needed(1, sub_extra_pd1_allow),
+		storage_available,
+
+		/* Needed */
+		ram_to_suspend() - nr_free_pages() - nr_free_highpages(),
+		storage_needed(1, sub_extra_pd1_allow) - storage_available, 
+		(image_size_limit > 0) ? (storage_needed(1, sub_extra_pd1_allow) - (image_size_limit << 8)) : 0);
+	if (always)
+		printk(buffer);
+	else
+		suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 1, buffer);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWFZXDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWFZXDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWFZXDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:03:40 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:25271 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933288AbWFZWjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 15/35] [Suspend2] Allocate filewriter storage.
Date: Tue, 27 Jun 2006 08:39:54 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223952.4685.22538.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate storage for the body of the image, preserving any existing
allocation for the header. This routine will never shrink the amount
allocated.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 6b04eb5..cdc0261 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -448,3 +448,35 @@ static int filewriter_allocate_header_sp
 	return 0;
 }
 
+static int filewriter_allocate_storage(int space_requested)
+{
+	int result = 0, prev_header_pages;
+	int blocks_to_get = (space_requested << devinfo.bmap_shift) -
+		block_chain.size;
+	
+	/* Only release_storage reduces the size */
+	if (blocks_to_get < 1)
+		return 0;
+
+	main_pages = space_requested;
+
+	populate_block_list();
+
+	suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+		"Finished with block_chain.size == %d.\n",
+		block_chain.size);
+
+	if (block_chain.size < (header_pages + main_pages)) {
+		printk("Block chain size (%d) < header pages (%d) + main pages (%d) (=%d).\n",
+				block_chain.size,
+				header_pages, main_pages,
+				header_pages + main_pages);
+		result = -ENOSPC;
+	}
+
+	prev_header_pages = header_pages;
+	header_pages = 0;
+	filewriter_allocate_header_space(prev_header_pages);
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

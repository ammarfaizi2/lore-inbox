Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933298AbWFZWkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298AbWFZWkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933296AbWFZWkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:40:21 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:28343 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933278AbWFZWkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:16 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 21/35] [Suspend2] Make modifications to the filewriter signature.
Date: Tue, 27 Jun 2006 08:40:15 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224013.4685.28953.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for invalidating an image or marking that we've attempted
to resume from the image before.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   51 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 8e4431c..4df05c8 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -663,3 +663,54 @@ static int filewriter_read_header_cleanu
 	return 0;
 }
 
+static int filewriter_signature_op(int op)
+{
+	char *cur;
+	int result = 0, changed = 0;
+	struct filewriter_header *header;
+	
+	if(filewriter_target_bdev <= 0)
+		return -1;
+
+	cur = (char *) get_zeroed_page(GFP_ATOMIC);
+	if (!cur) {
+		printk("Unable to allocate a page for reading the image "
+				"signature.\n");
+		return -ENOMEM;
+	}
+
+	suspend_bio_ops.bdev_page_io(READ, filewriter_target_bdev,
+			target_firstblock,
+			virt_to_page(cur));
+
+	header = (struct filewriter_header *) cur;
+	result = parse_signature(header);
+		
+	switch (op) {
+		case INVALIDATE:
+			if (result == -1)
+				goto out;
+
+			strcpy(header->sig, NoImage);
+			header->resumed_before = 0;
+			result = changed = 1;
+			break;
+		case MARK_RESUME_ATTEMPTED:
+			if (result == 1) {
+				header->resumed_before = 1;
+				changed = 1;
+			}
+			break;
+	}
+
+	if (changed)
+		suspend_bio_ops.bdev_page_io(WRITE, filewriter_target_bdev,
+				target_firstblock,
+				virt_to_page(cur));
+
+out:
+	suspend_bio_ops.finish_all_io();
+	free_page((unsigned long) cur);
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

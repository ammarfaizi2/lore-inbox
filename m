Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933169AbWFZXUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169AbWFZXUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWFZXUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:20:01 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:52127 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933169AbWFZWg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 17/19] [Suspend2] Get image_exists data.
Date: Tue, 27 Jun 2006 08:36:56 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223655.4219.30956.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get information for the image_exists proc entry.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index 79cf54f..cd99bd8 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -933,3 +933,41 @@ int read_pageset1(void)
 	return error;
 }
 
+/*
+ * get_have_image_data()
+ */
+char *get_have_image_data(void)
+{
+	char *output_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	struct suspend_header *suspend_header;
+
+	if (!output_buffer) {
+		printk("Output buffer null.\n");
+		return NULL;
+	}
+
+	/* Check for an image */
+	if (!suspend_active_writer->image_exists() ||
+	    suspend_active_writer->read_header_init() ||
+	    suspend_active_writer->rw_header_chunk(READ, NULL,
+			output_buffer, sizeof(struct suspend_header)) !=
+	    		sizeof(struct suspend_header)) {
+		sprintf(output_buffer, "0\n");
+		goto out;
+	}
+
+	suspend_header = (struct suspend_header *) output_buffer;
+
+	sprintf(output_buffer, "1\n%s\n%s\n",
+			suspend_header->machine,
+			suspend_header->version);
+
+	/* Check whether we've resumed before */
+	if (test_suspend_state(SUSPEND_RESUMED_BEFORE))
+		strcat(output_buffer, "Resumed before.\n");
+
+out:
+	noresume_reset_modules();
+	return output_buffer;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

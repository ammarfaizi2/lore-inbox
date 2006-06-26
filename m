Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933207AbWFZXWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207AbWFZXWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933184AbWFZWgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:50 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:49055 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933106AbWFZWgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:38 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/19] [Suspend2] Write module configurations in an image header.
Date: Tue, 27 Jun 2006 08:36:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223634.4219.43499.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Write the configuration of each module used to the image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index dade1fc..a0aabd1 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -421,3 +421,70 @@ static int read_pageset(struct pagedir *
 	return result;
 }
 
+/* write_module_configs()
+ *
+ * Description:	Store the configuration for each module in the image header.
+ * Returns:	Int: Zero on success, Error value otherwise.
+ */
+static int write_module_configs(void)
+{
+	struct suspend_module_ops *this_module;
+	char *buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	int len, index = 1;
+	struct suspend_module_header suspend_module_header;
+
+	if (!buffer) {
+		printk("Failed to allocate a buffer for saving "
+				"module configuration info.\n");
+		return -ENOMEM;
+	}
+		
+	/* 
+	 * We have to know which data goes with which module, so we at
+	 * least write a length of zero for a module. Note that we are
+	 * also assuming every module's config data takes <= PAGE_SIZE.
+	 */
+
+	/* For each module (in registration order) */
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled || !this_module->storage_needed ||
+		    (this_module->type == WRITER_MODULE &&
+		     suspend_active_writer != this_module))
+			continue;
+
+		/* Get the data from the module */
+		len = 0;
+		if (this_module->save_config_info)
+			len = this_module->save_config_info(buffer);
+
+		/* Save the details of the module */
+		suspend_module_header.disabled = this_module->disabled;
+		suspend_module_header.type = this_module->type;
+		suspend_module_header.index = index++;
+		strncpy(suspend_module_header.name, this_module->name, 
+					sizeof(suspend_module_header.name));
+		suspend_active_writer->rw_header_chunk(WRITE,
+				this_module,
+				(char *) &suspend_module_header,
+				sizeof(suspend_module_header));
+
+		/* Save the size of the data and any data returned */
+		suspend_active_writer->rw_header_chunk(WRITE,
+				this_module,
+				(char *) &len, sizeof(int));
+		if (len)
+			suspend_active_writer->rw_header_chunk(
+				WRITE, this_module, buffer, len);
+	}
+
+	/* Write a blank header to terminate the list */
+	suspend_module_header.name[0] = '\0';
+	suspend_active_writer->rw_header_chunk(WRITE, 
+			NULL,
+			(char *) &suspend_module_header,
+			sizeof(suspend_module_header));
+
+	free_page((unsigned long) buffer);
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

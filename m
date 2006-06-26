Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWFZRAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWFZRAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFZQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:13 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43398 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750868AbWFZQxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/11] [Suspend2] Get header storage needed for module data.
Date: Tue, 27 Jun 2006 02:53:08 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165307.10957.7513.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get the amount of space in the image header required by modules to store
their data. Modules store in image header configuration needed to resume,
such as the name of the cryptoapi modules used for encryption and
compression. The writer may store additional information for bootstrapping,
such as where to find the header's pages on disk, which is not included in
this value. This is only the space required in the image header proper.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index f337208..60c7c7b 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -16,3 +16,36 @@ struct suspend_module_ops *suspend_activ
 static int suspend_num_filters;
 int suspend_num_writers, suspend_num_modules;
        
+/*
+ * suspend_header_storage_for_modules
+ *
+ * Returns the amount of space needed to store configuration
+ * data needed by the modules prior to copying back the original
+ * kernel. We can exclude data for pageset2 because it will be
+ * available anyway once the kernel is copied back.
+ */
+unsigned long suspend_header_storage_for_modules(void)
+{
+	struct suspend_module_ops *this_module;
+	unsigned long bytes = 0;
+	
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		this_module->header_requested = 0;
+		this_module->header_used = 0;
+		if (this_module->disabled ||
+		    (this_module->type == WRITER_MODULE &&
+		     suspend_active_writer != this_module))
+			continue;
+		if (this_module->storage_needed) {
+			int this = this_module->storage_needed() +
+				sizeof(struct suspend_module_header) +
+				sizeof(int);
+			this_module->header_requested = this;
+			bytes += this;
+		}
+	}
+
+	/* One more for the empty terminator */
+	return bytes + sizeof(struct suspend_module_header);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

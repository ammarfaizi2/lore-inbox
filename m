Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933106AbWFZXVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933106AbWFZXVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933193AbWFZWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:47007 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933171AbWFZWgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:24 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/19] [Suspend2] Cleanup modules after doing I/O on a portion of the image.
Date: Tue, 27 Jun 2006 08:36:22 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223620.4219.88435.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flush any pending I/O (writes only), and cleanup modules using in doing the
I/O.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index 401789d..be13f42 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -206,3 +206,38 @@ static int rw_init_modules(int rw, int w
 	return 0;
 }
 
+/*
+ * rw_cleanup_modules
+ *
+ * Cleanup components after reading or writing a set of pages.
+ * Only the writer may fail.
+ */
+static int rw_cleanup_modules(int rw)
+{
+	struct suspend_module_ops *this_module;
+	int result = 0;
+
+	/* Cleanup other modules */
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled)
+			continue;
+		if ((this_module->type == FILTER_MODULE) ||
+		    (this_module->type == WRITER_MODULE))
+			continue;
+		if (this_module->rw_cleanup)
+			result |= this_module->rw_cleanup(rw);
+	}
+
+	/* Flush data and cleanup */
+	list_for_each_entry(this_module, &suspend_filters, type_list) {
+		if (this_module->disabled)
+			continue;
+		if (this_module->rw_cleanup)
+			result |= this_module->rw_cleanup(rw);
+	}
+
+	result |= suspend_active_writer->rw_cleanup(rw);
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWFZQxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWFZQxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWFZQxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:44 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:46214 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750885AbWFZQxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:21 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/11] [Suspend2] Move a suspend2 module to the tail of its list.
Date: Tue, 27 Jun 2006 02:53:25 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165323.10957.23439.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When suspend2 modules are built as kernel modules, they may be loaded in a
different order when resuming to the order used when suspending. This could
result in decryption and decompression being done in the wrong order. We
avoid this by remembering the order used when suspending, and reordering at
resume-time to match. This routine provides the primitive used in that
reordering.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index 6305fa2..af237b6 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -187,3 +187,38 @@ void suspend_unregister_module(struct su
 	list_del(&module->module_list);
 	suspend_num_modules--;
 }
+
+/*
+ * suspend_move_module_tail
+ *
+ * Rearrange modules when reloading the config.
+ */
+void suspend_move_module_tail(struct suspend_module_ops *module)
+{
+	switch (module->type) {
+		case FILTER_MODULE:
+			if (suspend_num_filters > 1)
+				list_move_tail(&module->type_list,
+						&suspend_filters);
+			break;
+
+		case WRITER_MODULE:
+			if (suspend_num_writers > 1)
+				list_move_tail(&module->type_list,
+						&suspend_writers);
+			break;
+		
+		case MISC_MODULE:
+			break;
+		default:
+			printk("Hmmm. Module '%s' has an invalid type."
+				" It has been ignored.\n", module->name);
+			return;
+	}
+	if ((suspend_num_filters + suspend_num_writers) > 1)
+		list_move_tail(&module->module_list, &suspend_modules);
+}
+
+	return len;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

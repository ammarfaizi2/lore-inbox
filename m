Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWFZQy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWFZQy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWFZQxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:45702 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750839AbWFZQxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:18 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/11] [Suspend2] Register and unregister suspend2 modules.
Date: Tue, 27 Jun 2006 02:53:21 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165320.10957.71611.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines for suspend2 modules to use at boot or module load/unload.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index 50607f5..6305fa2 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -116,3 +116,74 @@ int suspend_print_module_debug_info(char
 	return len;
 }
 
+/*
+ * suspend_register_module
+ *
+ * Register a module.
+ */
+int suspend_register_module(struct suspend_module_ops *module)
+{
+	if (suspend_find_module_given_name(module->name))
+		return -EBUSY;
+
+	switch (module->type) {
+		case FILTER_MODULE:
+			list_add_tail(&module->type_list,
+					&suspend_filters);
+			suspend_num_filters++;
+			break;
+
+		case WRITER_MODULE:
+			list_add_tail(&module->type_list,
+					&suspend_writers);
+			suspend_num_writers++;
+			break;
+
+		case MISC_MODULE:
+			break;
+
+		default:
+			printk("Hmmm. Module '%s' has an invalid type."
+				" It has been ignored.\n", module->name);
+			return -EINVAL;
+	}
+	list_add_tail(&module->module_list, &suspend_modules);
+	suspend_num_modules++;
+
+	return 0;	
+}
+
+/*
+ * suspend_unregister_module
+ *
+ * Remove a module.
+ */
+void suspend_unregister_module(struct suspend_module_ops *module)
+{
+	switch (module->type) {
+		case FILTER_MODULE:
+			list_del(&module->type_list);
+			suspend_num_filters--;
+			break;
+
+		case WRITER_MODULE:
+			list_del(&module->type_list);
+			suspend_num_writers--;
+			if (suspend_active_writer == module) {
+				suspend_active_writer = NULL;
+				clear_suspend_state(SUSPEND_CAN_RESUME);
+				clear_suspend_state(SUSPEND_CAN_SUSPEND);
+			}
+			break;
+		
+		case MISC_MODULE:
+			break;
+
+		default:
+			printk("Hmmm. Module '%s' has an invalid type."
+				" It has been ignored.\n", module->name);
+			return;
+	}
+	list_del(&module->module_list);
+	suspend_num_modules--;
+}

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWBALlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWBALlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWBALlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:23 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:16347 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932346AbWBALkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:47 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 02/10] [Suspend2] Module (de)registration.
Date: Wed, 01 Feb 2006 21:37:15 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113713.6320.99223.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements registration and deregistration of modules that are
used for page transformation and storage.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
new file mode 100644
index 0000000..227e320
--- /dev/null
+++ b/kernel/power/modules.c
@@ -0,0 +1,87 @@
+/*
+ * kernel/power/modules.c
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include "suspend2.h"
+#include "modules.h"
+
+struct list_head suspend_filters, suspend_writers, suspend_modules;
+struct suspend_module_ops *active_writer = NULL;
+static int num_filters = 0, num_ui = 0;
+int num_writers = 0, num_modules = 0;
+
+/*
+ * suspend_register_module
+ *
+ * Register a module.
+ */
+int suspend_register_module(struct suspend_module_ops *module)
+{
+	if (find_module_given_name(module->name))
+		return -EBUSY;
+
+	switch (module->type) {
+		case FILTER_PLUGIN:
+			list_add_tail(&module->ops.filter.filter_list,
+					&suspend_filters);
+			num_filters++;
+			break;
+
+		case WRITER_PLUGIN:
+			list_add_tail(&module->ops.writer.writer_list,
+					&suspend_writers);
+			num_writers++;
+			break;
+
+		case MISC_PLUGIN:
+			break;
+
+		default:
+			printk("Hmmm. Plugin '%s' has an invalid type."
+				" It has been ignored.\n", module->name);
+			return -EINVAL;
+	}
+	list_add_tail(&module->module_list, &suspend_modules);
+	num_modules++;
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
+		case FILTER_PLUGIN:
+			list_del(&module->ops.filter.filter_list);
+			num_filters--;
+			break;
+
+		case WRITER_PLUGIN:
+			list_del(&module->ops.writer.writer_list);
+			num_writers--;
+			if (active_writer == module) {
+				active_writer = NULL;
+				set_suspend_state(SUSPEND_DISABLED);
+			}
+			break;
+		
+		case MISC_PLUGIN:
+			break;
+
+		default:
+			printk("Hmmm. Plugin '%s' has an invalid type."
+				" It has been ignored.\n", module->name);
+			return;
+	}
+	list_del(&module->module_list);
+	num_modules--;
+}

--
Nigel Cunningham		nigel at suspend2 dot net

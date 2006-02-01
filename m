Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWBALlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWBALlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWBALlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:11 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:18907 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964928AbWBALk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:58 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 06/10] [Suspend2] Get/put module reference.
Date: Wed, 01 Feb 2006 21:37:22 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113722.6320.72928.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Take or put a reference to a module, so it can't be unloaded while in use.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index a7c3c38..dd53b27 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -185,3 +185,41 @@ struct suspend_module_ops *get_next_filt
 
 	return active_writer;
 }
+
+/* suspend2_get_modules
+ * 
+ * Take a reference to modules so they can't go away under us.
+ */
+
+int suspend2_get_modules(void)
+{
+	struct suspend_module_ops *this_module;
+	
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (!try_module_get(this_module->module)) {
+			/* Failed! Reverse gets and return error */
+			struct suspend_module_ops *this_module2;
+			list_for_each_entry(this_module2, &suspend_modules, module_list) {
+				if (this_module == this_module2)
+					return -EINVAL;
+				module_put(this_module2->module);
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* suspend2_put_modules
+ *
+ * Release our references to modules we used.
+ */
+
+void suspend2_put_modules(void)
+{
+	struct suspend_module_ops *this_module;
+	
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		module_put(this_module->module);
+	}
+}

--
Nigel Cunningham		nigel at suspend2 dot net

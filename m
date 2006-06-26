Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWFZQxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWFZQxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWFZQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:36 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:47750 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750898AbWFZQxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:31 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/11] [Suspend2] Get and put references to Suspend2 modules.
Date: Tue, 27 Jun 2006 02:53:35 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165334.10957.75157.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Functions to get and put references to suspend2 modules, to stop them being
unloaded while in use.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index d7c2076..5c5cbf0 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -288,6 +288,40 @@ struct suspend_module_ops *suspend_get_n
 	return suspend_active_writer;
 }
 
-	return len;
+/* suspend_get_modules
+ * 
+ * Take a reference to modules so they can't go away under us.
+ */
+
+int suspend_get_modules(void)
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
+/* suspend_put_modules
+ *
+ * Release our references to modules we used.
+ */
+
+void suspend_put_modules(void)
+{
+	struct suspend_module_ops *this_module;
+	
+	list_for_each_entry(this_module, &suspend_modules, module_list)
+		module_put(this_module->module);
 }
 

--
Nigel Cunningham		nigel at suspend2 dot net

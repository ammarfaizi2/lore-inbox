Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWFZQxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWFZQxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWFZQxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:42 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:46726 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750887AbWFZQxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:24 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/11] [Suspend2] Initialise and cleanup routines for suspend2 modules.
Date: Tue, 27 Jun 2006 02:53:28 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165327.10957.45861.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines to iterate through the list of suspend2 modules, calling their
initialisation and cleanup routines.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index af237b6..cd171a8 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -219,6 +219,55 @@ void suspend_move_module_tail(struct sus
 		list_move_tail(&module->module_list, &suspend_modules);
 }
 
+/*
+ * suspend_initialise_modules
+ *
+ * Get ready to do some work!
+ */
+int suspend_initialise_modules(int starting_cycle)
+{
+	struct suspend_module_ops *this_module;
+	int result;
+	
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled)
+			continue;
+		if (this_module->initialise) {
+			suspend_message(SUSPEND_MEMORY, SUSPEND_MEDIUM, 1,
+				"Initialising module %s.\n",
+				this_module->name);
+			if ((result = this_module->initialise(starting_cycle))) {
+				printk("%s didn't initialise okay.\n",
+						this_module->name);
+				return result;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* 
+ * suspend_cleanup_modules
+ *
+ * Tell modules the work is done.
+ */
+void suspend_cleanup_modules(int finishing_cycle)
+{
+	struct suspend_module_ops *this_module;
+	
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled)
+			continue;
+		if (this_module->cleanup) {
+			suspend_message(SUSPEND_MEMORY, SUSPEND_MEDIUM, 1,
+				"Cleaning up module %s.\n",
+				this_module->name);
+			this_module->cleanup(finishing_cycle);
+		}
+	}
+}
+
 	return len;
 }
 

--
Nigel Cunningham		nigel at suspend2 dot net

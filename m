Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWBALlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWBALlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWBALlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:13 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:17627 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964896AbWBALk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:56 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 04/10] [Suspend2] Module initialise/cleanup.
Date: Wed, 01 Feb 2006 21:37:19 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113718.6320.34368.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Routines to tell modules that we're about to do some work, and conversely,
have finished our labours for the moment. We allow them to do some actions
only if we're starting/finishing a cycle by passing a flag to indicate
that.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index f7e9ab0..eee5678 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -116,3 +116,52 @@ void suspend_move_module_tail(struct sus
 	if ((num_filters + num_writers + num_ui) > 1)
 		list_move_tail(&module->module_list, &suspend_modules);
 }
+
+/*
+ * suspend2_initialise_modules
+ *
+ * Get ready to do some work!
+ */
+int suspend2_initialise_modules(int starting_cycle)
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
+ * suspend2_cleanup_modules
+ *
+ * Tell modules the work is done.
+ */
+void suspend2_cleanup_modules(int finishing_cycle)
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

--
Nigel Cunningham		nigel at suspend2 dot net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWBALlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWBALlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWBALlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:25 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:16859 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932428AbWBALkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:47 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 03/10] [Suspend2] Move module to the tail of lists.
Date: Wed, 01 Feb 2006 21:37:17 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113716.6320.56569.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This function moves a module to the tail of lists in which it appears. This
is used at resume time, to make the order in which modules are used match
the order used when suspending. It wouldn't do to compress and then encrypt
while suspending, but try to decompress before decrypting at resume.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index 227e320..f7e9ab0 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -85,3 +85,34 @@ void suspend_unregister_module(struct su
 	list_del(&module->module_list);
 	num_modules--;
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
+		case FILTER_PLUGIN:
+			if (num_filters > 1)
+				list_move_tail(&module->ops.filter.filter_list,
+						&suspend_filters);
+			break;
+
+		case WRITER_PLUGIN:
+			if (num_writers > 1)
+				list_move_tail(&module->ops.writer.writer_list,
+						&suspend_writers);
+			break;
+		
+		case MISC_PLUGIN:
+			break;
+		default:
+			printk("Hmmm. Plugin '%s' has an invalid type."
+				" It has been ignored.\n", module->name);
+			return;
+	}
+	if ((num_filters + num_writers + num_ui) > 1)
+		list_move_tail(&module->module_list, &suspend_modules);
+}

--
Nigel Cunningham		nigel at suspend2 dot net

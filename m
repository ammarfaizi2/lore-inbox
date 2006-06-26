Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWFZRBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWFZRBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWFZRAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:00:48 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:45190 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750868AbWFZQxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:15 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/11] [Suspend2] Get debugging info from modules.
Date: Tue, 27 Jun 2006 02:53:18 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165317.10957.82355.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fill a buffer with debugging information from the suspend2 modules. It is
assumed that this information will never exceed a page in total. If this
did happen, the data would be truncated.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index c18b5fb..50607f5 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -90,3 +90,29 @@ struct suspend_module_ops *suspend_find_
 	return found_module;
 }
 
+/*
+ * suspend_print_module_debug_info
+ * Functionality   : Get debugging info from modules into a buffer.
+ */
+int suspend_print_module_debug_info(char *buffer, int buffer_size)
+{
+	struct suspend_module_ops *this_module;
+	int len = 0;
+
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled)
+			continue;
+		if (this_module->print_debug_info) {
+			int result;
+			result = this_module->print_debug_info(buffer + len, 
+					buffer_size - len);
+			len += result;
+		}
+	}
+
+	/* Ensure null terminated */
+	buffer[buffer_size] = 0;
+
+	return len;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

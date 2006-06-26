Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWFZQsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWFZQsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWFZQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:48:15 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:36325 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750812AbWFZQrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:47:46 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 6/7] [Suspend2] Register and remove proc file functions.
Date: Tue, 27 Jun 2006 02:47:50 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164749.10724.12205.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Functions to add and remove a Suspend2 proc file entry.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/proc.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/kernel/power/proc.c b/kernel/power/proc.c
index dad818f..9722377 100644
--- a/kernel/power/proc.c
+++ b/kernel/power/proc.c
@@ -281,3 +281,47 @@ static void suspend_initialise_proc(void
 		suspend_register_procfile(&proc_params[i]);
 }
 
+/* suspend_register_procfile
+ *
+ * Helper for registering a new /proc/suspend2 entry.
+ */
+
+struct proc_dir_entry *suspend_register_procfile(
+		struct suspend_proc_data *suspend_proc_data)
+{
+	struct proc_dir_entry *new_entry;
+	
+	if (!suspend_proc_initialised)
+		suspend_initialise_proc();
+
+	new_entry = create_proc_entry(
+			suspend_proc_data->filename,
+			suspend_proc_data->permissions, 
+			suspend_dir);
+	if (new_entry) {
+		list_add_tail(&suspend_proc_data->proc_data_list, &suspend_proc_entries);
+		new_entry->read_proc = suspend_read_proc;
+		new_entry->write_proc = suspend_write_proc;
+		new_entry->data = suspend_proc_data;
+	} else {
+		printk("Error! create_proc_entry returned NULL.\n");
+		INIT_LIST_HEAD(&suspend_proc_data->proc_data_list);
+	}
+	return new_entry;
+}
+
+/* suspend_unregister_procfile
+ *
+ * Helper for removing unwanted /proc/suspend2 entries.
+ *
+ */
+void suspend_unregister_procfile(struct suspend_proc_data *suspend_proc_data)
+{
+	if (list_empty(&suspend_proc_data->proc_data_list))
+		return;
+
+	remove_proc_entry(
+		suspend_proc_data->filename,
+		suspend_dir);
+	list_del(&suspend_proc_data->proc_data_list);
+}

--
Nigel Cunningham		nigel at suspend2 dot net

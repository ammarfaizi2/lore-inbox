Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933419AbWF0ElA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933419AbWF0ElA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933417AbWF0Ek7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:40:59 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:38875 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933416AbWF0Eky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/13] [Suspend2] Prepare and cleanup the storage manager.
Date: Tue, 27 Jun 2006 14:40:52 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044051.14778.8375.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Start the storage manager at the beginning of a suspend/resume, and clean
it up at the end of a resume or cancelled suspend.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index e31623a..fea9276 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -176,3 +176,50 @@ static unsigned long usm_memory_needed(v
 	return (32 * PAGE_SIZE);
 }
 
+/* suspend_prepare_usm
+ */
+int suspend_prepare_usm(void)
+{
+	usm_prepare_count++;
+
+	if (usm_prepare_count > 1 || usm_ops.disabled)
+		return 0;
+	
+	usm_helper_data.pid = -1;
+
+	if (!*usm_helper_data.program)
+		return 0;
+
+	suspend_netlink_setup(&usm_helper_data);
+
+	if (usm_helper_data.pid == -1)
+		printk("Suspend2 Storage Manager wanted, but couldn't start it.\n");
+
+	suspend_activate_storage(0);
+
+	return (usm_helper_data.pid != -1);
+}
+
+void suspend_cleanup_usm(void)
+{
+	usm_prepare_count--;
+
+	if (usm_helper_data.pid > -1 && !usm_prepare_count) {
+		struct task_struct *t;
+
+		suspend_deactivate_storage(0);
+
+		suspend_send_netlink_message(&usm_helper_data,
+				NETLINK_MSG_CLEANUP, NULL, 0);
+
+		read_lock(&tasklist_lock);
+		if ((t = find_task_by_pid(usm_helper_data.pid)))
+			t->flags &= ~PF_NOFREEZE;
+		read_unlock(&tasklist_lock);
+
+		suspend_netlink_close(&usm_helper_data);
+
+		usm_helper_data.pid = -1;
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

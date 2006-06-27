Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWF0FDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWF0FDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWF0FDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:03:19 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:28635 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030689AbWF0Ejt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:49 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/13] [Suspend2] Set NoFreeze flag on a userspace helper.
Date: Tue, 27 Jun 2006 14:39:47 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043946.14630.38851.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the NoFreeze flag on a userspace helper (userui or storage manager) so
that it can continue to function while we're doing I/O.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index 0aaf90e..7f06f7c 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -127,3 +127,28 @@ static void send_whether_debugging(struc
 			&is_debugging, sizeof(int));
 }
 
+/*
+ * Set the PF_NOFREEZE flag on the given process to ensure it can run whilst we
+ * are suspending.
+ */
+static int nl_set_nofreeze(struct user_helper_data *uhd, int pid)
+{
+	struct task_struct *t;
+
+	read_lock(&tasklist_lock);
+	if ((t = find_task_by_pid(pid)) == NULL) {
+		read_unlock(&tasklist_lock);
+		printk("Strange. Can't find the userspace task %d.\n", pid);
+		return -EINVAL;
+	}
+
+	t->flags |= PF_NOFREEZE;
+
+	read_unlock(&tasklist_lock);
+	uhd->pid = pid;
+
+	suspend_send_netlink_message(uhd, NETLINK_MSG_NOFREEZE_ACK, NULL, 0);
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

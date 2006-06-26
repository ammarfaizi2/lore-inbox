Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933271AbWFZXFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271AbWFZXFM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933270AbWFZWjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:49 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:21687 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933271AbWFZWjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:32 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/35] [Suspend2] Reopen the resume dev_t.
Date: Tue, 27 Jun 2006 08:39:30 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223929.4685.46774.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having processed the resume2= setting once to get the dev_t it refers to,
we can just use the dev_t again afterwards. This routine reopens the bdev
at some later stage, getting afresh the inode and device info - something
might have been modified by the user since our last use, and it would be
wrong to keep the device open all the time anyway.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index e2ad8dc..7e06a06 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -259,3 +259,22 @@ static void filewriter_cleanup(int finis
 	}
 }
 
+/* 
+ * reopen_resume_devt
+ *
+ * Having opened resume2= once, we remember the major and
+ * minor nodes and use them to reopen the bdev for checking
+ * whether an image exists (possibly when starting a resume).
+ */
+static void reopen_resume_devt(void)
+{
+	filewriter_target_bdev = open_by_devnum(resume_dev_t, FMODE_READ);
+	if (IS_ERR(filewriter_target_bdev)) {
+		printk("Got a dev_num (%lx) but failed to open it.\n",
+				(unsigned long) resume_dev_t);
+		return;
+	}
+	target_inode = filewriter_target_bdev->bd_inode;
+	set_devinfo(filewriter_target_bdev, target_inode->i_blkbits);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

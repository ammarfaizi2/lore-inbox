Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933282AbWFZWjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933282AbWFZWjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933277AbWFZWjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:41 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:22199 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933274AbWFZWjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:35 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/35] [Suspend2] Get filewriter target info.
Date: Tue, 27 Jun 2006 08:39:33 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223932.4685.56666.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the name of a target (eg /dev/hda3, /my-suspend-file, /dev/ttyS0),
attempt to access it and discover the properties (inode, block size, dev_t,
first block, storage available) we need to work with it.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   87 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 7e06a06..6851977 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -278,3 +278,90 @@ static void reopen_resume_devt(void)
 	set_devinfo(filewriter_target_bdev, target_inode->i_blkbits);
 }
 
+static void filewriter_get_target_info(char *target, int get_size,
+		int resume2)
+{
+	if (target_file)
+		filewriter_cleanup(0);
+
+	if (!target || !strlen(target))
+		return;
+
+	target_file = filp_open(target, O_RDWR, 0);
+
+	if (IS_ERR(target_file) || !target_file) {
+
+		if (!resume2) {
+			printk("Open file %s returned %p.\n",
+					target, target_file);
+			target_file = NULL;
+			return;
+		}
+
+		target_file = NULL;
+		resume_dev_t = name_to_dev_t(target);
+		if (!resume_dev_t) {
+			printk("Open file %s returned %p and name_to_devt "
+					"failed.\n",
+					target, target_file);
+			if (!resume_dev_t) {
+				struct kstat stat;
+				int error = vfs_stat(target, &stat);
+				if (error) {
+					printk("Stating the file also failed."
+						" Nothing more we can do.\n");
+					return;
+				}
+				resume_dev_t = stat.rdev;
+			}
+			return;
+		}
+	     	filewriter_target_bdev = open_by_devnum(resume_dev_t, FMODE_READ);
+		if (IS_ERR(filewriter_target_bdev)) {
+			printk("Got a dev_num (%lx) but failed to open it.\n",
+					(unsigned long) resume_dev_t);
+			return;
+		}
+		used_devt = 1;
+		target_inode = filewriter_target_bdev->bd_inode;
+	} else
+		target_inode = target_file->f_mapping->host;
+
+	if (S_ISLNK(target_inode->i_mode) ||
+	    S_ISDIR(target_inode->i_mode) ||
+	    S_ISSOCK(target_inode->i_mode) ||
+	    S_ISFIFO(target_inode->i_mode)) {
+		printk("The filewriter works with regular files, character "
+				"files and block devices.\n");
+		goto cleanup;
+	}
+
+	if (!used_devt) {
+		if (S_ISBLK(target_inode->i_mode)) {
+			filewriter_target_bdev = I_BDEV(target_inode);
+			if (!bd_claim(filewriter_target_bdev, &filewriterops))
+				target_claim = 1;
+		} else
+			filewriter_target_bdev = target_inode->i_sb->s_bdev;
+		resume_dev_t = filewriter_target_bdev->bd_dev;
+	}
+
+	set_devinfo(filewriter_target_bdev, target_inode->i_blkbits);
+
+	if (get_size)
+		target_storage_available = size_ignoring_ignored_pages();
+
+	if (!resume2)
+		target_firstblock = bmap(target_inode, 0) << devinfo.bmap_shift;
+	
+	return;
+cleanup:
+	target_inode = NULL;
+	if (target_file) {
+		filp_close(target_file, NULL);
+		target_file = NULL;
+	}
+	set_devinfo(NULL, 0);
+	target_storage_available = 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

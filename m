Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWFZXCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWFZXCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933290AbWFZWj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:56 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:19127 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933248AbWFZWjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:14 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/35] [Suspend2] Get filewriter storage available.
Date: Tue, 27 Jun 2006 08:39:13 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223912.4685.37028.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the amount of storage available to the filewriter, in pages.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 36db6b8..caa86bc 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -105,3 +105,34 @@ static void set_devinfo(struct block_dev
 	}
 }
 
+static int filewriter_storage_available(void)
+{
+	int result = 0;
+	struct block_device *bdev=filewriter_target_bdev;
+
+	if (!target_inode)
+		return 0;
+
+	switch (target_inode->i_mode & S_IFMT) {
+		case S_IFSOCK:
+		case S_IFCHR:
+		case S_IFIFO: /* Socket, Char, Fifo */
+			return -1;
+		case S_IFREG: /* Regular file: current size - holes + free
+				 space on part */
+			result = target_storage_available;
+			break;
+		case S_IFBLK: /* Block device */
+			if (!bdev->bd_disk) {
+				printk("bdev->bd_disk null.\n");
+				return 0;
+			}
+
+			result = (bdev->bd_part ?
+				bdev->bd_part->nr_sects :
+				bdev->bd_disk->capacity) >> (PAGE_SHIFT - 9);
+	}
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

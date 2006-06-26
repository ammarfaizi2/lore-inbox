Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWFZWyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWFZWyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933344AbWFZWwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:52:34 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:38071 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933331AbWFZWlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:20 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/28] [Suspend2] Open bdev for swapwriter use.
Date: Tue, 27 Jun 2006 08:41:19 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224118.4975.27802.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Open (at resume time) a bdev for the swapwriter to read from.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 6f87a4a..212555f 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -114,3 +114,40 @@ static void close_bdevs(void)
 	resume_block_device = header_block_device = NULL;
 }
 
+static struct block_device *open_bdev(int index, dev_t device)
+{
+	struct bdev_opened *this;
+	struct block_device *bdev;
+
+	if (bdev_info_list[index] && (bdev_info_list[index]->device == device)){
+		bdev = bdev_info_list[index]->bdev;
+		return bdev;
+	}
+	
+	if (bdev_info_list[index] && bdev_info_list[index]->device != device)
+		close_bdev(index);
+
+	bdev = open_by_devnum(device, FMODE_READ);
+
+	if (IS_ERR(bdev) || !bdev) {
+		suspend_early_boot_message(1,SUSPEND_CONTINUE_REQ,  
+				"Failed to get access to block device "
+				"%d.\n You could be "
+				"booting with a 2.6 kernel when you "
+				"suspended a 2.4 kernel.", bdev);
+		return ERR_PTR(-EINVAL);
+	}
+
+	this = kmalloc(sizeof(struct bdev_opened), GFP_KERNEL);
+	BUG_ON(!this);
+
+	bdev_info_list[index] = this;
+	this->device = device;
+	this->bdev = bdev;
+
+	if (index < MAX_SWAPFILES)
+		devinfo[index].bdev = bdev;
+
+	return bdev;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net

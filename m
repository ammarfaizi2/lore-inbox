Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWILP5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWILP5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWILP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:57:14 -0400
Received: from main.gmane.org ([80.91.229.2]:17835 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030234AbWILP5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:57:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Two vulnerabilities are founded,please confirm.
Date: 12 Sep 2006 17:55:23 +0200
Message-ID: <87lkop9j10.fsf@willow.rfc1149.net>
References: <4506C376.1080606@venustech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "ADLab" == ADLab  <adlab@venustech.com.cn> writes:

ADLab> Advisory: [AD_LAB-06011] Linux kernel Filesystem Mount Dead
ADLab> Loop Class: Design Error

Would a simple fix like this one (untested) work?

Check that the requested block fits in the device.

Fix for advisory AD_LAB-06011 Linux kernel Filesystem Mount Dead Loop.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

diff -r db51efd75e66 fs/buffer.c
--- a/fs/buffer.c	Sun Sep 10 01:02:33 2006 +0200
+++ b/fs/buffer.c	Tue Sep 12 17:54:13 2006 +0200
@@ -1456,7 +1456,17 @@ struct buffer_head *
 struct buffer_head *
 __getblk(struct block_device *bdev, sector_t block, int size)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	struct buffer_head *bh;
+	char b[BDEVNAME_SIZE];
+
+	if (block >= bdev->bd_disk->capacity) {
+		printk(KERN_ERR "Invalid block number %Ld requested on device %s",
+		       (unsigned long long)block,
+		       bdevname(bdev, b));
+		return NULL;
+	}
+
+	bh = __find_get_block(bdev, block, size);
 
 	might_sleep();
 	if (bh == NULL)



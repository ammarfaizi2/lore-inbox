Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWILQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWILQHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWILQHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:07:19 -0400
Received: from main.gmane.org ([80.91.229.2]:29073 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030254AbWILQHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:07:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Two vulnerabilities are founded,please confirm.
Date: 12 Sep 2006 18:03:40 +0200
Message-ID: <87hczd9in7.fsf@willow.rfc1149.net>
References: <4506C376.1080606@venustech.com.cn> <87lkop9j10.fsf@willow.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Sam" == Samuel Tardieu <sam@rfc1149.net> writes:

Sam> Would a simple fix like this one (untested) work?

Or rather (less likely to be in the path by putting it in
__find_get_block_slow):

Check that the requested block fits in the device.

Fix for advisory AD_LAB-06011 Linux kernel Filesystem Mount Dead Loop.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

diff -r db51efd75e66 fs/buffer.c
--- a/fs/buffer.c	Sun Sep 10 01:02:33 2006 +0200
+++ b/fs/buffer.c	Tue Sep 12 18:01:37 2006 +0200
@@ -393,6 +393,14 @@ __find_get_block_slow(struct block_devic
 	struct buffer_head *head;
 	struct page *page;
 	int all_mapped = 1;
+	char b[BDEVNAME_SIZE];
+
+	if (block >= bdev->bd_disk->capacity) {
+		printk(KERN_ERR "Invalid block number %Ld requested on device %s",
+		       (unsigned long long)block,
+		       bdevname(bdev, b));
+		return NULL;
+	}
 
 	index = block >> (PAGE_CACHE_SHIFT - bd_inode->i_blkbits);
 	page = find_get_page(bd_mapping, index);


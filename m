Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRCEPvR>; Mon, 5 Mar 2001 10:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRCEPvI>; Mon, 5 Mar 2001 10:51:08 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:44758 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129359AbRCEPvF>; Mon, 5 Mar 2001 10:51:05 -0500
Date: Mon, 5 Mar 2001 15:52:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-LVM@sistina.com, linux-kernel@vger.kernel.org
Subject: lvm_snap calc_max_buckets num_physpages
In-Reply-To: <Pine.LNX.4.21.0103022135140.1440-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0103051547450.1056-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

num_physpages is shifted too far in lvm_snap's calc_max_buckets():
would go to 0 on a 4GB, 8GB, ... 32-bit machine.  Okay, not quite all
the 4GB goes into num_physpages, so it's rather an issue with 5GB ...

Naive patch (against 2.4.3-pre2 or 2.4.2-ac11 or 2.4.2 or 2.4.1) below,
but I won't be submitting this to Alan or Linus myself (unless you ask):
I expect you'll want to consider whether the number should go on
climbing linearly in that way above 1GB.

Hugh

--- 2.4.2-ac11/drivers/md/lvm-snap.c	Mon Jan 29 00:11:20 2001
+++ linux/drivers/md/lvm-snap.c	Mon Mar  5 11:58:10 2001
@@ -489,10 +489,9 @@
 {
 	unsigned long mem;
 
-	mem = num_physpages << PAGE_SHIFT;
-	mem /= 100;
-	mem *= 2;
-	mem /= sizeof(struct list_head);
+	mem = num_physpages;
+	mem /= 50 * sizeof(struct list_head);
+	mem <<= PAGE_SHIFT;
 
 	return mem;
 }


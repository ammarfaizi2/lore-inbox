Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVJFGHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVJFGHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 02:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVJFGHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 02:07:52 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:11772 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1750722AbVJFGHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 02:07:52 -0400
Date: Wed, 5 Oct 2005 23:07:30 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510060607.j9667UPo027197@rastaban.cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Cc: paulmck@us.ibm.com, suzannew@cs.pdx.edu, walpole@cs.pdx.edu
Subject: [RFC][PATCH] identify rcu-protected ptr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider an addition to the patch to identify
raid rcu-protected pointer occurences.  All of the
work in the raid submittals which is correct is that
of Paul McKenney and any errors and oversights are
mine.

Also, please consider the effective addition of an
rcu_dereference() in bpq_get_ax25_dev() in recognition 
of each use being nested in an rcu critical section.
Thank you.

 md/md.c                 |    2 +-
 net/hamradio/bpqether.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-------------------------------------------------

diff -urpNa -X dontdiff a/linux-2.6.14-rc3/drivers/md/md.c b/linux-2.6.14-rc3/drivers/md/md.c
--- a/linux-2.6.14-rc3/drivers/md/md.c	2005-09-30 14:17:35.000000000 -0700
+++ b/linux-2.6.14-rc3/drivers/md/md.c	2005-10-05 22:30:31.000000000 -0700
@@ -1145,7 +1145,7 @@ static int bind_rdev_to_array(mdk_rdev_t
 	}
 			
 	list_add(&rdev->same_set, &mddev->disks);
-	rdev->mddev = mddev;
+	rcu_assign_pointer(rdev->mddev, mddev);
 	printk(KERN_INFO "md: bind<%s>\n", bdevname(rdev->bdev,b));
 	return 0;
 }
diff -urpNa -X dontdiff a/linux-2.6.14-rc3/drivers/net/hamradio/bpqether.c b/linux-2.6.14-rc3/drivers/net/hamradio/bpqether.c
--- a/linux-2.6.14-rc3/drivers/net/hamradio/bpqether.c	2005-09-30 14:17:35.000000000 -0700
+++ b/linux-2.6.14-rc3/drivers/net/hamradio/bpqether.c	2005-10-05 22:32:53.000000000 -0700
@@ -144,7 +144,7 @@ static inline struct net_device *bpq_get
 {
 	struct bpqdev *bpq;
 
-	list_for_each_entry(bpq, &bpq_devices, bpq_list) {
+	list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list) {
 		if (bpq->ethdev == dev)
 			return bpq->axdev;
 	}

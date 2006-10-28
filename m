Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWJ1Spb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWJ1Spb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWJ1Spb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:45:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:52539 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932075AbWJ1Spa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:45:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=boLpdHZTJtkzdiY5tZRii+hpW3oRh+CxodkRu+hCuzHZRuYwbIIeWG03ujRZxcaMyvXxP0TmWxLtqJzF664BNd4Mc/SYVvqq/zJOmMzlof6PEC2QJs2yrGauH4gmuPWcJV4HJosFn7AO6cwmdeJ0CJeRDCKfkp4hozuxcvRpeu0=
Date: Sun, 29 Oct 2006 03:45:48 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tim Waugh <tim@cyberelk.net>
Subject: [PATCH] paride: return proper error code
Message-ID: <20061028184548.GF9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Tim Waugh <tim@cyberelk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes module init return proper value instead of -1 (-EPERM).

Cc: Tim Waugh <tim@cyberelk.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/block/paride/pcd.c |    8 ++++----
 drivers/block/paride/pf.c  |    8 ++++----
 drivers/block/paride/pg.c  |    4 ++--
 drivers/block/paride/pt.c  |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

Index: work-fault-inject/drivers/block/paride/pcd.c
===================================================================
--- work-fault-inject.orig/drivers/block/paride/pcd.c
+++ work-fault-inject/drivers/block/paride/pcd.c
@@ -912,12 +912,12 @@ static int __init pcd_init(void)
 	int unit;
 
 	if (disable)
-		return -1;
+		return -EINVAL;
 
 	pcd_init_units();
 
 	if (pcd_detect())
-		return -1;
+		return -ENODEV;
 
 	/* get the atapi capabilities page */
 	pcd_probe_capabilities();
@@ -925,7 +925,7 @@ static int __init pcd_init(void)
 	if (register_blkdev(major, name)) {
 		for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
 			put_disk(cd->disk);
-		return -1;
+		return -EBUSY;
 	}
 
 	pcd_queue = blk_init_queue(do_pcd_request, &pcd_lock);
@@ -933,7 +933,7 @@ static int __init pcd_init(void)
 		unregister_blkdev(major, name);
 		for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
 			put_disk(cd->disk);
-		return -1;
+		return -ENOMEM;
 	}
 
 	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
Index: work-fault-inject/drivers/block/paride/pf.c
===================================================================
--- work-fault-inject.orig/drivers/block/paride/pf.c
+++ work-fault-inject/drivers/block/paride/pf.c
@@ -933,25 +933,25 @@ static int __init pf_init(void)
 	int unit;
 
 	if (disable)
-		return -1;
+		return -EINVAL;
 
 	pf_init_units();
 
 	if (pf_detect())
-		return -1;
+		return -ENODEV;
 	pf_busy = 0;
 
 	if (register_blkdev(major, name)) {
 		for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
 			put_disk(pf->disk);
-		return -1;
+		return -EBUSY;
 	}
 	pf_queue = blk_init_queue(do_pf_request, &pf_spin_lock);
 	if (!pf_queue) {
 		unregister_blkdev(major, name);
 		for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
 			put_disk(pf->disk);
-		return -1;
+		return -ENOMEM;
 	}
 
 	blk_queue_max_phys_segments(pf_queue, cluster);
Index: work-fault-inject/drivers/block/paride/pg.c
===================================================================
--- work-fault-inject.orig/drivers/block/paride/pg.c
+++ work-fault-inject/drivers/block/paride/pg.c
@@ -646,14 +646,14 @@ static int __init pg_init(void)
 	int err;
 
 	if (disable){
-		err = -1;
+		err = -EINVAL;
 		goto out;
 	}
 
 	pg_init_units();
 
 	if (pg_detect()) {
-		err = -1;
+		err = -ENODEV;
 		goto out;
 	}
 
Index: work-fault-inject/drivers/block/paride/pt.c
===================================================================
--- work-fault-inject.orig/drivers/block/paride/pt.c
+++ work-fault-inject/drivers/block/paride/pt.c
@@ -946,12 +946,12 @@ static int __init pt_init(void)
 	int err;
 
 	if (disable) {
-		err = -1;
+		err = -EINVAL;
 		goto out;
 	}
 
 	if (pt_detect()) {
-		err = -1;
+		err = -ENODEV;
 		goto out;
 	}
 

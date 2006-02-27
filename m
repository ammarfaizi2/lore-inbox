Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWB0WgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWB0WgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWB0Wbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:29825 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932365AbWB0Wbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:50 -0500
Message-Id: <20060227223358.303855000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:26 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, j-nomura@ce.jp.nec.com,
       agk@redhat.com
Subject: [patch 26/39] [PATCH] dm: free minor after unlink gendisk
Content-Disposition: inline; filename=dm-free-minor-after-unlink-gendisk.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Minor number should be freed after del_gendisk().  Otherwise, there could
be a window where 2 registered gendisk has same minor number.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Acked-by: Alasdair G Kergon <agk@redhat.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
[chrisw: backport to 2.6.15]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/md/dm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.15.4.orig/drivers/md/dm.c
+++ linux-2.6.15.4/drivers/md/dm.c
@@ -812,14 +812,16 @@ static struct mapped_device *alloc_dev(u
 
 static void free_dev(struct mapped_device *md)
 {
+	unsigned int minor = md->disk->first_minor;
+
 	if (md->frozen_bdev) {
 		thaw_bdev(md->frozen_bdev, NULL);
 		bdput(md->frozen_bdev);
 	}
-	free_minor(md->disk->first_minor);
 	mempool_destroy(md->tio_pool);
 	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
+	free_minor(minor);
 	put_disk(md->disk);
 	blk_put_queue(md->queue);
 	kfree(md);

--

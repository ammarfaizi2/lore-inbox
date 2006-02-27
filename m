Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWB0Wqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWB0Wqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWB0Wqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:46:35 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:60800 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751758AbWB0WbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:18 -0500
Message-Id: <20060227223357.241149000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, j-nomura@ce.jp.nec.com,
       agk@redhat.com
Subject: [patch 25/39] [PATCH] dm: missing bdput/thaw_bdev at removal
Content-Disposition: inline; filename=dm-missing-bdput-thaw_bdev-at-removal.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Need to unfreeze and release bdev otherwise the bdev inode with
inconsistent state is reused later and cause problem.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Acked-by: Alasdair G Kergon <agk@redhat.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
[chrisw: backport to 2.6.15]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/md/dm.c |    4 ++++
 1 files changed, 4 insertions(+)

--- linux-2.6.15.4.orig/drivers/md/dm.c
+++ linux-2.6.15.4/drivers/md/dm.c
@@ -812,6 +812,10 @@ static struct mapped_device *alloc_dev(u
 
 static void free_dev(struct mapped_device *md)
 {
+	if (md->frozen_bdev) {
+		thaw_bdev(md->frozen_bdev, NULL);
+		bdput(md->frozen_bdev);
+	}
 	free_minor(md->disk->first_minor);
 	mempool_destroy(md->tio_pool);
 	mempool_destroy(md->io_pool);

--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUJYVVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUJYVVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUJYVVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:21:23 -0400
Received: from av4-1-sn3.vrr.skanova.net ([81.228.9.111]:50582 "EHLO
	av4-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261295AbUJYVSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:18:13 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: [PATCH] Fix incorrect Mt Rainier detection
From: Peter Osterlund <petero2@telia.com>
Date: 25 Oct 2004 23:18:07 +0200
Message-ID: <m3wtxeijjk.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cdrom_is_mrw() can incorrectly think that a drive is Mt Rainier
capable, because if forgets to check if the "GET CONFIGURATION"
command returns the MRW feature number.  According to the MMC spec,
the drive shall return all feature numbers >= the starting feature
number, so even if the drive doesn't support Mt Rainier, it can return
some data that makes cdrom_is_mrw() incorrectly think the drive is MRW
capable.

This problem stops me from mounting DVD+RW discs in R/W mode on my
laptop, because it makes cdrom_open_write() call
cdrom_mrw_open_write() which fails because the drive isn't really MRW
capable.

The fix is to make sure the returned feature number is the correct one
for Mt Rainier.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/cdrom/cdrom.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/cdrom/cdrom.c~mrw-fix drivers/cdrom/cdrom.c
--- linux/drivers/cdrom/cdrom.c~mrw-fix	2004-10-25 22:43:15.711347640 +0200
+++ linux-petero/drivers/cdrom/cdrom.c	2004-10-25 22:43:15.716346880 +0200
@@ -546,6 +546,8 @@ int cdrom_is_mrw(struct cdrom_device_inf
 		return ret;
 
 	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];
+	if (be16_to_cpu(mfd->feature_code) != CDF_MRW)
+		return 1;
 	*write = mfd->write;
 
 	if ((ret = cdrom_mrw_probe_pc(cdi))) {
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

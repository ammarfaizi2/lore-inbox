Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVDVPMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVDVPMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVDVPKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:10:22 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:33704 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261969AbVDVPC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:02:58 -0400
Date: Fri, 22 Apr 2005 17:02:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 9/12] s390: don't pad cdl blocks for write requests.
Message-ID: <20050422150223.GI17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 9/12] s390: don't pad cdl blocks for write requests.

From: Horst Hummel <horst.hummel@de.ibm.com>

The first blocks on a cdl formatted dasd device are smaller than the
blocksize of the device. Read requests are padded with a 'e5' pattern.
Write requests should not pad the (user) buffer with 'e5' because a
write request is not allowed to modify the buffer.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd_eckd.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2005-04-22 15:44:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2005-04-22 15:45:05.000000000 +0200
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.69 $
+ * $Revision: 1.71 $
  */
 
 #include <linux/config.h>
@@ -1101,7 +1101,8 @@ dasd_eckd_build_cp(struct dasd_device * 
 				if (dasd_eckd_cdl_special(blk_per_trk, recid)){
 					rcmd |= 0x8;
 					count = dasd_eckd_cdl_reclen(recid);
-					if (count < blksize)
+					if (count < blksize &&
+					    rq_data_dir(req) == READ)
 						memset(dst + count, 0xe5,
 						       blksize - count);
 				}

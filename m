Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758272AbWK2WDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272AbWK2WDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758210AbWK2WCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:02:45 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57777 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758272AbWK2WCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:02:04 -0500
Message-Id: <20061129220255.546065000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, James.Bottomley@steeleye.com,
       htejun@gmail.com, dougg@torque.net, jens.axboe@oracle.com,
       mfluhr@nero.com, jgarzik@pobox.com
Subject: [patch 01/23] scsi: clear garbage after CDBs on SG_IO
Content-Disposition: inline; filename=scsi-clear-garbage-after-cdbs-on-sg_io.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Tejun Heo <htejun@gmail.com>

ATAPI devices transfer fixed number of bytes for CDBs (12 or 16).  Some
ATAPI devices choke when shorter CDB is used and the left bytes contain
garbage.  Block SG_IO cleared left bytes but SCSI SG_IO didn't.  This patch
makes SCSI SG_IO clear it and simplify CDB clearing in block SG_IO.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mathieu Fluhr <mfluhr@nero.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>
Cc: Douglas Gilbert <dougg@torque.net>
Acked-by: Jens Axboe <jens.axboe@oracle.com>
Cc: <stable@kernel.org>
Acked-by: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 block/scsi_ioctl.c      |    3 +--
 drivers/scsi/scsi_lib.c |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.4.orig/block/scsi_ioctl.c
+++ linux-2.6.18.4/block/scsi_ioctl.c
@@ -286,9 +286,8 @@ static int sg_io(struct file *file, requ
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr->cmd_len;
+	memset(rq->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(rq->cmd, cmd, hdr->cmd_len);
-	if (sizeof(rq->cmd) != hdr->cmd_len)
-		memset(rq->cmd + hdr->cmd_len, 0, sizeof(rq->cmd) - hdr->cmd_len);
 
 	memset(sense, 0, sizeof(sense));
 	rq->sense = sense;
--- linux-2.6.18.4.orig/drivers/scsi/scsi_lib.c
+++ linux-2.6.18.4/drivers/scsi/scsi_lib.c
@@ -408,6 +408,7 @@ int scsi_execute_async(struct scsi_devic
 		goto free_req;
 
 	req->cmd_len = cmd_len;
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sioc->sense;
 	req->sense_len = 0;

--

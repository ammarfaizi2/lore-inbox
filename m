Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTEYQMT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 12:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTEYQMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 12:12:19 -0400
Received: from mcmmta1.mediacapital.pt ([193.126.240.146]:25034 "EHLO
	mcmmta1.mediacapital.pt") by vger.kernel.org with ESMTP
	id S263418AbTEYQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 12:12:17 -0400
Date: Sun, 25 May 2003 17:25:49 +0100
From: "Paulo Andre'" <fscked@iol.pt>
Subject: [PATCH] Check copy_*_user return value in drivers/block/scsi_ioctl.c
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030525172549.7df834f9.fscked@iol.pt>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: multipart/mixed; boundary="Boundary_(ID_aPORyv4WFVOcyUpReFAB3Q)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_aPORyv4WFVOcyUpReFAB3Q)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hi Jens,

Please find attached a trivial patch that checks both
copy_to_user() and copy_from_user() returns values in scsi_ioctl.c,
returning accordinly in case of a transfer error.

Please review.


		Paulo Andre'




--Boundary_(ID_aPORyv4WFVOcyUpReFAB3Q)
Content-type: text/plain; name=patch-scsi_ioctl.c.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patch-scsi_ioctl.c.diff

--- scsi_ioctl.c.orig	2003-05-25 16:42:22.000000000 +0100
+++ scsi_ioctl.c	2003-05-25 16:59:44.000000000 +0100
@@ -213,7 +213,8 @@
 
 			nr_sectors = bytes >> 9;
 			if (writing)
-				copy_from_user(buffer,hdr.dxferp,hdr.dxfer_len);
+				if (copy_from_user(buffer,hdr.dxferp,hdr.dxfer_len))
+					goto efault;
 			else
 				memset(buffer, 0, hdr.dxfer_len);
 		}
@@ -225,7 +226,8 @@
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr.cmd_len;
-	copy_from_user(rq->cmd, hdr.cmdp, hdr.cmd_len);
+	if (copy_from_user(rq->cmd, hdr.cmdp, hdr.cmd_len))
+		goto efault;
 	if (sizeof(rq->cmd) != hdr.cmd_len)
 		memset(rq->cmd + hdr.cmd_len, 0, sizeof(rq->cmd) - hdr.cmd_len);
 
@@ -286,17 +288,23 @@
 
 	blk_put_request(rq);
 
-	copy_to_user(uptr, &hdr, sizeof(*uptr));
+	if (copy_to_user(uptr, &hdr, sizeof(*uptr)))
+		goto efault;
 
 	if (buffer) {
 		if (reading)
-			copy_to_user(hdr.dxferp, buffer, hdr.dxfer_len);
+			if (copy_to_user(hdr.dxferp, buffer, hdr.dxfer_len))
+				goto efault;
 
 		kfree(buffer);
 	}
 	/* may not have succeeded, but output values written to control
 	 * structure (struct sg_io_hdr).  */
 	return 0;
+efault:
+	if (buffer)
+		kfree(buffer);
+	return -EFAULT;
 }
 
 #define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)

--Boundary_(ID_aPORyv4WFVOcyUpReFAB3Q)--

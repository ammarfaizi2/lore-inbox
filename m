Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTEYQoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTEYQoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 12:44:11 -0400
Received: from mcmmta2.mediacapital.pt ([193.126.240.147]:13282 "EHLO
	mcmmta2.mediacapital.pt") by vger.kernel.org with ESMTP
	id S263510AbTEYQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 12:44:09 -0400
Date: Sun, 25 May 2003 17:58:12 +0100
From: "Paulo Andre'" <fscked@iol.pt>
Subject: Re: [PATCH] Check copy_*_user return value in
 drivers/block/scsi_ioctl.c
In-reply-to: <20030525162844.GJ812@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030525175812.3f8f3296.fscked@iol.pt>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: multipart/mixed; boundary="Boundary_(ID_7AyJQvUDAWJ9HprqNNGVRQ)"
References: <20030525172549.7df834f9.fscked@iol.pt>
 <20030525162844.GJ812@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_7AyJQvUDAWJ9HprqNNGVRQ)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT

On Sun, 25 May 2003 18:28:44 +0200
Jens Axboe <axboe@suse.de> wrote:

> 
> See above, we've already done access_ok() on the buffer so the
> "unchecked" copy_to/from_user are done that way on purpose. I suppose
> it could be made more explicit with __copy_to/from_user().

Ok, makes sense indeed. Please consider the following patch then.


		Paulo

--Boundary_(ID_7AyJQvUDAWJ9HprqNNGVRQ)
Content-type: text/plain; name=patch-scsi_ioctl.c.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patch-scsi_ioctl.c.diff

--- scsi_ioctl.c.orig	2003-05-25 16:42:22.000000000 +0100
+++ scsi_ioctl.c	2003-05-25 17:54:21.000000000 +0100
@@ -213,7 +213,7 @@
 
 			nr_sectors = bytes >> 9;
 			if (writing)
-				copy_from_user(buffer,hdr.dxferp,hdr.dxfer_len);
+				__copy_from_user(buffer,hdr.dxferp,hdr.dxfer_len);
 			else
 				memset(buffer, 0, hdr.dxfer_len);
 		}
@@ -225,7 +225,7 @@
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr.cmd_len;
-	copy_from_user(rq->cmd, hdr.cmdp, hdr.cmd_len);
+	__copy_from_user(rq->cmd, hdr.cmdp, hdr.cmd_len);
 	if (sizeof(rq->cmd) != hdr.cmd_len)
 		memset(rq->cmd + hdr.cmd_len, 0, sizeof(rq->cmd) - hdr.cmd_len);
 
@@ -286,11 +286,11 @@
 
 	blk_put_request(rq);
 
-	copy_to_user(uptr, &hdr, sizeof(*uptr));
+	__copy_to_user(uptr, &hdr, sizeof(*uptr));
 
 	if (buffer) {
 		if (reading)
-			copy_to_user(hdr.dxferp, buffer, hdr.dxfer_len);
+			__copy_to_user(hdr.dxferp, buffer, hdr.dxfer_len);
 
 		kfree(buffer);
 	}

--Boundary_(ID_7AyJQvUDAWJ9HprqNNGVRQ)--

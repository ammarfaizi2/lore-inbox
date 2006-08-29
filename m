Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWH2NVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWH2NVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWH2NVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:21:18 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:61637 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964950AbWH2NVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:21:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=GWG5WJ7rspjWnFzj7HFxkSosfflk2jufO2lJblDiBfMqRg272NH0rl74m9L7lDen/m4Cd9wj1u2j1h92ReynNeWGKWfsSJlutZNlhrBSilHUDj1Hpf8KN5EY3JcecfzKcgHC3zNgfZJz3Bt7AKzp2R2g/DxsuMVosnx9nAQAXOw=
Message-ID: <44F43F46.1070702@gmail.com>
Date: Tue, 29 Aug 2006 21:21:10 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the last post is corrupted by email client, this is a repost.

In the current implementation of AIO, for the operation IOCB_CMD_FDSYNC

and IOCB_CMD_FSYNC, the returned errno is -EINVAL although the kernel

does know them, I think the correct errno should be -EOPNOTSUPP which

means they aren't be implemented or supported.

--- a/fs/aio.c.orig	2006-08-28 15:15:18.000000000 +0800
+++ b/fs/aio.c	2006-08-28 15:33:59.000000000 +0800
@@ -1363,20 +1363,10 @@ static ssize_t aio_pwrite(struct kiocb *
 	return ret;
 }
 
-static ssize_t aio_fdsync(struct kiocb *iocb)
-{
-	struct file *file = iocb->ki_filp;
-	ssize_t ret = -EINVAL;
-
-	if (file->f_op->aio_fsync)
-		ret = file->f_op->aio_fsync(iocb, 1);
-	return ret;
-}
-
 static ssize_t aio_fsync(struct kiocb *iocb)
 {
 	struct file *file = iocb->ki_filp;
-	ssize_t ret = -EINVAL;
+	ssize_t ret = -EOPNOTSUPP;
 
 	if (file->f_op->aio_fsync)
 		ret = file->f_op->aio_fsync(iocb, 0);
@@ -1425,12 +1415,12 @@ static ssize_t aio_setup_iocb(struct kio
 			kiocb->ki_retry = aio_pwrite;
 		break;
 	case IOCB_CMD_FDSYNC:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		if (file->f_op->aio_fsync)
-			kiocb->ki_retry = aio_fdsync;
+			kiocb->ki_retry = aio_fsync;
 		break;
 	case IOCB_CMD_FSYNC:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		if (file->f_op->aio_fsync)
 			kiocb->ki_retry = aio_fsync;
 		break;



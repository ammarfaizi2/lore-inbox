Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWH1N2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWH1N2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 09:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWH1N2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 09:28:53 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:19756 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750809AbWH1N2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 09:28:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=qeB3LadWmtexxPhCSNydP3MQp6erksQ349NNX8wn4Bqa0rjaKSsrsRNHChvfCbMYMsbbG/QK7gjXtY81mwVZ6hdpEmdLy83ABFmgHws344RQDpf5cCmwRIvxeREXAjm5cRWAKE3SaPpwUtes7E6QVD5HnjrK2YaseD9W/11K/7E=
Message-ID: <44F2EF90.9050603@gmail.com>
Date: Mon, 28 Aug 2006 21:28:48 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current implementation of AIO, for the operation IOCB_CMD_FDSYNC
and IOCB_CMD_FSYNC, the returned errno is -EINVAL although the kernel
does know them, I think the correct errno should be -EOPNOTSUPP which
means they aren't be implemented or supported.

>From the kernel source code, we can see they can be supported without
any code modification if a specific filesystem implements aio_fsync.

Another obvious problem is the function aio_fsync is as same as the
function aio_fdsync, so they are duplicate, only one is enough.

Here this patch is.



--- a/fs/aio.c.orig 2006-08-28 15:15:18.000000000 +0800
+++ b/fs/aio.c 2006-08-28 15:33:59.000000000 +0800
@@ -1363,20 +1363,10 @@ static ssize_t aio_pwrite(struct kiocb *
return ret;
}

-static ssize_t aio_fdsync(struct kiocb *iocb)
-{
- struct file *file = iocb->ki_filp;
- ssize_t ret = -EINVAL;
-
- if (file->f_op->aio_fsync)
- ret = file->f_op->aio_fsync(iocb, 1);
- return ret;
-}
-
static ssize_t aio_fsync(struct kiocb *iocb)
{
struct file *file = iocb->ki_filp;
- ssize_t ret = -EINVAL;
+ ssize_t ret = -EOPNOTSUPP;

if (file->f_op->aio_fsync)
ret = file->f_op->aio_fsync(iocb, 0);
@@ -1425,12 +1415,12 @@ static ssize_t aio_setup_iocb(struct kio
kiocb->ki_retry = aio_pwrite;
break;
case IOCB_CMD_FDSYNC:
- ret = -EINVAL;
+ ret = -EOPNOTSUPP;
if (file->f_op->aio_fsync)
- kiocb->ki_retry = aio_fdsync;
+ kiocb->ki_retry = aio_fsync;
break;
case IOCB_CMD_FSYNC:
- ret = -EINVAL;
+ ret = -EOPNOTSUPP;
if (file->f_op->aio_fsync)
kiocb->ki_retry = aio_fsync;
break;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVJLTNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVJLTNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVJLTNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:13:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932435AbVJLTNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:13:55 -0400
Date: Wed, 12 Oct 2005 12:13:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] LSM update, another missing hook
Message-ID: <20051012191353.GG5856@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git/

This has one small fix in it:

 fs/aio.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

Kostik Belousov:
  aio syscalls are not checked by lsm

Patch inline below since it's small.

thanks,
-chris
--

>From nobody Mon Sep 17 00:00:00 2001
Subject: [PATCH] aio syscalls are not checked by lsm
From: Kostik Belousov <konstantin.belousov@zoral.com.ua>

another case of missing call to security_file_permission:
aio functions (namely, io_submit) does not check credentials
with security modules.

Below is the simple patch to the problem. It seems that it is
enough to check for rights at the request submission time.

Signed-off-by: Kostik Belousov <kostikbel@gmail.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 fs/aio.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

f223267dee21023ac5c1a0cdbbdbfed0dc8c8fff
diff --git a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1418,6 +1418,9 @@ static ssize_t aio_setup_iocb(struct kio
 		if (unlikely(!access_ok(VERIFY_WRITE, kiocb->ki_buf,
 			kiocb->ki_left)))
 			break;
+		ret = security_file_permission(file, MAY_READ);
+		if (unlikely(ret))
+			break;
 		ret = -EINVAL;
 		if (file->f_op->aio_read)
 			kiocb->ki_retry = aio_pread;
@@ -1430,6 +1433,9 @@ static ssize_t aio_setup_iocb(struct kio
 		if (unlikely(!access_ok(VERIFY_READ, kiocb->ki_buf,
 			kiocb->ki_left)))
 			break;
+		ret = security_file_permission(file, MAY_WRITE);
+		if (unlikely(ret))
+			break;
 		ret = -EINVAL;
 		if (file->f_op->aio_write)
 			kiocb->ki_retry = aio_pwrite;


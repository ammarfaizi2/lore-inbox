Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264908AbUFOBX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbUFOBX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 21:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbUFOBX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 21:23:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63197 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264908AbUFOBXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 21:23:25 -0400
Date: Mon, 14 Jun 2004 21:23:11 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, Alexander Viro <aviro@redhat.com>,
       Chris Wright <chrisw@osdl.org>, <bcrl@kvack.org>
cc: Stephen Tweedie <sct@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       <linux-kernel@vger.kernel.org>
Subject: [VFS/LSM] Add security_file_permission() to AIO paths.
Message-ID: <Xine.LNX.4.44.0406142059340.25292-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are no LSM hooks in the AIO codepaths, which means that
LSM based access controls are not revalidated upon AIO read and write
operations.  The patch below adds the security_file_permission() LSM hook
prior to the VFS aio_read()/aio_write() calls.

Please review and apply if ok.


Signed-off-by: James Morris <jmorris@redhat.com>


diff -purN -X dontdiff linux-2.6.7-rc3.o/fs/aio.c linux-2.6.7-rc3.aio/fs/aio.c
--- linux-2.6.7-rc3.o/fs/aio.c	2004-06-07 18:54:13.000000000 -0400
+++ linux-2.6.7-rc3.aio/fs/aio.c	2004-06-14 20:47:22.338492008 -0400
@@ -27,6 +27,7 @@
 #include <linux/aio.h>
 #include <linux/highmem.h>
 #include <linux/workqueue.h>
+#include <linux/security.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -1036,6 +1037,9 @@ int fastcall io_submit_one(struct kioctx
 		ret = -EFAULT;
 		if (unlikely(!access_ok(VERIFY_WRITE, buf, iocb->aio_nbytes)))
 			goto out_put_req;
+		ret = security_file_permission (file, MAY_READ);
+		if (ret)
+			goto out_put_req;
 		ret = -EINVAL;
 		if (file->f_op->aio_read)
 			ret = file->f_op->aio_read(req, buf,
@@ -1048,6 +1052,9 @@ int fastcall io_submit_one(struct kioctx
 		ret = -EFAULT;
 		if (unlikely(!access_ok(VERIFY_READ, buf, iocb->aio_nbytes)))
 			goto out_put_req;
+		ret = security_file_permission (file, MAY_WRITE);	
+		if (ret)
+			goto out_put_req;
 		ret = -EINVAL;
 		if (file->f_op->aio_write)
 			ret = file->f_op->aio_write(req, buf,


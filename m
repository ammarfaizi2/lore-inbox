Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTFQA31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTFQA31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:29:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264476AbTFQA3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:29:17 -0400
Subject: [PATCH 2.5.71-mm1] aio process hang on EINVAL
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Content-Type: multipart/mixed; boundary="=-//H5w9P6oqDVXMvkd3e/"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Jun 2003 17:43:28 -0700
Message-Id: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-//H5w9P6oqDVXMvkd3e/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

Here is a patch to fix EINVAL handling in io_submit_one() that was
causing a process hang when attempting AIO to a device not able
to handle aio.  I hit this doing a AIO read from /dev/zero.  The
process would hang on exit in wait_for_all_aios().  The fix is
to check for EINVAL coming back from aio_setup_iocb() in addition
to the EFAULT and EBADF already there.  This causes the io_submit
to fail with EINVAL.  That check looks error prone.
Are there other error return values where it should jump to the
aio_put_req()?  Should the check be:

	if (ret != 0 && ret != -EIOCBQUEUED)
		goto out_put_req;

Thanks,

Daniel McNeil <daniel@osdl.org>

--=-//H5w9P6oqDVXMvkd3e/
Content-Disposition: attachment; filename=patch.2.5.71-mm1.aio
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch.2.5.71-mm1.aio; charset=ISO-8859-1

diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.71-mm1/fs/aio.c linux-2.5=
.71-mm1.patch/fs/aio.c
--- linux-2.5.71-mm1/fs/aio.c	2003-06-16 15:17:22.000000000 -0700
+++ linux-2.5.71-mm1.patch/fs/aio.c	2003-06-16 16:46:27.515255621 -0700
@@ -1504,7 +1504,7 @@ int io_submit_one(struct kioctx *ctx, st
=20
 	ret =3D aio_setup_iocb(req, iocb);
=20
-	if ((-EBADF =3D=3D ret) || (-EFAULT =3D=3D ret))
+	if ((-EBADF =3D=3D ret) || (-EFAULT =3D=3D ret) || (-EINVAL =3D=3D ret))
 		goto out_put_req;
=20
 	spin_lock_irq(&ctx->ctx_lock);

--=-//H5w9P6oqDVXMvkd3e/--


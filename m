Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263929AbTDWBnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 21:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbTDWBnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 21:43:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38595 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263929AbTDWBnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 21:43:33 -0400
Subject: [PATCH] Small bug fix for aio
From: Mingming Cao <cmm@us.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Content-Type: multipart/mixed; boundary="=-J1SWzDJljbfhsVT+MOwZ"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Apr 2003 18:54:51 -0700
Message-Id: <1051062904.2808.37.camel@w-ming.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J1SWzDJljbfhsVT+MOwZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Here is a trivial patch fixed a bug in ioctx_alloc(). If
aio_setup_ring() failed, ioctx_alloc() should pass the return error from
aio_setup_ring() back to sys_io_setup().

Please apply. Thanks.

--=-J1SWzDJljbfhsVT+MOwZ
Content-Disposition: attachment; filename=aiofix.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=aiofix.patch; charset=UTF-8

diff -urNp linux-2.5.68/fs/aio.c 2568/fs/aio.c
--- linux-2.5.68/fs/aio.c	Sat Apr 19 19:49:25 2003
+++ 2568/fs/aio.c	Tue Apr 22 17:52:21 2003
@@ -204,6 +204,7 @@ static struct kioctx *ioctx_alloc(unsign
 {
 	struct mm_struct *mm;
 	struct kioctx *ctx;
+	int ret =3D 0;
=20
 	/* Prevent overflows */
 	if ((nr_events > (0x10000000U / sizeof(struct io_event))) ||
@@ -233,7 +234,8 @@ static struct kioctx *ioctx_alloc(unsign
 	INIT_LIST_HEAD(&ctx->run_list);
 	INIT_WORK(&ctx->wq, aio_kick_handler, ctx);
=20
-	if (aio_setup_ring(ctx) < 0)
+	ret =3D aio_setup_ring(ctx);
+	if (unlikely(ret < 0))
 		goto out_freectx;
=20
 	/* limit the number of system wide aios */
@@ -259,7 +261,7 @@ out_cleanup:
=20
 out_freectx:
 	kmem_cache_free(kioctx_cachep, ctx);
-	ctx =3D ERR_PTR(-ENOMEM);
+	ctx =3D ERR_PTR(ret);
=20
 	dprintk("aio: error allocating ioctx %p\n", ctx);
 	return ctx;

--=-J1SWzDJljbfhsVT+MOwZ--


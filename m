Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTKKSBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTKKSBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:01:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:20708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263587AbTKKSBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:01:10 -0500
Subject: [PATCH 2.6.0-test9] AIO-ref-count.patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20031110154232.55eb9b10.akpm@osdl.org>
References: <20031104225544.0773904f.akpm@osdl.org>
	 <1068505605.2042.11.camel@ibm-c.pdx.osdl.net>
	 <20031110154232.55eb9b10.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-r7NyEM6odk5MnRU306bp"
Organization: 
Message-Id: <1068573662.3405.12.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Nov 2003 10:01:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r7NyEM6odk5MnRU306bp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

If you do not want to go with the retry-based AIO in mm, here is
the AIO ref count patch against 2.6.0-test9.  This is a bit different
than the version in -mm, but accomplishes the same thing -- the submit
path holds an extra reference until just before returning.  This fixes
the referencing a free kiocb.

Without this patch on test9 (with PAGEALLOC_DEBUG), I get:
 
Unable to handle kernel paging request at virtual address df4fbf90
 printing eip:
c0143dc4
*pde = 0007f067
*pte = 1f4fb000
Oops: 0002 [#1]
CPU:    1
EIP:    0060:[<c0143dc4>]    Not tainted
EFLAGS: 00210287
EIP is at generic_file_aio_write_nolock+0x936/0xbbd
eax: 019d0000   ebx: 06400000   ecx: df4fbf90   edx: 00000000
esi: 00000000   edi: e700de88   ebp: df533eb4   esp: df533dc0
ds: 007b   es: 007b   ss: 0068
Process aiodio_sparse (pid: 1824, threadinfo=df532000 task=e66e29b0)
Stack: 00000001 df4fbf58 df533ecc 019c0000 00000000 00000001 00000001 df533e04
       00200286 c148fc10 00000000 00200286 db234d94 df533e18 f7a89218 019d0000
       00000000 df533e18 c011dd46 f65dbdf8 ffffffff 00000041 df533e50 00010000
Call Trace:
 [<c011dd46>] kernel_map_pages+0x28/0x5d
 [<c0144162>] generic_file_aio_write+0x86/0xa4
 [<c01a12d7>] ext3_file_write+0x3f/0xcc
 [<c018c948>] io_submit_one+0x2b5/0x2f7
 [<c018ca67>] sys_io_submit+0xdd/0x143
 [<c010a6c7>] syscall_call+0x7/0xb


I'm working on the other AIO fixes against mainline.

Thanks,

Daniel

--=-r7NyEM6odk5MnRU306bp
Content-Disposition: attachment; filename=2.6.0-test9-aio-refcnt.patch
Content-Type: text/plain; name=2.6.0-test9-aio-refcnt.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test9/fs/aio.c	2003-10-25 11:43:33.000000000 -0700
+++ linux-2.6.0-test9.aio-refcnt/fs/aio.c	2003-11-10 18:05:34.151193068 -0800
@@ -376,6 +376,11 @@ void __put_ioctx(struct kioctx *ctx)
  *	Allocate a slot for an aio request.  Increments the users count
  * of the kioctx so that the kioctx stays around until all requests are
  * complete.  Returns NULL if no requests are free.
+ *
+ * Returns with kiocb->users set to 2.  The io submit code path holds
+ * an extra reference while submitting the i/o.
+ * This prevents races between the aio code path referencing the
+ * req (after submitting it) and aio_complete() freeing the req.
  */
 static struct kiocb *FASTCALL(__aio_get_req(struct kioctx *ctx));
 static struct kiocb *__aio_get_req(struct kioctx *ctx)
@@ -389,7 +394,7 @@ static struct kiocb *__aio_get_req(struc
 		return NULL;
 
 	req->ki_flags = 1 << KIF_LOCKED;
-	req->ki_users = 1;
+	req->ki_users = 2;
 	req->ki_key = 0;
 	req->ki_ctx = ctx;
 	req->ki_cancel = NULL;
@@ -1009,7 +1014,7 @@ int io_submit_one(struct kioctx *ctx, st
 	if (unlikely(!file))
 		return -EBADF;
 
-	req = aio_get_req(ctx);
+	req = aio_get_req(ctx);		/* returns with 2 references to req */
 	if (unlikely(!req)) {
 		fput(file);
 		return -EAGAIN;
@@ -1069,13 +1074,15 @@ int io_submit_one(struct kioctx *ctx, st
 		ret = -EINVAL;
 	}
 
+	aio_put_req(req);	/* drop extra ref to req */
 	if (likely(-EIOCBQUEUED == ret))
 		return 0;
-	aio_complete(req, ret, 0);
+	aio_complete(req, ret, 0);	/* will drop i/o ref to req */
 	return 0;
 
 out_put_req:
-	aio_put_req(req);
+	aio_put_req(req);	/* drop extra ref to req */
+	aio_put_req(req);	/* drop i/o ref to req */
 	return ret;
 }
 

--=-r7NyEM6odk5MnRU306bp--


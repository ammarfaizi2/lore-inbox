Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966991AbWK2KeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966991AbWK2KeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966980AbWK2KeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:34:10 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:30685 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S966993AbWK2KeI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:34:08 -0500
Date: Wed, 29 Nov 2006 11:32:12 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: [PATCH -mm 1/5][AIO] - Rework compat_sys_io_submit
Message-ID: <20061129113212.1e614a61@frecb000686>
In-Reply-To: <20061129112441.745351c9@frecb000686>
References: <20061129112441.745351c9@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:41:17,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:41:19,
	Serialize complete at 29/11/2006 11:41:19
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                 compat_sys_io_submit() cleanup


  Cleanup compat_sys_io_submit by duplicating some of the native syscall
logic in the compat layer and directly calling io_submit_one() instead
of fooling the syscall into thinking it is called from a native 64-bit
caller.

  This is needed for the completion notification patch to avoid having
to rewrite each iocb on the caller stack for sys_io_submit() to find the
sigevents.



 compat.c |   61 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.19-rc6-mm2/fs/compat.c
===================================================================
--- linux-2.6.19-rc6-mm2.orig/fs/compat.c	2006-11-28 12:49:40.000000000
+0100 +++ linux-2.6.19-rc6-mm2/fs/compat.c	2006-11-28 12:51:35.000000000
+0100 @@ -642,40 +642,49 @@ out:
 	return ret;
 }
 
-static inline long
-copy_iocb(long nr, u32 __user *ptr32, struct iocb __user * __user *ptr64)
+asmlinkage long
+compat_sys_io_submit(aio_context_t ctx_id, int nr, u32 __user *iocb)
 {
-	compat_uptr_t uptr;
+	struct kioctx *ctx;
+	long ret = 0;
 	int i;
 
-	for (i = 0; i < nr; ++i) {
-		if (get_user(uptr, ptr32 + i))
-			return -EFAULT;
-		if (put_user(compat_ptr(uptr), ptr64 + i))
-			return -EFAULT;
-	}
-	return 0;
-}
+	if (unlikely(nr < 0))
+		return -EINVAL;
 
-#define MAX_AIO_SUBMITS 	(PAGE_SIZE/sizeof(struct iocb *))
+	if (unlikely(!access_ok(VERIFY_READ, iocb, (nr * sizeof(u32)))))
+		return -EFAULT;
 
-asmlinkage long
-compat_sys_io_submit(aio_context_t ctx_id, int nr, u32 __user *iocb)
-{
-	struct iocb __user * __user *iocb64; 
-	long ret;
+	ctx = lookup_ioctx(ctx_id);
 
-	if (unlikely(nr < 0))
+	if (unlikely(!ctx))
 		return -EINVAL;
+	for (i=0; i<nr; i++) {
+		compat_uptr_t uptr;
+		struct iocb __user *user_iocb;
+		struct iocb tmp;
 
-	if (nr > MAX_AIO_SUBMITS)
-		nr = MAX_AIO_SUBMITS;
-	
-	iocb64 = compat_alloc_user_space(nr * sizeof(*iocb64));
-	ret = copy_iocb(nr, iocb, iocb64);
-	if (!ret)
-		ret = sys_io_submit(ctx_id, nr, iocb64);
-	return ret;
+		if (get_user(uptr, iocb + i)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		user_iocb = compat_ptr(uptr);
+
+		if (unlikely(copy_from_user(&tmp, user_iocb, sizeof(tmp)))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = io_submit_one(ctx, user_iocb, &tmp);
+
+		if (ret)
+			break;
+	}
+
+	put_ioctx(ctx);
+
+	return i? i: ret;
 }
 
 struct compat_ncp_mount_data {

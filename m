Return-Path: <linux-kernel-owner+w=401wt.eu-S932242AbXAQJ7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbXAQJ7A (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbXAQJ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:58:38 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42758 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbXAQJ6e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:58:34 -0500
Date: Wed, 17 Jan 2007 10:48:05 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-aio <linux-aio@kvack.org>,
       Bharata B Rao <bharata@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: [PATCH -mm 1/5][AIO] - Rework compat_sys_io_submit
Message-ID: <20070117104805.723d15dc@frecb000686>
In-Reply-To: <20070117104601.36b2ab18@frecb000686>
References: <20070117104601.36b2ab18@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 11:06:49,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 11:06:50,
	Serialize complete at 17/01/2007 11:06:50
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


                 compat_sys_io_submit() cleanup


  Cleanup compat_sys_io_submit by duplicating some of the native syscall
logic in the compat layer and directly calling io_submit_one() instead
of fooling the syscall into thinking it is called from a native 64-bit
caller.

  This eliminates:

  - the overhead of copying the nr iocb pointers on the userspace stack

  - the PAGE_SIZE/(sizeof(void *)) limit on the number of iocbs that
    can be submitted.

  This is also needed for the completion notification patch to avoid having
to rewrite each iocb on the caller stack for io_submit_one() to find the
sigevents.


 compat.c |   61 ++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.20-rc4-mm1/fs/compat.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/fs/compat.c	2007-01-12 11:40:28.000000000 +0100
+++ linux-2.6.20-rc4-mm1/fs/compat.c	2007-01-12 12:14:51.000000000 +0100
@@ -644,40 +644,47 @@ out:
 	return ret;
 }
 
-static inline long
-copy_iocb(long nr, u32 __user *ptr32, struct iocb __user * __user *ptr64)
-{
-	compat_uptr_t uptr;
-	int i;
-
-	for (i = 0; i < nr; ++i) {
-		if (get_user(uptr, ptr32 + i))
-			return -EFAULT;
-		if (put_user(compat_ptr(uptr), ptr64 + i))
-			return -EFAULT;
-	}
-	return 0;
-}
-
-#define MAX_AIO_SUBMITS 	(PAGE_SIZE/sizeof(struct iocb *))
-
 asmlinkage long
 compat_sys_io_submit(aio_context_t ctx_id, int nr, u32 __user *iocb)
 {
-	struct iocb __user * __user *iocb64; 
-	long ret;
+	struct kioctx *ctx;
+	long ret = 0;
+	int i;
 
 	if (unlikely(nr < 0))
 		return -EINVAL;
 
-	if (nr > MAX_AIO_SUBMITS)
-		nr = MAX_AIO_SUBMITS;
-	
-	iocb64 = compat_alloc_user_space(nr * sizeof(*iocb64));
-	ret = copy_iocb(nr, iocb, iocb64);
-	if (!ret)
-		ret = sys_io_submit(ctx_id, nr, iocb64);
-	return ret;
+	if (unlikely(!access_ok(VERIFY_READ, iocb, (nr * sizeof(u32)))))
+		return -EFAULT;
+
+	ctx = lookup_ioctx(ctx_id);
+	if (unlikely(!ctx))
+		return -EINVAL;
+
+	for (i=0; i<nr; i++) {
+		compat_uptr_t uptr;
+		struct iocb __user *user_iocb;
+		struct iocb tmp;
+
+		if (unlikely(get_user(uptr, iocb + i))) {
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
+		if (ret)
+			break;
+	}
+
+	put_ioctx(ctx);
+	return i ? i: ret;
 }
 
 struct compat_ncp_mount_data {

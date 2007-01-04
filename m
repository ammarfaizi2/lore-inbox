Return-Path: <linux-kernel-owner+w=401wt.eu-S932332AbXADJXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbXADJXc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 04:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbXADJXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 04:23:32 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45858 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbXADJXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 04:23:31 -0500
Date: Thu, 4 Jan 2007 15:00:55 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: [PATCHSET 3][PATCH 1/5][AIO] - Rework compat_sys_io_submit
Message-ID: <20070104093055.GE9608@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20070104092733.GD9608@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070104092733.GD9608@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


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

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="rework-compat-sys-io-submit.patch"
Content-Transfer-Encoding: 8bit


From: Sébastien Dugué <sebastien.dugue@bull.net>

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

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 fs/compat.c |   61 +++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 34 insertions(+), 27 deletions(-)

diff -puN fs/compat.c~rework-compat-sys-io-submit fs/compat.c
--- linux-2.6.20-rc2/fs/compat.c~rework-compat-sys-io-submit	2007-01-03 10:15:03.000000000 +0530
+++ linux-2.6.20-rc2-bharata/fs/compat.c	2007-01-04 13:21:28.000000000 +0530
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
_

--i9LlY+UWpKt15+FH--

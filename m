Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWCGEe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWCGEe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 23:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWCGEeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 23:34:25 -0500
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:9363 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932490AbWCGEeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 23:34:25 -0500
Date: Mon, 6 Mar 2006 20:34:24 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fold select_bits_alloc/free into caller code.
Message-ID: <Pine.LNX.4.58.0603062031490.10262@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes what currently seems to be an unnecessary level of
indirection in allocating and freeing select bits, as per the
select_bits_alloc() and select_bits_free() functions. Both select.c and
compat.c are updated.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru linux-2.6.16-rc5/fs/compat.c linux-new/fs/compat.c
--- linux-2.6.16-rc5/fs/compat.c	2006-03-06 20:07:34.000000000 -0800
+++ linux-new/fs/compat.c	2006-03-06 20:12:13.000000000 -0800
@@ -1638,15 +1638,6 @@ void compat_set_fd_set(unsigned long nr,
  * This is a virtual copy of sys_select from fs/select.c and probably
  * should be compared to it from time to time
  */
-static void *select_bits_alloc(int size)
-{
-	return kmalloc(6 * size, GFP_KERNEL);
-}
-
-static void select_bits_free(void *bits, int size)
-{
-	kfree(bits);
-}

 /*
  * We can actually return ERESTARTSYS instead of EINTR, but I'd
@@ -1685,7 +1676,7 @@ int compat_core_sys_select(int n, compat
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
+	bits = kmalloc(6 * size, GFP_KERNEL);
 	if (!bits)
 		goto out_nofds;
 	fds.in      = (unsigned long *)  bits;
@@ -1719,7 +1710,7 @@ int compat_core_sys_select(int n, compat
 	compat_set_fd_set(n, exp, fds.res_ex);

 out:
-	select_bits_free(bits, size);
+	kfree(bits);
 out_nofds:
 	return ret;
 }
diff -Npru linux-2.6.16-rc5/fs/select.c linux-new/fs/select.c
--- linux-2.6.16-rc5/fs/select.c	2006-03-06 20:07:35.000000000 -0800
+++ linux-new/fs/select.c	2006-03-06 20:13:11.000000000 -0800
@@ -284,16 +284,6 @@ int do_select(int n, fd_set_bits *fds, s
 	return retval;
 }

-static void *select_bits_alloc(int size)
-{
-	return kmalloc(6 * size, GFP_KERNEL);
-}
-
-static void select_bits_free(void *bits, int size)
-{
-	kfree(bits);
-}
-
 /*
  * We can actually return ERESTARTSYS instead of EINTR, but I'd
  * like to be certain this leads to no problems. So I return
@@ -332,7 +322,7 @@ static int core_sys_select(int n, fd_set
 	 */
 	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	bits = select_bits_alloc(size);
+	bits = kmalloc(6 * size, GFP_KERNEL);
 	if (!bits)
 		goto out_nofds;
 	fds.in      = (unsigned long *)  bits;
@@ -367,7 +357,7 @@ static int core_sys_select(int n, fd_set
 		ret = -EFAULT;

 out:
-	select_bits_free(bits, size);
+	kfree(bits);
 out_nofds:
 	return ret;
 }

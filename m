Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbTCaGZ1>; Mon, 31 Mar 2003 01:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbTCaGZ1>; Mon, 31 Mar 2003 01:25:27 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:50862 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261413AbTCaGZU>;
	Mon, 31 Mar 2003 01:25:20 -0500
Date: Mon, 31 Mar 2003 16:36:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Randolph Chung <randolph@tausq.org>
Subject: [PATCH][COMPAT] fix for net/compat.c
Message-Id: <20030331163625.733559b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Dave,

This is basically a patch from Randolph Chung who tells me that when
a syscall is done from the kernel, you cannot pass user mode pointers
to it on some architectures.  So we need to copy the sock_filter
array into kernel space before we pass it to the real system call.

His original patch (which does the same thing) has been tested on
parisc64-linux and this patch has been cross compiled for ppc64-linux.

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.66-033114/net/compat.c 2.5.66-033114-netfix/net/compat.c
--- 2.5.66-033114/net/compat.c	2003-03-25 12:08:29.000000000 +1100
+++ 2.5.66-033114-netfix/net/compat.c	2003-03-31 16:08:02.000000000 +1000
@@ -496,6 +496,7 @@
 	struct sock_fprog kfprog;
 	mm_segment_t old_fs;
 	compat_uptr_t uptr;
+	unsigned int fsize;
 	int ret;
 
 	if (!access_ok(VERIFY_READ, fprog32, sizeof(*fprog32)) ||
@@ -503,15 +504,14 @@
 	    __get_user(uptr, &fprog32->filter))
 		return -EFAULT;
 
-	kfprog.filter = compat_ptr(uptr);
-	/*
-	 * Since struct sock_filter is architecure independent,
-	 * we can just do the access_ok check and pass the
-	 * same pointer to the real syscall.
-	 */
-	if (!access_ok(VERIFY_READ, kfprog.filter,
-			kfprog.len * sizeof(struct sock_filter)))
+	fsize = kfprog.len * sizeof(struct sock_filter);
+	kfprog.filter = (struct sock_filter *)kmalloc(fsize, GFP_KERNEL);
+	if (kfprog.filter == NULL)
+		return -ENOMEM;
+	if (copy_from_user(kfprog.filter, compat_ptr(uptr), fsize)) {
+		kfree(kfprog.filter);
 		return -EFAULT;
+	}
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -519,6 +519,7 @@
 			     (char *)&kfprog, sizeof(kfprog));
 	set_fs(old_fs);
 
+	kfree(kfprog.filter);
 	return ret;
 }
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUIPT7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUIPT7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 15:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268182AbUIPT7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 15:59:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:47352 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268175AbUIPT7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 15:59:11 -0400
Message-ID: <4149F078.7080006@us.ibm.com>
Date: Thu, 16 Sep 2004 14:58:48 -0500
From: John Engel <jhe@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: willy@debian.org, sfr@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] compat_sys_fcntl64: fix for locking near end of file
Content-Type: multipart/mixed;
 boundary="------------000304060200000400020101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304060200000400020101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,
     Here's a patch to fix a bug in compat_sys_fcntl64 in fs/compat.c.
The bug occurs with a 32 bit app that calls fcntl and checking for a 
lock near the end of a file.

    struct flock sflp;
    sflp.l_start = 2147483345;
    sflp.l_len = 302;
    /* 2147483345 + 302 == 2147483647 (this should not overflow 31 bits) */
    /* 2^31 ==             2147483648 */
    fcntl_stat = fcntl(fd, F_GETLK, &sflp);


The patch also contains a fix to handle l_len < 0 which is now defined 
in POSIX 1003.1-2001 from the fcntl man page.

Signed-off-by: John Engel <jhe@us.ibm.com>

-- 
John Engel
IBM Linux Technology Center


--------------000304060200000400020101
Content-Type: text/x-patch;
 name="compat_sys_fcntl64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compat_sys_fcntl64.patch"

diff -ruN linux-2.6.8.1-clean/fs/compat.c linux-2.6.8.1/fs/compat.c
--- linux-2.6.8.1-clean/fs/compat.c	2004-08-14 05:55:31.000000000 -0500
+++ linux-2.6.8.1/fs/compat.c	2004-09-16 13:52:37.000000000 -0500
@@ -522,8 +522,15 @@
 		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 		set_fs(old_fs);
 		if ((cmd == F_GETLK) && (ret == 0)) {
+			/* POSIX-2001 now defines negative l_len */
+			if (f.l_len < 0) {
+				f.l_start += f.l_len;
+				f.l_len = -f.l_len;
+			}
+			if (f.l_start < 0)
+				return -EINVAL;
 			if ((f.l_start >= COMPAT_OFF_T_MAX) ||
-			    ((f.l_start + f.l_len) >= COMPAT_OFF_T_MAX))
+			    ((f.l_start + f.l_len) > COMPAT_OFF_T_MAX))
 				ret = -EOVERFLOW;
 			if (ret == 0)
 				ret = put_compat_flock(&f, compat_ptr(arg));
@@ -543,8 +550,15 @@
 				(unsigned long)&f);
 		set_fs(old_fs);
 		if ((cmd == F_GETLK64) && (ret == 0)) {
+			/* POSIX-2001 now defines negative l_len */
+			if (f.l_len < 0) {
+				f.l_start += f.l_len;
+				f.l_len = -f.l_len;
+			}
+			if (f.l_start < 0)
+				return -EINVAL;
 			if ((f.l_start >= COMPAT_LOFF_T_MAX) ||
-			    ((f.l_start + f.l_len) >= COMPAT_LOFF_T_MAX))
+			    ((f.l_start + f.l_len) > COMPAT_LOFF_T_MAX))
 				ret = -EOVERFLOW;
 			if (ret == 0)
 				ret = put_compat_flock64(&f, compat_ptr(arg));

--------------000304060200000400020101--

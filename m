Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbULWWzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbULWWzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbULWWyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:54:02 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:25854 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261329AbULWWtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:49:55 -0500
Subject: [PATCH] VFS locking errors on max offset edge cases
From: Bruce Allan <bwa@us.ibm.com>
Reply-To: bwa@us.ibm.com
To: matthew@wil.cx
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Organization: IBM, Corp.
Message-Id: <1103842193.4702.77.camel@w-bwa3.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 23 Dec 2004 14:49:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of Connectathon (http://www.connectathon.org/nfstests.html)
POSIX/fcntl() locking tests fail (even on local filesystems) at various
edge cases (i.e. around maximum allowable offsets) on 64-bit
architectures.

The overflow tests in fs/compat.c were superfluous where they were
located because if there was a conflicting lock, l_start and l_len would
have been overwritten with the values owned by the conflicting lock; if
no conflicting lock, sys_fcntl() would have returned any applicable
error.  The tests are moved above the call to sys_fcntl() to capture
overflow errors which would not have been caught by sys_fcntl(), eg.
obvious overflow when _FILE_OFFSET_BITS == 32.

These tests also had a couple 'off by one' errors when comparing with
the maximum allowable offset.

Patch created against 2.6.10-rc3, tested on ppc64 with both
_FILE_OFFSET_BITS set to 32 and 64.

Signed-off-by: Bruce Allan <bwa@us.ibm.com>

diff -Nurp -X dontdiff linux-2.6.10-rc3-vanilla/fs/compat.c
linux-2.6.10-rc3/fs/compat.c
--- linux-2.6.10-rc3-vanilla/fs/compat.c	2004-12-23 11:52:50.642448274
-0800
+++ linux-2.6.10-rc3/fs/compat.c	2004-12-23 12:00:54.113913369 -0800
@@ -537,17 +537,19 @@ asmlinkage long compat_sys_fcntl64(unsig
 		ret = get_compat_flock(&f, compat_ptr(arg));
 		if (ret != 0)
 			break;
+		if ((cmd == F_GETLK) &&
+		    ((f.l_start > COMPAT_OFF_T_MAX) ||
+		     ((f.l_start + f.l_len - 1) > COMPAT_OFF_T_MAX))) {
+				ret = -EOVERFLOW;
+				break;
+			}
+		}
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 		set_fs(old_fs);
-		if (cmd == F_GETLK && ret == 0) {
-			if ((f.l_start >= COMPAT_OFF_T_MAX) ||
-			    ((f.l_start + f.l_len) > COMPAT_OFF_T_MAX))
-				ret = -EOVERFLOW;
-			if (ret == 0)
-				ret = put_compat_flock(&f, compat_ptr(arg));
-		}
+		if (cmd == F_GETLK && ret == 0)
+			ret = put_compat_flock(&f, compat_ptr(arg));
 		break;
 
 	case F_GETLK64:
@@ -556,19 +558,21 @@ asmlinkage long compat_sys_fcntl64(unsig
 		ret = get_compat_flock64(&f, compat_ptr(arg));
 		if (ret != 0)
 			break;
+		if ((cmd == F_GETLK64) &&
+		    ((f.l_start > COMPAT_LOFF_T_MAX) ||
+		     ((f.l_start + f.l_len - 1) > COMPAT_LOFF_T_MAX))) {
+				ret = -EOVERFLOW;
+				break;
+			}
+		}
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 		ret = sys_fcntl(fd, (cmd == F_GETLK64) ? F_GETLK :
 				((cmd == F_SETLK64) ? F_SETLK : F_SETLKW),
 				(unsigned long)&f);
 		set_fs(old_fs);
-		if (cmd == F_GETLK64 && ret == 0) {
-			if ((f.l_start >= COMPAT_LOFF_T_MAX) ||
-			    ((f.l_start + f.l_len) > COMPAT_LOFF_T_MAX))
-				ret = -EOVERFLOW;
-			if (ret == 0)
-				ret = put_compat_flock64(&f, compat_ptr(arg));
-		}
+		if (cmd == F_GETLK64 && ret == 0)
+			ret = put_compat_flock64(&f, compat_ptr(arg));
 		break;
 
 	default:
diff -Nurp -X dontdiff linux-2.6.10-rc3-vanilla/fs/locks.c
linux-2.6.10-rc3/fs/locks.c
--- linux-2.6.10-rc3-vanilla/fs/locks.c	2004-12-23 11:52:50.902423742
-0800
+++ linux-2.6.10-rc3/fs/locks.c	2004-12-23 12:02:35.268404863 -0800
@@ -314,7 +314,8 @@ static int flock_to_posix_lock(struct fi
 
 	/* POSIX-1996 leaves the case l->l_len < 0 undefined;
 	   POSIX-2001 defines it. */
-	start += l->l_start;
+	if ((start += l->l_start) < 0)
+		return -EINVAL;
 	end = start + l->l_len - 1;
 	if (l->l_len < 0) {
 		end = start - 1;


---
Bruce Allan  <bwa@us.ibm.com>
Software Engineer, Linux Technology Center
IBM Corporation, Beaverton OR USA


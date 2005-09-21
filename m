Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVIUPyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVIUPyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVIUPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:54:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62884 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751098AbVIUPyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:54:09 -0400
Date: Wed, 21 Sep 2005 17:54:07 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: bruce.allan@us.ibm.com, Olaf Hering <olh@suse.de>
Subject: compat fcntl errors
Message-ID: <20050921155407.GA21537@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This testcase fron ltp fails as 32bit binary on ppc64.
./testcases/network/nfs/cthon04/lock/tlock.c

fcntl(): Value too large for defined data type

Possible patch below.

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
        int fd = open(argv[1], O_RDWR | O_CREAT, 0666);
        struct flock fl;
        off_t maxeof;

        memset(&fl, 0, sizeof(struct flock));
        // test 1.6 of cthon04 locking tests
        maxeof = (off_t)1 << (sizeof (off_t) * 8 - 2);
        maxeof += maxeof - 1;
        fl.l_type   = F_WRLCK;
        fl.l_whence = SEEK_SET;
        fl.l_start  = 1;
        fl.l_len    = maxeof;
        if (fcntl(fd, F_GETLK, &fl) < 0) {
                perror("fcntl()");
                exit(1);
        }
        printf("test 1.6 passes\n");

        close(fd);
        return 0;
}

 fs/compat.c |   30 ++++++++++++++++--------------
 fs/locks.c  |    3 ++-
 2 files changed, 18 insertions(+), 15 deletions(-)

Index: linux-2.6.13.cthon04/fs/compat.c
===================================================================
--- linux-2.6.13.cthon04.orig/fs/compat.c
+++ linux-2.6.13.cthon04/fs/compat.c
@@ -584,17 +584,18 @@ asmlinkage long compat_sys_fcntl64(unsig
 		ret = get_compat_flock(&f, compat_ptr(arg));
 		if (ret != 0)
 			break;
+		if ((cmd == F_GETLK) &&
+		    ((f.l_start > COMPAT_OFF_T_MAX) ||
+		     ((f.l_start + f.l_len - 1) > COMPAT_OFF_T_MAX))) {
+			ret = -EOVERFLOW;
+			break;
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
@@ -603,19 +604,20 @@ asmlinkage long compat_sys_fcntl64(unsig
 		ret = get_compat_flock64(&f, compat_ptr(arg));
 		if (ret != 0)
 			break;
+		if ((cmd == F_GETLK64) &&
+		    ((f.l_start > COMPAT_LOFF_T_MAX) ||
+		     ((f.l_start + f.l_len - 1) > COMPAT_LOFF_T_MAX))) {
+			ret = -EOVERFLOW;
+			break;
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
Index: linux-2.6.13.cthon04/fs/locks.c
===================================================================
--- linux-2.6.13.cthon04.orig/fs/locks.c
+++ linux-2.6.13.cthon04/fs/locks.c
@@ -314,7 +314,8 @@ static int flock_to_posix_lock(struct fi
 
 	/* POSIX-1996 leaves the case l->l_len < 0 undefined;
 	   POSIX-2001 defines it. */
-	start += l->l_start;
+	if ((start += l->l_start) < 0)
+		return -EINVAL;
 	end = start + l->l_len - 1;
 	if (l->l_len < 0) {
 		end = start - 1;


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264456AbRFTAjA>; Tue, 19 Jun 2001 20:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264453AbRFTAiu>; Tue, 19 Jun 2001 20:38:50 -0400
Received: from m4-mp1-cvx1a.col.ntl.com ([213.104.68.4]:8321 "EHLO
	[213.104.68.4]") by vger.kernel.org with ESMTP id <S264450AbRFTAig>;
	Tue, 19 Jun 2001 20:38:36 -0400
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>
Subject: [PATCH] setuid(2) buggy or bad docs
From: John Fremlin <vii@users.sourceforge.net>
Date: 20 Jun 2001 01:37:51 +0100
Message-ID: <m23d8w2dgg.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

setuid(2) differs from the OpenBSD setuid(2) in that -EPERM is
returned by the syscall even if the euid of the process matches the
uid passed to it.

Either I am non compos or the thing is very wrong. The docs
(man-pages-1.35) say

ERRORS
       EPERM  The  user  is  not the super-user, and uid does not
              match the effective or saved user ID of the calling
              process.

The following untested patch changes the kernel to match the
documentated behaviour.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.4.4-setuid.patch

--- linux-2.4.4-orig/kernel/sys.c	Tue May  1 14:34:43 2001
+++ linux-2.4.4/kernel/sys.c	Wed Jun 20 01:32:46 2001
@@ -603,7 +603,9 @@ asmlinkage long sys_setuid(uid_t uid)
 		if (uid != old_ruid && set_user(uid, old_euid != uid) < 0)
 			return -EAGAIN;
 		new_suid = uid;
-	} else if ((uid != current->uid) && (uid != new_suid))
+	} else if ((uid != current->uid)
+		   && (uid != new_suid)
+		&& (uid != old_euid))
 		return -EPERM;
 
 	if (old_euid != uid)

--=-=-=

-- 
Summer job urgently sought due to last minute visa trouble!
Please see http://ape.n3.net/cv.html

--=-=-=--

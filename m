Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbVIOBFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbVIOBFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVIOBFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:05:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030315AbVIOBFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:05:11 -0400
Message-Id: <20050915010401.789690000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Kirill Korotaev <dev@sw.ru>,
       "Maxim Giryaev" <gem@sw.ru>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 02/11] [PATCH] Lost sockfd_put() in routing_ioctl()
Content-Disposition: inline; filename=lost-sockfd_put-in-32bit-compat-routing_ioctl.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This patch adds lost sockfd_put() in 32bit compat rounting_ioctl() on 
64bit platforms

I believe this is a security issues, since user can fget() file as many 
times as he wants to. So file refcounter can be overlapped and first 
fput() will free resources though there will be still structures 
pointing to the file, mnt, dentry etc.
Also fput() sets f_dentry and f_vfsmnt to NULL,
so other file users will OOPS.

The oops can be done under files_lock and others, so this can be an 
exploitable DoS on SMP. Didn't checked it on practice actually.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>
Signed-Off-By: Maxim Giryaev <gem@sw.ru>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 fs/compat_ioctl.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6.13.y/fs/compat_ioctl.c
===================================================================
--- linux-2.6.13.y.orig/fs/compat_ioctl.c
+++ linux-2.6.13.y/fs/compat_ioctl.c
@@ -798,13 +798,16 @@ static int routing_ioctl(unsigned int fd
 		r = (void *) &r4;
 	}
 
-	if (ret)
-		return -EFAULT;
+	if (ret) {
+		ret = -EFAULT;
+		goto out;
+	}
 
 	set_fs (KERNEL_DS);
 	ret = sys_ioctl (fd, cmd, (unsigned long) r);
 	set_fs (old_fs);
 
+out:
 	if (mysock)
 		sockfd_put(mysock);
 

--

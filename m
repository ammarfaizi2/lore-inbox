Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVIOBFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVIOBFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVIOBFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:05:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030311AbVIOBFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:05:05 -0400
Message-Id: <20050915010400.221519000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Kirill Korotaev <dev@sw.ru>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Chris Wright <chrisw@osdl.org>,
       Maxim Giryaev <gem@sw.ru>
Subject: [PATCH 01/11] [PATCH] lost fput in 32bit ioctl on x86-64
Content-Disposition: inline; filename=lost-fput-in-32bit-ioctl-on-x86-64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This patch adds lost fput in 32bit tiocgdev ioctl on x86-64

I believe this is a security issues, since user can fget() file as
many times as he wants to. So file refcounter can be overlapped and
first fput() will free resources though there will be still structures
pointing to the file, mnt, dentry etc.  Also fput() sets f_dentry and
f_vfsmnt to NULL, so other file users will OOPS.

The oops can be done under files_lock and others, so this is really
exploitable DoS on SMP. Didn't checked it on practice actually.

(chrisw: Update to use fget_light/fput_light)

Signed-Off-By: Kirill Korotaev <dev@sw.ru>
Signed-Off-By: Maxim Giryaev <gem@sw.ru>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 arch/x86_64/ia32/ia32_ioctl.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

Index: linux-2.6.13.y/arch/x86_64/ia32/ia32_ioctl.c
===================================================================
--- linux-2.6.13.y.orig/arch/x86_64/ia32/ia32_ioctl.c
+++ linux-2.6.13.y/arch/x86_64/ia32/ia32_ioctl.c
@@ -24,17 +24,26 @@
 static int tiocgdev(unsigned fd, unsigned cmd,  unsigned int __user *ptr) 
 { 
 
-	struct file *file = fget(fd);
+	struct file *file;
 	struct tty_struct *real_tty;
+	int fput_needed, ret;
 
+	file = fget_light(fd, &fput_needed);
 	if (!file)
 		return -EBADF;
+
+	ret = -EINVAL;
 	if (file->f_op->ioctl != tty_ioctl)
-		return -EINVAL; 
+		goto out;
 	real_tty = (struct tty_struct *)file->private_data;
 	if (!real_tty) 	
-		return -EINVAL; 
-	return put_user(new_encode_dev(tty_devnum(real_tty)), ptr); 
+		goto out;
+
+	ret = put_user(new_encode_dev(tty_devnum(real_tty)), ptr); 
+
+out:
+	fput_light(file, fput_needed);
+	return ret;
 } 
 
 #define RTC_IRQP_READ32	_IOR('p', 0x0b, unsigned int)	 /* Read IRQ rate   */

--

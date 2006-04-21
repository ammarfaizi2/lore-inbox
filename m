Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWDUEsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWDUEsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWDUEog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:14210 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932252AbWDUEoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:18 -0400
Date: Thu, 20 Apr 2006 21:39:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/22] x86: be careful about tailcall breakage for sys_opentoo
Message-ID: <20060421043945.GS12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="x86-be-careful-about-tailcall-breakage-for-sys_open-too.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>

x86: be careful about tailcall breakage for sys_open[at] too

Came up through a quick grep for other cases similar to the ftruncate()
one in commit 0a489cb3b6a7b277030cdbc97c2c65905db94536.

Also, add a comment, so that people who read the code understand why we
do what looks like a no-op.

(Again, this won't actually matter to any sane user, since libc will
save and restore the register gcc stomps on, but it's still wrong to
stomp on it)

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/open.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- linux-2.6.16.9.orig/fs/open.c
+++ linux-2.6.16.9/fs/open.c
@@ -331,6 +331,7 @@ out:
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length)
 {
 	long ret = do_sys_ftruncate(fd, length, 1);
+	/* avoid REGPARM breakage on x86: */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -345,6 +346,7 @@ asmlinkage long sys_truncate64(const cha
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length)
 {
 	long ret = do_sys_ftruncate(fd, length, 0);
+	/* avoid REGPARM breakage on x86: */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -1087,20 +1089,30 @@ long do_sys_open(int dfd, const char __u
 
 asmlinkage long sys_open(const char __user *filename, int flags, int mode)
 {
+	long ret;
+
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	return do_sys_open(AT_FDCWD, filename, flags, mode);
+	ret = do_sys_open(AT_FDCWD, filename, flags, mode);
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sys_open);
 
 asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
 			   int mode)
 {
+	long ret;
+
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	return do_sys_open(dfd, filename, flags, mode);
+	ret = do_sys_open(dfd, filename, flags, mode);
+	/* avoid REGPARM breakage on x86: */
+	prevent_tail_call(ret);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sys_openat);
 

--

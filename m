Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTDKA52 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTDKA52 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:57:28 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:38820 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S264276AbTDKA51 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 20:57:27 -0400
Date: Fri, 11 Apr 2003 11:06:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Randolph Chung <tausq@parisc-linux.org>, Andi Kleen <ak@muc.de>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH][COMPAT] Allow for architectures to override
 {get,put}_compat_flock64
Message-Id: <20030411110647.727c6ff7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a small patch to allow some architecture to override the
generic implementations on {get,put}_compat_flock64 as some of them
(ia64 and maybe x86_64) will take alignment faults when accessing
the loff_t members of struct compat_flock64.

Requested by David Mosberger, modified by Dave Miller.
(Dave Miller would like these API's renamed, but that is another patch).

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.67-041008-compat.1/fs/compat.c 2.5.67-041008-compat.2/fs/compat.c
--- 2.5.67-041008-compat.1/fs/compat.c	2003-03-25 11:13:15.000000000 +1100
+++ 2.5.67-041008-compat.2/fs/compat.c	2003-04-10 13:40:43.000000000 +1000
@@ -154,6 +154,7 @@
 	return 0;
 }
 
+#ifndef HAVE_ARCH_GET_COMPAT_FLOCK64
 static int get_compat_flock64(struct flock *kfl, struct compat_flock64 *ufl)
 {
 	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)) ||
@@ -165,7 +166,9 @@
 		return -EFAULT;
 	return 0;
 }
+#endif
 
+#ifndef HAVE_ARCH_PUT_COMPAT_FLOCK64
 static int put_compat_flock64(struct flock *kfl, struct compat_flock64 *ufl)
 {
 	if (!access_ok(VERIFY_WRITE, ufl, sizeof(*ufl)) ||
@@ -177,6 +180,7 @@
 		return -EFAULT;
 	return 0;
 }
+#endif
 
 extern asmlinkage long sys_fcntl(unsigned int, unsigned int, unsigned long);
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUBPHds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 02:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbUBPHds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 02:33:48 -0500
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:39172 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S265390AbUBPHdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 02:33:44 -0500
Date: Sun, 15 Feb 2004 23:29:29 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Subject: 2.4.24 link err for sparc64
Message-ID: <20040216072928.GA30923@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I ripped out sysctl support from a 2.4.24 kernel (stock
tarball from ftp.*.*.kernel.org) and the final link failed
with:

arch/sparc64/kernel/kernel.o(.text+0x19750): In function `sys32_sysctl':
: undefined reference to `do_sysctl'

I tossed an #ifndef CONFIG_SYSCTL...#else...#endif
guard around arch/sparc64/kernel/sys_sparc32.c file in the
sys32_sysctl() function so it returns -ENOTSUPP, but I'm not sure
that's the right fix.  Should it be in do_sysctl() instead?

Can anyone comment on this?

--- arch/sparc64/kernel/sys_sparc32.c.old	2003-11-28 10:26:19.000000000 -0800
+++ arch/sparc64/kernel/sys_sparc32.c	2004-02-15 23:21:18.304035000 -0800
@@ -4454,6 +4454,9 @@
 
 extern asmlinkage long sys32_sysctl(struct __sysctl_args32 *args)
 {
+#ifndef CONFIG_SYSCTL
+	return -ENOTSUPP;
+#else
 	struct __sysctl_args32 tmp;
 	int error;
 	size_t oldlen, *oldlenp = NULL;
@@ -4488,4 +4491,5 @@
 		copy_to_user(args->__unused, tmp.__unused, sizeof(tmp.__unused));
 	}
 	return error;
+#endif
 }

-- DN
Daniel

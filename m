Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUGTJZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUGTJZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUGTJZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 05:25:41 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:44224 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265724AbUGTJZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 05:25:37 -0400
Date: Tue, 20 Jul 2004 18:25:27 +0900
From: Fumihiro Tersawa <terasawa@pst.fujitsu.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
Subject: [PATCH] memory hotplug for ia64 (linux-2.6.7) [2/2]
Message-Id: <20040720182204.12BA.TERASAWA@pst.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch of memory hotplug for ia64.


diff -dupr linux-2.6.7-ORG/arch/ia64/ia32/sys_ia32.c linux-2.6.7-remap-ia64-aio/arch/ia64/ia32/sys_ia32.c
--- linux-2.6.7-ORG/arch/ia64/ia32/sys_ia32.c	2004-07-13 10:40:39.000000000 +0900
+++ linux-2.6.7-remap-ia64-aio/arch/ia64/ia32/sys_ia32.c	2004-07-14 11:31:29.234716800 +0900
@@ -440,7 +440,7 @@ sys32_mmap (struct mmap_arg_struct *arg)
 			return -EBADF;
 	}
 
-	addr = ia32_do_mmap(file, a.addr, a.len, a.prot, flags, a.offset);
+	addr = ia32_do_mmap(file, a.addr, a.len, a.prot, flags & ~MAP_IMMOVABLE, a.offset);
 
 	if (file)
 		fput(file);
@@ -461,7 +461,7 @@ sys32_mmap2 (unsigned int addr, unsigned
 			return -EBADF;
 	}
 
-	retval = ia32_do_mmap(file, addr, len, prot, flags,
+	retval = ia32_do_mmap(file, addr, len, prot, flags & ~MAP_IMMOVABLE,
 			      (unsigned long) pgoff << IA32_PAGE_SHIFT);
 
 	if (file)
diff -dupr linux-2.6.7-ORG/arch/ia64/kernel/sys_ia64.c linux-2.6.7-remap-ia64-aio/arch/ia64/kernel/sys_ia64.c
--- linux-2.6.7-ORG/arch/ia64/kernel/sys_ia64.c	2004-07-13 10:40:39.000000000 +0900
+++ linux-2.6.7-remap-ia64-aio/arch/ia64/kernel/sys_ia64.c	2004-07-14 11:31:29.235693362 +0900
@@ -239,7 +239,7 @@ out:	if (file)
 asmlinkage unsigned long
 sys_mmap2 (unsigned long addr, unsigned long len, int prot, int flags, int fd, long pgoff)
 {
-	addr = do_mmap2(addr, len, prot, flags, fd, pgoff);
+	addr = do_mmap2(addr, len, prot, flags & ~MAP_IMMOVABLE, fd, pgoff);
 	if (!IS_ERR((void *) addr))
 		force_successful_syscall_return();
 	return addr;
@@ -251,7 +251,7 @@ sys_mmap (unsigned long addr, unsigned l
 	if (offset_in_page(off) != 0)
 		return -EINVAL;
 
-	addr = do_mmap2(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
+	addr = do_mmap2(addr, len, prot, flags & ~MAP_IMMOVABLE, fd, off >> PAGE_SHIFT);
 	if (!IS_ERR((void *) addr))
 		force_successful_syscall_return();
 	return addr;


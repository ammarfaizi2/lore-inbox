Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbVJXXdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVJXXdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 19:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVJXXdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 19:33:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14841 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751380AbVJXXdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 19:33:41 -0400
Message-ID: <435D6F50.1000403@mvista.com>
Date: Mon, 24 Oct 2005 16:33:36 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       robustmutexes@lists.osdl.org
Subject: [PATCH] 2.6.14-rc5 fails to build with out CONFIG_FUTEX
Content-Type: multipart/mixed;
 boundary="------------090706050004060802020403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090706050004060802020403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Both kernel/exit.c and fs/dcache.c refer to functions in kernel/futex.c which is not built unless 
CONFIG_FUTEX is true.  This causes a build failure at link time:
   LD      vmlinux
kernel/built-in.o(.text+0xab58): In function `do_exit':
/usr/src/linux-2.6.14-rc/kernel/exit.c:851: undefined reference to `exit_futex'
fs/built-in.o(.text+0x1b2bf): In function `dput':
/usr/src/linux-2.6.14-rc/fs/dcache.c:165: undefined reference to `futex_free_robust_list'

Attached patch "defines" away the problem.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------090706050004060802020403
Content-Type: text/plain;
 name="futux-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="futux-fix.patch"

Source: MontaVista Software, Inc.

Type: Defect Fix 
Description:
CONFIG_FUTEX is an option but kernel/exit.c and fs/dcache.c refer to functions in kernel/futux.c unconditionally.  This patch ties those request off and allows a build with CONFIG_FUTEX  "not set".

Signed-off-by: George Anzinger <george@mvista.com>

 include/linux/futex.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.14-rc/include/linux/futex.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/futex.h
+++ linux-2.6.14-rc/include/linux/futex.h
@@ -35,9 +35,13 @@
 long do_futex(unsigned long uaddr, int op, int val,
 		unsigned long timeout, unsigned long uaddr2, int val2,
 		int val3);
-
+#ifdef CONFIG_FUTEX
 extern void futex_free_robust_list(struct inode *inode);
 extern void exit_futex(struct task_struct *tsk);
+#else
+#define futex_free_robust_list(a)
+#define exit_futex(b)
+#endif
 static inline void futex_init_inode(struct inode *inode)
 {
 	INIT_LIST_HEAD(&inode->i_data.robust_list);

--------------090706050004060802020403--

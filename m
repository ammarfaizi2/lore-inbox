Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbVH2UPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbVH2UPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbVH2UOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:14:06 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:36622 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751563AbVH2UOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:14:01 -0400
Message-Id: <200508292007.j7TK7HmD029954@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/9] UML - Remove debugging code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:07:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes some long-unused debugging code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/kernel/trap_kern.c
===================================================================
--- test.orig/arch/um/kernel/trap_kern.c	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/kernel/trap_kern.c	2005-08-29 13:06:43.000000000 -0400
@@ -200,30 +200,3 @@
 void trap_init(void)
 {
 }
-
-DEFINE_SPINLOCK(trap_lock);
-
-static int trap_index = 0;
-
-int next_trap_index(int limit)
-{
-	int ret;
-
-	spin_lock(&trap_lock);
-	ret = trap_index;
-	if(++trap_index == limit)
-		trap_index = 0;
-	spin_unlock(&trap_lock);
-	return(ret);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: test/arch/um/kernel/trap_user.c
===================================================================
--- test.orig/arch/um/kernel/trap_user.c	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/kernel/trap_user.c	2005-08-29 13:06:43.000000000 -0400
@@ -40,35 +40,14 @@
 	} while(1);
 }
 
-/* Unlocked - don't care if this is a bit off */
-int nsegfaults = 0;
-
-struct {
-	unsigned long address;
-	int is_write;
-	int pid;
-	unsigned long sp;
-	int is_user;
-} segfault_record[1024];
-
 void segv_handler(int sig, union uml_pt_regs *regs)
 {
-	int index, max;
         struct faultinfo * fi = UPT_FAULTINFO(regs);
 
         if(UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)){
                 bad_segv(*fi, UPT_IP(regs));
 		return;
 	}
-	max = sizeof(segfault_record)/sizeof(segfault_record[0]);
-	index = next_trap_index(max);
-
-	nsegfaults++;
-        segfault_record[index].address = FAULT_ADDRESS(*fi);
-	segfault_record[index].pid = os_getpid();
-        segfault_record[index].is_write = FAULT_WRITE(*fi);
-	segfault_record[index].sp = UPT_SP(regs);
-	segfault_record[index].is_user = UPT_IS_USER(regs);
         segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
 }
 


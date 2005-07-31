Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVGaSC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVGaSC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVGaSC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:02:28 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:21007 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261849AbVGaSCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:02:25 -0400
Message-Id: <200507311713.j6VHDfEB027574@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org,
       user-mode-linux-devel@projects.sourceforge.net
Subject: [PATCH] UML - Remove debugging code from page fault path
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 31 Jul 2005 13:13:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates the segfault info ring buffer, which added a system call to
each page fault, and which hadn't been useful for debugging in ages.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/trap_kern.c	2005-07-31 12:54:35.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/trap_kern.c	2005-07-31 13:18:40.000000000 -0400
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
Index: linux-2.6.12/arch/um/kernel/trap_user.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/trap_user.c	2005-07-31 12:54:35.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/trap_user.c	2005-07-31 13:18:02.000000000 -0400
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
 


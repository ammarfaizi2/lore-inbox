Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWGJOhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWGJOhp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWGJOhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:37:45 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:10727 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161161AbWGJOhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:37:45 -0400
Date: Mon, 10 Jul 2006 10:30:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: handle_BUG(): don't print garbage if debug info
  unavailable
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Mike Galbraith <efault@gmx.de>
Message-ID: <200607101034_MC3-1-C497-51F7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

handle_BUG() tries to print file and line number even when
they're not available (CONFIG_DEBUG_BUGVERBOSE is not set.)
Change this to print a message stating info is unavailable
instead of printing a misleading message.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 Compile tested only, with/without CONFIG_DEBUG_BUGVERBOSE.

 arch/i386/kernel/traps.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

--- 2.6.18-rc1-nb.orig/arch/i386/kernel/traps.c
+++ 2.6.18-rc1-nb/arch/i386/kernel/traps.c
@@ -324,13 +324,14 @@ void show_registers(struct pt_regs *regs
 
 static void handle_BUG(struct pt_regs *regs)
 {
+	unsigned long eip = regs->eip;
 	unsigned short ud2;
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
 	unsigned short line;
 	char *file;
 	char c;
-	unsigned long eip;
-
-	eip = regs->eip;
+#endif
 
 	if (eip < PAGE_OFFSET)
 		goto no_bug;
@@ -338,21 +339,26 @@ static void handle_BUG(struct pt_regs *r
 		goto no_bug;
 	if (ud2 != 0x0b0f)
 		goto no_bug;
+	printk(KERN_EMERG "------------[ cut here ]------------\n");
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
 	if (__get_user(line, (unsigned short __user *)(eip + 2)))
-		goto bug;
+		goto no_info;
 	if (__get_user(file, (char * __user *)(eip + 4)) ||
 		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
 		file = "<bad filename>";
 
-	printk(KERN_EMERG "------------[ cut here ]------------\n");
 	printk(KERN_EMERG "kernel BUG at %s:%d!\n", file, line);
+#else
+	goto no_info;
+#endif
 
 no_bug:
 	return;
 
 	/* Here we know it was a BUG but file-n-line is unavailable */
-bug:
-	printk(KERN_EMERG "Kernel BUG\n");
+no_info:
+	printk(KERN_EMERG "Kernel BUG at [verbose debug info unavailable]\n");
 }
 
 /* This is gone through when something in the kernel
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush

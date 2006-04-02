Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWDBRXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWDBRXy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 13:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWDBRXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 13:23:54 -0400
Received: from xenotime.net ([66.160.160.81]:38034 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932400AbWDBRXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 13:23:53 -0400
Date: Sun, 2 Apr 2006 10:26:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] i386: print EIP/ESP last [refresh]
Message-Id: <20060402102607.e06ca375.rdunlap@xenotime.net>
In-Reply-To: <20060401222629.56527533.akpm@osdl.org>
References: <20060330230915.32559021.rdunlap@xenotime.net>
	<20060401222629.56527533.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Print summary registers (EIP and SS:ESP only) as last death info.
This makes this important data visible in case it had scrolled
off the top of the display.
Similar to what x86_64 does.  Suggested by Andi Kleen.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/kernel/traps.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

--- linux-2616-mm2.orig/arch/i386/kernel/traps.c
+++ linux-2616-mm2/arch/i386/kernel/traps.c
@@ -398,6 +398,9 @@ void die(const char * str, struct pt_reg
 
 	if (++die.lock_owner_depth < 3) {
 		int nl = 0;
+		unsigned long esp;
+		unsigned short ss;
+
 		handle_BUG(regs);
 		printk(KERN_EMERG "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 #ifdef CONFIG_PREEMPT
@@ -430,8 +433,19 @@ void die(const char * str, struct pt_reg
 	 	check_remote_debug(0,SIGTRAP,err,regs,)
 		if (notify_die(DIE_OOPS, str, regs, err,
 					current->thread.trap_no, SIGSEGV) !=
-				NOTIFY_STOP)
+				NOTIFY_STOP) {
 			show_registers(regs);
+			/* Executive summary in case the oops scrolled away */
+			esp = (unsigned long) (&regs->esp);
+			savesegment(ss, ss);
+			if (user_mode(regs)) {
+				esp = regs->esp;
+				ss = regs->xss & 0xffff;
+			}
+			printk(KERN_EMERG "EIP: [<%08lx>] ", regs->eip);
+			print_symbol("%s", regs->eip);
+			printk(" SS:ESP %04x:%08lx\n", ss, esp);
+		}
 		else
 			regs = NULL;
   	} else



---

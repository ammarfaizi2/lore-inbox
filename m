Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWCaHJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWCaHJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWCaHJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:09:13 -0500
Received: from xenotime.net ([66.160.160.81]:32225 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751198AbWCaHJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:09:12 -0500
Date: Thu, 30 Mar 2006 23:09:15 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
Subject: [PATCH -mm] i386: print EIP/ESP last
Message-Id: <20060330230915.32559021.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
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
+			printk(KERN_EMERG "EIP: [<%08lx>] ", addr);
+			print_symbol("%s", addr);
+			printk(" SS:ESP %04x:%08lx\n", ss, esp);
+		}
 		else
 			regs = NULL;
   	} else


---

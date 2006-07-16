Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945920AbWGPMW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945920AbWGPMW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 08:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWGPMW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 08:22:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45293 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751236AbWGPMW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 08:22:57 -0400
Date: Sun, 16 Jul 2006 14:22:55 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: akpm@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.18-rc2] [8/8] i386: Do backtrace fallback too
Message-ID: <44ba2f9f.pI6EDffADjtkmAQ9%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Similar patch to earlier x86-64 patch. When the dwarf2 unwinder fails
dump the left over stack with the old unwinder.

Also some clarifications in the headers.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/traps.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -187,10 +187,21 @@ static void show_trace_log_lvl(struct ta
 			if (unwind_init_blocked(&info, task) == 0)
 				unw_ret = show_trace_unwind(&info, log_lvl);
 		}
-		if (unw_ret > 0) {
-			if (call_trace > 0)
+		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
+#ifdef CONFIG_STACK_UNWIND
+			print_symbol("DWARF2 unwinder stuck at %s\n",
+				     UNW_PC(info.regs));
+			if (call_trace == 1) {
+				printk("Leftover inexact backtrace:\n");
+				if (UNW_SP(info.regs))
+					stack = (void *)UNW_SP(info.regs);
+			} else if (call_trace > 1)
 				return;
-			printk("%sLegacy call trace:\n", log_lvl);
+			else
+				printk("Full inexact backtrace again:\n");
+#else
+			printk("Inexact backtrace:\n");
+#endif
 		}
 	}
 

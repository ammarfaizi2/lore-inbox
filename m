Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUK1Cjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUK1Cjl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 21:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUK1Cjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 21:39:41 -0500
Received: from ppp-202.176.140.158.revip.asianet.co.th ([202.176.140.158]:51098
	"EHLO mhfl2.mhf.dom") by vger.kernel.org with ESMTP id S261389AbUK1Cji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 21:39:38 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9] KDB: Fix compile problem when CONFIG_KPROBES and CONFIG_KDB set
Date: Sun, 28 Nov 2004 04:18:46 +0800
Cc: SoftwareSuspend Development 
	<softwaresuspend-devel@lists.berlios.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411280418.47543.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both  kprobes and kdb defined function do_int3.
Both functions were merged.

Signed off by: Michael Frank, email: mhf@linuxmail.org

diff -uN linux-2.6.9-mhf223/./arch/i386/kernel/traps.c.mhf.orig 
linux-2.6.9-mhf223/./arch/i386/kernel/traps.c
--- linux-2.6.9-mhf223/./arch/i386/kernel/traps.c.mhf.orig      2004-11-24 
16:51:02.000000000 +0800
+++ linux-2.6.9-mhf223/./arch/i386/kernel/traps.c       2004-11-24 
17:33:13.000000000 +0800
@@ -692,15 +692,21 @@
        nmi_callback = dummy_nmi_callback;
 }

-#ifdef CONFIG_KPROBES
+#if defined(CONFIG_KPROBES) || defined(CONFIG_KDB)
 asmlinkage int do_int3(struct pt_regs *regs, long error_code)
 {
+#if defined(CONFIG_KPROBES)
        if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
                        == NOTIFY_STOP)
                return 1;
        /* This is an interrupt gate, because kprobes wants interrupts
        disabled.  Normal trap handlers don't. */
        restore_interrupts(regs);
+#endif
+#ifdef CONFIG_KDB
+       if (kdb(KDB_REASON_BREAK, error_code, regs))
+               return 0;
+#endif /* CONFIG_KDB */
        do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
        return 0;
 }
@@ -811,16 +817,6 @@
        return;
 }

-#ifdef CONFIG_KDB
-asmlinkage void do_int3(struct pt_regs * regs, long error_code)
-{
-       if (kdb(KDB_REASON_BREAK, error_code, regs))
-               return;
-       do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
-}
-#endif /* CONFIG_KDB */
-
-
 /*
  * Note that we play around with the 'TS' bit in an attempt to get
  * the correct behaviour even in the presence of the asynchronous

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbULAVjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbULAVjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbULAVjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:39:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18962 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261486AbULAVjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:39:42 -0500
Date: Wed, 1 Dec 2004 22:39:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hariprasad Nellitheertha <hari@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] i386 crash_dump: make a function static
Message-ID: <20041201213939.GS2650@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


diffstat output:
 arch/i386/kernel/crash_dump.c |   13 ++++++-------
 include/asm-i386/crash_dump.h |    1 -
 2 files changed, 6 insertions(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/asm-i386/crash_dump.h.old	2004-12-01 07:53:20.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-i386/crash_dump.h	2004-12-01 07:53:26.000000000 +0100
@@ -13,7 +13,6 @@
 
 extern struct pt_regs crash_smp_regs[NR_CPUS];
 extern long crash_smp_current_task[NR_CPUS];
-extern void crash_dump_save_this_cpu(struct pt_regs *, int);
 extern void __crash_dump_stop_cpus(void);
 extern void crash_get_current_regs(struct pt_regs *regs);
 
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/crash_dump.c.old	2004-12-01 07:53:36.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/crash_dump.c	2004-12-01 08:06:40.000000000 +0100
@@ -28,6 +28,12 @@
 extern void crash_dump_send_ipi(void);
 extern void stop_this_cpu(void *);
 
+static void crash_dump_save_this_cpu(struct pt_regs *regs, int cpu)
+{
+	crash_smp_current_task[cpu] = (long)current;
+	crash_smp_regs[cpu] = *regs;
+}
+
 static int crash_dump_nmi_callback(struct pt_regs *regs, int cpu)
 {
 	if (!crash_dump_expect_ipi[cpu])
@@ -96,10 +102,3 @@
 
 	regs->eip = (unsigned long)current_text_addr();
 }
-
-void crash_dump_save_this_cpu(struct pt_regs *regs, int cpu)
-{
-	crash_smp_current_task[cpu] = (long)current;
-	crash_smp_regs[cpu] = *regs;
-}
-


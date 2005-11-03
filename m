Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVKCQM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVKCQM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVKCQM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:12:57 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5380 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1030366AbVKCQM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:12:57 -0500
Date: Thu, 3 Nov 2005 16:12:51 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org
Subject: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
Message-ID: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 The following hunk of the 2.6.14 patch:

diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index e3f362e..7a14fdf 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -313,16 +311,12 @@ void show_regs(struct pt_regs * regs)
 	printk(" DS: %04x ES: %04x\n",
 		0xffff & regs->xds,0xffff & regs->xes);
 
-	__asm__("movl %%cr0, %0": "=r" (cr0));
-	__asm__("movl %%cr2, %0": "=r" (cr2));
-	__asm__("movl %%cr3, %0": "=r" (cr3));
-	/* This could fault if %cr4 does not exist */
-	__asm__("1: movl %%cr4, %0		\n"
-		"2:				\n"
-		".section __ex_table,\"a\"	\n"
-		".long 1b,2b			\n"
-		".previous			\n"
-		: "=r" (cr4): "0" (0));
+	cr0 = read_cr0();
+	cr2 = read_cr2();
+	cr3 = read_cr3();
+	if (current_cpu_data.x86 > 4) {
+		cr4 = read_cr4();
+	}
 	printk("CR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n", cr0, cr2, cr3, cr4);
 	show_trace(NULL, &regs->esp);
 }

disables code to retrieve the actual value of CR4 on 486-class systems
(which may or may not implement the register, depending on the exact CPU
type and stepping).  This seems suspicious to me, but I have to admit I
haven't followed the discussion on the issue if there was any.

 Zachary, I think the change originates from you -- have you done it
deliberately (why?) or has it just been a mistake?

  Maciej

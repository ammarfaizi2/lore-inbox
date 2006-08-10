Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWHJUO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWHJUO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbWHJTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6891 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932316AbWHJTfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:30 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [16/145] x86_64: x86 clean up nmi panic messages
Message-Id: <20060810193528.E0ADE13C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:28 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Don Zickus <dzickus@redhat.com>
Clean up some of the output messages on the nmi error paths to make more
sense when they are displayed.  This is mainly a cosmetic fix and
shouldn't impact any normal code path.  

Signed-off-by:  Don Zickus <dzickus@redhat.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/traps.c   |   15 ++++++++-------
 arch/x86_64/kernel/traps.c |   21 ++++++++++++++-------
 2 files changed, 22 insertions(+), 14 deletions(-)

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -628,13 +628,15 @@ gp_in_kernel:
 
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
-	printk(KERN_EMERG "Uhhuh. NMI received. Dazed and confused, but trying "
-			"to continue\n");
+	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x on "
+		"CPU %d.\n", reason, smp_processor_id());
 	printk(KERN_EMERG "You probably have a hardware problem with your RAM "
 			"chips\n");
 	if (panic_on_unrecovered_nmi)
                 panic("NMI: Not continuing");
 
+	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
+
 	/* Clear and disable the memory parity error line. */
 	clear_mem_error(reason);
 }
@@ -665,14 +667,13 @@ static void unknown_nmi_error(unsigned c
 		return;
 	}
 #endif
-	printk("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
-		reason, smp_processor_id());
-	printk("Dazed and confused, but trying to continue\n");
-	printk("Do you have a strange power saving mode enabled?\n");
-
+	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x on "
+		"CPU %d.\n", reason, smp_processor_id());
+	printk(KERN_EMERG "Do you have a strange power saving mode enabled?\n");
 	if (panic_on_unrecovered_nmi)
                 panic("NMI: Not continuing");
 
+	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
 }
 
 static DEFINE_SPINLOCK(nmi_print_lock);
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -726,10 +726,15 @@ asmlinkage void __kprobes do_general_pro
 static __kprobes void
 mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
-	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
-	printk("You probably have a hardware problem with your RAM chips\n");
+	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x.\n",
+		reason);
+	printk(KERN_EMERG "You probably have a hardware problem with your "
+		"RAM chips\n");
+
 	if (panic_on_unrecovered_nmi)
-               panic("NMI: Not continuing");
+		panic("NMI: Not continuing");
+
+	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
 
 	/* Clear and disable the memory parity error line. */
 	reason = (reason & 0xf) | 4;
@@ -752,13 +757,15 @@ io_check_error(unsigned char reason, str
 
 static __kprobes void
 unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
-{	printk("Uhhuh. NMI received for unknown reason %02x.\n", reason);
-	printk("Dazed and confused, but trying to continue\n");
-	printk("Do you have a strange power saving mode enabled?\n");
+{
+	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x.\n",
+		reason);
+	printk(KERN_EMERG "Do you have a strange power saving mode enabled?\n");
 
 	if (panic_on_unrecovered_nmi)
-                panic("NMI: Not continuing");
+		panic("NMI: Not continuing");
 
+	printk(KERN_EMERG "Dazed and confused, but trying to continue\n");
 }
 
 /* Runs on IST stack. This code must keep interrupts off all the time.

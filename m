Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWBVLFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWBVLFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWBVLFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:05:31 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:28100 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S932149AbWBVLFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:05:30 -0500
From: Jan Beulich <jbeulich@novell.com>
To: akpm@osdl.org
Subject: [PATCH] i386: pass proper trap numbers to die chain handlers
Date: Wed, 22 Feb 2006 12:00:15 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221200.15783.jbeulich@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the trap number causing the call to notify_die() to the die
notification handler chain in a number of instances. Also, honor the
return value from the handler chain invocation in die() as, through a
debugger, the fault may have been fixed.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>
Acked-By: Andi Kleen <ak@suse.de>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/traps.c 2.6.16-rc4-i386-notify-die-info/arch/i386/kernel/traps.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/traps.c	2006-02-20 09:12:32.000000000 +0100
+++ 2.6.16-rc4-i386-notify-die-info/arch/i386/kernel/traps.c	2006-01-27 15:48:15.000000000 +0100
@@ -365,8 +365,10 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
-	notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
-		show_registers(regs);
+		if (notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV) != NOTIFY_STOP)
+			show_registers(regs);
+		else
+			regs = NULL;
   	} else
 		printk(KERN_EMERG "Recursive die() failure, output suppressed\n");
 
@@ -374,6 +376,9 @@ void die(const char * str, struct pt_reg
 	die.lock_owner = -1;
 	spin_unlock_irqrestore(&die.lock, flags);
 
+	if (!regs)
+		return;
+
 	if (kexec_should_crash(current))
 		crash_kexec(regs);
 
@@ -601,7 +606,7 @@ static DEFINE_SPINLOCK(nmi_print_lock);
 
 void die_nmi (struct pt_regs *regs, const char *msg)
 {
-	if (notify_die(DIE_NMIWATCHDOG, msg, regs, 0, 0, SIGINT) ==
+	if (notify_die(DIE_NMIWATCHDOG, msg, regs, 0, 2, SIGINT) ==
 	    NOTIFY_STOP)
 		return;
 
@@ -640,7 +645,7 @@ static void default_do_nmi(struct pt_reg
 		reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
-		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
+		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 2, SIGINT)
 							== NOTIFY_STOP)
 			return;
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -656,7 +661,7 @@ static void default_do_nmi(struct pt_reg
 		unknown_nmi_error(reason, regs);
 		return;
 	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_STOP)
+	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_STOP)
 		return;
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);


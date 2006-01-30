Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWA3JxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWA3JxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWA3JxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:53:16 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25295
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932190AbWA3JxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:53:14 -0500
Message-Id: <43DDF02E.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 30 Jan 2006 10:53:34 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] pass proper trap numbers to die chain handlers
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part1A38890E.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part1A38890E.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Jan Beulich <jbeulich@novell.com>

Pass the trap number causing the call to notify_die() to the die
notification handler chain in a number of instances. Also, honor the
return value from the handler chain invocation in die() as, through a
debugger, the fault may have been fixed.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>


--=__Part1A38890E.0__=
Content-Type: text/plain; name="linux-2.6.16-rc1-i386-notify-die-info.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.16-rc1-i386-notify-die-info.patch"

From: Jan Beulich <jbeulich@novell.com>

Pass the trap number causing the call to notify_die() to the die
notification handler chain in a number of instances. Also, honor the
return value from the handler chain invocation in die() as, through a
debugger, the fault may have been fixed.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/arch/i386/kernel/traps.c 2.6.16-rc1-i386-notify-die-info/arch/i386/kernel/traps.c
--- /home/jbeulich/tmp/linux-2.6.16-rc1/arch/i386/kernel/traps.c	2006-01-18 12:38:24.000000000 +0100
+++ 2.6.16-rc1-i386-notify-die-info/arch/i386/kernel/traps.c	2006-01-27 15:48:15.000000000 +0100
@@ -362,8 +362,10 @@ void die(const char * str, struct pt_reg
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
 
@@ -371,6 +373,9 @@ void die(const char * str, struct pt_reg
 	die.lock_owner = -1;
 	spin_unlock_irqrestore(&die.lock, flags);
 
+	if (!regs)
+		return;
+
 	if (kexec_should_crash(current))
 		crash_kexec(regs);
 
@@ -598,7 +603,7 @@ static DEFINE_SPINLOCK(nmi_print_lock);
 
 void die_nmi (struct pt_regs *regs, const char *msg)
 {
-	if (notify_die(DIE_NMIWATCHDOG, msg, regs, 0, 0, SIGINT) ==
+	if (notify_die(DIE_NMIWATCHDOG, msg, regs, 0, 2, SIGINT) ==
 	    NOTIFY_STOP)
 		return;
 
@@ -637,7 +642,7 @@ static void default_do_nmi(struct pt_reg
 		reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
-		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
+		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 2, SIGINT)
 							== NOTIFY_STOP)
 			return;
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -653,7 +658,7 @@ static void default_do_nmi(struct pt_reg
 		unknown_nmi_error(reason, regs);
 		return;
 	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_STOP)
+	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_STOP)
 		return;
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);

--=__Part1A38890E.0__=--

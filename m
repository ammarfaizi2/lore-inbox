Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbUBHVXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 16:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUBHVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 16:23:24 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:7623 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S264141AbUBHVWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 16:22:50 -0500
Date: Sun, 8 Feb 2004 16:22:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Philippe Elie <phil.el@wanadoo.fr>
Subject: [PATCH][2.6] Oprofile, fix nmi_timer_int detection
Message-ID: <Pine.LNX.4.58.0402081603120.3370@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nmi_timer_int oprofile driver was enabling itself unconditionally if
an SMP kernel was being used on a UP system without an IOAPIC.

Tested on a P5 using NMI timer int driver and UP system using timer int
driver both running an SMP kernel.

Index: linux-2.6.2/arch/i386/kernel/nmi.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.2/arch/i386/kernel/nmi.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 nmi.c
--- linux-2.6.2/arch/i386/kernel/nmi.c	4 Feb 2004 07:43:40 -0000	1.1.1.1
+++ linux-2.6.2/arch/i386/kernel/nmi.c	5 Feb 2004 21:49:58 -0000
@@ -42,7 +42,7 @@ extern void show_registers(struct pt_reg
  *     be enabled
  * -1: the lapic NMI watchdog is disabled, but can be enabled
  */
-static int nmi_active;
+int nmi_active;

 #define K7_EVNTSEL_ENABLE	(1 << 22)
 #define K7_EVNTSEL_INT		(1 << 20)
@@ -462,6 +462,7 @@ void nmi_watchdog_tick (struct pt_regs *
 	}
 }

+EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
 EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
Index: linux-2.6.2/arch/i386/oprofile/nmi_timer_int.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.2/arch/i386/oprofile/nmi_timer_int.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 nmi_timer_int.c
--- linux-2.6.2/arch/i386/oprofile/nmi_timer_int.c	4 Feb 2004 07:43:41 -0000	1.1.1.1
+++ linux-2.6.2/arch/i386/oprofile/nmi_timer_int.c	5 Feb 2004 18:45:04 -0000
@@ -48,9 +48,13 @@ static struct oprofile_operations nmi_ti
 	.cpu_type = "timer"
 };

-
 int __init nmi_timer_init(struct oprofile_operations ** ops)
 {
+	extern int nmi_active;
+
+	if (nmi_active <= 0)
+		return -ENODEV;
+
 	*ops = &nmi_timer_ops;
 	printk(KERN_INFO "oprofile: using NMI timer interrupt.\n");
 	return 0;

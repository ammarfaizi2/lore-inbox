Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUG1Mhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUG1Mhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUG1Mhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:37:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266894AbUG1Mhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:37:52 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16647.40347.365356.770724@segfault.boston.redhat.com>
Date: Wed, 28 Jul 2004 08:35:39 -0400
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: allow recursive die() on i386
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch allows for a recursive die() on i386.  This closely resembles
what is done on x86_64, fwiw.

-Jeff

--- linux-2.6.7/arch/i386/kernel/traps.c.orig	2004-07-28 08:08:21.000000000 -0400
+++ linux-2.6.7/arch/i386/kernel/traps.c	2004-07-28 08:10:54.000000000 -0400
@@ -294,6 +294,7 @@ bug:
 }
 
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+static int die_owner = -1;
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
@@ -301,7 +302,13 @@ void die(const char * str, struct pt_reg
 	int nl = 0;
 
 	console_verbose();
-	spin_lock_irq(&die_lock);
+	local_irq_disable();
+	if (!spin_trylock(&die_lock)) {
+		if (smp_processor_id() != die_owner)
+			spin_lock(&die_lock);
+		/* allow recursive die to fall through */
+	}
+	die_owner = smp_processor_id();
 	bust_spinlocks(1);
 	handle_BUG(regs);
 	printk(KERN_ALERT "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
@@ -321,6 +328,7 @@ void die(const char * str, struct pt_reg
 		printk("\n");
 	show_registers(regs);
 	bust_spinlocks(0);
+	die_owner = -1;
 	spin_unlock_irq(&die_lock);
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");

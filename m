Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279106AbRJaBjk>; Tue, 30 Oct 2001 20:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279105AbRJaBja>; Tue, 30 Oct 2001 20:39:30 -0500
Received: from host194.steeleye.com ([216.33.1.194]:5392 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S279112AbRJaBjO>; Tue, 30 Oct 2001 20:39:14 -0500
Message-Id: <200110310139.f9V1dkB10594@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@SteelEye.com
Subject: [PATCH] thinko in APIC_LOCKUP_DEBUG can cause SMP hang (2.4.7+)
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-14945458160"
Date: Tue, 30 Oct 2001 19:39:46 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-14945458160
Content-Type: text/plain; charset=us-ascii

This one looks like it would trip if the lockup debug code encounters a shared 
level interrupt which would cause it to loop forever.

James Bottomley


--==_Exmh_-14945458160
Content-Type: text/plain ; name="ioapic-shared.diff"; charset=us-ascii
Content-Description: ioapic-shared.diff
Content-Disposition: attachment; filename="ioapic-shared.diff"

Index: arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.22
diff -u -r1.1.1.22 io_apic.c
--- arch/i386/kernel/io_apic.c	2001/09/25 23:59:50	1.1.1.22
+++ arch/i386/kernel/io_apic.c	2001/10/31 01:34:49
@@ -1236,6 +1236,9 @@
 	ack_APIC_irq();
 
 	if (!(v & (1 << (i & 0x1f)))) {
+#ifdef APIC_LOCKUP_DEBUG
+		struct irq_pin_list *entry = irq_2_pin + irq;
+#endif
 #ifdef APIC_MISMATCH_DEBUG
 		atomic_inc(&irq_mis_count);
 #endif
@@ -1243,7 +1246,6 @@
 		__mask_and_edge_IO_APIC_irq(irq);
 #ifdef APIC_LOCKUP_DEBUG
 		for (;;) {
-			struct irq_pin_list *entry = irq_2_pin + irq;
 			unsigned int reg;
 
 			if (entry->pin == -1)

--==_Exmh_-14945458160--



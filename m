Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317690AbSGKAf5>; Wed, 10 Jul 2002 20:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317691AbSGKAf4>; Wed, 10 Jul 2002 20:35:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23733 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317690AbSGKAf4>;
	Wed, 10 Jul 2002 20:35:56 -0400
Date: Wed, 10 Jul 2002 17:37:47 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix timer interrupts on NUMA-Q
Message-ID: <179860000.1026347867@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I turned on the IO-APICs on secondary quads, we are receiving 
timer interrupts on *all* quads, not just the first quad, each from their 
local timer chip. This causes time to progress far too rapidly ;-)

The simple patch below turns off the timer interrupts for IO-APICs other
than interrupt 0, and has been tested to fix the problem. As it switches
on clustered_apic_mode, it should be safe from hurting anyone else.

This fix is already in 2.4 - I'm playing catchup with 2.5 - the same patch
applies with just a line offset

Please apply ...

Thanks,

Martin.

diff -urN virgin-2.4.19-pre8/arch/i386/kernel/io_apic.c linux-2.4.19-pre8-time/arch/i386/kernel/io_apic.c
--- virgin-2.4.19-pre8/arch/i386/kernel/io_apic.c	Tue May  7 15:21:16 2002
+++ linux-2.4.19-pre8-time/arch/i386/kernel/io_apic.c	Thu May  9 17:49:28 2002
@@ -654,7 +654,14 @@
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
-		add_pin_to_irq(irq, apic, pin);
+		/*
+		 * skip adding the timer int on secondary nodes, which causes
+		 * a small but painful rift in the time-space continuum
+		 */
+		if (clustered_apic_mode && (apic != 0) && (irq == 0))
+			continue;
+		else
+			add_pin_to_irq(irq, apic, pin);
 
 		if (!apic && !IO_APIC_IRQ(irq))
 			continue;


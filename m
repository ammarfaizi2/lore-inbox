Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314486AbSEMWJp>; Mon, 13 May 2002 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSEMWJo>; Mon, 13 May 2002 18:09:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12015 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314486AbSEMWJo>;
	Mon, 13 May 2002 18:09:44 -0400
Date: Mon, 13 May 2002 16:07:19 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove spurious timer interrupts
Message-ID: <22110000.1021331239@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I turned on the IO-APICs on secondary quads in 2.4.19-pre2, we
are receiving timer interrupts on *all* quads, not just the first quad, each
from their local timer chip. This causes time to progress far too rapidly ;-)
The simple patch below turns off the timer interrupts for IO-APICs other
than interrupt 0, and has been tested to fix the problem. As it switches
on clustered_apic_mode, it should be safe from hurting anyone else.
Please apply ...

Thanks,

Martin

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


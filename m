Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132402AbRALU46>; Fri, 12 Jan 2001 15:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132461AbRALU4r>; Fri, 12 Jan 2001 15:56:47 -0500
Received: from colorfullife.com ([216.156.138.34]:56581 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132402AbRALU4g>;
	Fri, 12 Jan 2001 15:56:36 -0500
Message-ID: <3A5F6F07.88564D5B@colorfullife.com>
Date: Fri, 12 Jan 2001 21:54:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Frank de Lange <frank@unternet.org>,
        Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <Pine.LNX.4.30.0101122136180.2772-100000@e2>
Content-Type: multipart/mixed;
 boundary="------------55919F484DB2C7B38B8C5162"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------55919F484DB2C7B38B8C5162
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> 
> 
> okay - i just wanted to hear a definitive word from you that this fixes
> your problem, because this is what we'll have to do as a final solution.
> (barring any other solution.)
> 
Ingo, is that possible?

The current fix is "disable_irq_nosync() and enable_irq() cause
deadlocks with level triggered ioapic irqs, do not use them" - I'm sure
ne2k-pci isn't the only driver that uses these function.

I have found one combination that doesn't hang with the unpatched
8390.c, but network throughput is down to 1/2. I hope that's due to the
debugging changes.

I'll restart now from a fresh 2.4.0 tree:
Changes:

1) enable focus cpu.
2) apply the attached patch.

I'm not sure if it's a real fix or if it just hides the problem: my
sysrq patch has shown that clearing and setting the "level trigger" bit
in the io apic reanimates the IO APIC.

--
        Manfred
--------------55919F484DB2C7B38B8C5162
Content-Type: text/plain; charset=us-ascii;
 name="patch-io"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-io"

--- build-2.4/arch/i386/kernel/io_apic.c.orig	Fri Jan 12 20:17:36 2001
+++ build-2.4/arch/i386/kernel/io_apic.c	Fri Jan 12 21:26:31 2001
@@ -134,6 +134,30 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+DO_ACTION( __trigger_level,    0, |= 0x00008000, io_apic_sync(entry->apic))/* mask = 1 */
+DO_ACTION( __trigger_edge,  0, &= 0xffff7fff, )				/* mask = 0 */
+
+
+static void unmask_level_IO_APIC_irq (unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__trigger_level_IO_APIC_irq(irq);
+	__unmask_IO_APIC_irq(irq);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
+static void mask_level_IO_APIC_irq (unsigned int irq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__mask_IO_APIC_irq(irq);
+	__trigger_edge_IO_APIC_irq(irq);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 static void unmask_IO_APIC_irq (unsigned int irq)
 {
 	unsigned long flags;
@@ -143,6 +167,7 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
+
 void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
@@ -1181,14 +1206,14 @@
  */
 static unsigned int startup_level_ioapic_irq (unsigned int irq)
 {
-	unmask_IO_APIC_irq(irq);
+	unmask_level_IO_APIC_irq(irq);
 
 	return 0; /* don't check for pending */
 }
 
-#define shutdown_level_ioapic_irq	mask_IO_APIC_irq
-#define enable_level_ioapic_irq		unmask_IO_APIC_irq
-#define disable_level_ioapic_irq	mask_IO_APIC_irq
+#define shutdown_level_ioapic_irq	mask_level_IO_APIC_irq
+#define enable_level_ioapic_irq		unmask_level_IO_APIC_irq
+#define disable_level_ioapic_irq	mask_level_IO_APIC_irq
 
 static void end_level_ioapic_irq (unsigned int i)
 {

--------------55919F484DB2C7B38B8C5162--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUHTSIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUHTSIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268632AbUHTSG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:06:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60321 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268594AbUHTSEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:04:08 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/14] kexec: ioapic-virtwire-on-shutdown.x86_64
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:02:51 -0600
Message-ID: <m1isbd662c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Restore an ioapic to virtual wire mode on reboot if it has an ExtInt
input.

diff -uNr linux-2.6.8.1-mm2-ioapic-virtwire-on-shutdown.i386/arch/x86_64/kernel/io_apic.c linux-2.6.8.1-mm2-ioapic-virtwire-on-shutdown.x86_64/arch/x86_64/kernel/io_apic.c
--- linux-2.6.8.1-mm2-ioapic-virtwire-on-shutdown.i386/arch/x86_64/kernel/io_apic.c	Sat Aug 14 11:55:02 2004
+++ linux-2.6.8.1-mm2-ioapic-virtwire-on-shutdown.x86_64/arch/x86_64/kernel/io_apic.c	Fri Aug 20 10:13:41 2004
@@ -1123,10 +1123,42 @@
  */
 void disable_IO_APIC(void)
 {
+	int pin;
 	/*
 	 * Clear the IO-APIC before rebooting:
 	 */
 	clear_IO_APIC();
+
+	/*
+	 * If the i82559 is routed through an IOAPIC
+	 * Put that IOAPIC in virtual wire mode
+	 * so legacy interrups can be delivered.
+	 */
+	pin = find_isa_irq_pin(0, mp_ExtINT);
+	if (pin != -1) {
+		struct IO_APIC_route_entry entry;
+		unsigned long flags;
+
+		memset(&entry, 0, sizeof(entry));
+		entry.mask            = 0; /* Enabled */
+		entry.trigger         = 0; /* Edge */
+		entry.irr             = 0;
+		entry.polarity        = 0; /* High */
+		entry.delivery_status = 0;
+		entry.dest_mode       = 0; /* Physical */
+		entry.delivery_mode   = 7; /* ExtInt */
+		entry.vector          = 0;
+		entry.dest.physical.physical_dest = 0;
+
+
+		/*
+		 * Add it to the IO-APIC irq-routing table:
+		 */
+		spin_lock_irqsave(&ioapic_lock, flags);
+		io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
+		io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
+		spin_unlock_irqrestore(&ioapic_lock, flags);
+	}
 
 	disconnect_bsp_APIC();
 }


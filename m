Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130002AbRBCOqD>; Sat, 3 Feb 2001 09:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbRBCOpo>; Sat, 3 Feb 2001 09:45:44 -0500
Received: from colorfullife.com ([216.156.138.34]:58897 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129368AbRBCOp3>;
	Sat, 3 Feb 2001 09:45:29 -0500
Message-ID: <3A7C1940.FDFC2EED@colorfullife.com>
Date: Sat, 03 Feb 2001 15:44:16 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Gérard Roudier <groudier@club-internet.fr>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ingo Molnar <mingo@chiara.elte.hu>,
        Randy <randy.dunlap@intel.com>
Subject: [test patch] reliable apic lockup with one enable/disable_irq()
In-Reply-To: <Pine.LNX.4.10.10102031117430.893-100000@linux.local>
Content-Type: multipart/mixed;
 boundary="------------3A7BC7E316CF42A86C333F93"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3A7BC7E316CF42A86C333F93
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I found a sequence that reliably locks up my 82093AA ioapic with just
one disable/enable_irq.
I've attached a patch for the tulip driver. (tested with a pnic card)

* focus cpu must be enabled.
* Gerard's mask sequence: disable_irq() only sets IRQ_DISABLED,
mask_and_ack masks the ioapic entry if an interrupt is send to a
disabled handler.
* tulip_open:

disable_irq()
<sleep>
force the irq line active (enable both TPLnkPass and TPLnkFail, one of
them is always active)
<sleep>
enable_irq()

#insmod tulip
#ifup eth1

and now the interrupt is delivered as edge triggered, but the IRR bit is
set --> irq line stuck.

Could someone test the patch with newer boards (i840, via apollo pro,
perhaps i815 if the bios builds the MP table)

I also tried changing the trigger mode bit in
{,un}mask_level_IO_APIC_irq(), but that doesn't prevent the hang.

The patch is against 2.4.1
--
	Manfred
--------------3A7BC7E316CF42A86C333F93
Content-Type: text/plain; charset=us-ascii;
 name="patch-hang"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-hang"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 1
//  EXTRAVERSION =
--- 2.4/drivers/net/tulip/tulip_core.c	Sat Feb  3 14:02:54 2001
+++ build-2.4/drivers/net/tulip/tulip_core.c	Sat Feb  3 14:04:58 2001
@@ -421,6 +421,24 @@
 
 	tulip_up (dev);
 
+	disable_irq(dev->irq);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(10);
+
+{
+	long ioaddr = dev->base_addr;
+	long csr7 = inl(ioaddr + CSR7);
+	outl(NormalIntr|AbnormalIntr|TPLnkPass|TPLnkFail, ioaddr + CSR7);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(10);
+	enable_irq(dev->irq);
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(10);
+	outl(csr7, ioaddr + CSR7);
+
+}
+
 	netif_start_queue (dev);
 
 	return 0;
--- 2.4/arch/i386/kernel/io_apic.c	Sat Feb  3 14:02:24 2001
+++ build-2.4/arch/i386/kernel/io_apic.c	Sat Feb  3 14:54:14 2001
@@ -693,7 +693,7 @@
 	printk(KERN_WARNING "          to linux-smp@vger.kernel.org\n");
 }
 
-void __init print_IO_APIC(void)
+void print_IO_APIC(void)
 {
 	int apic, i;
 	struct IO_APIC_reg_00 reg_00;
@@ -1189,14 +1189,22 @@
 
 #define shutdown_level_ioapic_irq	mask_IO_APIC_irq
 #define enable_level_ioapic_irq		unmask_IO_APIC_irq
-#define disable_level_ioapic_irq	mask_IO_APIC_irq
+static void disable_level_ioapic_irq(unsigned int i)
+{
+	/* delayed. */
+}
 
 static void end_level_ioapic_irq (unsigned int i)
 {
 	ack_APIC_irq();
 }
 
-static void mask_and_ack_level_ioapic_irq (unsigned int i) { /* nothing */ }
+static void mask_and_ack_level_ioapic_irq (unsigned int i)
+{
+	if (irq_desc[i].status & IRQ_DISABLED) {
+		mask_IO_APIC_irq(i);
+	}
+}
 
 static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
 {
--- 2.4/arch/i386/kernel/apic.c	Sat Feb  3 14:02:24 2001
+++ build-2.4/arch/i386/kernel/apic.c	Sat Feb  3 14:42:47 2001
@@ -270,7 +270,7 @@
 	 *   PCI Ne2000 networking cards and PII/PIII processors, dual
 	 *   BX chipset. ]
 	 */
-#if 0
+#if 1
 	/* Enable focus processor (bit==0) */
 	value &= ~(1<<9);
 #else
--- 2.4/drivers/char/sysrq.c	Mon Dec  4 02:48:19 2000
+++ build-2.4/drivers/char/sysrq.c	Sat Feb  3 14:33:51 2001
@@ -137,6 +137,10 @@
 		send_sig_all(SIGKILL, 1);
 		orig_log_level = 8;
 		break;
+	case 'q':
+		print_all_local_APICs();
+		print_IO_APIC();
+		break;
 	default:					    /* Unknown: help */
 		if (kbd)
 			printk("unRaw ");








--------------3A7BC7E316CF42A86C333F93--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

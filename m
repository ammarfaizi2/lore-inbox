Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRBFRRk>; Tue, 6 Feb 2001 12:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129589AbRBFRRa>; Tue, 6 Feb 2001 12:17:30 -0500
Received: from colorfullife.com ([216.156.138.34]:15624 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129172AbRBFRRY>;
	Tue, 6 Feb 2001 12:17:24 -0500
Message-ID: <3A8031AA.1FFDF6AE@colorfullife.com>
Date: Tue, 06 Feb 2001 18:17:30 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org
Subject: Re: APIC lockup in 2.4.x-x
In-Reply-To: <Pine.LNX.4.21.0102061559520.25695-100000@tux.rsn.hk-r.se>
Content-Type: multipart/mixed;
 boundary="------------34E22D8406E4F5D2FFA2253A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------34E22D8406E4F5D2FFA2253A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Martin Josefsson wrote:
> 
> Hi
> 
> I saw your patch for the APIC lockup and I saw that it was included in
> 2.4.1-ac2 so I tried that one.. but it didn't help..
> 
> I can begin with describing my machine:
> 
> dual pIII 800 (133MHz FSB)
> Asus P3C-D mainboard with i820 chipset
> 256MB rimm (rambus)
> Dlink DFE570TX (4 port tulip card)
> Adaptec 29160 scsicard and 18GB scsidisk.
>

Could you apply the attached patch, enable sysrq, compile & install the
kernel, reboot and press sysrq-q after ifup?

We assumed that only the old io apic for 440 BX boards is affected, but
your board contains a newer apic intrated in the ICH.

But probably you ran into another bug - the tulip driver doesn't use
disable_irq()

--
	Manfred
--------------34E22D8406E4F5D2FFA2253A
Content-Type: text/plain; charset=us-ascii;
 name="u4u5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="u4u5"

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









--------------34E22D8406E4F5D2FFA2253A--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

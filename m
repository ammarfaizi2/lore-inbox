Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUKTJDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUKTJDt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 04:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUKTJDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 04:03:49 -0500
Received: from fmr01.intel.com ([192.55.52.18]:29620 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261188AbUKTJDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 04:03:11 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041118230948.W2357@build.pdx.osdl.net>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-LUdyDXPBvgj+j8yCxSL9"
Organization: 
Message-Id: <1100941324.987.238.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Nov 2004 04:02:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LUdyDXPBvgj+j8yCxSL9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please try this updated debug patch.

It clears the ELCR on Linux boot.

Also, it prints out the ICH PIRQ registers which
are the hardware underlying the ACPI PCI Interrupt Links.
It no longer depends on IOAPIC support in the kernel,
nor the apic=debug flag.

Please boot it with no kernel parameters
and report if it makes the floppy probe failure
(or 8042 probe failure) go away, and send dmesg.

If it still fails, please boot it with pci=routeirq
and capture the dmesg; also boot it with
acpi_dbg_level=1 and capture the dmesg.
The former will program all the links
before device probe, the later will
cause the kernel to skip disabling
the links and skip clearning the ELCR.

thanks,
-Len

ps. what I think is happening...

To its credit, he BIOS correctly recognizes that there is
no floppy, and it routes a PIRQ to IRQ6.  It correctly sets the
ELCR bit for this IRQ.

Linux boots and disables all the PCI Interrupt Links,
which un-programs the PIRQ directed to IRQ6.

However, Linux doesn't clear the ELCR first,
and for some reason that causes an interrupt
to latch in IRQ6 -- though it is masked.

Along comes the broken floppy driver before
the PCI devices probe.  floppy
doesn't realize there is no hardware and
unwittingly does a request_irq(6).

Since nobody is camped on IRQ6, this exclusive
request succeeds, IRQ6 is unmasked and the
floppy driver takes the outstaning interrupt.
For some reason it is unable to clear the IRQ.
I don't think it is because the line is being
driven by the PIRQ, that is disabled.  It may
have something to do with the ELCR still
being set to level senstive for this IRQ.

So this hangs the system, or with Linus'
update to floppy.c, it nukes IRQ6.

I'm hopeful that with a cleared ELCR, the
misguided legacy floppy probe will work
as it always has, and floppy will then
unload so the PCI device can later claim
IRQ6 and program the link and the ELCR
accordingly.

I do believe that Linux should continue to disable
the PCI Interrupt Links at boot and enable them
only on demand.  We used to leave them
all enabled and on some systems that caused
spurious interrupts, duplicated interrupts,
and all kinds of crazy things.

Note if the floppy driver had not requested
IRQ6, then a PCI device would have requested it,
the link would be programmed, and ELCR would
be set (redundant), and the interrupt unmasked.
The device would take the initial interrupt,
it would clear it successfully, and run normally
from then on.


--=-LUdyDXPBvgj+j8yCxSL9
Content-Disposition: attachment; filename=debug.patch
Content-Type: text/plain; name=debug.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== arch/i386/kernel/i8259.c 1.38 vs edited =====
--- 1.38/arch/i386/kernel/i8259.c	2004-10-20 04:37:14 -04:00
+++ edited/arch/i386/kernel/i8259.c	2004-11-20 03:18:08 -05:00
@@ -243,10 +243,21 @@
 /**
  * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
  */
-static void restore_ELCR(char *trigger)
+
+void restore_ELCR(char *trigger)
 {
 	outb(trigger[0], 0x4d0);
 	outb(trigger[1], 0x4d1);
+}
+
+void
+clear_ELCR(void)
+{
+	char trigger[2] = {0, 0};
+
+	restore_ELCR(trigger);
+	printk("clear ELCR\n");
+	print_ICH_PIC();	/* XXX debug */
 }
 
 static void save_ELCR(char *trigger)
===== arch/i386/kernel/acpi/boot.c 1.75 vs edited =====
--- 1.75/arch/i386/kernel/acpi/boot.c	2004-11-11 19:08:40 -05:00
+++ edited/arch/i386/kernel/acpi/boot.c	2004-11-20 01:23:46 -05:00
@@ -801,7 +801,9 @@
 acpi_boot_init (void)
 {
 	int error;
-
+	extern int print_ICH_PIC(void);
+	
+	print_ICH_PIC();
 	/*
 	 * If acpi_disabled, bail out
 	 * One exception: acpi=ht continues far enough to enumerate LAPICs
===== arch/i386/pci/acpi.c 1.18 vs edited =====
--- 1.18/arch/i386/pci/acpi.c	2004-10-19 00:44:01 -04:00
+++ edited/arch/i386/pci/acpi.c	2004-11-20 01:23:46 -05:00
@@ -56,6 +56,10 @@
 	if (acpi_ioapic)
 		print_IO_APIC();
 #endif
+	{
+		extern int print_ICH_PIC(void);
+		print_ICH_PIC();
+	}
 
 	return 0;
 }
===== drivers/acpi/bus.c 1.47 vs edited =====
--- 1.47/drivers/acpi/bus.c	2004-11-02 02:40:09 -05:00
+++ edited/drivers/acpi/bus.c	2004-11-20 03:47:22 -05:00
@@ -31,6 +31,7 @@
 #include <linux/proc_fs.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
+#include <asm/i8259.h>
 #endif
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -629,6 +630,11 @@
 #ifdef CONFIG_X86
 	if (!acpi_ioapic) {
 		extern acpi_interrupt_flags acpi_sci_flags;
+
+		if (acpi_dbg_level == 1) /* XXX hack use of dbg flag */
+			printk("NOT clearing ELCR\n");
+		else
+			clear_ELCR();
 
 		/* compatible (0) means level (3) */
 		if (acpi_sci_flags.trigger == 0)
===== drivers/acpi/pci_link.c 1.34 vs edited =====
--- 1.34/drivers/acpi/pci_link.c	2004-11-02 02:40:09 -05:00
+++ edited/drivers/acpi/pci_link.c	2004-11-20 03:47:34 -05:00
@@ -54,6 +54,56 @@
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
 
 #define ACPI_PCI_LINK_MAX_POSSIBLE 16
+int print_ICH_PIC(void)
+{
+	extern spinlock_t i8259A_lock;
+	unsigned int v;
+	u8 b;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&i8259A_lock, flags);
+
+	v = inb(0xa1) << 8 | inb(0x21);
+	printk(KERN_DEBUG "... PIC  IMR: %04x\n", v);
+
+	v = inb(0xa0) << 8 | inb(0x20);
+	printk(KERN_DEBUG "... PIC  IRR: %04x\n", v);
+
+	outb(0x0b,0xa0);
+	outb(0x0b,0x20);
+	v = inb(0xa0) << 8 | inb(0x20);
+	outb(0x0a,0xa0);
+	outb(0x0a,0x20);
+
+	spin_unlock_irqrestore(&i8259A_lock, flags);
+
+	printk(KERN_DEBUG "... PIC  ISR: %04x\n", v);
+
+	v = inb(0x4d1) << 8 | inb(0x4d0);
+	printk(KERN_DEBUG "... PIC ELCR: %04x\n", v);
+#define PCI_CONF1_ADDRESS(bus, devfn, reg) \
+        (0x80000000 | (bus << 16) | (devfn << 8) | (reg & ~3))
+
+	for (i = 0; i < 8; ++i) {
+		u32 bus = 0;
+		u32 devfn = 0x1F << 3; /* ICH is dev 31, func 0 */
+		u32 reg;
+
+		if (i < 4)
+			reg = 0x60 + i;
+		else
+			reg = 0x64 + i;
+
+		outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
+		b = inb(0xCFC + (reg & 3));
+		printk("PIRQ%c -> IRQ%d %s\n", 'A' + i, b & 0xF,
+		       b & 0x80  ? "disabled" : "ACTIVE");
+	}
+	return 0;
+}
+
+late_initcall(print_ICH_PIC);
 
 static int acpi_pci_link_add (struct acpi_device *device);
 static int acpi_pci_link_remove (struct acpi_device *device, int type);
@@ -475,6 +525,8 @@
 	struct acpi_pci_link    *link = NULL;
 	int			i = 0;
 
+print_ICH_PIC();
+
 	ACPI_FUNCTION_TRACE("acpi_irq_penalty_init");
 
 	/*
@@ -685,8 +737,15 @@
 	acpi_link.count++;
 
 end:
+
 	/* disable all links -- to be activated on use */
+if (acpi_dbg_level == 1) {
+	printk("NOT _DISabled\n");
+} else {
 	acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
+	printk("_DISabled\n");
+}
+
 
 	if (result)
 		kfree(link);
@@ -865,6 +924,9 @@
 
 	if (acpi_noirq)
 		return_VALUE(0);
+
+printk("LENB: ACPI has not touched Links yet\n");
+print_ICH_PIC();
 
 	acpi_link.count = 0;
 	INIT_LIST_HEAD(&acpi_link.entries);
===== include/asm-i386/i8259.h 1.2 vs edited =====
--- 1.2/include/asm-i386/i8259.h	2003-03-06 13:14:05 -05:00
+++ edited/include/asm-i386/i8259.h	2004-11-20 03:17:06 -05:00
@@ -13,5 +13,7 @@
 extern void enable_8259A_irq(unsigned int irq);
 extern void disable_8259A_irq(unsigned int irq);
 extern unsigned int startup_8259A_irq(unsigned int irq);
+extern void clear_ELCR(void);
+extern void print_ICH_PIC(void);	/* debug hack only */
 
 #endif	/* __ASM_I8259_H__ */

--=-LUdyDXPBvgj+j8yCxSL9--


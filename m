Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSLXQQ5>; Tue, 24 Dec 2002 11:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSLXQQ5>; Tue, 24 Dec 2002 11:16:57 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:40920 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265081AbSLXQQz>; Tue, 24 Dec 2002 11:16:55 -0500
Date: Tue, 24 Dec 2002 17:25:01 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Workaround for AMD762MPX "mouse" bug
Message-ID: <20021224162501.GA5363@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


AMD has published a new errata sheet for the AMD762, which describes
the root cause of the infamous "AMD 762 unstable when no PS/2 mouse
connected" bug. The reason is that without a PS/2 mouse the BIOS doesn't
put a data page in front of the VGA buffer at 640K. When the kernel
puts a page cache page there and does busmaster IO with it then the automatic
PCI prefetch from the chipset can hit the VGA buffer and that may cause a hang.

The workaround is to reserve the page directly before 640K if it wasn't
already reserved by the BIOS.

The bug only occurs in newer revisions (B0,B1)

The workaround here is somewhat hackish. We can only reserve the page
in early boot, but at that time there is no easy way to check for the
AMD762's PCI-ID because the PCI subsystem hasn't been initialized yet.

This patch checks later during the pci quirks pass instead
and then tells the user to pass a kernel option - "vgaguard" - in
case of instability. This is not ideal, but probably preferable than
to connect PS/2 mouses to all boxes in a colocated rack. Another
way would be to always reserve that page, but I didn't feel like
punishing everybody just for a hardware bug in a single chipset.

Patch for 2.5.53. Please consider applying.

-Andi


diff -burp linux/arch/i386/kernel/setup.c linux-tmp/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	2002-12-24 16:45:11.000000000 +0100
+++ linux-tmp/arch/i386/kernel/setup.c	2002-12-24 17:19:22.000000000 +0100
@@ -59,6 +59,8 @@ unsigned long mmu_cr4_features;
 
 int acpi_disabled __initdata = 0;
 
+static int vgaguard __initdata = 0;
+
 int MCA_bus;
 /* for MCA, but anyone else can use it if they want */
 unsigned int machine_id;
@@ -557,6 +559,9 @@ static void __init parse_cmdline_early (
 		if (c == ' ' && !memcmp(from, "acpi=off", 8))
 			acpi_disabled = 1;
 
+		if (c == ' ' && !memcmp(from, "vgaguard", 8))
+			vgaguard = 1;
+
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.
@@ -748,6 +753,10 @@ static unsigned long __init setup_memory
 	 */
 	reserve_bootmem(0, PAGE_SIZE);
 
+	/* work around AMD-762 errata 56 - prefetch into VGA */
+	if (vgaguard)
+	     reserve_bootmem(640*1024 - PAGE_SIZE, PAGE_SIZE);
+
 #ifdef CONFIG_SMP
 	/*
 	 * But first pinch a few for the stack/trampoline stuff
diff -burp linux/drivers/pci/quirks.c linux-tmp/drivers/pci/quirks.c
--- linux/drivers/pci/quirks.c	2002-12-24 16:45:14.000000000 +0100
+++ linux-tmp/drivers/pci/quirks.c	2002-12-24 17:19:22.000000000 +0100
@@ -349,6 +349,24 @@ static void __devinit quirk_amd_ioapic(s
 	}
 }
 
+/* Some AMD 762 chips hang when a PCI busmaster prefetches into the VGA text buffer
+   at 640K. Workaround is to put a suitable guard page before it
+   Connecting an PS/2 mouse has the same effect, in this case the BIOS reserves
+   an data area there. We cannot detect this in early boot, so tell the user to pass 
+   an option to work around. In theory it would be possible to check the E820
+   MAP for a suitable guard page and not print it then. */
+static void __devinit quirk_amd_ioapic2(struct pci_dev *dev)
+{
+	u8 rev;
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+	if(rev >= 0x10) /* B0+ */
+	{
+		printk(KERN_WARNING "I/O APIC: AMD762 Errata #56 may be present.\n"
+		       KERN_WARNING "In case of instability boot with \"vgaguard\" or connect a PS/2 mouse.\n");
+	}
+}
+
 static void __init quirk_ioapic_rmw(struct pci_dev *dev)
 {
 	if (dev->devfn == 0 && dev->bus->number == 0)
@@ -604,6 +622,7 @@ static struct pci_fixup pci_fixups[] __d
 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
 	
+	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C,	quirk_amd_ioapic2 },
 
 	{ 0 }
 };

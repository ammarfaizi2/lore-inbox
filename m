Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSDAACn>; Sun, 31 Mar 2002 19:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSDAACe>; Sun, 31 Mar 2002 19:02:34 -0500
Received: from mail11.svr.pol.co.uk ([195.92.193.23]:22542 "EHLO
	mail11.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S289817AbSDAACX>; Sun, 31 Mar 2002 19:02:23 -0500
Message-ID: <3CA7A37F.3060600@cobb.uk.net>
Date: Mon, 01 Apr 2002 01:02:07 +0100
From: Graham Cobb <g+linux@cobb.uk.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo@conectiva.com.br, mj@ucw.cz
Subject: [PATCH] PCI fixup for old NCR 53C810 SCSI chips, kernel 2.4.18
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem which prevents any version of the 2.4 kernel 
running on DECpc XL systems (from c. 1993).  On that system, the NCR 
53C810 SCSI subsystem integrated on the motherboard does not have a PCI 
class code, which breaks PCI resource allocation in all 2.4 kernels. 
 The symptom is "resource collisions" reported for the SCSI device:

PCI: Device 00:01.0 not available because of resource collisions

These systems typically only have SCSI disks so the 2.4 kernel cannot be 
booted.

If you are running an earlier kernel and want to know if you will have 
this problem when upgrading, use lspci -vvv and look for output similar 
to this:

00:01.0 Non-VGA unclassified device: Symbios Logic Inc. (formerly NCR) 
53c810 (rev 01)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 4 set
    Interrupt: pin A routed to IRQ 11
    Region 0: I/O ports at d000

If the listing says "Non-VGA unclassified device" for the 53c810, it 
will not work with the 2.4 kernel.

The workround is to add fixup code for this device in 
arch/i386/kernel/pci-pc.c.  The patch is small and is included below.  I 
would appreciate anyone who uses NCR 53c810-based SCSI devices testing 
this patch to make sure it doesn't break any other configurations.
Graham Cobb

--- linux-2.4.18.orig/arch/i386/kernel/pci-pc.c    Mon Feb 25 19:37:53 2002
+++ linux-2.4.18/arch/i386/kernel/pci-pc.c    Sun Mar 31 23:29:30 2002
@@ -1058,6 +1058,18 @@
         d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
 }
 
+static void __devinit  pci_fixup_ncr53c810(struct pci_dev *d)
+{
+    /*
+     * NCR 53C810 returns class code 0 (at least on some systems).
+     * Fix class to be PCI_CLASS_STORAGE_SCSI
+     */
+    if (!d->class) {
+        printk("PCI: fixing NCR 53C810 class code for %s\n", d->slot_name);
+        d->class = PCI_CLASS_STORAGE_SCSI << 8;
+    }
+}
+
 static void __devinit pci_fixup_ide_bases(struct pci_dev *d)
 {
     int i;
@@ -1148,6 +1160,7 @@
     { PCI_FIXUP_HEADER,    PCI_VENDOR_ID_VIA,    
PCI_DEVICE_ID_VIA_8622,            pci_fixup_via_northbridge_bug },
     { PCI_FIXUP_HEADER,    PCI_VENDOR_ID_VIA,    
PCI_DEVICE_ID_VIA_8361,            pci_fixup_via_northbridge_bug },
     { PCI_FIXUP_HEADER,    PCI_VENDOR_ID_VIA,    
PCI_DEVICE_ID_VIA_8367_0,    pci_fixup_via_northbridge_bug },
+    { PCI_FIXUP_HEADER,    PCI_VENDOR_ID_NCR,    
PCI_DEVICE_ID_NCR_53C810,    pci_fixup_ncr53c810 },
     { 0 }
 };
 



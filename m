Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278832AbRJaBTA>; Tue, 30 Oct 2001 20:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278828AbRJaBSu>; Tue, 30 Oct 2001 20:18:50 -0500
Received: from host194.steeleye.com ([216.33.1.194]:59407 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S278832AbRJaBSj>; Tue, 30 Oct 2001 20:18:39 -0500
Message-Id: <200110310119.f9V1JBd10512@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@SteelEye.com
Subject: [PATCH] Multiple IO-APIC boot failure in all 2.4 kernels
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-15166256660"
Date: Tue, 30 Oct 2001 19:19:11 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-15166256660
Content-Type: text/plain; charset=us-ascii

This one's extremely wierd.  It may only affect Intel Alder derived 
motherboards (that's all I have with dual apics).  They refuse to boot all 2.4 
kernels SMP.

The problem is due to these errors:

PCI: Error while updating region 00:0f.0/1 (20000408 != 20000008)
PCI: Error while updating region 00:0f.0/2 (20000808 != 20000008)
PCI: Error while updating region 00:0f.0/3 (20000c08 != 20000008)
PCI: Error while updating region 00:0f.0/4 (20001008 != 20000008)
PCI: Error while updating region 00:0f.0/5 (20001408 != 20000008)

Beore the attempt to update this PCI resource, the secondary IO-APIC was 
mapped correctly.  However, after poking this region, the secondary IO-APIC 
disappears and consequently all interrupts routed through this io-apic are not 
delivered and the machine hangs.

The PCI details are:

00:0f.0 Class ff00: 8086:0008
        Subsystem: 1008:fec0
        Flags: fast devsel
        Memory at 20000000 (32-bit, prefetchable)
        Memory at 20000400 (32-bit, prefetchable)
        Memory at 20000800 (32-bit, prefetchable)
        Memory at 20000c00 (32-bit, prefetchable)
        Memory at 20001000 (32-bit, prefetchable)
        Memory at 20001400 (32-bit, prefetchable)

The attached patch works on the assumption that all things of class 0xff00 are 
some type of IO-APIC and prevents pcibios_update_resource() from poking it.  
However if anyone has a better suggestion, I'm open to trying it.

James Bottomley


--==_Exmh_-15166256660
Content-Type: text/plain ; name="io-apic.diff"; charset=us-ascii
Content-Description: io-apic.diff
Content-Disposition: attachment; filename="io-apic.diff"

Index: arch/i386/kernel/pci-i386.c
===================================================================
RCS file: /home/jejb/CVSROOT/linux/2.4/arch/i386/kernel/pci-i386.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 pci-i386.c
--- arch/i386/kernel/pci-i386.c	2001/07/06 14:42:02	1.1.1.5
+++ arch/i386/kernel/pci-i386.c	2001/10/31 01:15:44
@@ -112,6 +112,12 @@
 		/* Somebody might have asked allocation of a non-standard resource */
 		return;
 	}
+
+	if((dev->class >> 8) == 0xFF00) {
+		printk("PCI: device %s/%d belongs to IO-APIC, ignoring\n",
+		       dev->slot_name, resource);
+		return;
+	}
 	
 	pci_write_config_dword(dev, reg, new);
 	pci_read_config_dword(dev, reg, &check);

--==_Exmh_-15166256660--



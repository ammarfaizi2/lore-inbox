Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUFCO2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUFCO2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUFCO1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:27:45 -0400
Received: from mfep1.odn.ne.jp ([143.90.131.179]:65331 "EHLO t-mta1.odn.ne.jp")
	by vger.kernel.org with ESMTP id S264850AbUFCOYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:24:31 -0400
Date: Fri, 4 Jun 2004 11:26:18 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nForce2 C1halt fixup, again
Message-ID: <20040604112618.A1789%acyr@alumni.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i-ja0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With so many people reporting that 2.6.6 fixed the nForce2 hard lock
problem I soon started using it.  However, on my system it would still
lock up!  I tried disabling APIC, IO-APIC, ACPI, PREEMPT, etc. to no
avail.  

After looking into the pci_fixup_nforce2() function, I saw that it was
expecting one of two cases for the PCI config value: 0x1F0FFF01 or
0x9F0FFF01, then, depending on the PCI revision ID it would set the
config value to 0x1F01FF01 or 0x9F01FF01 resp. I looked at the value
of my nForce2 board and saw that it was actually 0x8F0FFF01.

So the current 2.6.6 fixup was inadvertently flipping the high nibble
to 0x9 in my case.  Since the fixup is actually idependent of the PCI
revision ID (the 5th nibble is changed from 0xF to 0x1 in either
case), I tried explicitly changing only that part of the config value.
Sure enough, for the first time in a while my system is finally stable
again.

My patch is attached.  Comments please!



#
# Do not modify the entire PCI config dword, but only the C1 halt
# disconnect related nibble.
#
--- linux-2.6.6/arch/i386/pci/fixup.c	Mon May 10 11:32:53 2004
+++ /usr/src/linux-2.6.6/arch/i386/pci/fixup.c	Fri Jun  4 10:27:05 2004
@@ -202,9 +202,6 @@
 static void __init pci_fixup_nforce2(struct pci_dev *dev)
 {
 	u32 val, fixed_val;
-	u8 rev;
-
-	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
 	/*
 	 * Chip  Old value   New value
@@ -214,9 +211,10 @@
 	 * Northbridge chip version may be determined by
 	 * reading the PCI revision ID (0xC1 or greater is C18D).
 	 */
-	fixed_val = rev < 0xC1 ? 0x1F01FF01 : 0x9F01FF01;
 
 	pci_read_config_dword(dev, 0x6c, &val);
+	fixed_val = val & 0xFFF1FFFF;
+
 	if (val != fixed_val) {
 		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
 		pci_write_config_dword(dev, 0x6c, fixed_val);

-- 
Aric Cyr <acyr at alumni dot uwaterloo dot ca>

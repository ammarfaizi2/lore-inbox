Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVCOQuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVCOQuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVCOQuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:50:39 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:26308 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261452AbVCOQub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:50:31 -0500
Subject: [PATCH] ia64 kernel fails to link because of PCI MSI quirk
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 10:50:10 -0600
Message-Id: <1110905410.5685.15.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that the MSI code has an unconditional dependency on
pci_msi_quirk.  However, the quirk and the variable are only defined if
CONFIG_X86_IO_APIC is defined, which it never is on ia64.

The solution is to make the variable global and unconditional.

James

===== drivers/pci/quirks.c 1.72 vs edited =====
--- 1.72/drivers/pci/quirks.c	2005-03-10 02:38:25 -06:00
+++ edited/drivers/pci/quirks.c	2005-03-15 10:25:43 -06:00
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
+int pci_msi_quirk = 0;
+
 #undef DEBUG
 
 /* Deal with broken BIOS'es that neglect to enable passive release,
@@ -428,8 +430,6 @@
 		sis_apic_bug = 1;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_ANY_ID,
quirk_ioapic_rmw );
-
-int pci_msi_quirk;
 
 #define AMD8131_revA0        0x01
 #define AMD8131_revB0        0x11



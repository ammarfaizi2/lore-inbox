Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUFKV3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUFKV3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 17:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUFKV3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 17:29:19 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:44723 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S264278AbUFKV3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 17:29:18 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH] clarify pci.txt wrt IRQ allocation
Date: Fri, 11 Jun 2004 15:29:16 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111529.16419.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we should make it explicit that PCI IRQs shouldn't be relied
upon until after pci_enable_device().  This patch:

    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/broken-out/bk-acpi.patch

does PCI interrupt routing (based on ACPI _PRT) and IRQ allocation
at pci_enable_device()-time.

(To avoid breaking things in 2.6, the above patch still allocates
all PCI IRQs in pci_acpi_init(), before any drivers are initialized.
But that shouldn't be needed by correct drivers, and I'd like to
remove it in 2.7.)

Here's a possible update:

===== Documentation/pci.txt 1.11 vs edited =====
--- 1.11/Documentation/pci.txt	2003-07-02 19:11:39 -06:00
+++ edited/Documentation/pci.txt	2004-06-11 15:09:58 -06:00
@@ -166,8 +166,9 @@
 ~~~~~~~~~~~~~~~~~~~
    Before you do anything with the device you've found, you need to enable
 it by calling pci_enable_device() which enables I/O and memory regions of
-the device, assigns missing resources if needed and wakes up the device
-if it was in suspended state. Please note that this function can fail.
+the device, allocates an IRQ if necessary, assigns missing resources if
+needed and wakes up the device if it was in suspended state. Please note
+that this function can fail.
 
    If you want to use the device in bus mastering mode, call pci_set_master()
 which enables the bus master bit in PCI_COMMAND register and also fixes

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUIFDF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUIFDF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIFDF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 23:05:29 -0400
Received: from [218.93.20.101] ([218.93.20.101]:49625 "EHLO mx.shinco.com")
	by vger.kernel.org with ESMTP id S267405AbUIFDCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 23:02:54 -0400
Date: Mon, 06 Sep 2004 11:02:52 +0800
From: test <test@shinco.com>
To: linux-kernel@vger.kernel.org
Subject: dose not detect SATA on DELL 750 without CDROM
Message-Id: <20040906110104.98EF.TEST@shinco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.09.01 [en]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a Dell PowerEdge 750, the SATA harddisk cannot be recognized by the
kernel (causing a kernel panic) if the cdrom drive is removed.

If the cdrom drive is put back, everything works fine!!!

These are the output before the kernel panic:

VFS: Mounted root (ext2 filesystem).
Red Hat nash version 3.5.21 starting
SCSI subsystem initialized
ata_piix: combined mode detected
ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.2
ata1: PATA max UDMA/33 cdm 0x1F0 ctl 0x3F6 bmdma 0xFEA0 irq 14
ata1: port disabled. ignoring.
scsi0: ata_piix
Using cfq io scheduler
ata2: SATA max UDMA/133 cdm 0x170 ctl 0x376 bmdma 0xFEA8 irq 15
ata2: port disabled. ignoring.
scsi1 : ata_piix
VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

2.4 and 2.6 have same problem.

then i find a patch for 2.4 kernel in dell:

http://linux.dell.com/blog/contributions
http://linux.dell.com/files/patches/sata/ata_piix.c.patch


and i also make a patch for 2.6 kernel:

*** ata_piix.c.orig	Mon Sep  6 22:25:32 2004
--- ata_piix.c	Mon Sep  6 22:25:43 2004
***************
*** 272,279 ****
  
  static void piix_pata_phy_reset(struct ata_port *ap)
  {
  	if (!pci_test_config_bits(ap->host_set->pdev,
! 				  &piix_enable_bits[ap->port_no])) {
  		ata_port_disable(ap);
  		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
  		return;
--- 272,290 ----
  
  static void piix_pata_phy_reset(struct ata_port *ap)
  {
+ 	unsigned int controller;
+ 
+ 	/* In combined legacy mode, port number is not the same
+ 	 * as primary/secondary controller!
+ 	 */
+ 	switch (ap->ioaddr.cmd_addr) {
+ 		case 0x1f0: controller = 0; break;
+ 		case 0x170: controller = 1; break;
+ 		default: controller = ap->port_no;
+ 	}
+ 
  	if (!pci_test_config_bits(ap->host_set->pdev,
! 				  &piix_enable_bits[controller])) {
  		ata_port_disable(ap);
  		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
  		return;



all works fine.

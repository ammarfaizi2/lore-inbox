Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267987AbTBRSCh>; Tue, 18 Feb 2003 13:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267979AbTBRSCW>; Tue, 18 Feb 2003 13:02:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33033 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267973AbTBRSBG>; Tue, 18 Feb 2003 13:01:06 -0500
Subject: PATCH: fix int for i/o in pcmcia ide_cs
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:11:28 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCDJ-00069f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/ide-cs.c linux-2.5.61-ac2/drivers/ide/legacy/ide-cs.c
--- linux-2.5.61/drivers/ide/legacy/ide-cs.c	2003-02-10 18:38:45.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/ide-cs.c	2003-02-18 18:06:19.000000000 +0000
@@ -225,10 +225,10 @@
 #define CFG_CHECK(fn, args...) \
 if (CardServices(fn, args) != 0) goto next_entry
 
-static int idecs_register(int io, int ctl, int irq)
+static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq)
 {
     hw_regs_t hw;
-    ide_init_hwif_ports(&hw, (ide_ioreg_t)io, (ide_ioreg_t)ctl, NULL);
+    ide_init_hwif_ports(&hw, io, ctl, NULL);
     hw.irq = irq;
     hw.chipset = ide_pci;
     return ide_register_hw(&hw, NULL);
@@ -244,7 +244,8 @@
     config_info_t conf;
     cistpl_cftable_entry_t *cfg = &parse.cftable_entry;
     cistpl_cftable_entry_t dflt = { 0 };
-    int i, pass, last_ret, last_fn, hd, io_base, ctl_base, is_kme = 0;
+    int i, pass, last_ret, last_fn, hd, is_kme = 0;
+    unsigned long io_base, ctl_base;
 
     DEBUG(0, "ide_config(0x%p)\n", link);
     
@@ -367,7 +368,7 @@
     }
     
     if (hd < 0) {
-	printk(KERN_NOTICE "ide-cs: ide_register() at 0x%3x & 0x%3x"
+	printk(KERN_NOTICE "ide-cs: ide_register() at 0x%3lx & 0x%3lx"
 	       ", irq %u failed\n", io_base, ctl_base,
 	       link->irq.AssignedIRQ);
 	goto failed;

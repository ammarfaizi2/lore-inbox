Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUHOPYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUHOPYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUHOPWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:22:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266798AbUHOPQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:16:23 -0400
Date: Sun, 15 Aug 2004 11:15:31 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: convert ide_cs to new unregister_hwif logic
Message-ID: <20040815151531.GA15748@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/legacy/ide-cs.c linux-2.6.8-rc3/drivers/ide/legacy/ide-cs.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/legacy/ide-cs.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/legacy/ide-cs.c	2004-08-10 16:43:56.000000000 +0100
@@ -90,6 +90,7 @@
     int		ndev;
     dev_node_t	node;
     int		hd;
+    ide_hwif_t *hwif;
 } ide_info_t;
 
 static void ide_release(dev_link_t *);
@@ -199,14 +200,14 @@
     
 } /* ide_detach */
 
-static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq)
+static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq, ide_hwif_t **hwif)
 {
     hw_regs_t hw;
     memset(&hw, 0, sizeof(hw));
     ide_init_hwif_ports(&hw, io, ctl, NULL);
     hw.irq = irq;
     hw.chipset = ide_pci;
-    return ide_register_hw(&hw, NULL);
+    return ide_register_hw(&hw, hwif);
 }
 
 /*======================================================================
@@ -224,6 +225,7 @@
 {
     client_handle_t handle = link->handle;
     ide_info_t *info = link->priv;
+    ide_hwif_t *hwif;
     tuple_t tuple;
     struct {
 	u_short		buf[128];
@@ -343,14 +345,17 @@
     if (is_kme)
 	outb(0x81, ctl_base+1);
 
-    /* retry registration in case device is still spinning up */
+    /* retry registration in case device is still spinning up 
+    
+       FIXME: now handled by IDE layer... ?? */
+       
     for (hd = -1, i = 0; i < 10; i++) {
-	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
+	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, &hwif);
 	if (hd >= 0) break;
 	if (link->io.NumPorts1 == 0x20) {
 	    outb(0x02, ctl_base + 0x10);
 	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
-				link->irq.AssignedIRQ);
+				link->irq.AssignedIRQ, &hwif);
 	    if (hd >= 0) {
 		io_base += 0x10;
 		ctl_base += 0x10;
@@ -373,6 +378,7 @@
     info->node.major = ide_major[hd];
     info->node.minor = 0;
     info->hd = hd;
+    info->hwif = hwif;
     link->dev = &info->node;
     printk(KERN_INFO "ide-cs: %s: Vcc = %d.%d, Vpp = %d.%d\n",
 	   info->node.dev_name, link->conf.Vcc / 10, link->conf.Vcc % 10,
@@ -411,7 +417,7 @@
     if (info->ndev) {
 	/* FIXME: if this fails we need to queue the cleanup somehow
 	   -- need to investigate the required PCMCIA magic */
-	ide_unregister(info->hd);
+	ide_unregister_hwif(info->hwif);
 	/* deal with brain dead IDE resource management */
 	request_region(link->io.BasePort1, link->io.NumPorts1,
 		       info->node.dev_name);

Signed-off-by: Alan Cox <alan@redhat.com>


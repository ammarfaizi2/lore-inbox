Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263917AbTDGXjO (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTDGXhn (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:37:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15504 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263917AbTDGXcf (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 19:32:35 -0400
Date: Tue, 8 Apr 2003 00:44:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [3/3] PCI segment support
Message-ID: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm putting this patch out for comments rather than merging, since I'm
aware that it won't apply to Linus' tree any more.

 - Add segment to pci_bus.
 - Change the sysfs name of each device to include a 16-bit segment ID.

diff -urpNX dontdiff linux-2.5.66/drivers/pci/probe.c linux-2.5.66-laptop/drivers/pci/probe.c
--- linux-2.5.66/drivers/pci/probe.c	2003-04-04 08:43:01.000000000 -0600
+++ linux-2.5.66-laptop/drivers/pci/probe.c	2003-04-04 14:36:37.000000000 -0600
@@ -510,7 +510,7 @@ pci_scan_device(struct pci_bus *bus, int
 	pci_name_device(dev);
 
 	/* now put in global tree */
-	strcpy(dev->dev.bus_id,dev->slot_name);
+	sprintf(dev->dev.bus_id, "%04x:%s", bus->segment, dev->slot_name);
 	dev->dev.dma_mask = &dev->dma_mask;
 
 	return dev;
diff -urpNX dontdiff linux-2.5.66/drivers/pcmcia/cardbus.c linux-2.5.66-laptop/drivers/pcmcia/cardbus.c
--- linux-2.5.66/drivers/pcmcia/cardbus.c	2003-04-04 08:43:59.000000000 -0600
+++ linux-2.5.66-laptop/drivers/pcmcia/cardbus.c	2003-04-04 14:36:36.000000000 -0600
@@ -282,7 +282,8 @@ int cb_alloc(socket_info_t * s)
 
 		pci_setup_device(dev);
 
-		strcpy(dev->dev.bus_id, dev->slot_name);
+		sprintf(dev->dev.bus_id, "%04x:%s", bus->segment,
+				dev->slot_name);
 
 		/* We need to assign resources for expansion ROM. */
 		for (r = 0; r < 7; r++) {
diff -urpNX dontdiff linux-2.5.66/include/linux/pci.h linux-2.5.66-laptop/include/linux/pci.h
--- linux-2.5.66/include/linux/pci.h	2003-04-04 08:43:21.000000000 -0600
+++ linux-2.5.66-laptop/include/linux/pci.h	2003-04-04 14:07:34.000000000 -0600
@@ -451,6 +451,7 @@ struct pci_bus {
 	void		*sysdata;	/* hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* directory entry in /proc/bus/pci */
 
+	unsigned short	segment;	/* domain/segment number */
 	unsigned char	number;		/* bus number */
 	unsigned char	primary;	/* number of primary bridge */
 	unsigned char	secondary;	/* number of secondary bridge */

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk

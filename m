Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVKCJV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVKCJV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 04:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVKCJV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 04:21:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:29393 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932150AbVKCJV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 04:21:27 -0500
Message-ID: <4369D693.4040500@suse.de>
Date: Thu, 03 Nov 2005 10:21:23 +0100
From: Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH] Incorrect device link for ide-cs
Content-Type: multipart/mixed;
 boundary="------------040104080100090507080704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040104080100090507080704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bartlomiej,

I just came across a patch which appearently never made it anywhere near
mainline. It is, however, still valid.

Problem is that devices driven by ide-cs will appear under /sys/devices
instead of the appropriate PCMCIA device. To fix this I had to extend
the hw_regs_t structure with a 'struct device' field, which allows us to
set the parent link for the appropriate hwif.

Signed-off-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

--------------040104080100090507080704
Content-Type: text/plain;
 name="ide-cs-correct-device-link"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-cs-correct-device-link"

From: Hannes Reinecke <hare@suse.de>
Subject: Incorrect device link for ide-cs

Devices driven by ide-cs will appear under /sys/devices instead of the
appropriate PCMCIA device. To fix this I had to extend the hw_regs_t
structure with a 'struct device' field, which allows us to set the
parent link for the appropriate hwif.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.com>

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -803,6 +803,7 @@ found:
 	hwif->irq = hw->irq;
 	hwif->noprobe = 0;
 	hwif->chipset = hw->chipset;
+	hwif->gendev.parent = hw->dev;
 
 	if (!initializing) {
 		probe_hwif_init_with_fixup(hwif, fixup);
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -182,13 +182,14 @@ static void ide_detach(dev_link_t *link)
     
 } /* ide_detach */
 
-static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq)
+static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq, struct pcmcia_device *handle)
 {
     hw_regs_t hw;
     memset(&hw, 0, sizeof(hw));
-    ide_init_hwif_ports(&hw, io, ctl, NULL);
+    ide_std_init_ports(&hw, io, ctl);
     hw.irq = irq;
     hw.chipset = ide_pci;
+    hw.dev = &handle->dev;
     return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
 }
 
@@ -328,12 +329,12 @@ static void ide_config(dev_link_t *link)
 
     /* retry registration in case device is still spinning up */
     for (hd = -1, i = 0; i < 10; i++) {
-	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
+	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, handle);
 	if (hd >= 0) break;
 	if (link->io.NumPorts1 == 0x20) {
 	    outb(0x02, ctl_base + 0x10);
 	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
-				link->irq.AssignedIRQ);
+				link->irq.AssignedIRQ, handle);
 	    if (hd >= 0) {
 		io_base += 0x10;
 		ctl_base += 0x10;
diff --git a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -230,6 +230,7 @@ typedef struct hw_regs_s {
 	int		dma;			/* our dma entry */
 	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	hwif_chipset_t  chipset;
+	struct device	*dev;
 } hw_regs_t;
 
 /*

--------------040104080100090507080704--

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSEIMnJ>; Thu, 9 May 2002 08:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSEIMnI>; Thu, 9 May 2002 08:43:08 -0400
Received: from www.cdhutmusic.co.sz ([196.28.7.66]:12216 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293337AbSEIMnH>; Thu, 9 May 2002 08:43:07 -0400
Date: Thu, 9 May 2002 14:18:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: twaugh@redhat.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] parport irq sharing
Message-ID: <Pine.LNX.4.44.0205091416280.6271-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,
        I finally got round to looking at the parport_pc irq sharing and 
noticed that request_irq is sent with '0' for flags. Since the serial code 
only does a request_irq when you open the port it will not be able to 
acquire the irq after parport_pc.

I tested by using standard benchmarking software such as yes(1) on the 
serial console and copying a 80M file from the cdrom simultaneously. The 
performance wasn't spectacular but it worked pretty well ;) The md5sum on 
the file was also correct. To test the NetMos i used the BARs which were
in the earlier patch, however this patch does not depend on the earlier 
one.

 5:        704          XT-PIC  parport1, serial

PCI: Found IRQ 5 for device 00:0d.0
ttyS04 at port 0xdc00 (irq = 5) is a 16550A
ttyS05 at port 0xda00 (irq = 5) is a 16550A
parport1: PC-style at 0xd800 (0xd600), irq 5, using FIFO 
[PCSPP,TRISTATE,COMPAT,ECP]
paride: version 1.06 installed (parport)
paride: epat registered as protocol 0
pcd: pcd version 1.07, major 46, nice 0
epat_init_protopcd0: Sharing parport1 at 0xd800
pcd0: epat 1.02, Shuttle EPAT chip c6 at 0xd800, mode 2 (8-bit), delay 1
pcd0: Master:  CD-ROM
pcd0: mode sense capabilities completion: alt=0x51 stat=0x51 err=0x60 loop=0 phase=3
pcd0: mode sense capabilities: Sense key: 6, ASC: 29, ASQ: 0

--- linux-2.4.19-pre-ac/drivers/parport/parport_pc.c	Mon Apr  8 21:36:20 2002
+++ linux-2.4.19-pre7-ac3/drivers/parport/parport_pc.c	Thu May  9 08:19:32 2002
@@ -2355,7 +2355,7 @@
 
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq (p->irq, parport_pc_interrupt,
-				 0, p->name, p)) {
+				 SA_SHIRQ, p->name, p)) {
 			printk (KERN_WARNING "%s: irq %d in use, "
 				"resorting to polled operation\n",
 				p->name, p->irq);
--- linux-2.4.19-pre7-ac3/drivers/parport/parport_serial.c.orig	Sun May  5 14:24:36 2002
+++ linux-2.4.19-pre7-ac3/drivers/parport/parport_serial.c	Thu May  9 09:46:58 2002
@@ -249,7 +249,7 @@
 	int success = 0;
 
 	if (cards[i].preinit_hook &&
-	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
+	    cards[i].preinit_hook (dev, dev->irq, PARPORT_DMA_NONE))
 		return -ENODEV;
 
 	for (n = 0; n < cards[i].numports; n++) {
@@ -265,12 +265,12 @@
 			io_lo += hi; /* Reinterpret the meaning of
                                         "hi" as an offset (see SYBA
                                         def.) */
-		/* TODO: test if sharing interrupts works */
+		
 		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
-			"I/O at %#lx(%#lx)\n",
+			"IRQ%d I/O at %#lx(%#lx)\n", 
 			parport_serial_pci_tbl[i].vendor,
-			parport_serial_pci_tbl[i].device, io_lo, io_hi);
-		port = parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
+			parport_serial_pci_tbl[i].device, dev->irq, io_lo, io_hi);
+		port = parport_pc_probe_port (io_lo, io_hi, dev->irq,
 					      PARPORT_DMA_NONE, dev);
 		if (port) {
 			priv->port[priv->num_par++] = port;
-- 
http://function.linuxpower.ca
		


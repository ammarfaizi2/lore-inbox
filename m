Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRC3LR4>; Fri, 30 Mar 2001 06:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131307AbRC3LRq>; Fri, 30 Mar 2001 06:17:46 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:21729 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131305AbRC3LRi>; Fri, 30 Mar 2001 06:17:38 -0500
Date: Fri, 30 Mar 2001 12:16:52 +0100
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.3: VIA SIO parport parameters
Message-ID: <20010330121652.I10553@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the VIA SuperIO chip's parallel port support uses IRQs
regardless of whether the user says not to.  This patch addresses
that.  Please let me know if there are problems with it.

Thanks,
Tim.
*/

2001-03-30  Tim Waugh  <twaugh@redhat.com>

	* drivers/parport/parport_pc.c: Make Via SuperIO chipsets behave
	like everything else with respect to irq= and dma= parameters.
	* drivers/parport/ChangeLog: Updated.

--- linux/drivers/parport/parport_pc.c.viaparam	Fri Mar 30 12:02:12 2001
+++ linux/drivers/parport/parport_pc.c	Fri Mar 30 12:02:12 2001
@@ -2180,7 +2180,8 @@
 
 
 /* Via support maintained by Jeff Garzik <jgarzik@mandrakesoft.com> */
-static int __devinit sio_via_686a_probe (struct pci_dev *pdev)
+static int __devinit sio_via_686a_probe (struct pci_dev *pdev, int autoirq,
+					 int autodma)
 {
 	u8 tmp;
 	int dma, irq;
@@ -2260,6 +2261,14 @@
 	if (!have_eppecp)
 		dma = PARPORT_DMA_NONE;
 
+	/* Let the user (or defaults) steer us away from interrupts and DMA */
+	if (autoirq != PARPORT_IRQ_AUTO) {
+		irq = PARPORT_IRQ_NONE;
+		dma = PARPORT_DMA_NONE;
+	}
+	if (autodma != PARPORT_DMA_AUTO)
+		dma = PARPORT_DMA_NONE;
+
 	/* finally, do the probe with values obtained */
 	if (parport_pc_probe_port (port1, port2, irq, dma, NULL)) {
 		printk (KERN_INFO
@@ -2285,7 +2294,7 @@
 
 /* each element directly indexed from enum list, above */
 static struct parport_pc_superio {
-	int (*probe) (struct pci_dev *pdev);
+	int (*probe) (struct pci_dev *pdev, int autoirq, int autodma);
 } parport_pc_superio_info[] __devinitdata = {
 	{ sio_via_686a_probe, },
 };
@@ -2542,7 +2551,7 @@
 	probe:		parport_pc_pci_probe,
 };
 
-static int __init parport_pc_init_superio (void)
+static int __init parport_pc_init_superio (int autoirq, int autodma)
 {
 #ifdef CONFIG_PCI
 	const struct pci_device_id *id;
@@ -2553,7 +2562,8 @@
 		if (id == NULL || id->driver_data >= last_sio)
 			continue;
 
-		return parport_pc_superio_info[id->driver_data].probe (pdev);
+		return parport_pc_superio_info[id->driver_data].probe
+			(pdev, autoirq, autodma);
 	}
 #endif /* CONFIG_PCI */
 
@@ -2596,7 +2606,7 @@
 #endif
 
 	/* Onboard SuperIO chipsets that show themselves on the PCI bus. */
-	count += parport_pc_init_superio ();
+	count += parport_pc_init_superio (autoirq, autodma);
 
 	/* ISA ports and whatever (see asm/parport.h). */
 	count += parport_pc_find_nonpci_ports (autoirq, autodma);
--- linux/drivers/parport/ChangeLog.viaparam	Fri Mar 30 12:02:12 2001
+++ linux/drivers/parport/ChangeLog	Fri Mar 30 12:02:12 2001
@@ -0,0 +1,10 @@
+2001-03-30  Tim Waugh  <twaugh@redhat.com>
+
+	* parport_pc.c (sio_via_686a_probe): Take autoirq and autodma
+	parameters in order to conform to how the rest of the driver
+	works.
+	(parport_pc_init_superio): Take autoirq and autodma parameters and
+	pass them on to sio_via_686a_probe.
+	(parport_pc_find_ports): Pass autoirq and autodma to
+	parport_pc_init_superio.
+

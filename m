Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131343AbRBMXoY>; Tue, 13 Feb 2001 18:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbRBMXoO>; Tue, 13 Feb 2001 18:44:14 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:32692 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131418AbRBMXn4>; Tue, 13 Feb 2001 18:43:56 -0500
Date: Tue, 13 Feb 2001 23:43:49 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.2-pre3: parport_pc init_module bug
Message-ID: <20010213234349.O9459@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here's a patch that fixes a bug that can cause PCI driver list
corruption.  If parport_pc's init_module fails after it calls
pci_register_driver, cleanup_module isn't called and so it's still
registered when it gets unloaded.

Tim.
*/

2001-01-13  Tim Waugh  <twaugh@redhat.com>

	* parport_pc.c: Fix PCI driver list corruption on
	unsuccessful module load (Andrew Morton).

--- linux/drivers/parport/parport_pc.c.init	Tue Feb 13 23:31:25 2001
+++ linux/drivers/parport/parport_pc.c	Tue Feb 13 23:35:56 2001
@@ -89,6 +89,7 @@
 } superios[NR_SUPERIOS] __devinitdata = { {0,},};
 
 static int user_specified __devinitdata = 0;
+static int registered_parport;
 
 /* frob_control, but for ECR */
 static void frob_econtrol (struct parport *pb, unsigned char m,
@@ -2605,6 +2606,7 @@
 	count += parport_pc_find_nonpci_ports (autoirq, autodma);
 
 	r = pci_register_driver (&parport_pc_pci_driver);
+	registered_parport = 1;
 	if (r > 0)
 		count += r;
 
@@ -2667,6 +2669,7 @@
 	/* Work out how many ports we have, then get parport_share to parse
 	   the irq values. */
 	unsigned int i;
+	int ret;
 	for (i = 0; i < PARPORT_PC_MAX_PORTS && io[i]; i++);
 	if (i) {
 		if (parport_parse_irqs(i, irq, irqval)) return 1;
@@ -2691,7 +2694,11 @@
 			}
 	}
 
-	return !parport_pc_init (io, io_hi, irqval, dmaval);
+	ret = !parport_pc_init (io, io_hi, irqval, dmaval);
+	if (ret && registered_parport)
+		pci_unregister_driver (&parport_pc_pci_driver);
+
+	return ret;
 }
 
 void cleanup_module(void)
*** linux/drivers/parport/ChangeLog.init	Fri Jan  5 10:41:52 2001
--- linux/drivers/parport/ChangeLog	Tue Feb 13 23:32:02 2001
***************
*** 0 ****
--- 1,7 ----
+ 2001-02-13  Andrew Morton <andrewm@uow.edu.au>
+ 
+ 	* parport_pc.c (registered_parport): New static variable.
+ 	(parport_pc_find_ports): Set it when we register PCI driver.
+ 	(init_module): Unregister PCI driver if necessary when we
+ 	fail.
+ 

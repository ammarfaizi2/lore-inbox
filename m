Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbRBNKyF>; Wed, 14 Feb 2001 05:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbRBNKxz>; Wed, 14 Feb 2001 05:53:55 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:4408 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129681AbRBNKxj>; Wed, 14 Feb 2001 05:53:39 -0500
Date: Wed, 14 Feb 2001 10:53:32 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
Message-ID: <20010214105332.U9459@redhat.com>
In-Reply-To: <20010213234349.O9459@redhat.com> <Pine.LNX.3.96.1010214020126.28011B-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010214020126.28011B-100000@mandrakesoft.mandrakesoft.com>; from jgarzik@mandrakesoft.mandrakesoft.com on Wed, Feb 14, 2001 at 02:03:07AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 02:03:07AM -0600, Jeff Garzik wrote:

> If pci_register_driver returns < 0, the driver is not registered with
> the system.

Thanks.  Okay, second try:

2001-01-14  Tim Waugh  <twaugh@redhat.com>

	* parport_pc.c: Fix PCI driver list corruption on
	unsuccessful module load (Andrew Morton).

--- linux/drivers/parport/parport_pc.c.init	Wed Feb 14 10:49:28 2001
+++ linux/drivers/parport/parport_pc.c	Wed Feb 14 10:50:31 2001
@@ -89,6 +89,7 @@
 } superios[NR_SUPERIOS] __devinitdata = { {0,},};
 
 static int user_specified __devinitdata = 0;
+static int registered_parport;
 
 /* frob_control, but for ECR */
 static void frob_econtrol (struct parport *pb, unsigned char m,
@@ -2605,8 +2606,10 @@
 	count += parport_pc_find_nonpci_ports (autoirq, autodma);
 
 	r = pci_register_driver (&parport_pc_pci_driver);
-	if (r > 0)
+	if (r >= 0) {
+		registered_parport = 1;
 		count += r;
+	}
 
 	return count;
 }
@@ -2667,6 +2670,7 @@
 	/* Work out how many ports we have, then get parport_share to parse
 	   the irq values. */
 	unsigned int i;
+	int ret;
 	for (i = 0; i < PARPORT_PC_MAX_PORTS && io[i]; i++);
 	if (i) {
 		if (parport_parse_irqs(i, irq, irqval)) return 1;
@@ -2691,7 +2695,11 @@
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
--- linux/drivers/parport/ChangeLog	Wed Feb 14 10:50:00 2001
***************
*** 0 ****
--- 1,7 ----
+ 2001-02-14  Andrew Morton <andrewm@uow.edu.au>
+ 
+ 	* parport_pc.c (registered_parport): New static variable.
+ 	(parport_pc_find_ports): Set it when we register PCI driver.
+ 	(init_module): Unregister PCI driver if necessary when we
+ 	fail.
+ 


Tim.
*/

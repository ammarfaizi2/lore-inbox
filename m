Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136459AbREINix>; Wed, 9 May 2001 09:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136455AbREINin>; Wed, 9 May 2001 09:38:43 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:48281 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136452AbREINhj>; Wed, 9 May 2001 09:37:39 -0400
Date: Wed, 9 May 2001 09:37:33 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu, jgarzik@mandrakesoft.com
Subject: [PATCH] make Xircom cardbus modems work
Message-ID: <20010509093733.C18911@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, tytso@mit.edu,
	jgarzik@mandrakesoft.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached allows serial.c to work with my Xircom cardbus
ethernet+modem combo card. It doesn't get autodetected, because
the serial driver explicitly doesn't recognize anything with
more than one iomem region (the Xircom modem has two.)
If the serial driver is linked in statically, the delay
on initialization is needed, else the UART will get detected
as a 16450 or not at all; I guess the card is just slow in
coming up.

Bill

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.3-xircom_serial.patch"

--- linux/drivers/char/serial.c.foo	Tue May  8 23:44:41 2001
+++ linux/drivers/char/serial.c	Wed May  9 01:18:07 2001
@@ -4182,6 +4182,15 @@
 	return 0;
 }
 
+static int
+#ifndef MODULE
+__devinit
+#endif
+pci_xircom_fn(struct pci_dev *dev, struct pci_board *board, int enable)
+{
+	__set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ/10);
+}
 
 /*
  * This is the configuration table for all of the PCI serial boards
@@ -4558,6 +4567,11 @@
 	/*
 	 * Untested PCI modems, sent in from various folks...
 	 */
+	/* Xircom Cardbus Ethernet 10/100 + 56k Modem <notting@redhat.com> */
+	{	0x115d, 0x0103,
+		PCI_ANY_ID, PCI_ANY_ID,
+		SPCI_FL_BASE0, 1, 115200,
+		0, 0, pci_xircom_fn },
 	/* Elsa Model 56K PCI Modem, from Andreas Rath <arh@01019freenet.de> */
 	{	PCI_VENDOR_ID_ROCKWELL, 0x1004,
 		0x1048, 0x1500, 

--EeQfGwPcQSOJBaQU--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTJ1WR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJ1WR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:17:57 -0500
Received: from lidskialf.net ([62.3.233.115]:16825 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261769AbTJ1WRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:17:53 -0500
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: linux1394-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.0-test9 ieee1394 on nforce2
Date: Tue, 28 Oct 2003 22:17:52 +0000
User-Agent: KMail/1.5.3
Cc: torvalds@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310282217.52426.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, ieee1394 does not work on my nforce2 motherboard. This patch fixes it. Please apply.

This basically enables each port supported by the ieee1394 PHY device, something 
my BIOS/ the current code neglects to do.

diff -Naurb linux-2.6.0-test9.orig/drivers/ieee1394/ohci1394.c linux-2.6.0-test9/drivers/ieee1394/ohci1394.c
--- linux-2.6.0-test9.orig/drivers/ieee1394/ohci1394.c	2003-10-25 19:44:35.000000000 +0100
+++ linux-2.6.0-test9/drivers/ieee1394/ohci1394.c	2003-10-28 21:59:01.964472056 +0000
@@ -500,6 +500,7 @@
 static void ohci_initialize(struct ti_ohci *ohci)
 {
 	char irq_buf[16];
+	int numports, port;
 	quadlet_t buf;
 
 	spin_lock_init(&ohci->phy_reg_lock);
@@ -611,6 +612,14 @@
 	      pci_resource_start(ohci->dev, 0),
 	      pci_resource_start(ohci->dev, 0) + OHCI1394_REGISTER_SIZE - 1,
 	      ohci->max_packet_size);
+   
+	/* enable all ports on the PHY, in case the BIOS has neglected to */
+	numports = get_phy_reg(ohci, 2) & 0xf;
+	for(port=0; port < numports; port++) {
+		// choose the port and enable it
+		set_phy_reg(ohci, 7, (0 << 5) | (port & 0xf));
+		set_phy_reg(ohci, 8, (get_phy_reg(ohci, 8) & ~1));
+	}
 }
 
 /* 


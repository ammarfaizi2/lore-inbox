Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTJ1WQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTJ1WQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:16:59 -0500
Received: from lidskialf.net ([62.3.233.115]:15801 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261768AbTJ1WQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:16:55 -0500
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: linux1394-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.23-pre8 ieee1394 on nforce2
Date: Tue, 28 Oct 2003 22:16:53 +0000
User-Agent: KMail/1.5.3
Cc: torvalds@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310282216.53346.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, ieee1394 does not work on my nforce2 motherboard. This patch fixes it. Please apply.

This basically enables each port supported by the ieee1394 PHY device, something 
my BIOS/ the current code neglects to do.

diff -Naurb linux-2.4.23-pre8.orig/drivers/ieee1394/ohci1394.c linux-2.4.23-pre8/drivers/ieee1394/ohci1394.c
--- linux-2.4.23-pre8.orig/drivers/ieee1394/ohci1394.c	2003-08-25 12:44:41.000000000 +0100
+++ linux-2.4.23-pre8/drivers/ieee1394/ohci1394.c	2003-10-28 22:06:56.545324800 +0000
@@ -504,6 +504,7 @@
 static void ohci_initialize(struct ti_ohci *ohci)
 {
 	char irq_buf[16];
+	int numports, port;
 	quadlet_t buf;
 
 	spin_lock_init(&ohci->phy_reg_lock);
@@ -615,6 +616,14 @@
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


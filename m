Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUF2Pcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUF2Pcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 11:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUF2Pcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 11:32:43 -0400
Received: from acrogw.sw.ru ([195.133.213.225]:27388 "EHLO dhcp6-7.acronis.ru")
	by vger.kernel.org with ESMTP id S265782AbUF2Pck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 11:32:40 -0400
Date: Tue, 29 Jun 2004 19:38:09 +0400
From: Andrey Ulanov <Andrey.Ulanov@acronis.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCMCIA bug fix
Message-ID: <20040629153809.GA6531@dhcp6-7.acronis.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I tested with one of ieee1394+usb2.0 PCMCIA adapters. Worked fine.
Without this patch only first device (ieee1394 controller) was
detected.

Please apply.
-- 
with best regards, Andrey Ulanov.

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcmcia-multi.patch"

--- linux/drivers/pcmcia/cardbus.c.pcmcia	2004-06-29 18:37:27.000000000 +0400
+++ linux/drivers/pcmcia/cardbus.c	2004-06-29 18:39:37.000000000 +0400
@@ -435,12 +435,12 @@
 	pci_readb(&tmp, PCI_HEADER_TYPE, &hdr);
 	fn = 1;
 	if (hdr & 0x80) {
-		do {
-			tmp.devfn = fn;
+		for (i = 0; i < 8; i++) {
+			tmp.devfn = i;
 			if (pci_readw(&tmp, PCI_VENDOR_ID, &v) || !v || v == 0xffff)
-				break;
+				continue;
 			fn++;
-		} while (fn < 8);
+		};
 	}
 	s->functions = fn;
 
@@ -450,11 +450,17 @@
 	memset(c, 0, fn * sizeof(struct cb_config_t));
 
 	irq = s->cap.pci_irq;
-	for (i = 0; i < fn; i++) {
-		struct pci_dev *dev = &c[i].dev;
+	for (i = 0, fn = 0; i < 8; i++) {
+		struct pci_dev *dev = &c[fn].dev;
 		u8 irq_pin;
 		int r;
 
+		tmp.devfn = i;
+		if(pci_readw(&tmp, PCI_VENDOR_ID, &v) || !v || v == 0xffff)
+		    continue;
+
+		fn++;
+
 		dev->bus = bus;
 		dev->sysdata = bus->sysdata;
 		dev->devfn = i;

--rwEMma7ioTxnRzrJ--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130250AbQKMXpt>; Mon, 13 Nov 2000 18:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130315AbQKMXpm>; Mon, 13 Nov 2000 18:45:42 -0500
Received: from quasar.osc.edu ([192.148.249.15]:60055 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S130250AbQKMXpe>;
	Mon, 13 Nov 2000 18:45:34 -0500
Date: Mon, 13 Nov 2000 18:15:30 -0500
From: Pete Wyckoff <pw@osc.edu>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: ns558 pci/isa change
Message-ID: <20001113181530.A7954@quasar.osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My joystick stopped working at 2.4.0-test10 due to a patch to
drivers/char/joystick/ns558.c that moves pci probing ahead of
isa probing.

The problem is that pci_module_init can return -ENODEV into i,
which is then used to index the ISA portlist.  ISA probing assumes
that i is initialized to zero.

Trivial fix attached, with plenty of context.

		-- Pete

--- drivers/char/joystick/ns558.c.orig	Mon Nov 13 18:04:16 2000
+++ drivers/char/joystick/ns558.c	Mon Nov 13 18:11:41 2000
@@ -299,37 +299,38 @@
 deactivate:
 	if (dev->deactivate)
 		dev->deactivate(dev);
 	return next;
 }
 #endif
 
 int __init ns558_init(void)
 {
-	int i = 0;
+	int i;
 #ifdef NSS558_ISAPNP
 	struct pci_dev *dev = NULL;
 	struct pnp_devid *devid;
 #endif
 
 /*
  * Probe for PCI ports.  Always probe for PCI first,
  * it is the least-invasive probe.
  */
 
 	i = pci_module_init(&ns558_pci_driver);
 	if (i == 0)
 		have_pci_devices = 1;
 
 /*
  * Probe for ISA ports.
  */
 
+	i = 0;
 	while (ns558_isa_portlist[i]) 
 		ns558 = ns558_isa_probe(ns558_isa_portlist[i++], ns558);
 
 /*
  * Probe for PnP ports.
  */
 
 #ifdef NSS558_ISAPNP
 	for (devid = pnp_devids; devid->vendor; devid++) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318979AbSHMQsE>; Tue, 13 Aug 2002 12:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318984AbSHMQsE>; Tue, 13 Aug 2002 12:48:04 -0400
Received: from [209.47.40.2] ([209.47.40.2]:47378 "EHLO mailnet.consensys.com")
	by vger.kernel.org with ESMTP id <S318979AbSHMQsD>;
	Tue, 13 Aug 2002 12:48:03 -0400
Message-ID: <015401c242e9$cb8b4370$4902a8c0@consensys.com>
From: "Jason Zebchuk" <jason@consensys.com>
To: <mj@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci_do_scan_bus
Date: Tue, 13 Aug 2002 12:52:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

    I've run into a stack overflow problem during boot that is caused by the
pci subsystem.  The function pci_do_scan_bus() puts a pci_dev on the stack,
and then indirectly calls itself recursively.  While this doesn't usually
cause any problems, the stack will overflow when there are a large number of
cascaded pci buses.

    This patch will fix the problem in the 2.5.30 kernel.  I discovered the
problem in the 2.4.18 kernel, and for anyone who wants to patch that kernel,
the same patch will work if you change "probe.c" to "pci.c"


Thanks,


Jason Zebchuk
Consensys RAIDZONE


--- linux-2.5.30/drivers/pci/probe.c    Thu Aug  1 17:16:10 2002
+++ linux/drivers/pci/probe.c   Tue Aug  6 12:36:53 2002
@@ -497,23 +497,27 @@
 {
        unsigned int devfn, max, pass;
        struct list_head *ln;
-       struct pci_dev *dev, dev0;
+       struct pci_dev *dev, *dev0;

        DBG("Scanning bus %02x\n", bus->number);
        max = bus->secondary;

        /* Create a device template */
-       memset(&dev0, 0, sizeof(dev0));
-       dev0.bus = bus;
-       dev0.sysdata = bus->sysdata;
-       dev0.dev.parent = bus->dev;
-       dev0.dev.bus = &pci_bus_type;
+       dev0 = kmalloc(sizeof(struct pci_dev), GFP_ATOMIC);
+       if (dev0 == NULL)
+               BUG();
+       memset(dev0, 0, sizeof(dev0));
+       dev0->bus = bus;
+       dev0->sysdata = bus->sysdata;
+       dev0->dev.parent = bus->dev;
+       dev0->dev.bus = &pci_bus_type;

        /* Go find them, Rover! */
        for (devfn = 0; devfn < 0x100; devfn += 8) {
-               dev0.devfn = devfn;
-               pci_scan_slot(&dev0);
+               dev0->devfn = devfn;
+               pci_scan_slot(dev0);
        }
+       kfree(dev0);

        /*
         * After performing arch-dependent fixup of the bus, look behind


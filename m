Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277564AbRKVMEu>; Thu, 22 Nov 2001 07:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277713AbRKVMEd>; Thu, 22 Nov 2001 07:04:33 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:772 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S277564AbRKVME1>; Thu, 22 Nov 2001 07:04:27 -0500
Date: Thu, 22 Nov 2001 15:04:18 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: [patch non-x86] PCI-PCI bridges fix
Message-ID: <20011122150418.A623@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bridge resources weren't added to the resource tree. This was
harmless for most real-life configurations (especially on Alpha),
but certainly it will be a problem with the hotplug stuff
(thinking of ES45).

Ivan.

--- 2.4.15p9/drivers/pci/setup-bus.c	Fri Oct  5 05:47:08 2001
+++ linux/drivers/pci/setup-bus.c	Wed Nov 21 20:16:24 2001
@@ -201,6 +201,16 @@ pbus_assign_resources(struct pci_bus *bu
 		b->resource[0]->end = ranges->io_end - 1;
 		b->resource[1]->end = ranges->mem_end - 1;
 
+		/* Add bridge resources to the resource tree. */
+		if (b->resource[0]->end > b->resource[0]->start &&
+		    request_resource(bus->resource[0], b->resource[0]) < 0)
+			printk(KERN_ERR "PCI: failed to reserve IO "
+					"for bus %d\n",	b->number);
+		if (b->resource[1]->end > b->resource[1]->start &&
+		    request_resource(bus->resource[1], b->resource[1]) < 0)
+			printk(KERN_ERR "PCI: failed to reserve MEM "
+					"for bus %d\n", b->number);
+
 		pci_setup_bridge(b);
 	}
 }

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRCCR6r>; Sat, 3 Mar 2001 12:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRCCR6h>; Sat, 3 Mar 2001 12:58:37 -0500
Received: from marine.sonic.net ([208.201.224.37]:18256 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S129624AbRCCR6b>;
	Sat, 3 Mar 2001 12:58:31 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010303095819.A16963@sonic.net>
Date: Sat, 3 Mar 2001 09:58:19 -0800
From: David Hinds <dhinds@sonic.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Bug in cardbus initialization, or am I missing something?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/pcmcia/cardbus.c in cb_alloc(), PCI_INTERRUPT_LINE and
dev->irq are not filled in until after calling pci_enable_device().
The result is a cryptic message like:

> PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try using pci=biosirq. 

Unless there is a less obvious reason for the ordering, I suggest the
following one-liner.

-- Dave Hinds

--- cardbus.c.orig	Fri Mar  2 09:49:46 2001
+++ cardbus.c	Fri Mar  2 09:50:28 2001
@@ -288,7 +288,6 @@
 			if (res->flags)
 				pci_assign_resource(dev, r);
 		}
-		pci_enable_device(dev); /* XXX check return */
 
 		/* Does this function have an interrupt at all? */
 		pci_readb(dev, PCI_INTERRUPT_PIN, &irq_pin);
@@ -297,6 +296,7 @@
 			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
 		}
 
+		pci_enable_device(dev); /* XXX check return */
 		pci_insert_device(dev, bus);
 	}
 

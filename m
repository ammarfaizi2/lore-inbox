Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVGQDva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVGQDva (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 23:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGQDva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 23:51:30 -0400
Received: from swordfish.cs.caltech.edu ([131.215.44.124]:7048 "EHLO
	swordfish.cs.caltech.edu") by vger.kernel.org with ESMTP
	id S261912AbVGQDva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 23:51:30 -0400
Date: Sat, 16 Jul 2005 20:51:24 -0700
From: Noah Misch <noah@cs.caltech.edu>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc3] pcmcia: pcmcia_request_irq for !IRQ_HANDLE_PRESENT
Message-ID: <20050717035124.GC13529@orchestra.cs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Between 2.6.10 and 2.6.11, the kernel began to print this message when I
inserted my IBM Home and Away adapter (pcnet_cs) into an i82365 slot:

  1.0: RequestIRQ: Unknown error code 0xffffffea

Initialization of the device then aborted; no `eth0' appeared.  Another user
recently reported the same problem:

  http://lists.infradead.org/pipermail/linux-pcmcia/2005-July/002151.html

I believe this change to pcmcia_request_irq brought about the problem:

  http://linus.bkbits.net:8080/linux-2.5/diffs/drivers/pcmcia/cs.c@1.122?nav=index.html|src/|src/drivers|src/drivers/pcmcia|hist/drivers/pcmcia/cs.c

When a driver calls pcmcia_request_irq with IRQ_HANDLE_PRESENT unset, it looks
for an open IRQ by request_irq()ing with a dummy handler and NULL dev_info.
free_irq uses dev_info as a key for identifying the handler to free among those
sharing an IRQ, so request_irq returns -EINVAL if dev_info is NULL and the IRQ
may be shared.  That unknown error code is the -EINVAL.

It looks like only pcnet_cs and axnet_cs are affected.  Most other drivers let
pcmcia_request_irq install their interrupt handlers.  sym53c500_cs requests its
IRQ manually, but it cannot share an IRQ.

The appended patch changes pcmcia_request_irq to pass an arbitrary, unique,
non-NULL dev_info with the dummy handler.

Signed-off-by: Noah Misch <noah@cs.caltech.edu>

--- pristine-linux-2.6.13-rc3/drivers/pcmcia/pcmcia_resource.c	2005-07-16 16:57:21.000000000 -0400
+++ rc3dbg/drivers/pcmcia/pcmcia_resource.c	2005-07-16 22:53:00.000000000 -0400
@@ -800,7 +800,7 @@ int pcmcia_request_irq(struct pcmcia_dev
 	} else {
 		int try;
 		u32 mask = s->irq_mask;
-		void *data = NULL;
+		int data;
 
 		for (try = 0; try < 64; try++) {
 			irq = try % 32;
@@ -822,10 +822,10 @@ int pcmcia_request_irq(struct pcmcia_dev
 					   (s->functions > 1) ||
 					   (irq == s->pci_irq)) ? SA_SHIRQ : 0,
 					  p_dev->dev.bus_id,
-					  (req->Attributes & IRQ_HANDLE_PRESENT) ? req->Instance : data);
+					  (req->Attributes & IRQ_HANDLE_PRESENT) ? req->Instance : &data);
 			if (!ret) {
 				if (!(req->Attributes & IRQ_HANDLE_PRESENT))
-					free_irq(irq, data);
+					free_irq(irq, &data);
 				break;
 			}
 		}

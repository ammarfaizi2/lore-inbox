Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129797AbQK3Kja>; Thu, 30 Nov 2000 05:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131595AbQK3KjU>; Thu, 30 Nov 2000 05:39:20 -0500
Received: from atbode61.informatik.tu-muenchen.de ([131.159.1.165]:54145 "EHLO
        atbode61.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
        id <S129797AbQK3KjL>; Thu, 30 Nov 2000 05:39:11 -0500
Date: Thu, 30 Nov 2000 11:08:40 +0100
From: Georg Acher <acher@in.tum.de>
To: linux-usb-devel@lists.sourceforge.net
Cc: johannes@erdfelt.com, linux-kernel@vger.kernel.org,
        linux-usb-users@lists.sourceforge.net
Subject: [patch] usb-uhci.c: fix for PCI-lockups/IRQ problems
Message-ID: <20001130110840.A2612@in.tum.de>
Mail-Followup-To: linux-usb-devel@lists.sourceforge.net,
        johannes@erdfelt.com, linux-kernel@vger.kernel.org,
        linux-usb-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
X-Mailer: Mutt 1.0pre3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii

Hi,
test12-pre3 had a large set of patches to usb-uhci.c. One small detail of
this patch can make the driver to lockup the PCI bus with certain UHCI-chips
(only Intel but not VIA, of course not on my machines...). This patch should 
fix that.
It also includes Linus' patch for the IRQ-setup.
-- 
         Georg Acher, acher@in.tum.de         
         http://www.in.tum.de/~acher/
          "Oh no, not again !" The bowl of petunias          

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-uhci.patch"

diff -u linux/drivers/usb/usb-uhci.c linux.afs/drivers/usb/usb-uhci.c
--- linux/drivers/usb/usb-uhci.c	Thu Nov 30 10:49:54 2000
+++ linux.afs/drivers/usb/usb-uhci.c	Thu Nov 30 10:47:54 2000
@@ -16,7 +16,7 @@
  * (C) Copyright 1999 Randy Dunlap
  * (C) Copyright 1999 Gregory P. Smith
  *
- * $Id: usb-uhci.c,v 1.249 2000/11/21 12:03:34 acher Exp $
+ * $Id: usb-uhci.c,v 1.251 2000/11/30 09:47:54 acher Exp $
  */
 
 #include <linux/config.h>
@@ -52,7 +52,7 @@
 /* This enables an extra UHCI slab for memory debugging */
 #define DEBUG_SLAB
 
-#define VERSTR "$Revision: 1.249 $ time " __TIME__ " " __DATE__
+#define VERSTR "$Revision: 1.251 $ time " __TIME__ " " __DATE__
 
 #include <linux/usb.h>
 #include "usb-uhci.h"
@@ -582,6 +582,7 @@
 	
 	fill_td (td, 0 * TD_CTRL_IOC, 0, 0); // generate 1ms interrupt (enabled on demand)
 	insert_td (s, qh, td, 0);
+	qh->hw.qh.element &= ~UHCI_PTR_TERM; // remove TERM bit
 	s->td1ms=td;
 
 	dbg("allocating qh: bulk_chain");
@@ -2916,6 +2917,9 @@
 		return -1;
 	}
 
+	/* Enable PIRQ */
+	pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);
+
 	s->irq = irq;
 
 	if(uhci_start_usb (s) < 0) {
@@ -2951,7 +2955,7 @@
 		if (check_region (io_addr, io_size))
 			break;
 		/* disable legacy emulation */
-		pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);
+		pci_write_config_word (dev, USBLEGSUP, 0);
 	
 		return alloc_uhci(dev, dev->irq, io_addr, io_size);
 	}

--3V7upXqbjpZ4EhLz--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

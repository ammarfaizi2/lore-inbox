Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRBIAJn>; Thu, 8 Feb 2001 19:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbRBIAJd>; Thu, 8 Feb 2001 19:09:33 -0500
Received: from cs.columbia.edu ([128.59.16.20]:9205 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129155AbRBIAJZ>;
	Thu, 8 Feb 2001 19:09:25 -0500
Date: Thu, 8 Feb 2001 16:09:15 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Donald Becker <becker@scyld.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jes@linuxcare.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102081406020.31024-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.30.0102081555450.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Ion Badulescu wrote:

> >    The MII read code is no longer reliable.  I spent twenty minutes at
> >    the show, but couldn't figure out the problem.  I haven't been able
> >    reproduce the problem locally with my 2.2 code and someone older
> >    hardware.
> 
> Yes, I've noticed this too, the PHY doesn't seem to get detected in all 
> cases, and it's pretty random at that. Other times the same PHY gets 
> detected multiple times at different addresses.
> 
> The good news is that the same code behaves the same on 2.4 and 2.2, so 
> I think it's not a core kernel issue. I'll try to track it down; 
> fortunately it doesn't affect card functionality as long as the user 
> sticks with autonegotiation.

Kicking the chip *hard* when probing can do wonders. :-)

The attached patch fixes MII detection for me, reliably. It's the same
thing my BSDI driver does. The patch is against the previous version I
sent to the list; it applies almost cleanly to 2.4.1-vanilla and the
reject is easy to apply manually.

Full patch (for Jeff) will follow later.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------
--- linux-2.4-boxter/drivers/net/starfire.c	Thu Feb  8 16:03:05 2001
+++ linux-2.4-zc/drivers/net/starfire.c	Thu Feb  8 16:02:26 2001
@@ -160,6 +160,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -519,6 +520,7 @@
 	static int printed_version = 0;
 	long ioaddr;
 	int drv_flags, io_size;
+	int boguscnt;
 
 	card_idx++;
 	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
@@ -586,8 +588,23 @@
 				   i % 16 != 15 ? " " : "\n");
 #endif
 
+	/* Issue soft reset */
+	writel(0x8000, ioaddr + TxMode);
+	udelay(1000);
+	writel(0, ioaddr + TxMode);
+
 	/* Reset the chip to erase previous misconfiguration. */
 	writel(1, ioaddr + PCIDeviceConfig);
+	boguscnt = 1000;
+	while (--boguscnt > 0) {
+		udelay(10);
+		if ((readl(ioaddr + PCIDeviceConfig) & 1) == 0)
+			break;
+	}
+	if (boguscnt == 0)
+		printk("%s: chipset reset never completed!\n", dev->name);
+	/* wait a little longer */
+	udelay(1000);
 
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
@@ -630,14 +647,27 @@
 
 	if (drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
+		int mii_status;
 		for (phy = 0; phy < 32 && phy_idx < 4; phy++) {
-			int mii_status = mdio_read(dev, phy, 1);
-			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
+			mdio_write(dev, phy, 0, 0x8000);
+			udelay(500);
+			boguscnt = 1000;
+			while (--boguscnt > 0)
+				if ((mdio_read(dev, phy, 0) & 0x8000) == 0)
+					break;
+			if (boguscnt == 0) {
+				printk("%s: PHY reset never completed!\n", dev->name);
+				continue;
+			}
+			mii_status = mdio_read(dev, phy, 1);
+			if (mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
 				np->advertising = mdio_read(dev, phy, 4);
 				printk(KERN_INFO "%s: MII PHY found at address %d, status "
 					   "0x%4.4x advertising %4.4x.\n",
 					   dev->name, phy, mii_status, np->advertising);
+				/* there can be only one PHY on-board */
+				break;
 			}
 		}
 		np->mii_cnt = phy_idx;
@@ -663,7 +693,11 @@
 	/* ??? Should we add a busy-wait here? */
 	do
 		result = readl(mdio_addr);
-	while ((result & 0xC0000000) != 0x80000000 && --boguscnt >= 0);
+	while ((result & 0xC0000000) != 0x80000000 && --boguscnt > 0);
+	if (boguscnt == 0)
+		return 0;
+	if ((result & 0xffff) == 0xffff)
+		return 0;
 	return result & 0xffff;
 }
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

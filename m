Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTKLQkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbTKLQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:40:31 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:12559 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262360AbTKLQkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:40:24 -0500
Date: Wed, 12 Nov 2003 19:39:34 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>,
       viro@parcelfarce.linux.theplanet.co.uk, dancraig@internode.on.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
Message-ID: <20031112193934.A1688@jurassic.park.msu.ru>
References: <20031112180642.A1064@jurassic.park.msu.ru> <Pine.LNX.4.44.0311120749520.3288-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0311120749520.3288-100000@home.osdl.org>; from torvalds@osdl.org on Wed, Nov 12, 2003 at 07:52:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 07:52:11AM -0800, Linus Torvalds wrote:
> The whole thing should probably be done as a PCI quirk. Anyway, I'll
> change my patch to be the absolute minimal one, ie just adding the
> !isa_dev test instead of removing the old confused logic. I'm pretty 
> certain that we shouldn't touch those GPIO's at all, but since some boards 
> probably _do_ want them enabled, let's go for the minimal "avoid oops" 
> approach.

Agreed.

Hmm, I've just looked at current 2.4 driver - it does test the isa_dev
and also does nothing for revisions C5 and above, probably for reason.
What about this, cut'n'pasted from 2.4?

Ivan.

--- linux/drivers/ide/pci/alim15x3.c.orig	Wed Nov 12 19:05:48 2003
+++ linux/drivers/ide/pci/alim15x3.c	Wed Nov 12 19:11:14 2003
@@ -578,6 +578,7 @@ static unsigned int __init init_chipset_
 {
 	unsigned long flags;
 	u8 tmpbyte;
+	struct pci_dev *north = pci_find_slot(0, PCI_DEVFN(0,0));
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &m5229_revision);
 
@@ -624,30 +625,35 @@ static unsigned int __init init_chipset_
 
 	/*
 	 * We should only tune the 1533 enable if we are using an ALi
+	 * North bridge. We might have no north found on some zany
+	 * box without a device at 0:0.0. The ALi bridge will be at
+	 * 0:0.0 so if we didn't find one we know what is cooking.
 	 * south bridge.
 	 */
-	if (!isa_dev) {
+	if (north && north->vendor != PCI_VENDOR_ID_AL) {
 		local_irq_restore(flags);
 	        return 0;
 	}
 
-	/*
-	 * set south-bridge's enable bit, m1533, 0x79
-	 */
-
-	pci_read_config_byte(isa_dev, 0x79, &tmpbyte);
-	if (m5229_revision == 0xC2) {
+	if (m5229_revision < 0xC5 && isa_dev)
+	{	
 		/*
-		 * 1543C-B0 (m1533, 0x79, bit 2)
+		 * set south-bridge's enable bit, m1533, 0x79
 		 */
-		pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x04);
-	} else if (m5229_revision >= 0xC3) {
-		/*
-		 * 1553/1535 (m1533, 0x79, bit 1)
-		 */
-		pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
-	}
 
+		pci_read_config_byte(isa_dev, 0x79, &tmpbyte);
+		if (m5229_revision == 0xC2) {
+			/*
+			 * 1543C-B0 (m1533, 0x79, bit 2)
+			 */
+			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x04);
+		} else if (m5229_revision >= 0xC3) {
+			/*
+			 * 1553/1535 (m1533, 0x79, bit 1)
+			 */
+			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
+		}
+	}
 	local_irq_restore(flags);
 	return 0;
 }

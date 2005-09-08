Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVIHONu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVIHONu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVIHONu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:13:50 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:20750 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751359AbVIHONs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:13:48 -0400
Date: Thu, 8 Sep 2005 10:13:24 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>
Subject: Re: [PATCH] 3c59x: cleanup of mdio_read routines to use MII_* macros in include/linux/mii.h
Message-ID: <20050908141324.GB17189@hmsreliant.homelinux.net>
References: <200509080125.j881PcL9015847@hera.kernel.org> <431F9899.4060602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431F9899.4060602@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 09:49:13PM -0400, Jeff Garzik wrote:
><snip> 
> It would be nice if somebody would be motivated to check in 
> s/1/MII_BMSR/ to utilize the constant in include/linux/mii.h.
> 
> 	Jeff
> 
As requested, a patch to cleanup mdio_read routines in 3c59x.c to use the MII_*
macros defined in include/linux/mii.h

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

 3c59x.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


--- linux-2.6/drivers/net/3c59x.c.orig	2005-09-08 08:24:35.000000000 -0400
+++ linux-2.6/drivers/net/3c59x.c	2005-09-08 08:27:57.000000000 -0400
@@ -1439,7 +1439,7 @@ static int __devinit vortex_probe1(struc
 		if (vp->drv_flags & EXTRA_PREAMBLE)
 			mii_preamble_required++;
 		mdio_sync(ioaddr, 32);
-		mdio_read(dev, 24, 1);
+		mdio_read(dev, 24, MII_BMSR);
 		for (phy = 0; phy < 32 && phy_idx < 1; phy++) {
 			int mii_status, phyx;
 
@@ -1453,7 +1453,7 @@ static int __devinit vortex_probe1(struc
 				phyx = phy - 1;
 			else
 				phyx = phy;
-			mii_status = mdio_read(dev, phyx, 1);
+			mii_status = mdio_read(dev, phyx, MII_BMSR);
 			if (mii_status  &&  mii_status != 0xffff) {
 				vp->phys[phy_idx++] = phyx;
 				if (print_info) {
@@ -1469,7 +1469,7 @@ static int __devinit vortex_probe1(struc
 			printk(KERN_WARNING"  ***WARNING*** No MII transceivers found!\n");
 			vp->phys[0] = 24;
 		} else {
-			vp->advertising = mdio_read(dev, vp->phys[0], 4);
+			vp->advertising = mdio_read(dev, vp->phys[0], MII_ADVERTISE);
 			if (vp->full_duplex) {
 				/* Only advertise the FD media types. */
 				vp->advertising &= ~0x02A0;
@@ -1641,8 +1641,8 @@ vortex_up(struct net_device *dev)
 		int mii_reg1, mii_reg5;
 		EL3WINDOW(4);
 		/* Read BMSR (reg1) only to clear old status. */
-		mii_reg1 = mdio_read(dev, vp->phys[0], 1);
-		mii_reg5 = mdio_read(dev, vp->phys[0], 5);
+		mii_reg1 = mdio_read(dev, vp->phys[0], MII_BMSR);
+		mii_reg5 = mdio_read(dev, vp->phys[0], MII_LPA);
 		if (mii_reg5 == 0xffff  ||  mii_reg5 == 0x0000) {
 			netif_carrier_off(dev); /* No MII device or no link partner report */
 		} else {
@@ -1872,13 +1872,13 @@ vortex_timer(unsigned long data)
 	case XCVR_MII: case XCVR_NWAY:
 		{
 			spin_lock_bh(&vp->lock);
-			mii_status = mdio_read(dev, vp->phys[0], 1);
+			mii_status = mdio_read(dev, vp->phys[0], MII_BMSR);
 			ok = 1;
 			if (vortex_debug > 2)
 				printk(KERN_DEBUG "%s: MII transceiver has status %4.4x.\n",
 					dev->name, mii_status);
 			if (mii_status & BMSR_LSTATUS) {
-				int mii_reg5 = mdio_read(dev, vp->phys[0], 5);
+				int mii_reg5 = mdio_read(dev, vp->phys[0], MII_LPA);
 				if (! vp->force_fd  &&  mii_reg5 != 0xffff) {
 					int duplex;
 
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263474AbSJGWFr>; Mon, 7 Oct 2002 18:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263503AbSJGWFq>; Mon, 7 Oct 2002 18:05:46 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:29629 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S263474AbSJGWFp>; Mon, 7 Oct 2002 18:05:45 -0400
Date: Mon, 7 Oct 2002 23:07:53 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.41: mii breakage in xircom_tulip_cb
Message-ID: <20021007220752.GA471@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Location: London, UK
X-URL: http://brautaset.org
X-KeyServer: wwwkeys.nl.pgp.net
X-PGP/GnuPG-Key: 9336ADC1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the xircom_tulip_cb driver with 2.4.19, because it is mii-enabled,
and the new driver isn't. 

In 2.5.41 (and .40, at least) the mii-capabilities is not there, I have
not tested earlier development kernels. The changes between the driver
in 2.4.19 and 2.5.41 are miniscule, so I was able to make mii work
again (this is my first attempt at kernel hacking; don't laugh :). It's
most definately _not_ the correct fix, it is just a revert from 2.4.19
that makes mii work for me again in 2.5.


--- drivers/net/tulip/xircom_tulip_cb.c.orig	Mon Oct  7 22:53:22 2002
+++ drivers/net/tulip/xircom_tulip_cb.c	Mon Oct  7 22:31:45 2002
@@ -1469,18 +1469,21 @@
 
 	/* Legacy mii-diag interface */
 	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
+	case SIOCDEVPRIVATE:		/* for binary compat, remove in 2.5 */
 		if (tp->mii_cnt)
 			data[0] = phy;
 		else
 			return -ENODEV;
 		return 0;
 	case SIOCGMIIREG:		/* Read MII PHY register. */
+	case SIOCDEVPRIVATE+1:		/* for binary compat, remove in 2.5 */
 		save_flags(flags);
 		cli();
 		data[3] = mdio_read(dev, data[0] & 0x1f, data[1] & 0x1f);
 		restore_flags(flags);
 		return 0;
 	case SIOCSMIIREG:		/* Write MII PHY register. */
+	case SIOCDEVPRIVATE+2:		/* for binary compat, remove in 2.5 */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		save_flags(flags);


Stig
-- 
brautaset.org

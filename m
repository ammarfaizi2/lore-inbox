Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264659AbUEOHMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbUEOHMl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 03:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUEOHMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 03:12:40 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:38417 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264659AbUEOHMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 03:12:36 -0400
Date: Sat, 15 May 2004 09:12:34 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with sis900
Message-ID: <20040515071233.GB9289@picchio.gall.it>
Mail-Followup-To: Dominik Karall <dominik.karall@gmx.net>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1084300104.24569.8.camel@datacontrol> <200405120030.12883.dominik.karall@gmx.net> <20040513151759.GA27382@gateway.milesteg.arr> <200405132002.56402.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <200405132002.56402.dominik.karall@gmx.net>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 13, 2004 at 08:02:56PM +0200, Dominik Karall wrote:
> Sorry, but the patch does not help, same error messages in log, and can't 
> change to full-duplex mode.
My fault, the linked list gets filled in reverse, address 1 is at the
end.

With the attached patch I should got it right...

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-phy.diff"

--- linux-2.6.5/drivers/net/sis900.c	2004-04-04 22:31:55.000000000 +0200
+++ linux-irda-2.6.5/drivers/net/sis900.c	2004-05-15 09:10:42.000000000 +0200
@@ -640,13 +640,16 @@
 static u16 sis900_default_phy(struct net_device * net_dev)
 {
 	struct sis900_private * sis_priv = net_dev->priv;
- 	struct mii_phy *phy = NULL, *phy_home = NULL, *default_phy = NULL;
+ 	struct mii_phy *phy = NULL, *phy_home = NULL, *default_phy = NULL, *phy_one = NULL;
 	u16 status;
 
         for( phy=sis_priv->first_mii; phy; phy=phy->next ){
 		status = mdio_read(net_dev, phy->phy_addr, MII_STATUS);
 		status = mdio_read(net_dev, phy->phy_addr, MII_STATUS);
 
+		if(phy->phy_addr == 1)
+			phy_one = phy;
+
 		/* Link ON & Not select deafalut PHY */
 		 if ( (status & MII_STAT_LINK) && !(default_phy) )
 		 	default_phy = phy;
@@ -665,6 +668,10 @@
 		default_phy = sis_priv->first_mii;
 
 	if( sis_priv->mii != default_phy ){
+		if(phy_one)
+			default_phy = phy_one;
+		else
+			printk(KERN_WARNING "Detected PHY not present in linked list!!\n");
 		sis_priv->mii = default_phy;
 		sis_priv->cur_phy = default_phy->phy_addr;
 		printk(KERN_INFO "%s: Using transceiver found at address %d as default\n", net_dev->name,sis_priv->cur_phy);

--opJtzjQTFsWo+cga--

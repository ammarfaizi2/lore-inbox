Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266792AbUG1HNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266792AbUG1HNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266797AbUG1HNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:13:38 -0400
Received: from ozlabs.org ([203.10.76.45]:7818 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266799AbUG1HLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:48 -0400
Date: Wed, 28 Jul 2004 16:57:25 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [8/15] orinoco merge preliminaries - use BUG_ON()
Message-ID: <20040728065725.GK16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax> <20040728065308.GD16908@zax> <20040728065345.GE16908@zax> <20040728065418.GF16908@zax> <20040728065450.GG16908@zax> <20040728065526.GH16908@zax> <20040728065550.GI16908@zax> <20040728065659.GJ16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065659.GJ16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use BUG_ON() macro instead of explicit if(x) BUG() in various places.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 15:05:39.583628208 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 15:05:40.433499008 +1000
@@ -1770,11 +1770,10 @@
 		int i;
 
 		for (i = 0; i < mc_count; i++) {
-			/* Paranoia: */
-			if (! p)
-				BUG(); /* Multicast list shorter than mc_count */
-			if (p->dmi_addrlen != ETH_ALEN)
-				BUG(); /* Bad address size in multicast list */
+			/* paranoia: is list shorter than mc_count? */
+			BUG_ON(! p);
+			/* paranoia: bad address size in list? */
+			BUG_ON(p->dmi_addrlen != ETH_ALEN);
 			
 			memcpy(mclist.addr[i], p->dmi_addr, ETH_ALEN);
 			p = p->next;
@@ -3185,8 +3184,7 @@
 
 	ratemode = priv->bitratemode;
 
-	if ( (ratemode < 0) || (ratemode >= BITRATE_TABLE_SIZE) )
-		BUG();
+	BUG_ON((ratemode < 0) || (ratemode >= BITRATE_TABLE_SIZE));
 
 	rrq->value = bitrate_table[ratemode].bitrate * 100000;
 	rrq->fixed = ! bitrate_table[ratemode].automatic;
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:39.588627448 +1000
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:40.435498704 +1000
@@ -172,8 +172,7 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
-	if (! dev)
-		BUG();
+	BUG_ON(! dev);
 
 	unregister_netdev(dev);
 		
Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c	2004-07-28 15:05:39.596626232 +1000
+++ working-2.6/drivers/net/wireless/orinoco_cs.c	2004-07-28 15:05:40.437498400 +1000
@@ -228,10 +228,8 @@
 	for (linkp = &dev_list; *linkp; linkp = &(*linkp)->next)
 		if (*linkp == link)
 			break;
-	if (*linkp == NULL) {
-		BUG();
-		return;
-	}
+
+	BUG_ON(*linkp == NULL);
 
 	if (link->state & DEV_CONFIG)
 		orinoco_cs_release(link);
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:39.592626840 +1000
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:40.438498248 +1000
@@ -286,8 +286,7 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
-	if (! dev)
-		BUG();
+	BUG_ON(! dev);
 
 	unregister_netdev(dev);
 		

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

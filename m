Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVBXEUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVBXEUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVBXETx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:19:53 -0500
Received: from ozlabs.org ([203.10.76.45]:16822 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261789AbVBXENZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:25 -0500
Date: Thu, 24 Feb 2005 15:02:28 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [10/14] Orinoco driver updates - prohibit IBSS with no ESSID
Message-ID: <20050224040228.GL32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain> <20050224040153.GK32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224040153.GK32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove has_ibss_any flag and never set the CREATEIBSS RID when the
ESSID is empty.  Too many firmware break if we do.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-24 14:50:50.125529816 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-24 14:50:53.166067584 +1100
@@ -1580,21 +1580,26 @@
 	}
 
 	if (priv->has_ibss) {
-		err = hermes_write_wordrec(hw, USER_BAP,
-					   HERMES_RID_CNFCREATEIBSS,
-					   priv->createibss);
-		if (err) {
-			printk(KERN_ERR "%s: Error %d setting CREATEIBSS\n", dev->name, err);
-			return err;
-		}
+		u16 createibss;
 
-		if ((strlen(priv->desired_essid) == 0) && (priv->createibss)
-		   && (!priv->has_ibss_any)) {
+		if ((strlen(priv->desired_essid) == 0) && (priv->createibss)) {
 			printk(KERN_WARNING "%s: This firmware requires an "
 			       "ESSID in IBSS-Ad-Hoc mode.\n", dev->name);
 			/* With wvlan_cs, in this case, we would crash.
 			 * hopefully, this driver will behave better...
 			 * Jean II */
+			createibss = 0;
+		} else {
+			createibss = priv->createibss;
+		}
+		
+		err = hermes_write_wordrec(hw, USER_BAP,
+					   HERMES_RID_CNFCREATEIBSS,
+					   createibss);
+		if (err) {
+			printk(KERN_ERR "%s: Error %d setting CREATEIBSS\n",
+			       dev->name, err);
+			return err;
 		}
 	}
 
@@ -2073,7 +2078,6 @@
 	priv->has_preamble = 0;
 	priv->has_port3 = 1;
 	priv->has_ibss = 1;
-	priv->has_ibss_any = 0;
 	priv->has_wep = 0;
 	priv->has_big_wep = 0;
 
@@ -2089,7 +2093,6 @@
 		firmver = ((unsigned long)sta_id.major << 16) | sta_id.minor;
 
 		priv->has_ibss = (firmver >= 0x60006);
-		priv->has_ibss_any = (firmver >= 0x60010);
 		priv->has_wep = (firmver >= 0x40020);
 		priv->has_big_wep = 1; /* FIXME: this is wrong - how do we tell
 					  Gold cards from the others? */
Index: working-2.6/drivers/net/wireless/orinoco.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.h	2005-02-24 14:50:46.549073520 +1100
+++ working-2.6/drivers/net/wireless/orinoco.h	2005-02-24 14:50:53.167067432 +1100
@@ -57,7 +57,7 @@
 #define FIRMWARE_TYPE_AGERE 1
 #define FIRMWARE_TYPE_INTERSIL 2
 #define FIRMWARE_TYPE_SYMBOL 3
-	int has_ibss, has_port3, has_ibss_any, ibss_port;
+	int has_ibss, has_port3, ibss_port;
 	int has_wep, has_big_wep;
 	int has_mwo;
 	int has_pm;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson

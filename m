Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVBXEaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVBXEaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVBXEaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:30:22 -0500
Received: from ozlabs.org ([203.10.76.45]:17078 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261792AbVBXENZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:25 -0500
Date: Thu, 24 Feb 2005 15:02:58 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [11/14] Orinoco driver updates - delay Tx wake
Message-ID: <20050224040258.GM32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain> <20050224040153.GK32001@localhost.localdomain> <20050224040228.GL32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224040228.GL32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delay netif_wake_queue() until the packet has actually been
transmitted, rather than just when the firmware has copied it into its
internal buffers.  This seems to prevent problems on some Intersil
firmware versions (I suspect the problems were caused by the
firmware's buffers filling up).

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-18 12:48:30.523655896 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-18 12:58:09.407652152 +1100
@@ -901,8 +901,6 @@
 			printk(KERN_WARNING "%s: Allocate event on unexpected fid (%04X)\n",
 			       dev->name, fid);
 		return;
-	} else {
-		netif_wake_queue(dev);
 	}
 
 	hermes_write_regn(hw, ALLOCFID, DUMMY_FID);
@@ -915,6 +913,8 @@
 
 	stats->tx_packets++;
 
+	netif_wake_queue(dev);
+
 	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
 }
 
@@ -941,6 +941,7 @@
 	
 	stats->tx_errors++;
 
+	netif_wake_queue(dev);
 	hermes_write_regn(hw, TXCOMPLFID, DUMMY_FID);
 }
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVBXEPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVBXEPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVBXEOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:14:25 -0500
Received: from ozlabs.org ([203.10.76.45]:12982 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261783AbVBXENX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:23 -0500
Date: Thu, 24 Feb 2005 14:56:50 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [3/14] Orinoco driver updates - use mdelay()/ssleep() more
Message-ID: <20050224035650.GD32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224035524.GC32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use mdelay() or ssleep() instead of various silly more complicated
ways of delaying in the orinoco driver.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2005-01-12 15:13:18.819073992 +1100
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2005-01-12 15:15:33.137654464 +1100
@@ -151,19 +151,11 @@
 
 	/* Assert the reset until the card notice */
 	hermes_write_regn(hw, PCI_COR, HERMES_PCI_COR_MASK);
-	timeout = jiffies + (HERMES_PCI_COR_ONT * HZ / 1000);
-	while(time_before(jiffies, timeout)) {
-		mdelay(1);
-	}
-	//mdelay(HERMES_PCI_COR_ONT);
+	mdelay(HERMES_PCI_COR_ONT);
 
 	/* Give time for the card to recover from this hard effort */
 	hermes_write_regn(hw, PCI_COR, 0x0000);
-	timeout = jiffies + (HERMES_PCI_COR_OFFT * HZ / 1000);
-	while(time_before(jiffies, timeout)) {
-		mdelay(1);
-	}
-	//mdelay(HERMES_PCI_COR_OFFT);
+	mdelay(HERMES_PCI_COR_OFFT);
 
 	/* The card is ready when it's no longer busy */
 	timeout = jiffies + (HERMES_PCI_COR_BUSYT * HZ / 1000);
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2005-01-12 15:13:18.821073688 +1100
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2005-01-12 15:15:33.138654312 +1100
@@ -356,8 +356,7 @@
 static void __exit orinoco_plx_exit(void)
 {
 	pci_unregister_driver(&orinoco_plx_driver);
-	current->state = TASK_UNINTERRUPTIBLE;
-	schedule_timeout(HZ);
+	ssleep(1);
 }
 
 module_init(orinoco_plx_init);
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2005-01-12 15:13:18.820073840 +1100
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2005-01-12 15:16:05.897674184 +1100
@@ -225,8 +225,7 @@
 static void __exit orinoco_tmd_exit(void)
 {
 	pci_unregister_driver(&orinoco_tmd_driver);
-	current->state = TASK_UNINTERRUPTIBLE;
-	schedule_timeout(HZ);
+	ssleep(1);
 }
 
 module_init(orinoco_tmd_init);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson

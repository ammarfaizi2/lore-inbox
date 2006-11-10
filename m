Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946690AbWKJOtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946690AbWKJOtK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946689AbWKJOtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:49:10 -0500
Received: from iona.labri.fr ([147.210.8.143]:58497 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1946690AbWKJOtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:49:06 -0500
Date: Fri, 10 Nov 2006 15:49:19 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: tori@unhappy.mine.nu, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sebastien.hinderer@loria.fr
Subject: Tulip dmfe carrier detection
Message-ID: <20061110144919.GI3411@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	tori@unhappy.mine.nu, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	sebastien.hinderer@loria.fr
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The dmfe module lacks netif stuff for carrier detection, while the board
does report carrier status. Here is a patch.

Note: there are probably a lot more ethtool stuff that could be added,
but carrier sense is really a must.

Samuel

--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- drivers/net/tulip/dmfe-orig.c	2006-10-01 16:09:49.000000000 +0200
+++ drivers/net/tulip/dmfe.c	2006-11-10 15:20:55.000000000 +0100
@@ -187,7 +187,7 @@ struct rx_desc {
 struct dmfe_board_info {
 	u32 chip_id;			/* Chip vendor/Device ID */
 	u32 chip_revision;		/* Chip revision */
-	struct DEVICE *next_dev;	/* next device */
+	struct DEVICE *dev;		/* net device */
 	struct pci_dev *pdev;		/* PCI device */
 	spinlock_t lock;
 
@@ -399,6 +399,8 @@ static int __devinit dmfe_init_one (stru
 	/* Init system & device */
 	db = netdev_priv(dev);
 
+	db->dev = dev;
+
 	/* Allocate Tx/Rx descriptor memory */
 	db->desc_pool_ptr = pci_alloc_consistent(pdev, sizeof(struct tx_desc) * DESC_ALL_CNT + 0x20, &db->desc_pool_dma_ptr);
 	db->buf_pool_ptr = pci_alloc_consistent(pdev, TX_BUF_ALLOC * TX_DESC_CNT + 4, &db->buf_pool_dma_ptr);
@@ -1050,6 +1052,7 @@ static void netdev_get_drvinfo(struct ne
 
 static struct ethtool_ops netdev_ethtool_ops = {
 	.get_drvinfo		= netdev_get_drvinfo,
+	.get_link               = ethtool_op_get_link,
 };
 
 /*
@@ -1144,6 +1147,7 @@ static void dmfe_timer(unsigned long dat
 		/* Link Failed */
 		DMFE_DBUG(0, "Link Failed", tmp_cr12);
 		db->link_failed = 1;
+		netif_carrier_off(db->dev);
 
 		/* For Force 10/100M Half/Full mode: Enable Auto-Nego mode */
 		/* AUTO or force 1M Homerun/Longrun don't need */
@@ -1166,6 +1170,8 @@ static void dmfe_timer(unsigned long dat
 			if ( (db->media_mode & DMFE_AUTO) &&
 				dmfe_sense_speed(db) )
 				db->link_failed = 1;
+			else
+				netif_carrier_on(db->dev);
 			dmfe_process_mode(db);
 			/* SHOW_MEDIA_TYPE(db->op_mode); */
 		}

--oTHb8nViIGeoXxdp--

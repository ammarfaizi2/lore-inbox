Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264856AbUDUEnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264856AbUDUEnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUDUEnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:43:45 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:50375 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S264856AbUDUEnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 00:43:42 -0400
Date: Wed, 21 Apr 2004 14:42:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] PPC64 iSeries virtual ethernet fix
Message-Id: <20040421144203.7c7c3d4e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__21_Apr_2004_14_42_03_+1000_.6VlfrR_A_cTs_to"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__21_Apr_2004_14_42_03_+1000_.6VlfrR_A_cTs_to
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This is the patch I said would be needed due to other patches that were
applied in parallel with the inclusion of the iSeries virtual ethernet
driver.

Please apply to your tree and send to Linus.

This patch is realtive to 2.6.6-rc2.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.6-rc2/drivers/net/iseries_veth.c 2.6.6-rc2.veth.1/drivers/net/iseries_veth.c
--- 2.6.6-rc2/drivers/net/iseries_veth.c	2004-04-21 13:26:12.000000000 +1000
+++ 2.6.6-rc2.veth.1/drivers/net/iseries_veth.c	2004-04-21 14:35:45.000000000 +1000
@@ -61,7 +61,6 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
-#include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -78,10 +77,11 @@
 #include <asm/iSeries/HvTypes.h>
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/iommu.h>
+#include <asm/vio.h>
 
 #include "iseries_veth.h"
 
-extern struct pci_dev *iSeries_veth_dev;
+extern struct vio_dev *iSeries_veth_dev;
 
 MODULE_AUTHOR("Kyle Lucke <klucke@us.ibm.com>");
 MODULE_DESCRIPTION("iSeries Virtual ethernet driver");
@@ -895,10 +895,10 @@
 	}
 
 	dma_length = skb->len;
-	dma_address = pci_map_single(iSeries_veth_dev, skb->data,
-				     dma_length, PCI_DMA_TODEVICE);
+	dma_address = vio_map_single(iSeries_veth_dev, skb->data,
+				     dma_length, DMA_TO_DEVICE);
 
-	if (pci_dma_mapping_error(dma_address))
+	if (dma_mapping_error(dma_address))
 		goto recycle_and_drop;
 
 	/* Is it really necessary to check the length and address
@@ -1016,8 +1016,8 @@
 		dma_address = msg->data.addr[0];
 		dma_length = msg->data.len[0];
 
-		pci_unmap_single(iSeries_veth_dev, dma_address, dma_length,
-				 PCI_DMA_TODEVICE);
+		vio_unmap_single(iSeries_veth_dev, dma_address, dma_length,
+				 DMA_TO_DEVICE);
 
 		if (msg->skb) {
 			dev_kfree_skb_any(msg->skb);


--Signature=_Wed__21_Apr_2004_14_42_03_+1000_.6VlfrR_A_cTs_to
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhfucFG47PeJeR58RAuFmAJ9oYXsCysN/91rMJnQfWd5W9ga/CgCgl7zE
iZsLmXxWzatx17FDXd40o48=
=wUCT
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Apr_2004_14_42_03_+1000_.6VlfrR_A_cTs_to--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264174AbUEXIxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUEXIxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUEXIwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:52:04 -0400
Received: from zeus.kernel.org ([204.152.189.113]:48287 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264174AbUEXIeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:34:18 -0400
Date: Mon, 24 May 2004 04:33:47 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 12/14 linux-2.6.7-rc1] prism54: Start using likely/unlikely
Message-ID: <20040524083347.GM3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hdMwqcnXK86+cyrC"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hdMwqcnXK86+cyrC
Content-Type: multipart/mixed; boundary="R4RAxL8G0iuuxuj8"
Content-Disposition: inline


--R4RAxL8G0iuuxuj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-04-26      Margit Schubert-While <margitsw@t-online.de>

* islpci_mgt.h : Replace init_wds with a define. The compiler does not=20
  optimize it out (and also generates the field in the ro section of every =
module)

* prismcompat(24).h : Include linux/compiler.h Now we can play=20
  with the likely/unlikely macros

* islpci_eth.c, islpci_dev.c : Align skb->data unconditonally after
  allocation. This would appear to improve RX rate. Do a little bit of
  likely/unlikely.
--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--R4RAxL8G0iuuxuj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="12-add-likely.patch"
Content-Transfer-Encoding: quoted-printable

2004-04-26	Margit Schubert-While <margitsw@t-online.de>

	* islpci_mgt.h : Replace init_wds with a define.
	The compiler does not optimize it out (and also generates the
	field in the ro section of every module)

	* prismcompat(24).h : Include linux/compiler.h
	Now we can play with the likely/unlikely macros

	* islpci_eth.c, islpci_dev.c : Align skb->data unconditonally
	after allocation.  This would appear to improve RX rate.
	Do a little bit of likely/unlikely.

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v
retrieving revision 1.152
retrieving revision 1.153
diff -u -r1.152 -r1.153
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	17 Apr 2004 08=
:46:04 -0000	1.152
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	22 Apr 2004 12=
:20:39 -0000	1.153
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.152 2004/04/17 0=
8:46:04 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.153 2004/04/22 1=
2:20:39 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *            (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
@@ -2146,7 +2146,7 @@
 	{PRISM54_DBG_OID, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
 	 "dbg_oid"},
 	{PRISM54_DBG_GET_OID, 0, IW_PRIV_TYPE_BYTE | 256, "dbg_get_oid"},
-	{PRISM54_DBG_SET_OID, IW_PRIV_TYPE_BYTE | 256, 0, "dbg_get_oid"},
+	{PRISM54_DBG_SET_OID, IW_PRIV_TYPE_BYTE | 256, 0, "dbg_set_oid"},
 	/* --- sub-ioctls handlers --- */
 	{PRISM54_GET_OID,
 	 0, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | PRIV_STR_SIZE, ""},
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v
retrieving revision 1.76
retrieving revision 1.77
diff -u -r1.76 -r1.77
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	19 Apr 2004 1=
8:33:45 -0000	1.76
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	26 Apr 2004 1=
0:09:58 -0000	1.77
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.76 2004/04/19 1=
8:33:45 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.77 2004/04/26 1=
0:09:58 msw Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -560,6 +560,7 @@
 			skb =3D NULL;
 			goto out_free;
 		}
+		skb_reserve(skb, (4 - (long) skb->data) & 0x03);
 		/* add the new allocated sk_buff to the buffer array */
 		priv->data_low_rx[counter] =3D skb;
=20
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v
retrieving revision 1.35
retrieving revision 1.36
diff -u -r1.35 -r1.36
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	20 Mar 2004 1=
6:58:36 -0000	1.35
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	26 Apr 2004 1=
0:09:58 -0000	1.36
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.35 2004/03/20 1=
6:58:36 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.36 2004/04/26 1=
0:09:58 msw Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2004 Aurelien Alleaume <slts@free.fr>
@@ -105,7 +105,7 @@
=20
 	/* check whether the destination queue has enough fragments for the frame=
 */
 	curr_frag =3D le32_to_cpu(cb->driver_curr_frag[ISL38XX_CB_TX_DATA_LQ]);
-	if (curr_frag - priv->free_data_tx >=3D ISL38XX_CB_TX_QSIZE) {
+	if (unlikely(curr_frag - priv->free_data_tx >=3D ISL38XX_CB_TX_QSIZE)) {
 		printk(KERN_ERR "%s: transmit device queue full when awake\n",
 		       ndev->name);
 		netif_stop_queue(ndev);
@@ -121,7 +121,7 @@
 	/* Check alignment and WDS frame formatting. The start of the packet shou=
ld
 	 * be aligned on a 4-byte boundary. If WDS is enabled add another 6 bytes
 	 * and add WDS address information */
-	if (((long) skb->data & 0x03) | init_wds) {
+	if (unlikely(((long) skb->data & 0x03) | init_wds)) {
 		/* get the number of bytes to add and re-allign */
 		offset =3D (4 - (long) skb->data) & 0x03;
 		offset +=3D init_wds ? 6 : 0;
@@ -192,7 +192,7 @@
 	pci_map_address =3D pci_map_single(priv->pdev,
 					 (void *) skb->data, skb->len,
 					 PCI_DMA_TODEVICE);
-	if (pci_map_address =3D=3D 0) {
+	if (unlikely(pci_map_address =3D=3D 0)) {
 		printk(KERN_WARNING "%s: cannot map buffer to PCI\n",
 		       ndev->name);
=20
@@ -382,10 +382,10 @@
 	skb->dev =3D ndev;
=20
 	/* take care of monitor mode and spy monitoring. */
-	if (priv->iw_mode =3D=3D IW_MODE_MONITOR)
+	if (unlikely(priv->iw_mode =3D=3D IW_MODE_MONITOR))
 		discard =3D islpci_monitor_rx(priv, &skb);
 	else {
-		if (skb->data[2 * ETH_ALEN] =3D=3D 0) {
+		if (unlikely(skb->data[2 * ETH_ALEN] =3D=3D 0)) {
 			/* The packet has a rx_annex. Read it for spy monitoring, Then
 			 * remove it, while keeping the 2 leading MAC addr.
 			 */
@@ -418,7 +418,7 @@
 	     skb->data[0], skb->data[1], skb->data[2], skb->data[3],
 	     skb->data[4], skb->data[5]);
 #endif
-	if (discard) {
+	if (unlikely(discard)) {
 		dev_kfree_skb(skb);
 		skb =3D NULL;
 	} else
@@ -434,11 +434,13 @@
 	       index - priv->free_data_rx < ISL38XX_CB_RX_QSIZE) {
 		/* allocate an sk_buff for received data frames storage
 		 * include any required allignment operations */
-		if (skb =3D dev_alloc_skb(MAX_FRAGMENT_SIZE_RX + 2), skb =3D=3D NULL) {
+		skb =3D dev_alloc_skb(MAX_FRAGMENT_SIZE_RX + 2);
+		if (unlikely(skb =3D=3D NULL)) {
 			/* error allocating an sk_buff structure elements */
 			DEBUG(SHOW_ERROR_MESSAGES, "Error allocating skb \n");
 			break;
 		}
+		skb_reserve(skb, (4 - (long) skb->data) & 0x03);
 		/* store the new skb structure pointer */
 		index =3D index % ISL38XX_CB_RX_QSIZE;
 		priv->data_low_rx[index] =3D skb;
@@ -454,7 +456,7 @@
 		    pci_map_single(priv->pdev, (void *) skb->data,
 				   MAX_FRAGMENT_SIZE_RX + 2,
 				   PCI_DMA_FROMDEVICE);
-		if (priv->pci_map_rx_address[index] =3D=3D (dma_addr_t) NULL) {
+		if (unlikely(priv->pci_map_rx_address[index] =3D=3D (dma_addr_t) NULL)) {
 			/* error mapping the buffer to device accessable memory address */
 			DEBUG(SHOW_ERROR_MESSAGES,
 			      "Error mapping DMA address\n");
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.h,v
retrieving revision 1.25
retrieving revision 1.26
diff -u -r1.25 -r1.26
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.h	20 Mar 2004 1=
6:58:37 -0000	1.25
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.h	26 Apr 2004 1=
0:09:58 -0000	1.26
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.h,v 1.25 2004/03/20 1=
6:58:37 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.h,v 1.26 2004/04/26 1=
0:09:58 msw Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Luis R. Rodriguez <mcgrof@ruslug.rutgers.edu>
@@ -34,7 +34,7 @@
 #define TRACE(devname)   K_DEBUG(SHOW_TRACING, VERBOSE, "%s:  -> " __FUNCT=
ION__ "()\n", devname)
=20
 extern int pc_debug;
-static const int init_wds =3D 0;	/* help compiler optimize away dead code =
*/
+#define init_wds   0	/* help compiler optimize away dead code */
=20
=20
 /* General driver definitions */
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/prismcompat.h,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -r1.3 -r1.4
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h	19 Apr 2004 =
18:33:45 -0000	1.3
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat.h	26 Apr 2004 =
10:09:58 -0000	1.4
@@ -32,6 +32,7 @@
 #include <linux/config.h>
 #include <linux/moduleparam.h>
 #include <linux/workqueue.h>
+#include <linux/compiler.h>
=20
 #if !defined(CONFIG_FW_LOADER) && !defined(CONFIG_FW_LOADER_MODULE)
 #error Firmware Loading is not configured in the kernel !
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/prismcompat24.h,v
retrieving revision 1.3
retrieving revision 1.5
diff -u -r1.3 -r1.5
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h	19 Apr 200=
4 18:33:45 -0000	1.3
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h	26 Apr 200=
4 10:09:58 -0000	1.5
@@ -26,6 +26,8 @@
 #include <linux/firmware.h>
 #include <linux/config.h>
 #include <linux/tqueue.h>
+#include <linux/version.h>
+#include <linux/compiler.h>
=20
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,25)
 #define module_param(x, y, z)	MODULE_PARM(x, "i")

--R4RAxL8G0iuuxuj8--

--hdMwqcnXK86+cyrC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbNrat1JN+IKUl4RAnn7AJ9qepm0AumXVIIncA79FLLZQagZbQCgqfMc
GrTjPQXLTRO8KbV2Ur1QVfI=
=GS0G
-----END PGP SIGNATURE-----

--hdMwqcnXK86+cyrC--

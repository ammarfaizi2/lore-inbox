Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUEXIiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUEXIiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUEXIiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:38:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:49822 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264134AbUEXIbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:31:43 -0400
Date: Mon, 24 May 2004 04:31:17 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 3/14 linux-2.6.7-rc1] prism54: add iwspy support
Message-ID: <20040524083117.GD3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="27KoNqt0fmcl1zj/"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--27KoNqt0fmcl1zj/
Content-Type: multipart/mixed; boundary="fzZfjcV6kaBgkq89"
Content-Disposition: inline


--fzZfjcV6kaBgkq89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-03-18      Aurelien Alleaume <slts@free.fr>

        * islpci_eth.c, islpci_dev.h, isl_ioctl.c : iwspy support. Ran
	* lindent.

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--fzZfjcV6kaBgkq89
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename="03-add-iwspy-support.patch"
Content-Transfer-Encoding: quoted-printable

2004-03-18      Aurelien Alleaume <slts@free.fr>

	* islpci_eth.c, islpci_dev.h, isl_ioctl.c : iwspy support. Ran lindent.

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v
retrieving revision 1.144
retrieving revision 1.145
diff -u -r1.144 -r1.145
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	18 Mar 2004 11=
:16:23 -0000	1.144
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	18 Mar 2004 15=
:27:44 -0000	1.145
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.144 2004/03/18 1=
1:16:23 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.145 2004/03/18 1=
5:27:44 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *            (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
@@ -2098,6 +2098,31 @@
 	return ret;
 }
=20
+static int
+prism54_set_spy(struct net_device *ndev,
+		struct iw_request_info *info,
+		union iwreq_data *uwrq, char *extra)
+{
+	islpci_private *priv =3D netdev_priv(ndev);
+	u32 u, oid =3D OID_INL_CONFIG;
+
+	down_write(&priv->mib_sem);
+	mgt_get(priv, OID_INL_CONFIG, &u);
+
+	if ((uwrq->data.length =3D=3D 0) && (priv->spy_data.spy_number > 0))
+		/* disable spy */
+		u &=3D ~INL_CONFIG_RXANNEX;
+	else if ((uwrq->data.length > 0) && (priv->spy_data.spy_number =3D=3D 0))
+		/* enable spy */
+		u |=3D INL_CONFIG_RXANNEX;
+
+	mgt_set(priv, OID_INL_CONFIG, &u);
+	mgt_commit_list(priv, &oid, 1);
+	up_write(&priv->mib_sem);
+
+	return iw_handler_set_spy(ndev, info, uwrq, extra);
+}
+
 static const iw_handler prism54_handler[] =3D {
 	(iw_handler) prism54_commit,	/* SIOCSIWCOMMIT */
 	(iw_handler) prism54_get_name,	/* SIOCGIWNAME */
@@ -2115,7 +2140,7 @@
 	(iw_handler) NULL,	/* SIOCGIWPRIV */
 	(iw_handler) NULL,	/* SIOCSIWSTATS */
 	(iw_handler) NULL,	/* SIOCGIWSTATS */
-	iw_handler_set_spy,	/* SIOCSIWSPY */
+	prism54_set_spy,	/* SIOCSIWSPY */
 	iw_handler_get_spy,	/* SIOCGIWSPY */
 	iw_handler_set_thrspy,	/* SIOCSIWTHRSPY */
 	iw_handler_get_thrspy,	/* SIOCGIWTHRSPY */
@@ -2182,7 +2207,6 @@
 #define IWPRIV_SSID(n,x)	IWPRIV_SET_SSID(n,x), IWPRIV_GET(n,x)
 #define IWPRIV_ADDR(n,x)	IWPRIV_SET_ADDR(n,x), IWPRIV_GET(n,x)
=20
-
 /* Note : limited to 128 private ioctls */
=20
 static const struct iw_priv_args prism54_private_args[] =3D {
@@ -2234,7 +2258,7 @@
 	IWPRIV_U32(DOT11_OID_AUTHENABLE, "authenable"),
 	IWPRIV_U32(DOT11_OID_PRIVACYINVOKED, "privinvok"),
 	IWPRIV_U32(DOT11_OID_EXUNENCRYPTED, "exunencrypt"),
-=09
+
 	IWPRIV_U32(DOT11_OID_REKEYTHRESHOLD, "rekeythresh"),
=20
 	IWPRIV_U32(DOT11_OID_MAXTXLIFETIME, "maxtxlife"),
@@ -2261,7 +2285,7 @@
 	IWPRIV_GET(DOT11_OID_FREQUENCYACTIVITY, "freqactivity"),
 	IWPRIV_U32(DOT11_OID_NONERPPROTECTION, "nonerpprotec"),
 	IWPRIV_U32(DOT11_OID_PROFILES, "profile"),
-	IWPRIV_GET(DOT11_OID_EXTENDEDRATES,"extrates"),
+	IWPRIV_GET(DOT11_OID_EXTENDEDRATES, "extrates"),
 	IWPRIV_U32(DOT11_OID_MLMEAUTOLEVEL, "mlmelevel"),
=20
 	IWPRIV_GET(DOT11_OID_BSSS, "bsss"),
@@ -2308,20 +2332,13 @@
 	.standard =3D (iw_handler *) prism54_handler,
 	.private =3D (iw_handler *) prism54_private_handler,
 	.private_args =3D (struct iw_priv_args *) prism54_private_args,
+	.spy_offset =3D offsetof(islpci_private, spy_data),
 };
=20
-/* These ioctls won't work with the new API */
+/* For ioctls that don't work with the new API */
=20
 int
 prism54_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
-	/*struct iwreq *wrq =3D (struct iwreq *) rq;
-	   islpci_private *priv =3D netdev_priv(ndev);
-	   int ret =3D 0;
-
-	   switch (cmd) {
-
-	   }
-	 */
 	return -EOPNOTSUPP;
 }
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_oid.h,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -r1.4 -r1.5
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h	18 Mar 2004 11:1=
6:23 -0000	1.4
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h	18 Mar 2004 15:2=
7:44 -0000	1.5
@@ -1,9 +1,9 @@
 /*
- *  $Id: isl_oid.h,v 1.4 2004/03/18 11:16:23 ajfa Exp $
+ *  $Id: isl_oid.h,v 1.5 2004/03/18 15:27:44 ajfa Exp $
  * =20
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
  *  Copyright (C) 2004 Luis R. Rodriguez <mcgrof@ruslug.rutgers.edu>
- *  Copyright (C) 2004 Aur=E9lien Alleaume <slts@free.fr>
+ *  Copyright (C) 2004 Aurelien Alleaume <slts@free.fr>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -91,6 +91,19 @@
 	u16 mhz[0];
 } __attribute__ ((packed));
=20
+struct obj_rx_annex {
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u32 something0;
+	u32 time;
+	u16 something1;
+	u16 rate;
+	u16 freq;
+	u16 something2;
+	u8 rssi;
+	u8 pad[3];
+} __attribute__ ((packed));
+
 /*=20
  * in case everything's ok, the inlined function below will be
  * optimized away by the compiler...
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v
retrieving revision 1.56
retrieving revision 1.57
diff -u -r1.56 -r1.57
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	18 Mar 2004 1=
1:44:17 -0000	1.56
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	18 Mar 2004 1=
5:27:44 -0000	1.57
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.56 2004/03/18 1=
1:44:17 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.57 2004/03/18 1=
5:27:44 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.=20
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -26,6 +26,7 @@
 #include <linux/version.h>
 #include <linux/netdevice.h>
 #include <linux/wireless.h>
+#include <net/iw_handler.h>
 #include <linux/list.h>
=20
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,41)
@@ -111,6 +112,8 @@
 	struct iw_statistics local_iwstatistics;
 	struct iw_statistics iwstatistics;
=20
+	struct iw_spy_data spy_data; /* iwspy support */
+
 	struct islpci_acl acl;
=20
 	/* PCI bus allocation & configuration members */
@@ -182,7 +185,7 @@
 	islpci_state_t state;
 	int state_off;		/* enumeration of off-state, if 0 then
 				 * we're not in any off-state */
-=09
+
 	/* WPA stuff */
 	int wpa; /* WPA mode enabled */
 	struct list_head bss_wpa_list;
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v
retrieving revision 1.30
retrieving revision 1.31
diff -u -r1.30 -r1.31
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 2004 1=
1:44:17 -0000	1.30
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 2004 1=
5:27:44 -0000	1.31
@@ -1,7 +1,7 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.30 2004/03/18 1=
1:44:17 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.31 2004/03/18 1=
5:27:44 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
- *
+ *  Copyright (C) 2004 Aurelien Alleaume <slts@free.fr>
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License
@@ -205,7 +205,7 @@
 	priv->data_low_tx[index] =3D skb;
 	/* set the proper fragment start address and size information */
 	fragment->size =3D cpu_to_le16(frame_size);
-	fragment->flags =3D cpu_to_le16(0);  /* set to 1 if more fragments */
+	fragment->flags =3D cpu_to_le16(0);	/* set to 1 if more fragments */
 	fragment->address =3D cpu_to_le32(pci_map_address);
 	curr_frag++;
=20
@@ -215,7 +215,7 @@
 	cb->driver_curr_frag[ISL38XX_CB_TX_DATA_LQ] =3D cpu_to_le32(curr_frag);
=20
 	if (curr_frag - priv->free_data_tx + ISL38XX_MIN_QTHRESHOLD
-	                                           > ISL38XX_CB_TX_QSIZE) {
+	    > ISL38XX_CB_TX_QSIZE) {
 		/* stop sends from upper layers */
 		netif_stop_queue(ndev);
=20
@@ -236,7 +236,7 @@
=20
 	return 0;
=20
- drop_free:
+      drop_free:
 	/* free the skbuf structure before aborting */
 	dev_kfree_skb(skb);
 	skb =3D NULL;
@@ -266,7 +266,8 @@
 	index =3D priv->free_data_rx % ISL38XX_CB_RX_QSIZE;
 	size =3D le16_to_cpu(control_block->rx_data_low[index].size);
 	skb =3D priv->data_low_rx[index];
-	offset =3D ((unsigned long) le32_to_cpu(control_block->rx_data_low[index]=
.address) -
+	offset =3D ((unsigned long)
+		  le32_to_cpu(control_block->rx_data_low[index].address) -
 		  (unsigned long) skb->data) & 3;
=20
 #if VERBOSE > SHOW_ERROR_MESSAGES
@@ -320,15 +321,34 @@
 		 * header and without the FCS. But there a is a bit that
 		 * indicates if the packet is corrupted :-) */
 		if (skb->data[8] & 0x01)
-			/* This one is bad. Drop it !*/
+			/* This one is bad. Drop it ! */
 			discard =3D 1;
 		skb_pull(skb, 20);
 		skb->protocol =3D htons(ETH_P_802_2);
 		skb->mac.raw =3D skb->data;
 		skb->pkt_type =3D PACKET_OTHERHOST;
-	} else
+	} else {
+		if (skb->data[2 * ETH_ALEN] =3D=3D 0) {
+			/* The packet has a rx_annex. Read it for spy monitoring, Then
+			 * remove it, while keeping the 2 leading MAC addr.
+			 */
+			struct iw_quality wstats;
+			struct obj_rx_annex *annex =3D
+			    (struct obj_rx_annex *) skb->data;
+			wstats.level =3D annex->rssi;
+			/* The noise value can be a bit outdated if nobody's=20
+			 * reading wireless stats... */
+			wstats.noise =3D priv->iwstatistics.qual.noise;
+			wstats.qual =3D wstats.level - wstats.noise;
+			wstats.updated =3D 0x07;
+			/* Update spy records */
+			wireless_spy_update(ndev, annex->addr2, &wstats);
+			/* 20 =3D sizeof(struct obj_rx_annex) - 2*ETH_ALEN */
+			memcpy(skb->data + 20, skb->data, 2 * ETH_ALEN);
+			skb_pull(skb, 20);
+		}
 		skb->protocol =3D eth_type_trans(skb, ndev);
-
+	}
 	skb->ip_summed =3D CHECKSUM_NONE;
 	priv->statistics.rx_packets++;
 	priv->statistics.rx_bytes +=3D size;
@@ -343,8 +363,7 @@
 	if (discard) {
 		dev_kfree_skb(skb);
 		skb =3D NULL;
-	}
-	else
+	} else
 		netif_rx(skb);
=20
 	/* increment the read index for the rx data low queue */
@@ -395,7 +414,7 @@
 		wmb();
=20
 		/* increment the driver read pointer */
-		add_le32p((u32 *) & control_block->
+		add_le32p((u32 *) &control_block->
 			  driver_curr_frag[ISL38XX_CB_RX_DATA_LQ], 1);
 	}
=20
@@ -405,13 +424,13 @@
 	return 0;
 }
=20
-void=20
+void
 islpci_do_reset_and_wake(void *data)
 {
-       islpci_private *priv =3D (islpci_private *) data;
-       islpci_reset(priv, 1);
-       netif_wake_queue(priv->ndev);
-       priv->reset_task_pending =3D 0;
+	islpci_private *priv =3D (islpci_private *) data;
+	islpci_reset(priv, 1);
+	netif_wake_queue(priv->ndev);
+	priv->reset_task_pending =3D 0;
 }
=20
 void
@@ -423,7 +442,7 @@
 	/* increment the transmit error counter */
 	statistics->tx_errors++;
=20
-	if(!priv->reset_task_pending) {
+	if (!priv->reset_task_pending) {
 		priv->reset_task_pending =3D 1;
 		netif_stop_queue(ndev);
 		schedule_work(&priv->reset_task);
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.c,v
retrieving revision 1.8
retrieving revision 1.9
diff -u -r1.8 -r1.9
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	18 Mar 2004 11:1=
6:23 -0000	1.8
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	18 Mar 2004 15:2=
7:44 -0000	1.9
@@ -570,6 +570,17 @@
 	mgt_cpu_to_le(isl_oid[n].flags & OID_FLAG_TYPE, priv->mib[n]);
 }
=20
+void
+mgt_get(islpci_private *priv, enum oid_num_t n, void *res)
+{
+	BUG_ON(OID_NUM_LAST <=3D n);
+	BUG_ON(priv->mib[n] =3D=3D NULL);
+	BUG_ON(res =3D=3D NULL);
+
+	memcpy(res, priv->mib[n], isl_oid[n].size);
+	mgt_le_to_cpu(isl_oid[n].flags & OID_FLAG_TYPE, res);
+}
+
 /* Commits the cache. Lock outside. */
=20
 static enum oid_num_t commit_part1[] =3D {
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.h,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -r1.3 -r1.4
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h	18 Mar 2004 11:1=
6:23 -0000	1.3
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h	18 Mar 2004 15:2=
7:44 -0000	1.4
@@ -37,12 +37,14 @@
 int mgt_set_request(islpci_private *, enum oid_num_t, int, void *);
=20
 int mgt_get_request(islpci_private *, enum oid_num_t, int, void *,
-                    union oid_res_t *);
+		    union oid_res_t *);
=20
 int mgt_commit_list(islpci_private *, enum oid_num_t *, int);
=20
 void mgt_set(islpci_private *, enum oid_num_t, void *);
=20
+void mgt_get(islpci_private *, enum oid_num_t, void *);
+
 void mgt_commit(islpci_private *);
=20
 int mgt_mlme_answer(islpci_private *);

--fzZfjcV6kaBgkq89--

--27KoNqt0fmcl1zj/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbLVat1JN+IKUl4RAvTqAJ0bQ1tGxVVKncf36hdyw0b+G6eD0gCcCYwU
uGJxo87p8bPU+08+3XhDl8Q=
=vfAm
-----END PGP SIGNATURE-----

--27KoNqt0fmcl1zj/--

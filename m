Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUEXIkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUEXIkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUEXIkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:40:16 -0400
Received: from zeus.kernel.org ([204.152.189.113]:61598 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264147AbUEXIcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:32:11 -0400
Date: Mon, 24 May 2004 04:31:46 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header in
Message-ID: <20040524083146.GE3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5joxkA65nhhP20dL"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5joxkA65nhhP20dL
Content-Type: multipart/mixed; boundary="SKW69dzTt3T8RCN0"
Content-Disposition: inline


--SKW69dzTt3T8RCN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-03-19      Aurelien Alleaume <slts@free.fr>

* islpci_eth.[c,h], islpci_dev.[c,h], isl_ioctl.[c,h] : added
  support for avs header in monitor mode. Based on the work of
  Antonio Eugenio Burriel <aeb@ryanstudios.com>. Unified packets
  header (rfmon_header and rx_annex) for iwspy.j

* Some minor things (oid_mgt.[c,h]).
				=09
--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--SKW69dzTt3T8RCN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="04-add_avs_header_support.patch"
Content-Transfer-Encoding: quoted-printable

2004-03-19	Aurelien Alleaume <slts@free.fr>

	* islpci_eth.[c,h], islpci_dev.[c,h], isl_ioctl.[c,h] : added support
	for avs header in monitor mode. Based on the work of Antonio Eugenio
	Burriel <aeb@ryanstudios.com>. Unified packets header (rfmon_header and
	rx_annex) for iwspy.

	* Some minor things (oid_mgt.[c,h]).

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v
retrieving revision 1.145
retrieving revision 1.148
diff -u -r1.145 -r1.148
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	18 Mar 2004 15=
:27:44 -0000	1.145
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	19 Mar 2004 23=
:03:58 -0000	1.148
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.145 2004/03/18 1=
5:27:44 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.148 2004/03/19 2=
3:03:58 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *            (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
@@ -327,34 +327,15 @@
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	int rvalue;
-	u32 c =3D 0;
+	u32 c;
=20
-	/* prepare the structure for the set object */
-	if (fwrq->m < 1000)
-		/* structure value contains a channel indication */
-		c =3D fwrq->m;
-	else {
-		/* structure contains a frequency indication and fwrq->e =3D 1 */
-		int f =3D fwrq->m / 100000;
-
-		if (fwrq->e !=3D 1)
-			return -EINVAL;
-		if ((f >=3D 2412) && (f <=3D 2484)) {
-			while ((c < 14) && (f !=3D frequency_list_bg[c]))
-				c++;
-			if (c >=3D 14)
-				return -EINVAL;
-		} else if ((f >=3D (int) 5170) && (f <=3D (int) 5320)) {
-			while ((c < 12) && (f !=3D frequency_list_a[c]))
-				c++;
-			if (c >=3D 12)
-				return -EINVAL;
-		} else
-			return -EINVAL;
-		c++;
-	}
+	if (fwrq->m  < 1000)
+		/* we have a channel number */
+		c =3D  fwrq->m;
+	else
+		c =3D (fwrq->e =3D=3D 1) ? channel_of_freq(fwrq->m / 100000) : 0;
=20
-	rvalue =3D mgt_set_request(priv, DOT11_OID_CHANNEL, 0, &c);
+	rvalue =3D c ? mgt_set_request(priv, DOT11_OID_CHANNEL, 0, &c) : -EINVAL;
=20
 	/* Call commit handler */
 	return (rvalue ? rvalue : -EINPROGRESS);
@@ -410,7 +391,7 @@
=20
 	mgt_commit(priv);
 	priv->ndev->type =3D (priv->iw_mode =3D=3D IW_MODE_MONITOR)
-	    ? ARPHRD_IEEE80211 : ARPHRD_ETHER;
+	    ? priv->monitor_type : ARPHRD_ETHER;
 	up_write(&priv->mib_sem);
=20
 	return 0;
@@ -1963,6 +1944,28 @@
 }
=20
 int
+prism54_set_prismhdr(struct net_device *ndev, struct iw_request_info *info,
+		     __u32 * uwrq, char *extra)
+{
+	islpci_private *priv =3D netdev_priv(ndev);
+	priv->monitor_type =3D
+	    (*uwrq ? ARPHRD_IEEE80211_PRISM : ARPHRD_IEEE80211);
+	if (priv->iw_mode =3D=3D IW_MODE_MONITOR)
+		priv->ndev->type =3D priv->monitor_type;
+
+	return 0;
+}
+
+int
+prism54_get_prismhdr(struct net_device *ndev, struct iw_request_info *info,
+		     __u32 * uwrq, char *extra)
+{
+	islpci_private *priv =3D netdev_priv(ndev);
+	*uwrq =3D (priv->monitor_type =3D=3D ARPHRD_IEEE80211_PRISM);
+	return 0;
+}
+
+int
 prism54_set_maxframeburst(struct net_device *ndev, struct iw_request_info =
*info,
 			  __u32 * uwrq, char *extra)
 {
@@ -2198,6 +2201,9 @@
 #define	PRISM54_SET_OID_STR	SIOCIWFIRSTPRIV+20
 #define	PRISM54_SET_OID_ADDR	SIOCIWFIRSTPRIV+22
=20
+#define PRISM54_GET_PRISMHDR	SIOCIWFIRSTPRIV+23
+#define PRISM54_SET_PRISMHDR	SIOCIWFIRSTPRIV+24
+
 #define IWPRIV_SET_U32(n,x)	{ n, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1=
, 0, "set_"x }
 #define IWPRIV_SET_SSID(n,x)	{ n, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED |=
 1, 0, "set_"x }
 #define IWPRIV_SET_ADDR(n,x)	{ n, IW_PRIV_TYPE_ADDR | IW_PRIV_SIZE_FIXED |=
 1, 0, "set_"x }
@@ -2212,6 +2218,10 @@
 static const struct iw_priv_args prism54_private_args[] =3D {
 /*{ cmd, set_args, get_args, name } */
 	{PRISM54_RESET, 0, 0, "reset"},
+	{PRISM54_GET_PRISMHDR, 0, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+	 "get_prismhdr"},
+	{PRISM54_SET_PRISMHDR, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
+	 "set_prismhdr"},
 	{PRISM54_GET_POLICY, 0, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
 	 "getPolicy"},
 	{PRISM54_SET_POLICY, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
@@ -2321,7 +2331,8 @@
 	(iw_handler) prism54_set_raw,
 	(iw_handler) NULL,
 	(iw_handler) prism54_set_raw,
-
+	(iw_handler) prism54_get_prismhdr,
+	(iw_handler) prism54_set_prismhdr,
 };
=20
 const struct iw_handler_def prism54_handler_def =3D {
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_oid.h,v
retrieving revision 1.5
retrieving revision 1.6
diff -u -r1.5 -r1.6
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h	18 Mar 2004 15:2=
7:44 -0000	1.5
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h	19 Mar 2004 20:5=
4:33 -0000	1.6
@@ -1,5 +1,5 @@
 /*
- *  $Id: isl_oid.h,v 1.5 2004/03/18 15:27:44 ajfa Exp $
+ *  $Id: isl_oid.h,v 1.6 2004/03/19 20:54:33 ajfa Exp $
  * =20
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
  *  Copyright (C) 2004 Luis R. Rodriguez <mcgrof@ruslug.rutgers.edu>
@@ -91,19 +91,6 @@
 	u16 mhz[0];
 } __attribute__ ((packed));
=20
-struct obj_rx_annex {
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u32 something0;
-	u32 time;
-	u16 something1;
-	u16 rate;
-	u16 freq;
-	u16 something2;
-	u8 rssi;
-	u8 pad[3];
-} __attribute__ ((packed));
-
 /*=20
  * in case everything's ok, the inlined function below will be
  * optimized away by the compiler...
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v
retrieving revision 1.71
retrieving revision 1.72
diff -u -r1.71 -r1.72
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	18 Mar 2004 1=
1:44:17 -0000	1.71
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	19 Mar 2004 2=
0:54:33 -0000	1.72
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.71 2004/03/18 1=
1:44:17 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.72 2004/03/19 2=
0:54:33 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -715,9 +715,9 @@
 	priv =3D netdev_priv(ndev);
 	priv->ndev =3D ndev;
 	priv->pdev =3D pdev;
-
+	priv->monitor_type =3D ARPHRD_IEEE80211;
 	priv->ndev->type =3D (priv->iw_mode =3D=3D IW_MODE_MONITOR) ?
-		ARPHRD_IEEE80211: ARPHRD_ETHER;
+		priv->monitor_type : ARPHRD_ETHER;
=20
 	/* save the start and end address of the PCI memory area */
 	ndev->mem_start =3D (unsigned long) priv->device_base;
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v
retrieving revision 1.57
retrieving revision 1.58
diff -u -r1.57 -r1.58
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	18 Mar 2004 1=
5:27:44 -0000	1.57
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	19 Mar 2004 2=
0:54:33 -0000	1.58
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.57 2004/03/18 1=
5:27:44 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.58 2004/03/19 2=
0:54:33 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.=20
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -114,6 +114,8 @@
=20
 	struct iw_spy_data spy_data; /* iwspy support */
=20
+	int monitor_type; /* ARPHRD_IEEE80211 or ARPHRD_IEEE80211_PRISM */
+
 	struct islpci_acl acl;
=20
 	/* PCI bus allocation & configuration members */
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v
retrieving revision 1.31
retrieving revision 1.33
diff -u -r1.31 -r1.33
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 2004 1=
5:27:44 -0000	1.31
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	19 Mar 2004 2=
3:03:58 -0000	1.33
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.31 2004/03/18 1=
5:27:44 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.33 2004/03/19 2=
3:03:58 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2004 Aurelien Alleaume <slts@free.fr>
@@ -24,10 +24,12 @@
 #include <linux/delay.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/if_arp.h>
=20
 #include "isl_38xx.h"
 #include "islpci_eth.h"
 #include "islpci_mgt.h"
+#include "oid_mgt.h"
=20
 /*************************************************************************=
*****
     Network Interface functions
@@ -246,6 +248,69 @@
 	return err;
 }
=20
+static inline int
+islpci_monitor_rx(islpci_private *priv, struct sk_buff **skb)
+{
+	/* The card reports full 802.11 packets but with a 20 bytes
+	 * header and without the FCS. But there a is a bit that
+	 * indicates if the packet is corrupted :-) */
+	struct rfmon_header *hdr =3D (struct rfmon_header *) (*skb)->data;
+	if (hdr->flags & 0x01)
+		/* This one is bad. Drop it ! */
+		return -1;
+	if (priv->ndev->type =3D=3D ARPHRD_IEEE80211_PRISM) {
+		struct avs_80211_1_header *avs;
+		/* extract the relevant data from the header */
+		u32 clock =3D hdr->clock;
+		u8 rate =3D hdr->rate;
+		u16 freq =3D be16_to_cpu(hdr->freq);
+		u8 rssi =3D hdr->rssi;
+
+		skb_pull(*skb, sizeof (struct rfmon_header));
+
+		if (skb_headroom(*skb) < sizeof (struct avs_80211_1_header)) {
+			struct sk_buff *newskb =3D skb_copy_expand(*skb,
+								 sizeof (struct
+									 avs_80211_1_header),
+								 0, GFP_ATOMIC);
+			if (newskb) {
+				kfree_skb(*skb);
+				*skb =3D newskb;
+			} else
+				return -1;
+			/* This behavior is not very subtile... */
+		}
+
+		/* make room for the new header and fill it. */
+		avs =3D
+		    (struct avs_80211_1_header *) skb_push(*skb,
+							   sizeof (struct
+								   avs_80211_1_header));
+
+		avs->version =3D htonl(P80211CAPTURE_VERSION);
+		avs->length =3D htonl(sizeof (struct avs_80211_1_header));
+		avs->mactime =3D __cpu_to_be64(clock);
+		avs->hosttime =3D __cpu_to_be64(jiffies);
+		avs->phytype =3D htonl(6);	/*OFDM: 6 for (g), 8 for (a) */
+		avs->channel =3D htonl(channel_of_freq(freq));
+		avs->datarate =3D htonl(rate * 5);
+		avs->antenna =3D htonl(0);	/*unknown */
+		avs->priority =3D htonl(0);	/*unknown */
+		avs->ssi_type =3D htonl(2);	/*2: dBm, 3: raw RSSI */
+		avs->ssi_signal =3D htonl(rssi);
+		avs->ssi_noise =3D htonl(priv->local_iwstatistics.qual.noise);	/*better =
than 'undefined', I assume */
+		avs->preamble =3D htonl(0);	/*unknown */
+		avs->encoding =3D htonl(0);	/*unknown */
+	} else
+		skb_pull(*skb, sizeof (struct rfmon_header));
+
+	(*skb)->protocol =3D htons(ETH_P_802_2);
+	(*skb)->mac.raw =3D (*skb)->data;
+	(*skb)->pkt_type =3D PACKET_OTHERHOST;
+
+	return 0;
+}
+
 int
 islpci_eth_receive(islpci_private *priv)
 {
@@ -315,37 +380,29 @@
 	/* do some additional sk_buff and network layer parameters */
 	skb->dev =3D ndev;
=20
-	/* take care of monitor mode */
-	if (priv->iw_mode =3D=3D IW_MODE_MONITOR) {
-		/* The card reports full 802.11 packets but with a 20 bytes
-		 * header and without the FCS. But there a is a bit that
-		 * indicates if the packet is corrupted :-) */
-		if (skb->data[8] & 0x01)
-			/* This one is bad. Drop it ! */
-			discard =3D 1;
-		skb_pull(skb, 20);
-		skb->protocol =3D htons(ETH_P_802_2);
-		skb->mac.raw =3D skb->data;
-		skb->pkt_type =3D PACKET_OTHERHOST;
-	} else {
+	/* take care of monitor mode and spy monitoring. */
+	if (priv->iw_mode =3D=3D IW_MODE_MONITOR)
+		discard =3D islpci_monitor_rx(priv, &skb);
+	else {
 		if (skb->data[2 * ETH_ALEN] =3D=3D 0) {
 			/* The packet has a rx_annex. Read it for spy monitoring, Then
 			 * remove it, while keeping the 2 leading MAC addr.
 			 */
 			struct iw_quality wstats;
-			struct obj_rx_annex *annex =3D
-			    (struct obj_rx_annex *) skb->data;
-			wstats.level =3D annex->rssi;
+			struct rx_annex_header *annex =3D
+			    (struct rx_annex_header *) skb->data;
+			wstats.level =3D annex->rfmon.rssi;
 			/* The noise value can be a bit outdated if nobody's=20
 			 * reading wireless stats... */
-			wstats.noise =3D priv->iwstatistics.qual.noise;
+			wstats.noise =3D priv->local_iwstatistics.qual.noise;
 			wstats.qual =3D wstats.level - wstats.noise;
 			wstats.updated =3D 0x07;
 			/* Update spy records */
 			wireless_spy_update(ndev, annex->addr2, &wstats);
-			/* 20 =3D sizeof(struct obj_rx_annex) - 2*ETH_ALEN */
-			memcpy(skb->data + 20, skb->data, 2 * ETH_ALEN);
-			skb_pull(skb, 20);
+
+			memcpy(skb->data + sizeof (struct rfmon_header),
+			       skb->data, 2 * ETH_ALEN);
+			skb_pull(skb, sizeof (struct rfmon_header));
 		}
 		skb->protocol =3D eth_type_trans(skb, ndev);
 	}
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.h,v
retrieving revision 1.6
retrieving revision 1.7
diff -u -r1.6 -r1.7
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.h	18 Mar 2004 1=
1:44:17 -0000	1.6
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.h	19 Mar 2004 2=
0:54:33 -0000	1.7
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.h,v 1.6 2004/03/18 11=
:44:17 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.h,v 1.7 2004/03/19 20=
:54:33 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *
@@ -23,6 +23,47 @@
 #include "isl_38xx.h"
 #include "islpci_dev.h"
=20
+struct rfmon_header {
+	u16 unk0;		/* =3D 0x0000 */
+	u16 length;		/* =3D 0x1400 */
+	u32 clock;		/* 1MHz clock */
+	u8 flags;
+	u8 unk1;
+	u8 rate;
+	u8 unk2;
+	u16 freq;
+	u16 unk3;
+	u8 rssi;
+	u8 padding[3];
+} __attribute__ ((packed));
+
+struct rx_annex_header {
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	struct rfmon_header rfmon;
+} __attribute__ ((packed));
+
+/* wlan-ng (and hopefully others) AVS header, version one.  Fields in
+ * network byte order. */
+#define P80211CAPTURE_VERSION 0x80211001
+
+struct avs_80211_1_header {
+	uint32_t version;
+	uint32_t length;
+	uint64_t mactime;
+	uint64_t hosttime;
+	uint32_t phytype;
+	uint32_t channel;
+	uint32_t datarate;
+	uint32_t antenna;
+	uint32_t priority;
+	uint32_t ssi_type;
+	int32_t ssi_signal;
+	int32_t ssi_noise;
+	uint32_t preamble;
+	uint32_t encoding;
+};
+
 void islpci_eth_cleanup_transmit(islpci_private *, isl38xx_control_block *=
);
 int islpci_eth_transmit(struct sk_buff *, struct net_device *);
 int islpci_eth_receive(islpci_private *);
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.c,v
retrieving revision 1.9
retrieving revision 1.11
diff -u -r1.9 -r1.11
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	18 Mar 2004 15:2=
7:44 -0000	1.9
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	19 Mar 2004 23:0=
3:58 -0000	1.11
@@ -31,6 +31,27 @@
 	5240, 5260, 5280, 5300, 5320
 };
=20
+int
+channel_of_freq(int f)
+{
+	int c =3D 0;
+
+	if ((f >=3D 2412) && (f <=3D 2484)) {
+		while ((c < 14) && (f !=3D frequency_list_bg[c]))
+			c++;
+		if (c >=3D 14)
+			return 0;
+	} else if ((f >=3D (int) 5170) && (f <=3D (int) 5320)) {
+		while ((c < 12) && (f !=3D frequency_list_a[c]))
+			c++;
+		if (c >=3D 12)
+			return 0;
+	} else
+		return 0;
+
+	return ++c;
+}
+
 #define OID_STRUCT(name,oid,s,t) [name] =3D {oid, 0, sizeof(s), t}
 #define OID_STRUCT_C(name,oid,s,t) OID_STRUCT(name,oid,s,t | OID_FLAG_CACH=
ED)
 #define OID_U32(name,oid) OID_STRUCT(name,oid,u32,OID_TYPE_U32)
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.h,v
retrieving revision 1.4
retrieving revision 1.5
diff -u -r1.4 -r1.5
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h	18 Mar 2004 15:2=
7:44 -0000	1.4
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h	19 Mar 2004 20:5=
4:33 -0000	1.5
@@ -28,9 +28,10 @@
=20
 void mgt_clean(islpci_private *);
=20
+/* I don't know where to put these 3 */
 extern const int frequency_list_bg[];
-
 extern const int frequency_list_a[];
+int channel_of_freq(int);
=20
 void mgt_le_to_cpu(int, void *);
=20

--SKW69dzTt3T8RCN0--

--5joxkA65nhhP20dL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbLyat1JN+IKUl4RAp8jAKCHkr7ygtOLaSBy1d98FOKIwdzVywCdFPS6
o9RWEaNjqGbhICVey9o/p+0=
=zPAo
-----END PGP SIGNATURE-----

--5joxkA65nhhP20dL--

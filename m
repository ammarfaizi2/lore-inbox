Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264132AbUEXIei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUEXIei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUEXIei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:34:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:21918 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264132AbUEXIal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:30:41 -0400
Date: Mon, 24 May 2004 04:30:15 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 1/14] prism54: add new private ioctls
Message-ID: <20040524083015.GB3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WxezjuMNsgvRf6mf"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WxezjuMNsgvRf6mf
Content-Type: multipart/mixed; boundary="RUvhGz2nhX7DIu1B"
Content-Disposition: inline


--RUvhGz2nhX7DIu1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-03-18      Aurelien Alleaume <slts@free.fr>

* oid_mgt.[c,h] : added type to oids. New functions :
  oid_cpu_to_le(), mgt_le_to_cpu() and mgt_response_to_str().

* isl_ioctl.c : use private sub-ioctls. Added a
  bunch of private sub-ioctls. Removed the le??_to_cpu and
  cpu_to_le??. Give the error code when sending wireless
  events.


--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--RUvhGz2nhX7DIu1B
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename="01-new-private-ioctls.patch"
Content-Transfer-Encoding: quoted-printable

2004-03-18	Aurelien Alleaume <slts@free.fr>

	* oid_mgt.[c,h] : added type to oids. New functions : oid_cpu_to_le(),
	 mgt_le_to_cpu() and mgt_response_to_str().

	* isl_ioctl.c : use private sub-ioctls. Added a bunch of private
	sub-ioctls. Removed the le??_to_cpu and cpu_to_le??. Give the error
	code when sending wireless events.

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v
retrieving revision 1.143
retrieving revision 1.144
diff -u -r1.143 -r1.144
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	18 Mar 2004 05=
:25:24 -0000	1.143
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	18 Mar 2004 11=
:16:23 -0000	1.144
@@ -1,7 +1,7 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.140 2004/02/28 0=
3:06:07 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.144 2004/03/18 1=
1:16:23 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
- *            (C) 2003 Aurelien Alleaume <slts@free.fr>
+ *            (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
  *            (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
  *            (C) 2003 Luis R. Rodriguez <mcgrof@ruslug.rutgers.edu>
  *
@@ -87,9 +87,9 @@
=20
 	/* For now, just catch early the Repeater and Secondary modes here */
 	if (iw_mode =3D=3D IW_MODE_REPEAT || iw_mode =3D=3D IW_MODE_SECOND) {
-		printk(KERN_DEBUG "%s(): Sorry, Repeater mode and Secondary mode "
-				"are not yet supported by this driver.\n",
-		       __FUNCTION__);
+		printk(KERN_DEBUG
+		       "%s(): Sorry, Repeater mode and Secondary mode "
+		       "are not yet supported by this driver.\n", __FUNCTION__);
 		return -EINVAL;
 	}
=20
@@ -143,8 +143,8 @@
 {
 	u32 t;
 	struct obj_buffer psm_buffer =3D {
-		.size =3D cpu_to_le32(PSM_BUFFER_SIZE),
-		.addr =3D cpu_to_le32(priv->device_psm_buffer)
+		.size =3D PSM_BUFFER_SIZE,
+		.addr =3D priv->device_psm_buffer
 	};
=20
 	mgt_set(priv, DOT11_OID_CHANNEL, &init_channel);
@@ -166,7 +166,7 @@
 	 * for it save old values */
 	if (init_mode > IW_MODE_MONITOR || init_mode < IW_MODE_AUTO) {
 		printk(KERN_DEBUG "%s(): You passed a non-valid init_mode. "
-				"Using default mode\n", __FUNCTION__);
+		       "Using default mode\n", __FUNCTION__);
 		init_mode =3D CARD_DEFAULT_IW_MODE;
 	}
 	/* This sets all of the mode-dependent values */
@@ -285,7 +285,7 @@
 	/* Commit in Monitor mode is not necessary, also setting essid
 	 * in Monitor mode does not make sense and isn't allowed for this
 	 * device's firmware */
-	if(priv->iw_mode !=3D IW_MODE_MONITOR)
+	if (priv->iw_mode !=3D IW_MODE_MONITOR)
 		return mgt_set_request(priv, DOT11_OID_SSID, 0, NULL);
 	return 0;
 }
@@ -531,20 +531,20 @@
 	    mgt_get_request(priv, DOT11_OID_SUPPORTEDFREQUENCIES, 0, NULL, &r);
 	freq =3D r.ptr;
=20
-	range->num_channels =3D le16_to_cpu(freq->nr);
-	range->num_frequency =3D le16_to_cpu(freq->nr);
+	range->num_channels =3D freq->nr;
+	range->num_frequency =3D freq->nr;
=20
 	/* Frequencies are not listed in the right order. The reordering is proba=
bly
 	 * firmware dependant and thus should work for everyone.
 	 */
-	m =3D min(IW_MAX_FREQUENCIES, (int) le16_to_cpu(freq->nr));
+	m =3D min(IW_MAX_FREQUENCIES, (int) freq->nr);
 	for (i =3D 0; i < m - 12; i++) {
-		range->freq[i].m =3D le16_to_cpu(freq->mhz[12 + i]);
+		range->freq[i].m =3D freq->mhz[12 + i];
 		range->freq[i].e =3D 6;
 		range->freq[i].i =3D i + 1;
 	}
 	for (i =3D m - 12; i < m; i++) {
-		range->freq[i].m =3D le16_to_cpu(freq->mhz[i - m + 12]);
+		range->freq[i].m =3D freq->mhz[i - m + 12];
 		range->freq[i].e =3D 6;
 		range->freq[i].i =3D i + 23;
 	}
@@ -655,7 +655,7 @@
 #define CAP_CRYPT 0x10
=20
 	/* Mode */
-	cap =3D le16_to_cpu(bss->capinfo);
+	cap =3D bss->capinfo;
 	iwe.u.mode =3D 0;
 	if (cap & CAP_ESS)
 		iwe.u.mode =3D IW_MODE_MASTER;
@@ -747,7 +747,7 @@
 	bsslist =3D r.ptr;
=20
 	/* ok now, scan the list and translate its info */
-	for (i =3D 0; i < min(IW_MAX_AP, (int) le32_to_cpu(bsslist->nr)); i++)
+	for (i =3D 0; i < min(IW_MAX_AP, (int) bsslist->nr); i++)
 		current_ev =3D prism54_translate_bss(ndev, current_ev,
 						   extra + IW_SCAN_MAX_DATA,
 						   &(bsslist->bsslist[i]),
@@ -776,7 +776,7 @@
 		memcpy(essid.octets, extra, dwrq->length);
 	} else
 		essid.length =3D 0;
-=09
+
 	if (priv->iw_mode !=3D IW_MODE_MONITOR)
 		return mgt_set_request(priv, DOT11_OID_SSID, 0, &essid);
=20
@@ -862,38 +862,39 @@
 	char *data;
 	int ret, i;
 	union oid_res_t r;
-=09
+
 	if (vwrq->value =3D=3D -1) {
 		/* auto mode. No limit. */
 		profile =3D 1;
 		return mgt_set_request(priv, DOT11_OID_PROFILES, 0, &profile);
 	}
-=09
-	if((ret =3D mgt_get_request(priv, DOT11_OID_SUPPORTEDRATES, 0, NULL, &r)))
+
+	if ((ret =3D
+	     mgt_get_request(priv, DOT11_OID_SUPPORTEDRATES, 0, NULL, &r)))
 		return ret;
-	=09
+
 	rate =3D (u32) (vwrq->value / 500000);
 	data =3D r.ptr;
 	i =3D 0;
-=09
-	while(data[i]) {
-		if(rate && (data[i] =3D=3D rate)) {
+
+	while (data[i]) {
+		if (rate && (data[i] =3D=3D rate)) {
 			break;
 		}
-		if(vwrq->value =3D=3D i) {
+		if (vwrq->value =3D=3D i) {
 			break;
 		}
 		data[i] |=3D 0x80;
 		i++;
 	}
-	=09
-	if(!data[i]) {
+
+	if (!data[i]) {
 		return -EINVAL;
 	}
-=09
+
 	data[i] |=3D 0x80;
 	data[i + 1] =3D 0;
-=09
+
 	/* Now, check if we want a fixed or auto value */
 	if (vwrq->fixed) {
 		data[0] =3D data[i];
@@ -908,14 +909,14 @@
 		i++;
 	}
 	printk("0\n");
-*/=09
+*/
 	profile =3D -1;
 	ret =3D mgt_set_request(priv, DOT11_OID_PROFILES, 0, &profile);
 	ret |=3D mgt_set_request(priv, DOT11_OID_EXTENDEDRATES, 0, data);
 	ret |=3D mgt_set_request(priv, DOT11_OID_RATES, 0, data);
-=09
+
 	kfree(r.ptr);
-=09
+
 	return ret;
 }
=20
@@ -931,17 +932,17 @@
 	union oid_res_t r;
=20
 	/* Get the current bit rate */
-	if((rvalue =3D mgt_get_request(priv, GEN_OID_LINKSTATE, 0, NULL, &r)))
+	if ((rvalue =3D mgt_get_request(priv, GEN_OID_LINKSTATE, 0, NULL, &r)))
 		return rvalue;
 	vwrq->value =3D r.u * 500000;
=20
 	/* request the device for the enabled rates */
-	if((rvalue =3D mgt_get_request(priv, DOT11_OID_RATES, 0, NULL, &r)))
+	if ((rvalue =3D mgt_get_request(priv, DOT11_OID_RATES, 0, NULL, &r)))
 		return rvalue;
 	data =3D r.ptr;
 	vwrq->fixed =3D (data[0] !=3D 0) && (data[1] =3D=3D 0);
 	kfree(r.ptr);
-=09
+
 	return 0;
 }
=20
@@ -1225,7 +1226,7 @@
=20
 	rvalue =3D mgt_get_request(priv, OID_INL_OUTPUTPOWER, 0, NULL, &r);
 	/* intersil firmware operates in 0.25 dBm (1/4 dBm) */
-	vwrq->value =3D (s32)r.u / 4;
+	vwrq->value =3D (s32) r.u / 4;
 	vwrq->fixed =3D 1;
 	/* radio is not turned of
 	 * btw: how is possible to turn off only the radio=20
@@ -1271,28 +1272,41 @@
 }
=20
 static int
-prism54_set_beacon(struct net_device *ndev, struct iw_request_info *info,
-		   __u32 * uwrq, char *extra)
+prism54_get_oid(struct net_device *ndev, struct iw_request_info *info,
+		struct iw_point *dwrq, char *extra)
 {
-	int rvalue =3D mgt_set_request((islpci_private *) netdev_priv(ndev),
-				     DOT11_OID_BEACONPERIOD, 0, uwrq);
+	union oid_res_t r;
+	int rvalue;
+	enum oid_num_t n =3D dwrq->flags;
=20
-	return (rvalue ? rvalue : -EINPROGRESS);
+	rvalue =3D mgt_get_request((islpci_private *) ndev->priv, n, 0, NULL, &r);
+	dwrq->length =3D mgt_response_to_str(n, &r, extra);
+	if ((isl_oid[n].flags & OID_FLAG_TYPE) !=3D OID_TYPE_U32)
+		kfree(r.ptr);
+	return rvalue;
 }
=20
 static int
-prism54_get_beacon(struct net_device *ndev, struct iw_request_info *info,
-		   __u32 * uwrq, char *extra)
+prism54_set_u32(struct net_device *ndev, struct iw_request_info *info,
+		__u32 * uwrq, char *extra)
 {
-	union oid_res_t r;
-	int rvalue;
+	/*
+	   u32 *i =3D (int *) extra;
+	   int param =3D *i;
+	   int u =3D *(i + 1);
+	 */
+	u32 oid =3D uwrq[0], u =3D uwrq[1];
=20
-	rvalue =3D
-	    mgt_get_request((islpci_private *) netdev_priv(ndev),
-			    DOT11_OID_BEACONPERIOD, 0, NULL, &r);
-	*uwrq =3D r.u;
+	return mgt_set_request((islpci_private *) ndev->priv, oid, 0, &u);
+}
=20
-	return rvalue;
+static int
+prism54_set_raw(struct net_device *ndev, struct iw_request_info *info,
+		struct iw_point *dwrq, char *extra)
+{
+	u32 oid =3D dwrq->flags;
+
+	return mgt_set_request((islpci_private *) ndev->priv, oid, 0, extra);
 }
=20
 void
@@ -1511,8 +1525,9 @@
 		return -ENOMEM;
=20
 	/* Tell the card to kick every client */
-	mlme->id =3D cpu_to_le16(0);
-	rvalue =3D mgt_set_request(netdev_priv(ndev), DOT11_OID_DISASSOCIATE, 0, =
mlme);
+	mlme->id =3D 0;
+	rvalue =3D
+	    mgt_set_request(netdev_priv(ndev), DOT11_OID_DISASSOCIATE, 0, mlme);
 	kfree(mlme);
=20
 	return rvalue;
@@ -1535,8 +1550,9 @@
=20
 	/* Tell the card to only kick the corresponding bastard */
 	memcpy(mlme->address, addr->sa_data, ETH_ALEN);
-	mlme->id =3D cpu_to_le16(-1);
-	rvalue =3D mgt_set_request(netdev_priv(ndev), DOT11_OID_DISASSOCIATE, 0, =
mlme);
+	mlme->id =3D -1;
+	rvalue =3D
+	    mgt_set_request(netdev_priv(ndev), DOT11_OID_DISASSOCIATE, 0, mlme);
=20
 	kfree(mlme);
=20
@@ -1551,12 +1567,12 @@
 {
 	const u8 *a =3D mlme->address;
 	int n =3D snprintf(dest, IW_CUSTOM_MAX,
-			 "%s %s %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X %s",
+			 "%s %s %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X %s (%2.2X)",
 			 str,
-			 ((priv->iw_mode =3D=3D IW_MODE_MASTER) ? "to" : "from"),
+			 ((priv->iw_mode =3D=3D IW_MODE_MASTER) ? "from" : "to"),
 			 a[0], a[1], a[2], a[3], a[4], a[5],
 			 (error ? (mlme->code ? " : REJECTED " : " : ACCEPTED ")
-			  : ""));
+			  : ""), mlme->code);
 	BUG_ON(n > IW_CUSTOM_MAX);
 	*length =3D n;
 }
@@ -1598,14 +1614,15 @@
 {
 	islpci_private *priv =3D netdev_priv(ndev);
=20
-	if (le32_to_cpu(bitrate)) {
+	if (bitrate) {
 		if (priv->iw_mode =3D=3D IW_MODE_INFRA) {
 			union iwreq_data uwrq;
 			prism54_get_wap(ndev, NULL, (struct sockaddr *) &uwrq,
 					NULL);
 			wireless_send_event(ndev, SIOCGIWAP, &uwrq, NULL);
 		} else
-			send_simple_event(netdev_priv(ndev), "Link established");
+			send_simple_event(netdev_priv(ndev),
+					  "Link established");
 	} else
 		send_simple_event(netdev_priv(ndev), "Link lost");
 }
@@ -1765,15 +1782,14 @@
 static void
 handle_request(islpci_private *priv, struct obj_mlme *mlme, enum oid_num_t=
 oid)
 {
-	if (((le16_to_cpu(mlme->state) =3D=3D DOT11_STATE_AUTHING) ||
-	     (le16_to_cpu(mlme->state) =3D=3D DOT11_STATE_ASSOCING))
+	if (((mlme->state =3D=3D DOT11_STATE_AUTHING) ||
+	     (mlme->state =3D=3D DOT11_STATE_ASSOCING))
 	    && mgt_mlme_answer(priv)) {
 		/* Someone is requesting auth and we must respond. Just send back
 		 * the trap with error code set accordingly.
 		 */
-		mlme->code =3D cpu_to_le16(prism54_mac_accept(&priv->acl,
-							    mlme->
-							    address) ? 0 : 1);
+		mlme->code =3D prism54_mac_accept(&priv->acl,
+						mlme->address) ? 0 : 1;
 		mgt_set_request(priv, oid, 0, mlme);
 	}
 }
@@ -1797,6 +1813,13 @@
 	 * suited. We use the more flexible custom event facility.
 	 */
=20
+	/* I fear prism54_process_bss_data won't work with big endian data */
+	if ((oid =3D=3D DOT11_OID_BEACON) || (oid =3D=3D DOT11_OID_PROBE))
+		prism54_process_bss_data(priv, oid, mlme->address,
+					 payload, len);
+
+	mgt_le_to_cpu(isl_oid[oid].flags & OID_FLAG_TYPE, (void *) mlme);
+
 	switch (oid) {
=20
 	case GEN_OID_LINKSTATE:
@@ -1831,8 +1854,6 @@
 		break;
=20
 	case DOT11_OID_BEACON:
-		prism54_process_bss_data(priv, oid, mlme->address,
-					 payload, len);
 		send_formatted_event(priv,
 				     "Received a beacon from an unkown AP",
 				     mlme, 0);
@@ -1840,8 +1861,6 @@
=20
 	case DOT11_OID_PROBE:
 		/* we received a probe from a client. */
-		prism54_process_bss_data(priv, oid, mlme->address,
-					 payload, len);
 		send_formatted_event(priv, "Received a probe from client", mlme,
 				     0);
 		break;
@@ -1915,13 +1934,6 @@
 }
=20
 int
-prism54_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
-{
-	/* should we really support this old stuff ? */
-	return -EOPNOTSUPP;
-}
-
-int
 prism54_set_wpa(struct net_device *ndev, struct iw_request_info *info,
 		__u32 * uwrq, char *extra)
 {
@@ -1952,7 +1964,7 @@
=20
 int
 prism54_set_maxframeburst(struct net_device *ndev, struct iw_request_info =
*info,
-		__u32 *uwrq, char *extra)
+			  __u32 * uwrq, char *extra)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	u32 max_burst;
@@ -1960,39 +1972,39 @@
 	max_burst =3D (*uwrq) ? *uwrq : CARD_DEFAULT_MAXFRAMEBURST;
 	mgt_set_request(priv, DOT11_OID_MAXFRAMEBURST, 0, &max_burst);
=20
-	return -EINPROGRESS; /* Call commit handler */
+	return -EINPROGRESS;	/* Call commit handler */
 }
=20
 int
 prism54_get_maxframeburst(struct net_device *ndev, struct iw_request_info =
*info,
-		__u32 *uwrq, char *extra)
+			  __u32 * uwrq, char *extra)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	union oid_res_t r;
 	int rvalue;
-=09
+
 	rvalue =3D mgt_get_request(priv, DOT11_OID_MAXFRAMEBURST, 0, NULL, &r);
 	*uwrq =3D r.u;
-=09
+
 	return rvalue;
 }
=20
 int
 prism54_set_profile(struct net_device *ndev, struct iw_request_info *info,
-		__u32 *uwrq, char *extra)
+		    __u32 * uwrq, char *extra)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	u32 profile;
=20
 	profile =3D (*uwrq) ? *uwrq : CARD_DEFAULT_PROFILE;
 	mgt_set_request(priv, DOT11_OID_PROFILES, 0, &profile);
-=09
-	return -EINPROGRESS; /* Call commit handler */
+
+	return -EINPROGRESS;	/* Call commit handler */
 }
=20
 int
 prism54_get_profile(struct net_device *ndev, struct iw_request_info *info,
-		__u32 *uwrq, char *extra)
+		    __u32 * uwrq, char *extra)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	union oid_res_t r;
@@ -2005,11 +2017,11 @@
 }
=20
 int
-prism54_oid(struct net_device *ndev, struct iw_request_info *info,
-		__u32 *uwrq, char *extra)
+prism54_debug_oid(struct net_device *ndev, struct iw_request_info *info,
+		  __u32 * uwrq, char *extra)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
-=09
+
 	priv->priv_oid =3D *uwrq;
 	printk("%s: oid 0x%08X\n", ndev->name, *uwrq);
=20
@@ -2017,22 +2029,26 @@
 }
=20
 int
-prism54_get_oid(struct net_device *ndev, struct iw_request_info *info,
-		struct iw_point *data, char *extra)
+prism54_debug_get_oid(struct net_device *ndev, struct iw_request_info *inf=
o,
+		      struct iw_point *data, char *extra)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	struct islpci_mgmtframe *response =3D NULL;
 	int ret =3D -EIO, response_op =3D PIMFOR_OP_ERROR;
-=09
+
 	printk("%s: get_oid 0x%08X\n", ndev->name, priv->priv_oid);
 	data->length =3D 0;
-=09
+
 	if (islpci_get_state(priv) >=3D PRV_STATE_INIT) {
-		ret =3D islpci_mgt_transaction(priv->ndev, PIMFOR_OP_GET, priv->priv_oid=
, extra, 256, &response);
+		ret =3D
+		    islpci_mgt_transaction(priv->ndev, PIMFOR_OP_GET,
+					   priv->priv_oid, extra, 256,
+					   &response);
 		response_op =3D response->header->operation;
 		printk("%s: ret: %i\n", ndev->name, ret);
 		printk("%s: response_op: %i\n", ndev->name, response_op);
-		if (ret || !response || response->header->operation =3D=3D PIMFOR_OP_ERR=
OR) {
+		if (ret || !response
+		    || response->header->operation =3D=3D PIMFOR_OP_ERROR) {
 			if (response) {
 				islpci_mgt_release(response);
 			}
@@ -2046,34 +2062,39 @@
 			printk("%s: len: %i\n", ndev->name, data->length);
 		}
 	}
-=09
+
 	return ret;
 }
=20
 int
-prism54_set_oid(struct net_device *ndev, struct iw_request_info *info,
-		struct iw_point *data, char *extra)
+prism54_debug_set_oid(struct net_device *ndev, struct iw_request_info *inf=
o,
+		      struct iw_point *data, char *extra)
 {
 	islpci_private *priv =3D netdev_priv(ndev);
 	struct islpci_mgmtframe *response =3D NULL;
 	int ret =3D 0, response_op =3D PIMFOR_OP_ERROR;
-=09
-	printk("%s: set_oid 0x%08X\tlen: %d\n", ndev->name, priv->priv_oid, data-=
>length);
-=09
+
+	printk("%s: set_oid 0x%08X\tlen: %d\n", ndev->name, priv->priv_oid,
+	       data->length);
+
 	if (islpci_get_state(priv) >=3D PRV_STATE_INIT) {
-		ret =3D islpci_mgt_transaction(priv->ndev, PIMFOR_OP_SET, priv->priv_oid=
, extra, data->length, &response);
+		ret =3D
+		    islpci_mgt_transaction(priv->ndev, PIMFOR_OP_SET,
+					   priv->priv_oid, extra, data->length,
+					   &response);
 		printk("%s: ret: %i\n", ndev->name, ret);
 		if (!ret) {
 			response_op =3D response->header->operation;
-			printk("%s: response_op: %i\n", ndev->name, response_op);
+			printk("%s: response_op: %i\n", ndev->name,
+			       response_op);
 			islpci_mgt_release(response);
 		}
 		if (ret || response_op =3D=3D PIMFOR_OP_ERROR) {
 			printk("%s: EIO\n", ndev->name);
-		        ret =3D -EIO;
+			ret =3D -EIO;
 		}
 	}
-=09
+
 	return ret;
 }
=20
@@ -2129,33 +2150,44 @@
 /* The low order bit identify a SET (0) or a GET (1) ioctl.  */
=20
 #define PRISM54_RESET		SIOCIWFIRSTPRIV
-#define PRISM54_GET_BEACON	SIOCIWFIRSTPRIV+1
-#define PRISM54_SET_BEACON	SIOCIWFIRSTPRIV+2
-#define PRISM54_GET_POLICY SIOCIWFIRSTPRIV+3
-#define PRISM54_SET_POLICY SIOCIWFIRSTPRIV+4
-#define PRISM54_GET_MAC 	   SIOCIWFIRSTPRIV+5
-#define PRISM54_ADD_MAC 	   SIOCIWFIRSTPRIV+6
+#define PRISM54_GET_POLICY	SIOCIWFIRSTPRIV+1
+#define PRISM54_SET_POLICY	SIOCIWFIRSTPRIV+2
+#define PRISM54_GET_MAC		SIOCIWFIRSTPRIV+3
+#define PRISM54_ADD_MAC		SIOCIWFIRSTPRIV+4
+
+#define PRISM54_DEL_MAC		SIOCIWFIRSTPRIV+6
=20
-#define PRISM54_DEL_MAC    SIOCIWFIRSTPRIV+8
+#define PRISM54_KICK_MAC	SIOCIWFIRSTPRIV+8
=20
-#define PRISM54_KICK_MAC   SIOCIWFIRSTPRIV+10
+#define PRISM54_KICK_ALL	SIOCIWFIRSTPRIV+10
=20
-#define PRISM54_KICK_ALL   SIOCIWFIRSTPRIV+12
+#define PRISM54_GET_WPA		SIOCIWFIRSTPRIV+11
+#define PRISM54_SET_WPA		SIOCIWFIRSTPRIV+12
=20
-#define PRISM54_GET_WPA	   SIOCIWFIRSTPRIV+13
-#define PRISM54_SET_WPA	   SIOCIWFIRSTPRIV+14
+#define PRISM54_DBG_OID		SIOCIWFIRSTPRIV+14
+#define PRISM54_DBG_GET_OID	SIOCIWFIRSTPRIV+15
+#define PRISM54_DBG_SET_OID	SIOCIWFIRSTPRIV+16
=20
-#define PRISM54_OID	   SIOCIWFIRSTPRIV+16
-#define PRISM54_GET_OID	   SIOCIWFIRSTPRIV+17
-#define PRISM54_SET_OID	   SIOCIWFIRSTPRIV+18
+#define PRISM54_GET_OID		SIOCIWFIRSTPRIV+17
+#define PRISM54_SET_OID_U32	SIOCIWFIRSTPRIV+18
+#define	PRISM54_SET_OID_STR	SIOCIWFIRSTPRIV+20
+#define	PRISM54_SET_OID_ADDR	SIOCIWFIRSTPRIV+22
+
+#define IWPRIV_SET_U32(n,x)	{ n, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1=
, 0, "set_"x }
+#define IWPRIV_SET_SSID(n,x)	{ n, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED |=
 1, 0, "set_"x }
+#define IWPRIV_SET_ADDR(n,x)	{ n, IW_PRIV_TYPE_ADDR | IW_PRIV_SIZE_FIXED |=
 1, 0, "set_"x }
+#define IWPRIV_GET(n,x)	{ n, 0, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | P=
RIV_STR_SIZE, "get_"x }
+
+#define IWPRIV_U32(n,x)		IWPRIV_SET_U32(n,x), IWPRIV_GET(n,x)
+#define IWPRIV_SSID(n,x)	IWPRIV_SET_SSID(n,x), IWPRIV_GET(n,x)
+#define IWPRIV_ADDR(n,x)	IWPRIV_SET_ADDR(n,x), IWPRIV_GET(n,x)
+
+
+/* Note : limited to 128 private ioctls */
=20
 static const struct iw_priv_args prism54_private_args[] =3D {
 /*{ cmd, set_args, get_args, name } */
 	{PRISM54_RESET, 0, 0, "reset"},
-	{PRISM54_GET_BEACON, 0, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
-	 "getBeaconPeriod"},
-	{PRISM54_SET_BEACON, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
-	 "setBeaconPeriod"},
 	{PRISM54_GET_POLICY, 0, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
 	 "getPolicy"},
 	{PRISM54_SET_POLICY, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
@@ -2172,15 +2204,77 @@
 	 "get_wpa"},
 	{PRISM54_SET_WPA, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
 	 "set_wpa"},
-	{PRISM54_OID, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "oid"},
-	{PRISM54_GET_OID, 0, IW_PRIV_TYPE_BYTE | 256, "get_oid"},
-	{PRISM54_SET_OID, IW_PRIV_TYPE_BYTE | 256, 0, "set_oid"},
+	{PRISM54_DBG_OID, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
+	 "dbg_oid"},
+	{PRISM54_DBG_GET_OID, 0, IW_PRIV_TYPE_BYTE | 256, "dbg_get_oid"},
+	{PRISM54_DBG_SET_OID, IW_PRIV_TYPE_BYTE | 256, 0, "dbg_get_oid"},
+	/* --- sub-ioctls handlers --- */
+	{PRISM54_GET_OID,
+	 0, IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | PRIV_STR_SIZE, ""},
+	{PRISM54_SET_OID_U32,
+	 IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, ""},
+	{PRISM54_SET_OID_STR,
+	 IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | 1, 0, ""},
+	{PRISM54_SET_OID_ADDR,
+	 IW_PRIV_TYPE_ADDR | IW_PRIV_SIZE_FIXED | 1, 0, ""},
+	/* --- sub-ioctls definitions --- */
+	IWPRIV_ADDR(GEN_OID_MACADDRESS, "addr"),
+	IWPRIV_GET(GEN_OID_LINKSTATE, "linkstate"),
+	IWPRIV_U32(DOT11_OID_BSSTYPE, "bsstype"),
+	IWPRIV_ADDR(DOT11_OID_BSSID, "bssid"),
+	IWPRIV_U32(DOT11_OID_STATE, "state"),
+	IWPRIV_U32(DOT11_OID_AID, "aid"),
+
+	IWPRIV_SSID(DOT11_OID_SSIDOVERRIDE, "ssidoverride"),
+
+	IWPRIV_U32(DOT11_OID_MEDIUMLIMIT, "medlimit"),
+	IWPRIV_U32(DOT11_OID_BEACONPERIOD, "beacon"),
+	IWPRIV_U32(DOT11_OID_DTIMPERIOD, "dtimperiod"),
+
+	IWPRIV_U32(DOT11_OID_AUTHENABLE, "authenable"),
+	IWPRIV_U32(DOT11_OID_PRIVACYINVOKED, "privinvok"),
+	IWPRIV_U32(DOT11_OID_EXUNENCRYPTED, "exunencrypt"),
+=09
+	IWPRIV_U32(DOT11_OID_REKEYTHRESHOLD, "rekeythresh"),
+
+	IWPRIV_U32(DOT11_OID_MAXTXLIFETIME, "maxtxlife"),
+	IWPRIV_U32(DOT11_OID_MAXRXLIFETIME, "maxrxlife"),
+	IWPRIV_U32(DOT11_OID_ALOFT_FIXEDRATE, "fixedrate"),
+	IWPRIV_U32(DOT11_OID_MAXFRAMEBURST, "frameburst"),
+	IWPRIV_U32(DOT11_OID_PSM, "psm"),
+
+	IWPRIV_U32(DOT11_OID_BRIDGELOCAL, "bridge"),
+	IWPRIV_U32(DOT11_OID_CLIENTS, "clients"),
+	IWPRIV_U32(DOT11_OID_CLIENTSASSOCIATED, "clientassoc"),
+	IWPRIV_U32(DOT11_OID_DOT1XENABLE, "dot1xenable"),
+	IWPRIV_U32(DOT11_OID_ANTENNARX, "rxant"),
+	IWPRIV_U32(DOT11_OID_ANTENNATX, "txant"),
+	IWPRIV_U32(DOT11_OID_ANTENNADIVERSITY, "antdivers"),
+	IWPRIV_U32(DOT11_OID_EDTHRESHOLD, "edthresh"),
+	IWPRIV_U32(DOT11_OID_PREAMBLESETTINGS, "preamble"),
+	IWPRIV_GET(DOT11_OID_RATES, "rates"),
+	IWPRIV_U32(DOT11_OID_OUTPUTPOWER, ".11outpower"),
+	IWPRIV_GET(DOT11_OID_SUPPORTEDRATES, "supprates"),
+	IWPRIV_GET(DOT11_OID_SUPPORTEDFREQUENCIES, "suppfreq"),
+
+	IWPRIV_U32(DOT11_OID_NOISEFLOOR, "noisefloor"),
+	IWPRIV_GET(DOT11_OID_FREQUENCYACTIVITY, "freqactivity"),
+	IWPRIV_U32(DOT11_OID_NONERPPROTECTION, "nonerpprotec"),
+	IWPRIV_U32(DOT11_OID_PROFILES, "profile"),
+	IWPRIV_GET(DOT11_OID_EXTENDEDRATES,"extrates"),
+	IWPRIV_U32(DOT11_OID_MLMEAUTOLEVEL, "mlmelevel"),
+
+	IWPRIV_GET(DOT11_OID_BSSS, "bsss"),
+	IWPRIV_GET(DOT11_OID_BSSLIST, "bsslist"),
+	IWPRIV_U32(OID_INL_MODE, "mode"),
+	IWPRIV_U32(OID_INL_CONFIG, "config"),
+	IWPRIV_U32(OID_INL_DOT11D_CONFORMANCE, ".11dconform"),
+	IWPRIV_GET(OID_INL_PHYCAPABILITIES, "phycapa"),
+	IWPRIV_U32(OID_INL_OUTPUTPOWER, "outpower"),
 };
=20
 static const iw_handler prism54_private_handler[] =3D {
 	(iw_handler) prism54_reset,
-	(iw_handler) prism54_get_beacon,
-	(iw_handler) prism54_set_beacon,
 	(iw_handler) prism54_get_policy,
 	(iw_handler) prism54_set_policy,
 	(iw_handler) prism54_get_mac,
@@ -2194,9 +2288,16 @@
 	(iw_handler) prism54_get_wpa,
 	(iw_handler) prism54_set_wpa,
 	(iw_handler) NULL,
-	(iw_handler) prism54_oid,
+	(iw_handler) prism54_debug_oid,
+	(iw_handler) prism54_debug_get_oid,
+	(iw_handler) prism54_debug_set_oid,
 	(iw_handler) prism54_get_oid,
-	(iw_handler) prism54_set_oid,
+	(iw_handler) prism54_set_u32,
+	(iw_handler) NULL,
+	(iw_handler) prism54_set_raw,
+	(iw_handler) NULL,
+	(iw_handler) prism54_set_raw,
+
 };
=20
 const struct iw_handler_def prism54_handler_def =3D {
@@ -2209,3 +2310,18 @@
 	.private_args =3D (struct iw_priv_args *) prism54_private_args,
 };
=20
+/* These ioctls won't work with the new API */
+
+int
+prism54_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+	/*struct iwreq *wrq =3D (struct iwreq *) rq;
+	   islpci_private *priv =3D netdev_priv(ndev);
+	   int ret =3D 0;
+
+	   switch (cmd) {
+
+	   }
+	 */
+	return -EOPNOTSUPP;
+}
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_oid.h,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -r1.3 -r1.4
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h	9 Mar 2004 09:05=
:27 -0000	1.3
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_oid.h	18 Mar 2004 11:1=
6:23 -0000	1.4
@@ -1,8 +1,9 @@
 /*
- *  $Id: isl_oid.h,v 1.3 2004/03/09 09:05:27 mcgrof Exp $
+ *  $Id: isl_oid.h,v 1.4 2004/03/18 11:16:23 ajfa Exp $
  * =20
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
  *  Copyright (C) 2004 Luis R. Rodriguez <mcgrof@ruslug.rutgers.edu>
+ *  Copyright (C) 2004 Aur=E9lien Alleaume <slts@free.fr>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -457,16 +458,29 @@
 	OID_NUM_LAST
 };
=20
-/* We  could add more flags. eg: in which mode are they allowed, ro, rw, .=
..*/
-#define OID_FLAG_CACHED	0x01
-#define OID_FLAG_U32	0x02
-#define OID_FLAG_MLMEEX	0x04	/* this type is special because of a variable
-				   size field when sending. Not yet implemented (not used in driver). =
*/
+#define OID_FLAG_CACHED		0x80
+#define OID_FLAG_TYPE		0x7f
+
+#define OID_TYPE_U32		0x01
+#define OID_TYPE_SSID		0x02
+#define OID_TYPE_KEY		0x03
+#define OID_TYPE_BUFFER		0x04
+#define OID_TYPE_BSS		0x05
+#define OID_TYPE_BSSLIST	0x06
+#define OID_TYPE_FREQUENCIES	0x07
+#define OID_TYPE_MLME		0x08
+#define OID_TYPE_MLMEEX		0x09
+#define OID_TYPE_ADDR		0x0A
+#define OID_TYPE_RAW		0x0B
+
+/* OID_TYPE_MLMEEX is special because of a variable size field when sendin=
g.
+ * Not yet implemented (not used in driver anyway).
+ */
=20
 struct oid_t {
 	enum oid_num_t oid;
 	short range;		/* to define a range of oid */
-	short size;		/* size of the associated data */
+	short size;		/* max size of the associated data */
 	char flags;
 };
=20
@@ -478,6 +492,7 @@
 #define	IWMAX_BITRATES	20
 #define	IWMAX_BSS	24
 #define IWMAX_FREQ	30
+#define PRIV_STR_SIZE	1024
=20
 #endif				/* !defined(_ISL_OID_H) */
 /* EOF */
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v
retrieving revision 1.54
retrieving revision 1.55
diff -u -r1.54 -r1.55
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	18 Mar 2004 0=
5:25:24 -0000	1.54
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	18 Mar 2004 1=
1:16:23 -0000	1.55
@@ -1,8 +1,9 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.53 2004/02/28 0=
3:06:07 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.55 2004/03/18 1=
1:16:23 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.=20
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
  *  Copyright (C) 2003 Luis R. Rodriguez <mcgrof@ruslug.rutgers.edu>
+ *  Copyright (C) 2003 Aurelien Alleaume <slts@free.fr>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.c,v
retrieving revision 1.7
retrieving revision 1.8
diff -u -r1.7 -r1.8
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	9 Mar 2004 09:05=
:27 -0000	1.7
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	18 Mar 2004 11:1=
6:23 -0000	1.8
@@ -1,5 +1,5 @@
 /*  =20
- *  Copyright (C) 2003 Aurelien Alleaume <slts@free.fr>
+ *  Copyright (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -31,182 +31,189 @@
 	5240, 5260, 5280, 5300, 5320
 };
=20
-#define OID_U32(x) {x, 0, sizeof(u32), OID_FLAG_U32}
-#define OID_U32_C(x) {x, 0, sizeof(u32), OID_FLAG_U32 | OID_FLAG_CACHED}
-#define OID_STRUCT(x,s) {x, 0, sizeof(s), 0}
-#define OID_STRUCT_C(x,s) {x, 0, sizeof(s), OID_FLAG_CACHED}
-#define OID_STRUCT_MLME(x){x, 0, sizeof(struct obj_mlme), 0}
-#define OID_STRUCT_MLMEEX(x){x, 0, sizeof(struct obj_mlmeex), OID_FLAG_MLM=
EEX}
+#define OID_STRUCT(name,oid,s,t) [name] =3D {oid, 0, sizeof(s), t}
+#define OID_STRUCT_C(name,oid,s,t) OID_STRUCT(name,oid,s,t | OID_FLAG_CACH=
ED)
+#define OID_U32(name,oid) OID_STRUCT(name,oid,u32,OID_TYPE_U32)
+#define OID_U32_C(name,oid) OID_STRUCT_C(name,oid,u32,OID_TYPE_U32)
+#define OID_STRUCT_MLME(name,oid) OID_STRUCT(name,oid,struct obj_mlme,OID_=
TYPE_MLME)
+#define OID_STRUCT_MLMEEX(name,oid) OID_STRUCT(name,oid,struct obj_mlmeex,=
OID_TYPE_MLMEEX)
=20
-#define OID_UNKNOWN(x) {x, 0, 0, 0}
+#define OID_UNKNOWN(name,oid) OID_STRUCT(name,oid,0,0)
=20
 struct oid_t isl_oid[] =3D {
-	[GEN_OID_MACADDRESS] =3D OID_STRUCT(0x00000000, u8[6]),
-	[GEN_OID_LINKSTATE] =3D OID_U32(0x00000001),
-	[GEN_OID_WATCHDOG] =3D OID_UNKNOWN(0x00000002),
-	[GEN_OID_MIBOP] =3D OID_UNKNOWN(0x00000003),
-	[GEN_OID_OPTIONS] =3D OID_UNKNOWN(0x00000004),
-	[GEN_OID_LEDCONFIG] =3D OID_UNKNOWN(0x00000005),
+	OID_STRUCT(GEN_OID_MACADDRESS, 0x00000000, u8[6], OID_TYPE_ADDR),
+	OID_U32(GEN_OID_LINKSTATE, 0x00000001),
+	OID_UNKNOWN(GEN_OID_WATCHDOG, 0x00000002),
+	OID_UNKNOWN(GEN_OID_MIBOP, 0x00000003),
+	OID_UNKNOWN(GEN_OID_OPTIONS, 0x00000004),
+	OID_UNKNOWN(GEN_OID_LEDCONFIG, 0x00000005),
=20
 	/* 802.11 */
-	[DOT11_OID_BSSTYPE] =3D OID_U32_C(0x10000000),
-	[DOT11_OID_BSSID] =3D OID_STRUCT_C(0x10000001, u8[6]),
-	[DOT11_OID_SSID] =3D OID_STRUCT_C(0x10000002, struct obj_ssid),
-	[DOT11_OID_STATE] =3D OID_U32(0x10000003),
-	[DOT11_OID_AID] =3D OID_U32(0x10000004),
-	[DOT11_OID_COUNTRYSTRING] =3D OID_STRUCT(0x10000005, u8[4]),
-	[DOT11_OID_SSIDOVERRIDE] =3D OID_STRUCT_C(0x10000006, struct obj_ssid),
-
-	[DOT11_OID_MEDIUMLIMIT] =3D OID_U32(0x11000000),
-	[DOT11_OID_BEACONPERIOD] =3D OID_U32_C(0x11000001),
-	[DOT11_OID_DTIMPERIOD] =3D OID_U32(0x11000002),
-	[DOT11_OID_ATIMWINDOW] =3D OID_U32(0x11000003),
-	[DOT11_OID_LISTENINTERVAL] =3D OID_U32(0x11000004),
-	[DOT11_OID_CFPPERIOD] =3D OID_U32(0x11000005),
-	[DOT11_OID_CFPDURATION] =3D OID_U32(0x11000006),
-
-	[DOT11_OID_AUTHENABLE] =3D OID_U32_C(0x12000000),
-	[DOT11_OID_PRIVACYINVOKED] =3D OID_U32_C(0x12000001),
-	[DOT11_OID_EXUNENCRYPTED] =3D OID_U32_C(0x12000002),
-	[DOT11_OID_DEFKEYID] =3D OID_U32_C(0x12000003),
-	[DOT11_OID_DEFKEYX] =3D {0x12000004, 3, sizeof (struct obj_key), OID_FLAG=
_CACHED},	/* DOT11_OID_DEFKEY1,...DOT11_OID_DEFKEY4 */
-	[DOT11_OID_STAKEY] =3D OID_UNKNOWN(0x12000008),
-	[DOT11_OID_REKEYTHRESHOLD] =3D OID_U32(0x12000009),
-	[DOT11_OID_STASC] =3D OID_UNKNOWN(0x1200000a),
-
-	[DOT11_OID_PRIVTXREJECTED] =3D OID_U32(0x1a000000),
-	[DOT11_OID_PRIVRXPLAIN] =3D OID_U32(0x1a000001),
-	[DOT11_OID_PRIVRXFAILED] =3D OID_U32(0x1a000002),
-	[DOT11_OID_PRIVRXNOKEY] =3D OID_U32(0x1a000003),
-
-	[DOT11_OID_RTSTHRESH] =3D OID_U32_C(0x13000000),
-	[DOT11_OID_FRAGTHRESH] =3D OID_U32_C(0x13000001),
-	[DOT11_OID_SHORTRETRIES] =3D OID_U32_C(0x13000002),
-	[DOT11_OID_LONGRETRIES] =3D OID_U32_C(0x13000003),
-	[DOT11_OID_MAXTXLIFETIME] =3D OID_U32_C(0x13000004),
-	[DOT11_OID_MAXRXLIFETIME] =3D OID_U32(0x13000005),
-	[DOT11_OID_AUTHRESPTIMEOUT] =3D OID_U32(0x13000006),
-	[DOT11_OID_ASSOCRESPTIMEOUT] =3D OID_U32(0x13000007),
-
-	[DOT11_OID_ALOFT_TABLE] =3D OID_UNKNOWN(0x1d000000),
-	[DOT11_OID_ALOFT_CTRL_TABLE] =3D OID_UNKNOWN(0x1d000001),
-	[DOT11_OID_ALOFT_RETREAT] =3D OID_UNKNOWN(0x1d000002),
-	[DOT11_OID_ALOFT_PROGRESS] =3D OID_UNKNOWN(0x1d000003),
-	[DOT11_OID_ALOFT_FIXEDRATE] =3D OID_U32(0x1d000004),
-	[DOT11_OID_ALOFT_RSSIGRAPH] =3D OID_UNKNOWN(0x1d000005),
-	[DOT11_OID_ALOFT_CONFIG] =3D OID_UNKNOWN(0x1d000006),
+	OID_U32_C(DOT11_OID_BSSTYPE, 0x10000000),
+	OID_STRUCT_C(DOT11_OID_BSSID, 0x10000001, u8[6], OID_TYPE_SSID),
+	OID_STRUCT_C(DOT11_OID_SSID, 0x10000002, struct obj_ssid,
+		     OID_TYPE_SSID),
+	OID_U32(DOT11_OID_STATE, 0x10000003),
+	OID_U32(DOT11_OID_AID, 0x10000004),
+	OID_STRUCT(DOT11_OID_COUNTRYSTRING, 0x10000005, u8[4], OID_TYPE_RAW),
+	OID_STRUCT_C(DOT11_OID_SSIDOVERRIDE, 0x10000006, struct obj_ssid,
+		     OID_TYPE_SSID),
+
+	OID_U32(DOT11_OID_MEDIUMLIMIT, 0x11000000),
+	OID_U32_C(DOT11_OID_BEACONPERIOD, 0x11000001),
+	OID_U32(DOT11_OID_DTIMPERIOD, 0x11000002),
+	OID_U32(DOT11_OID_ATIMWINDOW, 0x11000003),
+	OID_U32(DOT11_OID_LISTENINTERVAL, 0x11000004),
+	OID_U32(DOT11_OID_CFPPERIOD, 0x11000005),
+	OID_U32(DOT11_OID_CFPDURATION, 0x11000006),
+
+	OID_U32_C(DOT11_OID_AUTHENABLE, 0x12000000),
+	OID_U32_C(DOT11_OID_PRIVACYINVOKED, 0x12000001),
+	OID_U32_C(DOT11_OID_EXUNENCRYPTED, 0x12000002),
+	OID_U32_C(DOT11_OID_DEFKEYID, 0x12000003),
+	[DOT11_OID_DEFKEYX] =3D {0x12000004, 3, sizeof (struct obj_key),
+			       OID_FLAG_CACHED | OID_TYPE_KEY},	/* DOT11_OID_DEFKEY1,...DOT11_O=
ID_DEFKEY4 */
+	OID_UNKNOWN(DOT11_OID_STAKEY, 0x12000008),
+	OID_U32(DOT11_OID_REKEYTHRESHOLD, 0x12000009),
+	OID_UNKNOWN(DOT11_OID_STASC, 0x1200000a),
+
+	OID_U32(DOT11_OID_PRIVTXREJECTED, 0x1a000000),
+	OID_U32(DOT11_OID_PRIVRXPLAIN, 0x1a000001),
+	OID_U32(DOT11_OID_PRIVRXFAILED, 0x1a000002),
+	OID_U32(DOT11_OID_PRIVRXNOKEY, 0x1a000003),
+
+	OID_U32_C(DOT11_OID_RTSTHRESH, 0x13000000),
+	OID_U32_C(DOT11_OID_FRAGTHRESH, 0x13000001),
+	OID_U32_C(DOT11_OID_SHORTRETRIES, 0x13000002),
+	OID_U32_C(DOT11_OID_LONGRETRIES, 0x13000003),
+	OID_U32_C(DOT11_OID_MAXTXLIFETIME, 0x13000004),
+	OID_U32(DOT11_OID_MAXRXLIFETIME, 0x13000005),
+	OID_U32(DOT11_OID_AUTHRESPTIMEOUT, 0x13000006),
+	OID_U32(DOT11_OID_ASSOCRESPTIMEOUT, 0x13000007),
+
+	OID_UNKNOWN(DOT11_OID_ALOFT_TABLE, 0x1d000000),
+	OID_UNKNOWN(DOT11_OID_ALOFT_CTRL_TABLE, 0x1d000001),
+	OID_UNKNOWN(DOT11_OID_ALOFT_RETREAT, 0x1d000002),
+	OID_UNKNOWN(DOT11_OID_ALOFT_PROGRESS, 0x1d000003),
+	OID_U32(DOT11_OID_ALOFT_FIXEDRATE, 0x1d000004),
+	OID_UNKNOWN(DOT11_OID_ALOFT_RSSIGRAPH, 0x1d000005),
+	OID_UNKNOWN(DOT11_OID_ALOFT_CONFIG, 0x1d000006),
=20
 	[DOT11_OID_VDCFX] =3D {0x1b000000, 7, 0, 0},
-	[DOT11_OID_MAXFRAMEBURST] =3D OID_U32(0x1b000008), /* in microseconds */
+	OID_U32(DOT11_OID_MAXFRAMEBURST, 0x1b000008),
=20
-	[DOT11_OID_PSM] =3D OID_U32(0x14000000),
-	[DOT11_OID_CAMTIMEOUT] =3D OID_U32(0x14000001),
-	[DOT11_OID_RECEIVEDTIMS] =3D OID_U32(0x14000002),
-	[DOT11_OID_ROAMPREFERENCE] =3D OID_U32(0x14000003),
-
-	[DOT11_OID_BRIDGELOCAL] =3D OID_U32(0x15000000),
-	[DOT11_OID_CLIENTS] =3D OID_U32(0x15000001),
-	[DOT11_OID_CLIENTSASSOCIATED] =3D OID_U32(0x15000002),
+	OID_U32(DOT11_OID_PSM, 0x14000000),
+	OID_U32(DOT11_OID_CAMTIMEOUT, 0x14000001),
+	OID_U32(DOT11_OID_RECEIVEDTIMS, 0x14000002),
+	OID_U32(DOT11_OID_ROAMPREFERENCE, 0x14000003),
+
+	OID_U32(DOT11_OID_BRIDGELOCAL, 0x15000000),
+	OID_U32(DOT11_OID_CLIENTS, 0x15000001),
+	OID_U32(DOT11_OID_CLIENTSASSOCIATED, 0x15000002),
 	[DOT11_OID_CLIENTX] =3D {0x15000003, 2006, 0, 0},	/* DOT11_OID_CLIENTX,..=
.DOT11_OID_CLIENT2007 */
=20
-	[DOT11_OID_CLIENTFIND] =3D OID_STRUCT(0x150007DB, u8[6]),
-	[DOT11_OID_WDSLINKADD] =3D OID_STRUCT(0x150007DC, u8[6]),
-	[DOT11_OID_WDSLINKREMOVE] =3D OID_STRUCT(0x150007DD, u8[6]),
-	[DOT11_OID_EAPAUTHSTA] =3D OID_STRUCT(0x150007DE, u8[6]),
-	[DOT11_OID_EAPUNAUTHSTA] =3D OID_STRUCT(0x150007DF, u8[6]),
-	[DOT11_OID_DOT1XENABLE] =3D OID_U32_C(0x150007E0),
-	[DOT11_OID_MICFAILURE] =3D OID_UNKNOWN(0x150007E1),
-	[DOT11_OID_REKEYINDICATE] =3D OID_UNKNOWN(0x150007E2),
-
-	[DOT11_OID_MPDUTXSUCCESSFUL] =3D OID_U32(0x16000000),
-	[DOT11_OID_MPDUTXONERETRY] =3D OID_U32(0x16000001),
-	[DOT11_OID_MPDUTXMULTIPLERETRIES] =3D OID_U32(0x16000002),
-	[DOT11_OID_MPDUTXFAILED] =3D OID_U32(0x16000003),
-	[DOT11_OID_MPDURXSUCCESSFUL] =3D OID_U32(0x16000004),
-	[DOT11_OID_MPDURXDUPS] =3D OID_U32(0x16000005),
-	[DOT11_OID_RTSSUCCESSFUL] =3D OID_U32(0x16000006),
-	[DOT11_OID_RTSFAILED] =3D OID_U32(0x16000007),
-	[DOT11_OID_ACKFAILED] =3D OID_U32(0x16000008),
-	[DOT11_OID_FRAMERECEIVES] =3D OID_U32(0x16000009),
-	[DOT11_OID_FRAMEERRORS] =3D OID_U32(0x1600000A),
-	[DOT11_OID_FRAMEABORTS] =3D OID_U32(0x1600000B),
-	[DOT11_OID_FRAMEABORTSPHY] =3D OID_U32(0x1600000C),
-
-	[DOT11_OID_SLOTTIME] =3D OID_U32(0x17000000),
-	[DOT11_OID_CWMIN] =3D OID_U32(0x17000001),
-	[DOT11_OID_CWMAX] =3D OID_U32(0x17000002),
-	[DOT11_OID_ACKWINDOW] =3D OID_U32(0x17000003),
-	[DOT11_OID_ANTENNARX] =3D OID_U32(0x17000004),
-	[DOT11_OID_ANTENNATX] =3D OID_U32(0x17000005),
-	[DOT11_OID_ANTENNADIVERSITY] =3D OID_U32(0x17000006),
-	[DOT11_OID_CHANNEL] =3D OID_U32_C(0x17000007),
-	[DOT11_OID_EDTHRESHOLD] =3D OID_U32_C(0x17000008),
-	[DOT11_OID_PREAMBLESETTINGS] =3D OID_U32(0x17000009),
-	[DOT11_OID_RATES] =3D OID_STRUCT(0x1700000A, u8[IWMAX_BITRATES + 1]),
-	[DOT11_OID_CCAMODESUPPORTED] =3D OID_U32(0x1700000B),
-	[DOT11_OID_CCAMODE] =3D OID_U32(0x1700000C),
-	[DOT11_OID_RSSIVECTOR] =3D OID_U32(0x1700000D),
-	[DOT11_OID_OUTPUTPOWERTABLE] =3D OID_U32(0x1700000E),
-	[DOT11_OID_OUTPUTPOWER] =3D OID_U32_C(0x1700000F),
-	[DOT11_OID_SUPPORTEDRATES] =3D
-	    OID_STRUCT(0x17000010, u8[IWMAX_BITRATES + 1]),
-	[DOT11_OID_FREQUENCY] =3D OID_U32_C(0x17000011),
-	[DOT11_OID_SUPPORTEDFREQUENCIES] =3D {0x17000012, 0, sizeof (struct
-								   obj_frequencies)
-					    + sizeof (u16) * IWMAX_FREQ, 0},
-
-	[DOT11_OID_NOISEFLOOR] =3D OID_U32(0x17000013),
-	[DOT11_OID_FREQUENCYACTIVITY] =3D
-	    OID_STRUCT(0x17000014, u8[IWMAX_FREQ + 1]),
-	[DOT11_OID_IQCALIBRATIONTABLE] =3D OID_UNKNOWN(0x17000015),
-	[DOT11_OID_NONERPPROTECTION] =3D OID_U32(0x17000016),
-	[DOT11_OID_SLOTSETTINGS] =3D OID_U32(0x17000017),
-	[DOT11_OID_NONERPTIMEOUT] =3D OID_U32(0x17000018),
-	[DOT11_OID_PROFILES] =3D OID_U32(0x17000019),
-	[DOT11_OID_EXTENDEDRATES] =3D
-	    OID_STRUCT(0x17000020, u8[IWMAX_BITRATES + 1]),
-
-	[DOT11_OID_DEAUTHENTICATE] =3D OID_STRUCT_MLME(0x18000000),
-	[DOT11_OID_AUTHENTICATE] =3D OID_STRUCT_MLME(0x18000001),
-	[DOT11_OID_DISASSOCIATE] =3D OID_STRUCT_MLME(0x18000002),
-	[DOT11_OID_ASSOCIATE] =3D OID_STRUCT_MLME(0x18000003),
-	[DOT11_OID_SCAN] =3D OID_UNKNOWN(0x18000004),
-	[DOT11_OID_BEACON] =3D OID_STRUCT_MLMEEX(0x18000005),
-	[DOT11_OID_PROBE] =3D OID_STRUCT_MLMEEX(0x18000006),
-	[DOT11_OID_DEAUTHENTICATEEX] =3D OID_STRUCT_MLMEEX(0x18000007),
-	[DOT11_OID_AUTHENTICATEEX] =3D OID_STRUCT_MLMEEX(0x18000008),
-	[DOT11_OID_DISASSOCIATEEX] =3D OID_STRUCT_MLMEEX(0x18000009),
-	[DOT11_OID_ASSOCIATEEX] =3D OID_STRUCT_MLMEEX(0x1800000A),
-	[DOT11_OID_REASSOCIATE] =3D OID_STRUCT_MLMEEX(0x1800000B),
-	[DOT11_OID_REASSOCIATEEX] =3D OID_STRUCT_MLMEEX(0x1800000C),
-
-	[DOT11_OID_NONERPSTATUS] =3D OID_U32(0x1E000000),
-
-	[DOT11_OID_STATIMEOUT] =3D OID_U32(0x19000000),
-	[DOT11_OID_MLMEAUTOLEVEL] =3D OID_U32_C(0x19000001),
-	[DOT11_OID_BSSTIMEOUT] =3D OID_U32(0x19000002),
-	[DOT11_OID_ATTACHMENT] =3D OID_UNKNOWN(0x19000003),
-	[DOT11_OID_PSMBUFFER] =3D OID_STRUCT_C(0x19000004, struct obj_buffer),
-
-	[DOT11_OID_BSSS] =3D OID_U32(0x1C000000),
-	[DOT11_OID_BSSX] =3D {0x1C000001, 63, sizeof (struct obj_bss), 0},	/*DOT1=
1_OID_BSS1,...,DOT11_OID_BSS64 */
-	[DOT11_OID_BSSFIND] =3D OID_STRUCT(0x1C000042, struct obj_bss),
+	OID_STRUCT(DOT11_OID_CLIENTFIND, 0x150007DB, u8[6], OID_TYPE_ADDR),
+	OID_STRUCT(DOT11_OID_WDSLINKADD, 0x150007DC, u8[6], OID_TYPE_ADDR),
+	OID_STRUCT(DOT11_OID_WDSLINKREMOVE, 0x150007DD, u8[6], OID_TYPE_ADDR),
+	OID_STRUCT(DOT11_OID_EAPAUTHSTA, 0x150007DE, u8[6], OID_TYPE_ADDR),
+	OID_STRUCT(DOT11_OID_EAPUNAUTHSTA, 0x150007DF, u8[6], OID_TYPE_ADDR),
+	OID_U32_C(DOT11_OID_DOT1XENABLE, 0x150007E0),
+	OID_UNKNOWN(DOT11_OID_MICFAILURE, 0x150007E1),
+	OID_UNKNOWN(DOT11_OID_REKEYINDICATE, 0x150007E2),
+
+	OID_U32(DOT11_OID_MPDUTXSUCCESSFUL, 0x16000000),
+	OID_U32(DOT11_OID_MPDUTXONERETRY, 0x16000001),
+	OID_U32(DOT11_OID_MPDUTXMULTIPLERETRIES, 0x16000002),
+	OID_U32(DOT11_OID_MPDUTXFAILED, 0x16000003),
+	OID_U32(DOT11_OID_MPDURXSUCCESSFUL, 0x16000004),
+	OID_U32(DOT11_OID_MPDURXDUPS, 0x16000005),
+	OID_U32(DOT11_OID_RTSSUCCESSFUL, 0x16000006),
+	OID_U32(DOT11_OID_RTSFAILED, 0x16000007),
+	OID_U32(DOT11_OID_ACKFAILED, 0x16000008),
+	OID_U32(DOT11_OID_FRAMERECEIVES, 0x16000009),
+	OID_U32(DOT11_OID_FRAMEERRORS, 0x1600000A),
+	OID_U32(DOT11_OID_FRAMEABORTS, 0x1600000B),
+	OID_U32(DOT11_OID_FRAMEABORTSPHY, 0x1600000C),
+
+	OID_U32(DOT11_OID_SLOTTIME, 0x17000000),
+	OID_U32(DOT11_OID_CWMIN, 0x17000001),
+	OID_U32(DOT11_OID_CWMAX, 0x17000002),
+	OID_U32(DOT11_OID_ACKWINDOW, 0x17000003),
+	OID_U32(DOT11_OID_ANTENNARX, 0x17000004),
+	OID_U32(DOT11_OID_ANTENNATX, 0x17000005),
+	OID_U32(DOT11_OID_ANTENNADIVERSITY, 0x17000006),
+	OID_U32_C(DOT11_OID_CHANNEL, 0x17000007),
+	OID_U32_C(DOT11_OID_EDTHRESHOLD, 0x17000008),
+	OID_U32(DOT11_OID_PREAMBLESETTINGS, 0x17000009),
+	OID_STRUCT(DOT11_OID_RATES, 0x1700000A, u8[IWMAX_BITRATES + 1],
+		   OID_TYPE_RAW),
+	OID_U32(DOT11_OID_CCAMODESUPPORTED, 0x1700000B),
+	OID_U32(DOT11_OID_CCAMODE, 0x1700000C),
+	OID_UNKNOWN(DOT11_OID_RSSIVECTOR, 0x1700000D),
+	OID_UNKNOWN(DOT11_OID_OUTPUTPOWERTABLE, 0x1700000E),
+	OID_U32(DOT11_OID_OUTPUTPOWER, 0x1700000F),
+	OID_STRUCT(DOT11_OID_SUPPORTEDRATES, 0x17000010,
+		   u8[IWMAX_BITRATES + 1], OID_TYPE_RAW),
+	OID_U32_C(DOT11_OID_FREQUENCY, 0x17000011),
+	[DOT11_OID_SUPPORTEDFREQUENCIES] =3D
+	    {0x17000012, 0, sizeof (struct obj_frequencies)
+	     + sizeof (u16) * IWMAX_FREQ, OID_TYPE_FREQUENCIES},
+
+	OID_U32(DOT11_OID_NOISEFLOOR, 0x17000013),
+	OID_STRUCT(DOT11_OID_FREQUENCYACTIVITY, 0x17000014, u8[IWMAX_FREQ + 1],
+		   OID_TYPE_RAW),
+	OID_UNKNOWN(DOT11_OID_IQCALIBRATIONTABLE, 0x17000015),
+	OID_U32(DOT11_OID_NONERPPROTECTION, 0x17000016),
+	OID_U32(DOT11_OID_SLOTSETTINGS, 0x17000017),
+	OID_U32(DOT11_OID_NONERPTIMEOUT, 0x17000018),
+	OID_U32(DOT11_OID_PROFILES, 0x17000019),
+	OID_STRUCT(DOT11_OID_EXTENDEDRATES, 0x17000020,
+		   u8[IWMAX_BITRATES + 1], OID_TYPE_RAW),
+
+	OID_STRUCT_MLME(DOT11_OID_DEAUTHENTICATE, 0x18000000),
+	OID_STRUCT_MLME(DOT11_OID_AUTHENTICATE, 0x18000001),
+	OID_STRUCT_MLME(DOT11_OID_DISASSOCIATE, 0x18000002),
+	OID_STRUCT_MLME(DOT11_OID_ASSOCIATE, 0x18000003),
+	OID_UNKNOWN(DOT11_OID_SCAN, 0x18000004),
+	OID_STRUCT_MLMEEX(DOT11_OID_BEACON, 0x18000005),
+	OID_STRUCT_MLMEEX(DOT11_OID_PROBE, 0x18000006),
+	OID_STRUCT_MLMEEX(DOT11_OID_DEAUTHENTICATEEX, 0x18000007),
+	OID_STRUCT_MLMEEX(DOT11_OID_AUTHENTICATEEX, 0x18000008),
+	OID_STRUCT_MLMEEX(DOT11_OID_DISASSOCIATEEX, 0x18000009),
+	OID_STRUCT_MLMEEX(DOT11_OID_ASSOCIATEEX, 0x1800000A),
+	OID_STRUCT_MLMEEX(DOT11_OID_REASSOCIATE, 0x1800000B),
+	OID_STRUCT_MLMEEX(DOT11_OID_REASSOCIATEEX, 0x1800000C),
+
+	OID_U32(DOT11_OID_NONERPSTATUS, 0x1E000000),
+
+	OID_U32(DOT11_OID_STATIMEOUT, 0x19000000),
+	OID_U32_C(DOT11_OID_MLMEAUTOLEVEL, 0x19000001),
+	OID_U32(DOT11_OID_BSSTIMEOUT, 0x19000002),
+	OID_UNKNOWN(DOT11_OID_ATTACHMENT, 0x19000003),
+	OID_STRUCT_C(DOT11_OID_PSMBUFFER, 0x19000004, struct obj_buffer,
+		     OID_TYPE_BUFFER),
+
+	OID_U32(DOT11_OID_BSSS, 0x1C000000),
+	[DOT11_OID_BSSX] =3D {0x1C000001, 63, sizeof (struct obj_bss),
+			    OID_TYPE_BSS},	/*DOT11_OID_BSS1,...,DOT11_OID_BSS64 */
+	OID_STRUCT(DOT11_OID_BSSFIND, 0x1C000042, struct obj_bss, OID_TYPE_BSS),
 	[DOT11_OID_BSSLIST] =3D {0x1C000043, 0, sizeof (struct
 						      obj_bsslist) +
-			       sizeof (struct obj_bss[IWMAX_BSS]), 0},
+			       sizeof (struct obj_bss[IWMAX_BSS]),
+			       OID_TYPE_BSSLIST},
=20
-	[OID_INL_TUNNEL] =3D OID_UNKNOWN(0xFF020000),
-	[OID_INL_MEMADDR] =3D OID_UNKNOWN(0xFF020001),
-	[OID_INL_MEMORY] =3D OID_UNKNOWN(0xFF020002),
-	[OID_INL_MODE] =3D OID_U32_C(0xFF020003),
-	[OID_INL_COMPONENT_NR] =3D OID_UNKNOWN(0xFF020004),
-	[OID_INL_VERSION] =3D OID_UNKNOWN(0xFF020005),
-	[OID_INL_INTERFACE_ID] =3D OID_UNKNOWN(0xFF020006),
-	[OID_INL_COMPONENT_ID] =3D OID_UNKNOWN(0xFF020007),
-	[OID_INL_CONFIG] =3D OID_U32_C(0xFF020008),
-	[OID_INL_DOT11D_CONFORMANCE] =3D OID_U32_C(0xFF02000C),
-	[OID_INL_PHYCAPABILITIES] =3D OID_U32(0xFF02000D),
-	[OID_INL_OUTPUTPOWER] =3D OID_U32_C(0xFF02000F),
+	OID_UNKNOWN(OID_INL_TUNNEL, 0xFF020000),
+	OID_UNKNOWN(OID_INL_MEMADDR, 0xFF020001),
+	OID_UNKNOWN(OID_INL_MEMORY, 0xFF020002),
+	OID_U32_C(OID_INL_MODE, 0xFF020003),
+	OID_UNKNOWN(OID_INL_COMPONENT_NR, 0xFF020004),
+	OID_UNKNOWN(OID_INL_VERSION, 0xFF020005),
+	OID_UNKNOWN(OID_INL_INTERFACE_ID, 0xFF020006),
+	OID_UNKNOWN(OID_INL_COMPONENT_ID, 0xFF020007),
+	OID_U32_C(OID_INL_CONFIG, 0xFF020008),
+	OID_U32_C(OID_INL_DOT11D_CONFORMANCE, 0xFF02000C),
+	OID_U32(OID_INL_PHYCAPABILITIES, 0xFF02000D),
+	OID_U32_C(OID_INL_OUTPUTPOWER, 0xFF02000F),
=20
 };
=20
@@ -257,6 +264,134 @@
 	priv->mib =3D NULL;
 }
=20
+void
+mgt_le_to_cpu(int type, void *data)
+{
+	switch (type) {
+	case OID_TYPE_U32:
+		*(u32 *) data =3D le32_to_cpu(*(u32 *) data);
+		break;
+	case OID_TYPE_BUFFER:{
+			struct obj_buffer *buff =3D data;
+			buff->size =3D le32_to_cpu(buff->size);
+			buff->addr =3D le32_to_cpu(buff->addr);
+			break;
+		}
+	case OID_TYPE_BSS:{
+			struct obj_bss *bss =3D data;
+			bss->age =3D le16_to_cpu(bss->age);
+			bss->channel =3D le16_to_cpu(bss->channel);
+			bss->capinfo =3D le16_to_cpu(bss->capinfo);
+			bss->rates =3D le16_to_cpu(bss->rates);
+			bss->basic_rates =3D le16_to_cpu(bss->basic_rates);
+			break;
+		}
+	case OID_TYPE_BSSLIST:{
+			struct obj_bsslist *list =3D data;
+			int i;
+			list->nr =3D le32_to_cpu(list->nr);
+			for (i =3D 0; i < list->nr; i++)
+				mgt_le_to_cpu(OID_TYPE_BSS, &list->bsslist[i]);
+			break;
+		}
+	case OID_TYPE_FREQUENCIES:{
+			struct obj_frequencies *freq =3D data;
+			int i;
+			freq->nr =3D le16_to_cpu(freq->nr);
+			for (i =3D 0; i < freq->nr; i++)
+				freq->mhz[i] =3D le16_to_cpu(freq->mhz[i]);
+			break;
+		}
+	case OID_TYPE_MLME:{
+			struct obj_mlme *mlme =3D data;
+			mlme->id =3D le16_to_cpu(mlme->id);
+			mlme->state =3D le16_to_cpu(mlme->state);
+			mlme->code =3D le16_to_cpu(mlme->code);
+			break;
+		}
+	case OID_TYPE_MLMEEX:{
+			struct obj_mlmeex *mlme =3D data;
+			mlme->id =3D le16_to_cpu(mlme->id);
+			mlme->state =3D le16_to_cpu(mlme->state);
+			mlme->code =3D le16_to_cpu(mlme->code);
+			mlme->size =3D le16_to_cpu(mlme->size);
+			break;
+		}
+	case OID_TYPE_SSID:
+	case OID_TYPE_KEY:
+	case OID_TYPE_ADDR:
+	case OID_TYPE_RAW:
+		break;
+	default:
+		BUG();
+	}
+}
+
+static void
+mgt_cpu_to_le(int type, void *data)
+{
+	switch (type) {
+	case OID_TYPE_U32:
+		*(u32 *) data =3D cpu_to_le32(*(u32 *) data);
+		break;
+	case OID_TYPE_BUFFER:{
+			struct obj_buffer *buff =3D data;
+			buff->size =3D cpu_to_le32(buff->size);
+			buff->addr =3D cpu_to_le32(buff->addr);
+			break;
+		}
+	case OID_TYPE_BSS:{
+			struct obj_bss *bss =3D data;
+			bss->age =3D cpu_to_le16(bss->age);
+			bss->channel =3D cpu_to_le16(bss->channel);
+			bss->capinfo =3D cpu_to_le16(bss->capinfo);
+			bss->rates =3D cpu_to_le16(bss->rates);
+			bss->basic_rates =3D cpu_to_le16(bss->basic_rates);
+			break;
+		}
+	case OID_TYPE_BSSLIST:{
+			struct obj_bsslist *list =3D data;
+			int i;
+			list->nr =3D cpu_to_le32(list->nr);
+			for (i =3D 0; i < list->nr; i++)
+				mgt_cpu_to_le(OID_TYPE_BSS, &list->bsslist[i]);
+			break;
+		}
+	case OID_TYPE_FREQUENCIES:{
+			struct obj_frequencies *freq =3D data;
+			int i;
+			freq->nr =3D cpu_to_le16(freq->nr);
+			for (i =3D 0; i < freq->nr; i++)
+				freq->mhz[i] =3D cpu_to_le16(freq->mhz[i]);
+			break;
+		}
+	case OID_TYPE_MLME:{
+			struct obj_mlme *mlme =3D data;
+			mlme->id =3D cpu_to_le16(mlme->id);
+			mlme->state =3D cpu_to_le16(mlme->state);
+			mlme->code =3D cpu_to_le16(mlme->code);
+			break;
+		}
+	case OID_TYPE_MLMEEX:{
+			struct obj_mlmeex *mlme =3D data;
+			mlme->id =3D cpu_to_le16(mlme->id);
+			mlme->state =3D cpu_to_le16(mlme->state);
+			mlme->code =3D cpu_to_le16(mlme->code);
+			mlme->size =3D cpu_to_le16(mlme->size);
+			break;
+		}
+	case OID_TYPE_SSID:
+	case OID_TYPE_KEY:
+	case OID_TYPE_ADDR:
+	case OID_TYPE_RAW:
+		break;
+	default:
+		BUG();
+	}
+}
+
+/* Note : data is modified during this function */
+
 int
 mgt_set_request(islpci_private *priv, enum oid_num_t n, int extra, void *d=
ata)
 {
@@ -265,7 +400,7 @@
 	int response_op =3D PIMFOR_OP_ERROR;
 	int dlen;
 	void *cache, *_data =3D data;
-	u32 oid, u;
+	u32 oid;
=20
 	BUG_ON(OID_NUM_LAST <=3D n);
 	BUG_ON(extra > isl_oid[n].range);
@@ -279,13 +414,11 @@
 	cache +=3D (cache ? extra * dlen : 0);
 	oid =3D isl_oid[n].oid + extra;
=20
-	if (data =3D=3D NULL)
+	if (_data =3D=3D NULL)
 		/* we are requested to re-set a cached value */
 		_data =3D cache;
-	if ((isl_oid[n].flags & OID_FLAG_U32) && data) {
-		u =3D cpu_to_le32(*(u32 *) data);
-		_data =3D &u;
-	}
+	else
+		mgt_cpu_to_le(isl_oid[n].flags & OID_FLAG_TYPE, _data);
 	/* If we are going to write to the cache, we don't want anyone to read
 	 * it -> acquire write lock.
 	 * Else we could acquire a read lock to be sure we don't bother the
@@ -303,7 +436,7 @@
 			islpci_mgt_release(response);
 		}
 		if (ret || response_op =3D=3D PIMFOR_OP_ERROR)
-		        ret =3D -EIO;
+			ret =3D -EIO;
 	} else if (!cache)
 		ret =3D -EIO;
=20
@@ -313,6 +446,10 @@
 		up_write(&priv->mib_sem);
 	}
=20
+	/* re-set given data to what it was */
+	if (data)
+		mgt_le_to_cpu(isl_oid[n].flags & OID_FLAG_TYPE, data);
+
 	return ret;
 }
=20
@@ -324,9 +461,9 @@
 	int ret =3D -EIO;
 	int reslen =3D 0;
 	struct islpci_mgmtframe *response =3D NULL;
-=09
+
 	int dlen;
-	void *cache, *_res=3DNULL;
+	void *cache, *_res =3D NULL;
 	u32 oid;
=20
 	BUG_ON(OID_NUM_LAST <=3D n);
@@ -349,7 +486,7 @@
 		ret =3D islpci_mgt_transaction(priv->ndev, PIMFOR_OP_GET,
 					     oid, data, dlen, &response);
 		if (ret || !response ||
-			response->header->operation =3D=3D PIMFOR_OP_ERROR) {
+		    response->header->operation =3D=3D PIMFOR_OP_ERROR) {
 			if (response)
 				islpci_mgt_release(response);
 			ret =3D -EIO;
@@ -362,20 +499,19 @@
 		_res =3D cache;
 		ret =3D 0;
 	}
-	if (isl_oid[n].flags & OID_FLAG_U32) {
-		if (ret)
-			res->u =3D 0;
-		else
-			res->u =3D le32_to_cpu(*(u32 *) _res);
-	} else {
+	if ((isl_oid[n].flags & OID_FLAG_TYPE) =3D=3D OID_TYPE_U32)
+		res->u =3D ret ? 0 : le32_to_cpu(*(u32 *) _res);
+	else {
 		res->ptr =3D kmalloc(reslen, GFP_KERNEL);
 		BUG_ON(res->ptr =3D=3D NULL);
 		if (ret)
 			memset(res->ptr, 0, reslen);
-		else
+		else {
 			memcpy(res->ptr, _res, reslen);
+			mgt_le_to_cpu(isl_oid[n].flags & OID_FLAG_TYPE,
+				      res->ptr);
+		}
 	}
-
 	if (cache)
 		up_read(&priv->mib_sem);
=20
@@ -387,7 +523,7 @@
 		       "mgt_get_request(0x%x): received data length was bigger "
 		       "than expected (%d > %d). Memory is probably corrupted... ",
 		       oid, reslen, isl_oid[n].size);
-=09
+
 	return ret;
 }
=20
@@ -404,14 +540,14 @@
 		int j =3D 0;
 		u32 oid =3D t->oid;
 		BUG_ON(data =3D=3D NULL);
-		while (j <=3D t->range){
+		while (j <=3D t->range) {
 			response =3D NULL;
 			ret |=3D islpci_mgt_transaction(priv->ndev, PIMFOR_OP_SET,
-			                              oid, data, t->size,
+						      oid, data, t->size,
 						      &response);
 			if (response) {
 				ret |=3D (response->header->operation =3D=3D
-				        PIMFOR_OP_ERROR);
+					PIMFOR_OP_ERROR);
 				islpci_mgt_release(response);
 			}
 			j++;
@@ -431,13 +567,10 @@
 	BUG_ON(priv->mib[n] =3D=3D NULL);
=20
 	memcpy(priv->mib[n], data, isl_oid[n].size);
-	if (isl_oid[n].flags & OID_FLAG_U32)
-		*(u32 *) priv->mib[n] =3D cpu_to_le32(*(u32 *) priv->mib[n]);
+	mgt_cpu_to_le(isl_oid[n].flags & OID_FLAG_TYPE, priv->mib[n]);
 }
=20
-/* Commits the cache. If something goes wrong, it restarts the device. Lock
- * outside
- */
+/* Commits the cache. Lock outside. */
=20
 static enum oid_num_t commit_part1[] =3D {
 	OID_INL_CONFIG,
@@ -486,7 +619,7 @@
 		/* some request have failed. The device might be in an
 		   incoherent state. We should reset it ! */
 		printk(KERN_DEBUG "%s: mgt_commit has failed. Restart the "
-                "device \n", priv->ndev->name);
+		       "device \n", priv->ndev->name);
 	}
=20
 	/* update the MAC addr. As it's not cached, no lock will be acquired by
@@ -530,3 +663,102 @@
=20
 	return 0;
 }
+
+int
+mgt_response_to_str(enum oid_num_t n, union oid_res_t *r, char *str)
+{
+	switch (isl_oid[n].flags & OID_FLAG_TYPE) {
+	case OID_TYPE_U32:
+		return snprintf(str, PRIV_STR_SIZE, "%u\n", r->u);
+		break;
+	case OID_TYPE_BUFFER:{
+			struct obj_buffer *buff =3D r->ptr;
+			return snprintf(str, PRIV_STR_SIZE,
+					"size=3D%u\naddr=3D0x%X\n", buff->size,
+					buff->addr);
+		}
+		break;
+	case OID_TYPE_BSS:{
+			struct obj_bss *bss =3D r->ptr;
+			return snprintf(str, PRIV_STR_SIZE,
+					"age=3D%u\nchannel=3D%u\n\
+				        capinfo=3D0x%X\nrates=3D0x%X\nbasic_rates=3D0x%X\n", bss->age,=
 bss->channel, bss->capinfo, bss->rates, bss->basic_rates);
+		}
+		break;
+	case OID_TYPE_BSSLIST:{
+			struct obj_bsslist *list =3D r->ptr;
+			int i, k;
+			k =3D snprintf(str, PRIV_STR_SIZE, "nr=3D%u\n", list->nr);
+			for (i =3D 0; i < list->nr; i++)
+				k +=3D snprintf(str + k, PRIV_STR_SIZE - k,
+					      "bss[%u] : \nage=3D%u\nchannel=3D%u\ncapinfo=3D0x%X\nrates=3D0x=
%X\nbasic_rates=3D0x%X\n",
+					      i, list->bsslist[i].age,
+					      list->bsslist[i].channel,
+					      list->bsslist[i].capinfo,
+					      list->bsslist[i].rates,
+					      list->bsslist[i].basic_rates);
+			return k;
+		}
+		break;
+	case OID_TYPE_FREQUENCIES:{
+			struct obj_frequencies *freq =3D r->ptr;
+			int i, t;
+			printk("nr : %u\n", freq->nr);
+			t =3D snprintf(str, PRIV_STR_SIZE, "nr=3D%u\n", freq->nr);
+			for (i =3D 0; i < freq->nr; i++)
+				t +=3D snprintf(str + t, PRIV_STR_SIZE - t,
+					      "mhz[%u]=3D%u\n", i, freq->mhz[i]);
+			return t;
+		}
+		break;
+	case OID_TYPE_MLME:{
+			struct obj_mlme *mlme =3D r->ptr;
+			return snprintf(str, PRIV_STR_SIZE, "id=3D0x%X\nstate=3D0x%X\n\
+			         code=3D0x%X\n", mlme->id, mlme->state,
+					mlme->code);
+		}
+		break;
+	case OID_TYPE_MLMEEX:{
+			struct obj_mlmeex *mlme =3D r->ptr;
+			return snprintf(str, PRIV_STR_SIZE, "id=3D0x%X\nstate=3D0x%X\n\
+			         code=3D0x%X\nsize=3D0x%X\n", mlme->id, mlme->state,
+					mlme->code, mlme->size);
+		}
+		break;
+	case OID_TYPE_SSID:{
+			struct obj_ssid *ssid =3D r->ptr;
+			return snprintf(str, PRIV_STR_SIZE,
+					"length=3D%u\noctets=3D%s\n",
+					ssid->length, ssid->octets);
+		}
+		break;
+	case OID_TYPE_KEY:{
+			struct obj_key *key =3D r->ptr;
+			int t, i;
+			t =3D snprintf(str, PRIV_STR_SIZE,
+				     "type=3D0x%X\nlength=3D0x%X\nkey=3D0x",
+				     key->type, key->length);
+			for (i =3D 0; i < key->length; i++)
+				t +=3D snprintf(str + t, PRIV_STR_SIZE - t,
+					      "%02X:", key->key[i]);
+			t +=3D snprintf(str + t, PRIV_STR_SIZE - t, "\n");
+			return t;
+		}
+		break;
+	case OID_TYPE_RAW:
+	case OID_TYPE_ADDR:{
+			unsigned char *buff =3D r->ptr;
+			int t, i;
+			t =3D snprintf(str, PRIV_STR_SIZE, "hex data=3D");
+			for (i =3D 0; i < isl_oid[n].size; i++)
+				t +=3D snprintf(str + t, PRIV_STR_SIZE - t,
+					      "%02X:", buff[i]);
+			t +=3D snprintf(str + t, PRIV_STR_SIZE - t, "\n");
+			return t;
+		}
+		break;
+	default:
+		BUG();
+	}
+	return 0;
+}
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.h,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -r1.2 -r1.3
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h	30 Jan 2004 16:2=
4:00 -0000	1.2
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.h	18 Mar 2004 11:1=
6:23 -0000	1.3
@@ -32,6 +32,8 @@
=20
 extern const int frequency_list_a[];
=20
+void mgt_le_to_cpu(int, void *);
+
 int mgt_set_request(islpci_private *, enum oid_num_t, int, void *);
=20
 int mgt_get_request(islpci_private *, enum oid_num_t, int, void *,
@@ -47,5 +49,7 @@
=20
 enum oid_num_t mgt_oidtonum(u32 oid);
=20
+int mgt_response_to_str(enum oid_num_t, union oid_res_t *, char *);
+
 #endif				/* !defined(_OID_MGT_H) */
 /* EOF */

--RUvhGz2nhX7DIu1B--

--WxezjuMNsgvRf6mf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbKXat1JN+IKUl4RAkpZAKCmaoIeG1RPCd+zUGVrPcTRbHL4wwCfcNjB
YyvAH33wyeWyjY9FWG+M1b8=
=O8ob
-----END PGP SIGNATURE-----

--WxezjuMNsgvRf6mf--

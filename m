Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264170AbUEXIvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUEXIvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUEXIuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:50:14 -0400
Received: from zeus.kernel.org ([204.152.189.113]:43167 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264166AbUEXIeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:34:00 -0400
Date: Mon, 24 May 2004 04:33:30 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 10/14 linux-2.6.7-rc1] prism54: Don't allow mib reads while unconfigured
Message-ID: <20040524083330.GK3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cGn0fZIJon5R7R2H"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cGn0fZIJon5R7R2H
Content-Type: multipart/mixed; boundary="yQifGgTvVVJcdOYJ"
Content-Disposition: inline


--yQifGgTvVVJcdOYJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-04-17      Aurelien Alleaume <slts@free.fr>

        * oid_mgt.c, isl_ioctl.c : Cleanup. Prevented real oid reading
	before the card is configured with mib values (might be
	related to
	bug #53).

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--yQifGgTvVVJcdOYJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="10-prevent-oid-read-before-config.patch"
Content-Transfer-Encoding: quoted-printable

2004-04-17	Aurelien Alleaume <slts@free.fr>

	* oid_mgt.c, isl_ioctl.c : Cleanup. Prevented real oid reading
	before the card is configured with mib values (might be related to=20
	bug #53).

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v
retrieving revision 1.151
retrieving revision 1.152
diff -u -r1.151 -r1.152
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	9 Apr 2004 11:=
42:25 -0000	1.151
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.c	17 Apr 2004 08=
:46:04 -0000	1.152
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.151 2004/04/09 1=
1:42:25 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.c,v 1.152 2004/04/17 0=
8:46:04 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *            (C) 2003,2004 Aurelien Alleaume <slts@free.fr>
@@ -173,14 +173,6 @@
 	prism54_mib_mode_helper(priv, init_mode);
 }
=20
-void
-prism54_mib_init_work(islpci_private *priv)
-{
-	down_write(&priv->mib_sem);
-	mgt_commit(priv);
-	up_write(&priv->mib_sem);
-}
-
 /* this will be executed outside of atomic context thanks to
  * schedule_work(), thus we can as well use sleeping semaphore
  * locking */
@@ -195,13 +187,6 @@
 	if (down_interruptible(&priv->stats_sem))
 		return;
=20
-/* missing stats are :
- *  iwstatistics.qual.updated
- *  iwstatistics.discard.nwid	   =20
- *  iwstatistics.discard.fragment	   =20
- *  iwstatistics.discard.misc
- *  iwstatistics.miss.beacon */
-
 /* Noise floor.
  * I'm not sure if the unit is dBm.
  * Note : If we are not connected, this value seems to be irrelevant. */
@@ -425,7 +410,6 @@
 	/* by default  the card sets this to 20. */
 	sens =3D vwrq->disabled ? 20 : vwrq->value;
=20
-	/* set the ed threshold. */
 	return mgt_set_request(priv, DOT11_OID_EDTHRESHOLD, 0, &sens);
 }
=20
@@ -534,9 +518,7 @@
 		i++;
 		data++;
 	}
-
 	range->num_bitrates =3D i;
-
 	kfree(r.ptr);
=20
 	return rvalue;
@@ -575,7 +557,6 @@
 	int rvalue;
=20
 	rvalue =3D mgt_get_request(priv, DOT11_OID_BSSID, 0, NULL, &r);
-
 	memcpy(awrq->sa_data, r.ptr, 6);
 	awrq->sa_family =3D ARPHRD_ETHER;
 	kfree(r.ptr);
@@ -685,7 +666,6 @@
 			kfree(buf);
 		}
 	}
-
 	return current_ev;
 }
=20
@@ -712,7 +692,7 @@
=20
 	/* Ask the device for a list of known bss. We can report at most
 	 * IW_MAX_AP=3D64 to the range struct. But the device won't repport anyth=
ing
-	 * if you change the value of MAXBSS=3D24. Anyway 24 AP It is probably en=
ough.
+	 * if you change the value of IWMAX_BSS=3D24.
 	 */
 	rvalue |=3D mgt_get_request(priv, DOT11_OID_BSSLIST, 0, NULL, &r);
 	bsslist =3D r.ptr;
@@ -969,8 +949,6 @@
  * small frame <=3D>  smaller than the rts threshold
  * This is not really the behavior expected by the wireless tool but it se=
ems
  * to be a common behavior in other drivers.
- *=20
- * It seems that playing with this tends to hang the card -> DISABLED
  */
=20
 static int
@@ -1002,18 +980,16 @@
 		lifetime =3D vwrq->value / 1024;
=20
 	/* now set what is requested */
-
-	if (slimit !=3D 0)
+	if (slimit)
 		rvalue =3D
 		    mgt_set_request(priv, DOT11_OID_SHORTRETRIES, 0, &slimit);
-	if (llimit !=3D 0)
+	if (llimit)
 		rvalue |=3D
 		    mgt_set_request(priv, DOT11_OID_LONGRETRIES, 0, &llimit);
-	if (lifetime !=3D 0)
+	if (lifetime)
 		rvalue |=3D
 		    mgt_set_request(priv, DOT11_OID_MAXTXLIFETIME, 0,
 				    &lifetime);
-
 	return rvalue;
 }
=20
@@ -1109,8 +1085,7 @@
 			}
 		}
 	}
-
-	/* now read the flags     */
+	/* now read the flags */
 	if (dwrq->flags & IW_ENCODE_DISABLED) {
 		/* Encoding disabled,=20
 		 * authen =3D DOT11_AUTH_OS;
@@ -1261,11 +1236,6 @@
 prism54_set_u32(struct net_device *ndev, struct iw_request_info *info,
 		__u32 * uwrq, char *extra)
 {
-	/*
-	   u32 *i =3D (int *) extra;
-	   int param =3D *i;
-	   int u =3D *(i + 1);
-	 */
 	u32 oid =3D uwrq[0], u =3D uwrq[1];
=20
 	return mgt_set_request((islpci_private *) ndev->priv, oid, 0, &u);
@@ -1836,9 +1806,7 @@
 				     0);
 		break;
=20
-		/* Note : the following should never happen since we don't run the card =
in
-		 * extended mode.
-		 * Note : "mlme" is actually a "struct obj_mlmeex *" here, but this
+		/* Note : "mlme" is actually a "struct obj_mlmeex *" here, but this
 		 * is backward compatible layout-wise with "struct obj_mlme".
 		 */
=20
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.h,v
retrieving revision 1.31
retrieving revision 1.32
diff -u -r1.31 -r1.32
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.h	18 Mar 2004 05=
:25:24 -0000	1.31
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/isl_ioctl.h	17 Apr 2004 08=
:46:04 -0000	1.32
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.h,v 1.30 2004/01/30 16=
:24:00 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/isl_ioctl.h,v 1.32 2004/04/17 08=
:46:04 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *            (C) 2003 Aurelien Alleaume <slts@free.fr>
@@ -30,7 +30,6 @@
 #define SUPPORTED_WIRELESS_EXT                  16
=20
 void prism54_mib_init(islpci_private *);
-void prism54_mib_init_work(islpci_private *);
=20
 struct iw_statistics *prism54_get_wireless_stats(struct net_device *);
 void prism54_update_stats(islpci_private *);
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v
retrieving revision 1.74
retrieving revision 1.75
diff -u -r1.74 -r1.75
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	7 Apr 2004 04=
:12:12 -0000	1.74
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	17 Apr 2004 0=
8:46:04 -0000	1.75
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.74 2004/04/07 0=
4:12:12 msw Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.75 2004/04/17 0=
8:46:04 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -387,7 +387,9 @@
 	 * the IRQ line until we know for sure the reset went through */
 	isl38xx_enable_common_interrupts(priv->device_base);
=20
-	prism54_mib_init_work(priv);
+	down_write(&priv->mib_sem);
+	mgt_commit(priv);
+	up_write(&priv->mib_sem);
=20
 	islpci_set_state(priv, PRV_STATE_READY);
=20
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v
retrieving revision 1.44
retrieving revision 1.45
diff -u -r1.44 -r1.45
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c	9 Apr 2004 11=
:42:25 -0000	1.44
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_mgt.c	10 Apr 2004 0=
3:16:55 -0000	1.45
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v 1.44 2004/04/09 1=
1:42:25 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_mgt.c,v 1.45 2004/04/10 0=
3:16:55 msw Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright 2004 Jens Maurer <Jens.Maurer@gmx.net>
@@ -312,8 +312,9 @@
 		 * size of a receive buffer.  Thus, if this check
 		 * triggers, we likely have kernel heap corruption. */
 		if (frag_len > MGMT_FRAME_SIZE) {
-			printk(KERN_WARNING "%s: Bogus packet size of %d (%#x).\
-n", ndev->name, frag_len, frag_len);
+			printk(KERN_WARNING
+				"%s: Bogus packet size of %d (%#x).\n",
+				ndev->name, frag_len, frag_len);
 			frag_len =3D MGMT_FRAME_SIZE;
 		}
=20
@@ -487,8 +488,9 @@
 		}
 		if (timeleft =3D=3D 0) {
 			printk(KERN_DEBUG
-			       "%s: timeout waiting for mgmt response %lu, trigging device\n",
-			       ndev->name, timeout_left);
+				"%s: timeout waiting for mgmt response %lu, "
+				"triggering device\n",
+				ndev->name, timeout_left);
 			islpci_trigger(priv);
 		}
 		timeout_left +=3D timeleft - wait_cycle_jiffies;
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/oid_mgt.c,v
retrieving revision 1.14
retrieving revision 1.15
diff -u -r1.14 -r1.15
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	9 Apr 2004 11:42=
:25 -0000	1.14
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/oid_mgt.c	17 Apr 2004 08:4=
6:04 -0000	1.15
@@ -446,7 +446,7 @@
 	if (cache)
 		down_write(&priv->mib_sem);
=20
-	if (islpci_get_state(priv) >=3D PRV_STATE_INIT) {
+	if (islpci_get_state(priv) >=3D PRV_STATE_READY) {
 		ret =3D islpci_mgt_transaction(priv->ndev, PIMFOR_OP_SET, oid,
 					     _data, dlen, &response);
 		if (!ret) {
@@ -500,7 +500,7 @@
 	if (cache)
 		down_read(&priv->mib_sem);
=20
-	if (islpci_get_state(priv) >=3D PRV_STATE_INIT) {
+	if (islpci_get_state(priv) >=3D PRV_STATE_READY) {
 		ret =3D islpci_mgt_transaction(priv->ndev, PIMFOR_OP_GET,
 					     oid, data, dlen, &response);
 		if (ret || !response ||
@@ -539,7 +539,7 @@
 	if (reslen > isl_oid[n].size)
 		printk(KERN_DEBUG
 		       "mgt_get_request(0x%x): received data length was bigger "
-		       "than expected (%d > %d). Memory is probably corrupted... ",
+		       "than expected (%d > %d). Memory is probably corrupted...",
 		       oid, reslen, isl_oid[n].size);
=20
 	return ret;
@@ -622,12 +622,32 @@
 	OID_INL_OUTPUTPOWER,
 };
=20
+/* update the MAC addr. */
+static int
+mgt_update_addr(islpci_private *priv)
+{
+	struct islpci_mgmtframe *res;
+	int ret;
+
+	ret =3D islpci_mgt_transaction(priv->ndev, PIMFOR_OP_GET,
+				     isl_oid[GEN_OID_MACADDRESS].oid, NULL,
+				     isl_oid[GEN_OID_MACADDRESS].size, &res);
+
+	if ((ret =3D=3D 0) && res && (res->header->operation !=3D PIMFOR_OP_ERROR=
))
+		memcpy(priv->ndev->dev_addr, res->data, 6);
+	else
+		ret =3D -EIO;
+	if (res)
+		islpci_mgt_release(res);
+
+	return ret;
+}
+
 void
 mgt_commit(islpci_private *priv)
 {
 	int rvalue;
 	u32 u;
-	union oid_res_t r;
=20
 	if (islpci_get_state(priv) < PRV_STATE_INIT)
 		return;
@@ -643,6 +663,7 @@
=20
 	u =3D OID_INL_MODE;
 	rvalue |=3D mgt_commit_list(priv, &u, 1);
+	rvalue |=3D mgt_update_addr(priv);
=20
 	if (rvalue) {
 		/* some request have failed. The device might be in an
@@ -650,14 +671,6 @@
 		printk(KERN_DEBUG "%s: mgt_commit has failed. Restart the "
 		       "device \n", priv->ndev->name);
 	}
-
-	/* update the MAC addr. As it's not cached, no lock will be acquired by
-	 * the mgt_get_request
-	 */
-	mgt_get_request(priv, GEN_OID_MACADDRESS, 0, NULL, &r);
-	memcpy(priv->ndev->dev_addr, r.ptr, 6);
-	kfree(r.ptr);
-
 }
=20
 /* This will tell you if you are allowed to answer a mlme(ex) request .*/
@@ -710,8 +723,11 @@
 	case OID_TYPE_BSS:{
 			struct obj_bss *bss =3D r->ptr;
 			return snprintf(str, PRIV_STR_SIZE,
-					"age=3D%u\nchannel=3D%u\n\
-				        capinfo=3D0x%X\nrates=3D0x%X\nbasic_rates=3D0x%X\n", bss->age,=
 bss->channel, bss->capinfo, bss->rates, bss->basic_rates);
+					"age=3D%u\nchannel=3D%u\n"
+					"capinfo=3D0x%X\nrates=3D0x%X\n"
+					"basic_rates=3D0x%X\n", bss->age,
+					bss->channel, bss->capinfo,
+					bss->rates, bss->basic_rates);
 		}
 		break;
 	case OID_TYPE_BSSLIST:{
@@ -720,7 +736,9 @@
 			k =3D snprintf(str, PRIV_STR_SIZE, "nr=3D%u\n", list->nr);
 			for (i =3D 0; i < list->nr; i++)
 				k +=3D snprintf(str + k, PRIV_STR_SIZE - k,
-					      "bss[%u] : \nage=3D%u\nchannel=3D%u\ncapinfo=3D0x%X\nrates=3D0x=
%X\nbasic_rates=3D0x%X\n",
+					      "bss[%u] : \nage=3D%u\nchannel=3D%u\n"
+					      "capinfo=3D0x%X\nrates=3D0x%X\n"
+					      "basic_rates=3D0x%X\n",
 					      i, list->bsslist[i].age,
 					      list->bsslist[i].channel,
 					      list->bsslist[i].capinfo,
@@ -742,16 +760,17 @@
 		break;
 	case OID_TYPE_MLME:{
 			struct obj_mlme *mlme =3D r->ptr;
-			return snprintf(str, PRIV_STR_SIZE, "id=3D0x%X\nstate=3D0x%X\n\
-			         code=3D0x%X\n", mlme->id, mlme->state,
-					mlme->code);
+			return snprintf(str, PRIV_STR_SIZE,
+					"id=3D0x%X\nstate=3D0x%X\ncode=3D0x%X\n",
+					mlme->id, mlme->state, mlme->code);
 		}
 		break;
 	case OID_TYPE_MLMEEX:{
 			struct obj_mlmeex *mlme =3D r->ptr;
-			return snprintf(str, PRIV_STR_SIZE, "id=3D0x%X\nstate=3D0x%X\n\
-			         code=3D0x%X\nsize=3D0x%X\n", mlme->id, mlme->state,
-					mlme->code, mlme->size);
+			return snprintf(str, PRIV_STR_SIZE,
+					"id=3D0x%X\nstate=3D0x%X\n"
+					"code=3D0x%X\nsize=3D0x%X\n", mlme->id,
+					mlme->state, mlme->code, mlme->size);
 		}
 		break;
 	case OID_TYPE_SSID:{
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/prismcompat24.h,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h	20 Mar 200=
4 18:23:28 -0000	1.1
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/prismcompat24.h	13 Apr 200=
4 08:20:13 -0000	1.2
@@ -27,20 +27,25 @@
 #include <linux/config.h>
 #include <linux/tqueue.h>
=20
-#define work_struct		tq_struct
-#define INIT_WORK		INIT_TQUEUE
-#define schedule_work		schedule_task
-
-#define irqreturn_t		void
-#define IRQ_HANDLED
-#define IRQ_NONE
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,25)
+#define module_param(x, y, z)	MODULE_PARM(x, "i")
+#else
+#include <linux/moduleparam.h>
+#endif
=20
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
 #define free_netdev(x)		kfree(x)
 #define pci_name(x)		x->slot_name
+#define irqreturn_t		void
+#define IRQ_HANDLED
+#define IRQ_NONE
+#else
+#include <linux/interrupt.h>
 #endif
=20
-#define module_param(x, y, z)	MODULE_PARM(x, "i")
+#define work_struct		tq_struct
+#define INIT_WORK		INIT_TQUEUE
+#define schedule_work		schedule_task
=20
 #define netdev_priv(x)		x->priv
=20

--yQifGgTvVVJcdOYJ--

--cGn0fZIJon5R7R2H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbNaat1JN+IKUl4RAmYgAJ9lElz3VPsY3qRvJlVTIo9AyreENACfXoTc
Exnhw03PYFJcxGzvK20JIts=
=ClAE
-----END PGP SIGNATURE-----

--cGn0fZIJon5R7R2H--

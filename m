Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264151AbUEXIgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbUEXIgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUEXIgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:36:23 -0400
Received: from zeus.kernel.org ([204.152.189.113]:26526 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264151AbUEXIa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:30:56 -0400
Date: Mon, 24 May 2004 04:30:28 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 2/14] prism54: reset card on tx_timeout
Message-ID: <20040524083028.GC3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nM4qzG6nHdnn/sXd"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nM4qzG6nHdnn/sXd
Content-Type: multipart/mixed; boundary="GD+uNaHYxbVPHaQt"
Content-Disposition: inline


--GD+uNaHYxbVPHaQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


2004-03-18      Aurelien Alleaume <slts@free.fr>

* islpci_eth.[c,h] islpci_dev.[c,h] : reset card on tx_timeout.
  Patch submited by Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--GD+uNaHYxbVPHaQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02-reset_card_on_tx_timeout.patch"
Content-Transfer-Encoding: quoted-printable

2004-03-18	Aurelien Alleaume <slts@free.fr>
=20
	* islpci_eth.[c,h] islpci_dev.[c,h] : reset card on tx_timeout. Patch
	submited by Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>

Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v
retrieving revision 1.70
retrieving revision 1.71
diff -u -r1.70 -r1.71
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	18 Mar 2004 0=
5:25:24 -0000	1.70
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.c	18 Mar 2004 1=
1:44:17 -0000	1.71
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.68 2004/02/28 0=
3:06:07 mcgrof Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.c,v 1.71 2004/03/18 1=
1:44:17 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -743,9 +743,11 @@
 	/* initialize workqueue's */
 	INIT_WORK(&priv->stats_work,
 		  (void (*)(void *)) prism54_update_stats, priv);
-
 	priv->stats_timestamp =3D 0;
=20
+	INIT_WORK(&priv->reset_task, islpci_do_reset_and_wake, priv);
+	priv->reset_task_pending =3D 0;
+
 	/* allocate various memory areas */
 	if (islpci_alloc_memory(priv))
 		goto do_free_netdev;
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v
retrieving revision 1.55
retrieving revision 1.56
diff -u -r1.55 -r1.56
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	18 Mar 2004 1=
1:16:23 -0000	1.55
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_dev.h	18 Mar 2004 1=
1:44:17 -0000	1.56
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.55 2004/03/18 1=
1:16:23 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_dev.h,v 1.56 2004/03/18 1=
1:44:17 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.=20
  *  Copyright (C) 2003 Herbert Valerio Riedel <hvr@gnu.org>
@@ -188,6 +188,9 @@
 	struct list_head bss_wpa_list;
 	int num_bss_wpa;
 	struct semaphore wpa_sem;
+
+	struct work_struct reset_task;
+	int reset_task_pending;
 } islpci_private;
=20
 static inline islpci_state_t
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v
retrieving revision 1.29
retrieving revision 1.30
diff -u -r1.29 -r1.30
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 2004 0=
5:25:24 -0000	1.29
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 2004 1=
1:44:17 -0000	1.30
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.27 2004/01/30 1=
6:24:00 ajfa Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.30 2004/03/18 1=
1:44:17 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *
@@ -319,17 +319,9 @@
 		/* The card reports full 802.11 packets but with a 20 bytes
 		 * header and without the FCS. But there a is a bit that
 		 * indicates if the packet is corrupted :-) */
-		/* int i; */
-		if (skb->data[8] & 0x01){
+		if (skb->data[8] & 0x01)
 			/* This one is bad. Drop it !*/
 			discard =3D 1;
-			/* printk("BAD\n");*/
-		}
-		/*
-		for(i=3D0;i<50;i++)
-			printk("%2.2X:",skb->data[i]);
-		printk("\n");
-		*/	=09
 		skb_pull(skb, 20);
 		skb->protocol =3D htons(ETH_P_802_2);
 		skb->mac.raw =3D skb->data;
@@ -413,6 +405,15 @@
 	return 0;
 }
=20
+void=20
+islpci_do_reset_and_wake(void *data)
+{
+       islpci_private *priv =3D (islpci_private *) data;
+       islpci_reset(priv, 1);
+       netif_wake_queue(priv->ndev);
+       priv->reset_task_pending =3D 0;
+}
+
 void
 islpci_eth_tx_timeout(struct net_device *ndev)
 {
@@ -422,13 +423,11 @@
 	/* increment the transmit error counter */
 	statistics->tx_errors++;
=20
-#if 0
-	/* don't do this here! we are not allowed to sleep since we are in interr=
upt context */
-	if (islpci_reset(priv))
-		printk(KERN_ERR "%s: error on TX timeout card reset!\n",
-		       ndev->name);
-#endif
+	if(!priv->reset_task_pending) {
+		priv->reset_task_pending =3D 1;
+		netif_stop_queue(ndev);
+		schedule_work(&priv->reset_task);
+	}
=20
-	/* netif_wake_queue(ndev); */
 	return;
 }
Index: linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.h,v
retrieving revision 1.5
retrieving revision 1.6
diff -u -r1.5 -r1.6
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.h	12 Jan 2004 2=
2:16:32 -0000	1.5
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.h	18 Mar 2004 1=
1:44:17 -0000	1.6
@@ -1,4 +1,4 @@
-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.h,v 1.5 2004/01/12 22=
:16:32 jmaurer Exp $
+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.h,v 1.6 2004/03/18 11=
:44:17 ajfa Exp $
  * =20
  *  Copyright (C) 2002 Intersil Americas Inc.
  *
@@ -27,5 +27,6 @@
 int islpci_eth_transmit(struct sk_buff *, struct net_device *);
 int islpci_eth_receive(islpci_private *);
 void islpci_eth_tx_timeout(struct net_device *);
+void islpci_do_reset_and_wake(void *data);
=20
 #endif				/* _ISL_GEN_H */

--GD+uNaHYxbVPHaQt--

--nM4qzG6nHdnn/sXd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbKkat1JN+IKUl4RAnD6AJsFJHuYI518d6eM0lex2kOCq5Cl/ACfQOsS
MQZaNRzTSFiiqk4S/wtu7uA=
=3qp6
-----END PGP SIGNATURE-----

--nM4qzG6nHdnn/sXd--

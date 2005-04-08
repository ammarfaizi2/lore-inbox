Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVDHKVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVDHKVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVDHKVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:21:19 -0400
Received: from dea.vocord.ru ([217.67.177.50]:437 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262784AbVDHKTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:19:24 -0400
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jay Lan <jlan@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
In-Reply-To: <4255B868.6040600@engr.sgi.com>
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>
	 <20050331144428.7bbb4b32.akpm@osdl.org>  <424C9177.1070404@engr.sgi.com>
	 <1112341968.9334.109.camel@uganda> <4255B6D2.7050102@engr.sgi.com>
	 <4255B868.6040600@engr.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+cMe4kG4/bmeB2JwPTE8"
Organization: MIPT
Date: Fri, 08 Apr 2005 14:24:00 +0400
Message-Id: <1112955840.28858.236.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 14:17:22 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+cMe4kG4/bmeB2JwPTE8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 15:47 -0700, Jay Lan wrote:
> BTW, when it happened last time, my program listening to the socket
> complained about duplicate messages received.
>=20
>     Unmatched seq. Rcvd=3D1824062, expected=3D1824061   <=3D=3D=3D
>     Unmatched seq. Rcvd=3D1824062, expected=3D1824063   <=3D=3D=3D
>     Unmatched seq. Rcvd=3D1824348, expected=3D1824307
>=20
> When my program received 1824062 while expecting 1824061
> it adjusted itself to expect the next one being 1824063. But instead
> the message of 1824062 arrived the second time.

Thank you for your report.

Could you reproduce a bug with the attached patch?

>     - jay


* looking for johnpol@2ka.mipt.ru-2004/connector--main--0--patch-38 to comp=
are with
* comparing to johnpol@2ka.mipt.ru-2004/connector--main--0--patch-38
M  connector.c

* modified files

--- orig/drivers/connector/connector.c
+++ mod/drivers/connector/connector.c
@@ -121,7 +121,7 @@
 	NETLINK_CB(skb).dst_groups =3D groups;
=20
 	uskb =3D skb_clone(skb, GFP_ATOMIC);
-	if (uskb)
+	if (uskb && 0)
 		netlink_unicast(dev->nls, uskb, 0, 0);
 =09
 	netlink_broadcast(dev->nls, skb, 0, groups, GFP_ATOMIC);
@@ -158,7 +158,7 @@
 	}
 	spin_unlock_bh(&dev->cbdev->queue_lock);
=20
-	return found;
+	return (found)?0:-ENODEV;
 }
=20
 /*
@@ -181,7 +181,6 @@
 				"requested msg->len=3D%u[%u], nlh->nlmsg_len=3D%u, skb->len=3D%u.\n",
 				msg->len, NLMSG_SPACE(msg->len + sizeof(*msg)),
 				nlh->nlmsg_len, skb->len);
-		kfree_skb(skb);
 		return -EINVAL;
 	}
 #if 0
@@ -215,17 +214,18 @@
 	       skb->len, skb->data_len, skb->truesize, skb->protocol,
 	       skb_cloned(skb), skb_shared(skb));
 #endif
-	while (skb->len >=3D NLMSG_SPACE(0)) {
+	if (skb->len >=3D NLMSG_SPACE(0)) {
 		nlh =3D (struct nlmsghdr *)skb->data;
+
 		if (nlh->nlmsg_len < sizeof(struct cn_msg) ||
 		    skb->len < nlh->nlmsg_len ||
 		    nlh->nlmsg_len > CONNECTOR_MAX_MSG_SIZE) {
-#if 0
+#if 1
 			printk(KERN_INFO "nlmsg_len=3D%u, sizeof(*nlh)=3D%u\n",
 			       nlh->nlmsg_len, sizeof(*nlh));
 #endif
 			kfree_skb(skb);
-			break;
+			goto out;
 		}
=20
 		len =3D NLMSG_ALIGN(nlh->nlmsg_len);
@@ -233,22 +233,11 @@
 			len =3D skb->len;
=20
 		err =3D __cn_rx_skb(skb, nlh);
-		if (err) {
-#if 0
-			if (err < 0 && (nlh->nlmsg_flags & NLM_F_ACK))
-				netlink_ack(skb, nlh, -err);
-#endif
-			break;
-		} else {
-#if 0
-			if (nlh->nlmsg_flags & NLM_F_ACK)
-				netlink_ack(skb, nlh, 0);
-#endif
-			break;
-		}
-		skb_pull(skb, len);
+		if (err < 0)
+			kfree_skb(skb);
 	}
-		=09
+
+out:
 	kfree_skb(__skb);
 }
=20





--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-+cMe4kG4/bmeB2JwPTE8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVlvAIKTPhE+8wY0RAkGUAJ0RiELOuHIMLWN+aVM+broVXDKeNQCcCijC
Ggs3CtX7+vpNgvmc9I3dLgw=
=0ZW1
-----END PGP SIGNATURE-----

--=-+cMe4kG4/bmeB2JwPTE8--


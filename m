Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVDHKrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVDHKrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVDHKrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:47:52 -0400
Received: from dea.vocord.ru ([217.67.177.50]:43198 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262694AbVDHKrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:47:24 -0400
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jay Lan <jlan@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
In-Reply-To: <1112955840.28858.236.camel@uganda>
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>
	 <20050331144428.7bbb4b32.akpm@osdl.org>  <424C9177.1070404@engr.sgi.com>
	 <1112341968.9334.109.camel@uganda> <4255B6D2.7050102@engr.sgi.com>
	 <4255B868.6040600@engr.sgi.com>  <1112955840.28858.236.camel@uganda>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Cno0kqshTrNhzOc99HvP"
Organization: MIPT
Date: Fri, 08 Apr 2005 14:52:43 +0400
Message-Id: <1112957563.28858.240.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 14:45:58 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Cno0kqshTrNhzOc99HvP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Could you give attached patch a try instead of previous one.
It adds gfp mask into cn_netlink_send() call also.
If you need updated CBUS sources, feel free to ask,=20
I will send updated sources with Andrew's comments resolved too.

I do not know exactly your connector version,=20
so patch will probably be applied with fuzz.

feel free to contact if it does not apply, I will send
the whole sources.

Thank you.

* looking for johnpol@2ka.mipt.ru-2004/connector--main--0--patch-38 to comp=
are with
* comparing to johnpol@2ka.mipt.ru-2004/connector--main--0--patch-38
M  connector.c
M  connector.h
M  cbus.c

* modified files

--- orig/drivers/connector/connector.c
+++ mod/drivers/connector/connector.c
@@ -70,7 +70,7 @@
  * then it is new message.
  *
  */
-void cn_netlink_send(struct cn_msg *msg, u32 __groups)
+void cn_netlink_send(struct cn_msg *msg, u32 __groups, int gfp_mask)
 {
 	struct cn_callback_entry *n, *__cbq;
 	unsigned int size;
@@ -102,7 +102,7 @@
=20
 	size =3D NLMSG_SPACE(sizeof(*msg) + msg->len);
=20
-	skb =3D alloc_skb(size, GFP_ATOMIC);
+	skb =3D alloc_skb(size, gfp_mask);
 	if (!skb) {
 		printk(KERN_ERR "Failed to allocate new skb with size=3D%u.\n", size);
 		return;
@@ -119,11 +119,11 @@
 #endif
 =09
 	NETLINK_CB(skb).dst_groups =3D groups;
-
-	uskb =3D skb_clone(skb, GFP_ATOMIC);
-	if (uskb)
+#if 0
+	uskb =3D skb_clone(skb, gfp_mask);
+	if (uskb && 0)
 		netlink_unicast(dev->nls, uskb, 0, 0);
-=09
+#endif=09
 	netlink_broadcast(dev->nls, skb, 0, groups, GFP_ATOMIC);
=20
 	return;
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
@@ -310,7 +299,7 @@
 			m.ack =3D notify_event;
=20
 			memcpy(&m.id, id, sizeof(m.id));
-			cn_netlink_send(&m, ctl->group);
+			cn_netlink_send(&m, ctl->group, GFP_ATOMIC);
 		}
 	}
 	spin_unlock_bh(&notify_lock);


--- orig/include/linux/connector.h
+++ mod/include/linux/connector.h
@@ -148,7 +148,7 @@
=20
 int cn_add_callback(struct cb_id *, char *, void (* callback)(void *));
 void cn_del_callback(struct cb_id *);
-void cn_netlink_send(struct cn_msg *, u32);
+void cn_netlink_send(struct cn_msg *, u32, int);
=20
 int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb=
);
 void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id);





--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Cno0kqshTrNhzOc99HvP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVmJ7IKTPhE+8wY0RAjhvAJ0eQgSpxXDOiNNaMtF+ETmdyUCXFQCePqQZ
wzHw4cXuZ0L6kufX1ZJN4QA=
=ii2H
-----END PGP SIGNATURE-----

--=-Cno0kqshTrNhzOc99HvP--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWCXQYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWCXQYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWCXQYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:24:11 -0500
Received: from ms-smtp-04-lbl.southeast.rr.com ([24.25.9.103]:40387 "EHLO
	ms-smtp-04-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S932135AbWCXQYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:24:10 -0500
Date: Fri, 24 Mar 2006 11:24:03 -0500
From: Brian Weaver <weave@spellweaver.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]: Add support for rx packet consumption by a network tap
Message-ID: <20060324162402.GD5996@mail.spellweaver.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is my first attempt doing any serious modifications to the Linux
kernel. Feedback is welcome.

I work for a company that does a lot of packet captures using Linux on a
device with multiple ethernet interfaces. The normal configuration has
one device that is configured with an actual IP address, the remaining
interfaces are setup in promiscious mode without any IP bindings.

In order to minimize the amount of time the kernel spends processing
packets on the "listening" interfaces I've written a patch that allows a
userspace program to direct the kernel to prevent the protocol handlers
=66rom seeing packets that a network tap has "consumed."

The attached patch is against the 2.6.16 series, and I have one for the
2.4 series if anyone would like a copy.

-Brian

----

    [PATCH]: Add support for rx packet consumption by a network tap
   =20
        Many systems are configured with multiple network interfaces, howev=
er
        there are times when one or more adapter is designated solely for
        capturing packets. This is often the case with Intrusion Detection
        System (IDS) and other network security applications.
   =20
        These systems need to capture packets as quickly as possible and
        minimize the time the kernel spends processing the packets in the
        protocol modules like IP, IPX, etc.
   =20
        This patch provides a way for a network tap (e.g. packet socket) to
        notify the kernel that the packet was "consumed" and shouldn't be
        passed to the specific network protocol handlers.

diff --git a/include/linux/if_packet.h b/include/linux/if_packet.h
index b925585..59e8b13 100644
--- a/include/linux/if_packet.h
+++ b/include/linux/if_packet.h
@@ -39,6 +39,7 @@ struct sockaddr_ll
 #define PACKET_RX_RING			5
 #define PACKET_STATISTICS		6
 #define PACKET_COPY_THRESH		7
+#define PACKET_RX_CONSUME		8
=20
 struct tpacket_stats
 {
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7fda03d..44eb88d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -60,12 +60,13 @@ struct netpoll_info;
 					   returns this as NET_XMIT_SUCCESS) */
=20
 /* Backlog congestion levels */
-#define NET_RX_SUCCESS		0   /* keep 'em coming, baby */
+#define NET_RX_SUCCESS		0  /* keep 'em coming, baby */
 #define NET_RX_DROP		1  /* packet dropped */
-#define NET_RX_CN_LOW		2   /* storm alert, just in case */
-#define NET_RX_CN_MOD		3   /* Storm on its way! */
-#define NET_RX_CN_HIGH		4   /* The storm is here */
+#define NET_RX_CN_LOW		2  /* storm alert, just in case */
+#define NET_RX_CN_MOD		3  /* Storm on its way! */
+#define NET_RX_CN_HIGH		4  /* The storm is here */
 #define NET_RX_BAD		5  /* packet dropped due to kernel error */
+#define NET_RX_CONSUMED        16  /* packet consumed by network tap */
=20
 #define net_xmit_errno(e)	((e) !=3D NET_XMIT_CN ? -ENOBUFS : 0)
=20
diff --git a/net/core/dev.c b/net/core/dev.c
index 2afb0de..c1b59bb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -305,6 +305,7 @@ void __dev_remove_pack(struct packet_typ
 out:
 	spin_unlock_bh(&ptype_lock);
 }
+
 /**
  *	dev_remove_pack	 - remove packet handler
  *	@pt: packet type declaration
@@ -1525,11 +1526,6 @@ static __inline__ int handle_bridge(stru
 	    (port =3D rcu_dereference((*pskb)->dev->br_port)) =3D=3D NULL)
 		return 0;
=20
-	if (*pt_prev) {
-		*ret =3D deliver_skb(*pskb, *pt_prev, orig_dev);
-		*pt_prev =3D NULL;
-	}=20
-=09
 	return br_handle_frame_hook(port, pskb);
 }
 #else
@@ -1580,6 +1576,7 @@ int netif_receive_skb(struct sk_buff *sk
 	struct net_device *orig_dev;
 	int ret =3D NET_RX_DROP;
 	unsigned short type;
+	int consumed =3D NET_RX_SUCCESS; 	/* consumed by network tap? NET_RX_SUCC=
ESS =3D 0 */
=20
 	/* if we've gotten here through NAPI, check netpoll */
 	if (skb->dev->poll && netpoll_rx(skb))
@@ -1611,16 +1608,16 @@ int netif_receive_skb(struct sk_buff *sk
=20
 	list_for_each_entry_rcu(ptype, &ptype_all, list) {
 		if (!ptype->dev || ptype->dev =3D=3D skb->dev) {
-			if (pt_prev)=20
-				ret =3D deliver_skb(skb, pt_prev, orig_dev);
+			if (pt_prev)
+				consumed |=3D (ret =3D deliver_skb(skb, pt_prev, orig_dev));
 			pt_prev =3D ptype;
 		}
 	}
=20
 #ifdef CONFIG_NET_CLS_ACT
 	if (pt_prev) {
-		ret =3D deliver_skb(skb, pt_prev, orig_dev);
-		pt_prev =3D NULL; /* noone else should process this after*/
+		consumed |=3D (ret =3D deliver_skb(skb, pt_prev, orig_dev));
+		pt_prev =3D NULL; /* no one else should process this after*/
 	} else {
 		skb->tc_verd =3D SET_TC_OK2MUNGE(skb->tc_verd);
 	}
@@ -1634,6 +1631,11 @@ int netif_receive_skb(struct sk_buff *sk
=20
 	skb->tc_verd =3D 0;
 ncls:
+#else
+	if(pt_prev) {
+		consumed |=3D (ret =3D deliver_skb(skb, pt_prev, orig_dev));
+		pt_prev =3D NULL; /* prevent double processing after checking for consum=
ption */
+	}
 #endif
=20
 	handle_diverter(skb);
@@ -1641,13 +1643,15 @@ ncls:
 	if (handle_bridge(&skb, &pt_prev, &ret, orig_dev))
 		goto out;
=20
-	type =3D skb->protocol;
-	list_for_each_entry_rcu(ptype, &ptype_base[ntohs(type)&15], list) {
-		if (ptype->type =3D=3D type &&
-		    (!ptype->dev || ptype->dev =3D=3D skb->dev)) {
-			if (pt_prev)=20
-				ret =3D deliver_skb(skb, pt_prev, orig_dev);
-			pt_prev =3D ptype;
+	if(likely(!(consumed & NET_RX_CONSUMED))) {
+		type =3D skb->protocol;
+		list_for_each_entry_rcu(ptype, &ptype_base[ntohs(type)&15], list) {
+			if (ptype->type =3D=3D type &&
+			    (!ptype->dev || ptype->dev =3D=3D skb->dev)) {
+				if (pt_prev)=20
+					ret =3D deliver_skb(skb, pt_prev, orig_dev);
+				pt_prev =3D ptype;
+			}
 		}
 	}
=20
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 9db7dbd..918137f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -212,6 +212,7 @@ struct packet_sock {
 	unsigned int		pg_vec_pages;
 	unsigned int		pg_vec_len;
 #endif
+	int			consume;	/* consume RX packets */
 };
=20
 #ifdef CONFIG_PACKET_MMAP
@@ -544,7 +545,7 @@ static int packet_rcv(struct sk_buff *sk
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	spin_unlock(&sk->sk_receive_queue.lock);
 	sk->sk_data_ready(sk, skb->len);
-	return 0;
+	return (po->consume ? NET_RX_CONSUMED : 0);
=20
 drop_n_acct:
 	spin_lock(&sk->sk_receive_queue.lock);
@@ -574,6 +575,7 @@ static int tpacket_rcv(struct sk_buff *s
 	unsigned long status =3D TP_STATUS_LOSING|TP_STATUS_USER;
 	unsigned short macoff, netoff;
 	struct sk_buff *copy_skb =3D NULL;
+	int eatskb =3D 0;
=20
 	if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
 		goto drop;
@@ -684,6 +686,7 @@ static int tpacket_rcv(struct sk_buff *s
 	}
=20
 	sk->sk_data_ready(sk, 0);
+	eatskb =3D (po->consume ? NET_RX_CONSUMED : 0);
=20
 drop_n_restore:
 	if (skb_head !=3D skb->data && skb_shared(skb)) {
@@ -692,7 +695,7 @@ drop_n_restore:
 	}
 drop:
         kfree_skb(skb);
-	return 0;
+	return eatskb;
=20
 ring_is_full:
 	po->stats.tp_drops++;
@@ -1377,6 +1380,18 @@ packet_setsockopt(struct socket *sock, i
 		return 0;
 	}
 #endif
+	case PACKET_RX_CONSUME:
+	{
+		int val;
+
+		if(optlen !=3D sizeof(val))
+			return -EINVAL;
+		if(copy_from_user(&val, optval, sizeof(val)))
+			return -EFAULT;
+
+		pkt_sk(sk)->consume =3D val;
+		return 0;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -1415,6 +1430,19 @@ static int packet_getsockopt(struct sock
 			return -EFAULT;
 		break;
 	}
+	case PACKET_RX_CONSUME:
+	{
+		int val;
+		int __user *dst =3D (int __user *)optval;
+
+		if(len < sizeof(val))
+			return -EINVAL;
+		if(put_user(po->consume,dst))
+			return -EFAULT;
+
+		len =3D sizeof(val);
+		break;
+	}
 	default:
 		return -ENOPROTOOPT;
 	}


--=20

/* insert witty signature here */

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEJB0ivoRcrx1Yhm4RAuYZAJ9ZEjtM8QB3blOdGN8uj9OsBkYXcwCdE7GX
487hqU0Xy6L/1Jv/ynhcB3w=
=CDre
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

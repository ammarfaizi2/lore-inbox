Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTDSJfv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 05:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTDSJfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 05:35:51 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:61122 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263369AbTDSJfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 05:35:46 -0400
Date: Sat, 19 Apr 2003 12:44:45 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andy Chou <acc@CS.Stanford.EDU>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 6 memory leaks
Message-ID: <20030419094445.GA7283@actcom.co.il>
References: <20030419025025.GA32656@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20030419025025.GA32656@Xenon.Stanford.EDU>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2003 at 07:50:25PM -0700, Andy Chou wrote:
> The following memory leaks were found by static analysis using the MC
> system (aka "Stanford Checker").  This is only an incremental list of new
> bugs found by an updated version of the memory leak checker.  I checked
> the ipv4 and ipv6 bugs and they are still in 2.5.67.
>=20
> Confirmation/rejection would be appreciated for any of these bugs.
>=20
> -Andy

> ---------------------------------------------------------
> [BUG]=20
> /u1/acc/linux/2.5.48/net/ipv4/netfilter/ip_queue.c:321:ipq_enqueue_packet=
: ERROR:LEAK:296:321:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/=
ipv4/netfilter/ip_queue.c:296:ipq_build_packet_message]
>=20
> 		entry->rt_info.tos =3D iph->tos;
> 		entry->rt_info.daddr =3D iph->daddr;
> 		entry->rt_info.saddr =3D iph->saddr;
> 	}
>=20
> Start --->
> 	nskb =3D ipq_build_packet_message(entry, &status);

This one appears to be a leak. Patch attached.=20

> static int
> ---------------------------------------------------------
> [BUG]=20
> /u1/acc/linux/2.5.48/net/ipv6/netfilter/ip6_queue.c:326:ipq_enqueue_packe=
t: ERROR:LEAK:301:326:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net=
/ipv6/netfilter/ip6_queue.c:301:ipq_build_packet_message]
>=20
>=20
> 		entry->rt_info.daddr =3D iph->daddr;
> 		entry->rt_info.saddr =3D iph->saddr;
> 	}

This one appears to be exactly the same as the previous one, except
the line number is different. Does that mean the checker things there
are two leaks in this piece of code?=20

> ---------------------------------------------------------
> [BUG]=20
> /u1/acc/linux/2.5.48/net/irda/irttp.c:266:irttp_reassemble_skb: ERROR:LEA=
K:242:266:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/irda/irttp.=
c:242:dev_alloc_skb]
>=20
> 	ASSERT(self->magic =3D=3D TTP_TSAP_MAGIC, return NULL;);
>=20
> 	IRDA_DEBUG(2, "%s(), self->rx_sdu_size=3D%d\n", __FUNCTION__,
> 		   self->rx_sdu_size);
>=20
> Start --->
> 	skb =3D dev_alloc_skb(TTP_HEADER + self->rx_sdu_size);
>=20
> 	... DELETED 18 lines ...
>=20
> 	}
> 	IRDA_DEBUG(2, "%s(), frame len=3D%d\n",  __FUNCTION__, n);
>=20
> 	IRDA_DEBUG(2, "%s(), rx_sdu_size=3D%d\n",  __FUNCTION__,
> 		   self->rx_sdu_size);
> Error --->
> 	ASSERT(n <=3D self->rx_sdu_size, return NULL;);

This one appears to be a leak. Patch attached (not compiled - file
does not compile currently).=20

> /u1/acc/linux/2.5.48/drivers/isdn/tpam/tpam_queues.c:150:tpam_irq: ERROR:=
LEAK:112:150:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/isdn=
/tpam/tpam_queues.c:112:alloc_skb]
>=20
> 	=09
> 		/* get the beginning of the message (pci_mpb part) */
> 		copy_from_pam(card, &mpb, (void *)uploadptr, sizeof(pci_mpb));
>=20
> 		/* allocate the sk_buff */
> Start --->
> 		if (!(skb =3D alloc_skb(sizeof(skb_header) + sizeof(pci_mpb) +=20
>=20
> 	... DELETED 32 lines ...
>=20
> 			hpic =3D readl(card->bar0 + TPAM_HPIC_REGISTER);
> 			if (waiting_too_long++ > 0xfffffff) {
> 				spin_unlock(&card->lock);
> 				printk(KERN_ERR "TurboPAM(tpam_irq): "
> 						"waiting too long...\n");
> Error --->

This one appears to be a leak, patch attached. Not compiled either,
the old ISDN4Linux does not compile.=20

> ---------------------------------------------------------
> [BUG]
> /u1/acc/linux/2.5.48/drivers/net/wan/sdla_ppp.c:1921:rx_intr: ERROR:LEAK:=
1830:1921:Memory leak [Allocated from: /u1/acc/linux/2.5.48/drivers/net/wan=
/sdla_ppp.c:1830:dev_alloc_skb]
>=20
> =09
> 		len  =3D rxbuf->length;
> 		ppp_priv_area =3D dev->priv;
>=20
> 		/* Allocate socket buffer */
> Start --->
> 		skb =3D dev_alloc_skb(len);
>=20
> 	... DELETED 85 lines ...
>=20
> 	/* Release buffer element and calculate a pointer to the next one */
> 	rxbuf->flag =3D 0x00;
> 	card->rxmb =3D ++rxbuf;
> 	if ((void*)rxbuf > card->u.p.rxbuf_last)
> 		card->rxmb =3D card->u.p.rxbuf_base;
> Error --->
> }

This one appears to be a leak. Patch attached.=20

> ---------------------------------------------------------
> [BUG]
> /u1/acc/linux/2.5.48/net/ax25/af_ax25.c:1294:ax25_connect: ERROR:LEAK:116=
8:1294:Memory leak [Allocated from: /u1/acc/linux/2.5.48/net/ax25/af_ax25.c=
:1168:kmalloc]
>=20
> 		if (fsa->fsa_ax25.sax25_ndigis < 1 || fsa->fsa_ax25.sax25_ndigis > AX25=
_MAX_DIGIS) {
> 			err =3D -EINVAL;
> 			goto out;
> 		}
>=20
> Start --->
> 		if ((digi =3D kmalloc(sizeof(ax25_digi), GFP_KERNEL)) =3D=3D NULL) {
>=20
> 	... DELETED 120 lines ...
>=20
> 	sock->state =3D SS_CONNECTED;
>=20
> out:
> 	release_sock(sk);
>=20
> Error --->

This one appears to be a leak, patch attached.=20

Index: drivers/isdn/tpam/tpam_queues.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/drivers/isdn/tpam/tpam_queues.c,v
retrieving revision 1.4
diff -u -r1.4 tpam_queues.c
--- drivers/isdn/tpam/tpam_queues.c	2 Oct 2002 01:32:32 -0000	1.4
+++ drivers/isdn/tpam/tpam_queues.c	19 Apr 2003 08:49:49 -0000
@@ -144,6 +144,7 @@
 		do {
 			hpic =3D readl(card->bar0 + TPAM_HPIC_REGISTER);
 			if (waiting_too_long++ > 0xfffffff) {
+				kfree_skb(skb);=20
 				spin_unlock(&card->lock);
 				printk(KERN_ERR "TurboPAM(tpam_irq): "
 						"waiting too long...\n");
Index: drivers/net/wan/sdla_ppp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/drivers/net/wan/sdla_ppp.c,v
retrieving revision 1.23
diff -u -r1.23 sdla_ppp.c
--- drivers/net/wan/sdla_ppp.c	7 Mar 2003 15:39:16 -0000	1.23
+++ drivers/net/wan/sdla_ppp.c	19 Apr 2003 08:49:52 -0000
@@ -1747,11 +1747,10 @@
 					if (!test_bit(SEND_CRIT, &card->wandev.critical)){
 					 	ppp_send(card, skb->data, skb->len, htons(ETH_P_IPX));
 					}
-					dev_kfree_skb_any(skb);
-
 				} else {
 					++card->wandev.stats.rx_dropped;
 				}
+				dev_kfree_skb_any(skb);
 			} else {
 				/* Pass data up the protocol stack */
 	    			skb->dev =3D dev;
Index: net/ax25/af_ax25.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/net/ax25/af_ax25.c,v
retrieving revision 1.16
diff -u -r1.16 af_ax25.c
--- net/ax25/af_ax25.c	11 Mar 2003 01:33:58 -0000	1.16
+++ net/ax25/af_ax25.c	19 Apr 2003 08:49:58 -0000
@@ -1202,6 +1202,8 @@
 		ax25_insert_socket(ax25);
 	} else {
 		if (ax25->ax25_dev =3D=3D NULL) {
+			if (digi !=3D NULL)
+				kfree(digi);
 			err =3D -EHOSTUNREACH;
 			goto out;
 		}
Index: net/ipv4/netfilter/ip_queue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/net/ipv4/netfilter/ip_queue.c,v
retrieving revision 1.13
diff -u -r1.13 ip_queue.c
--- net/ipv4/netfilter/ip_queue.c	3 Apr 2003 16:59:51 -0000	1.13
+++ net/ipv4/netfilter/ip_queue.c	19 Apr 2003 08:49:58 -0000
@@ -298,10 +298,11 @@
 		goto err_out_free;
 	=09
 	write_lock_bh(&queue_lock);
-=09
+
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb;=20
=20
+	/* netlink_unicast will either free the nskb or attach it to a socket */=
=20
 	status =3D netlink_unicast(ipqnl, nskb, peer_pid, MSG_DONTWAIT);
 	if (status < 0)
 		goto err_out_unlock;
@@ -312,6 +313,9 @@
=20
 	write_unlock_bh(&queue_lock);
 	return status;
+
+err_out_free_nskb:
+	kfree_skb(nskb);=20
 =09
 err_out_unlock:
 	write_unlock_bh(&queue_lock);
Index: net/irda/irttp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/net/irda/irttp.c,v
retrieving revision 1.12
diff -u -r1.12 irttp.c
--- net/irda/irttp.c	25 Feb 2003 05:02:46 -0000	1.12
+++ net/irda/irttp.c	19 Apr 2003 08:50:00 -0000
@@ -263,7 +263,7 @@
=20
 	IRDA_DEBUG(2, "%s(), rx_sdu_size=3D%d\n",  __FUNCTION__,
 		   self->rx_sdu_size);
-	ASSERT(n <=3D self->rx_sdu_size, return NULL;);
+	ASSERT(n <=3D self->rx_sdu_size, {dev_kfree_skb(skb); return NULL;});
=20
 	/* Set the new length */
 	skb_trim(skb, n);

--=20
Muli Ben-Yehuda
http://www.mulix.org


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+oRqNKRs727/VN8sRAnDmAJ4/mHnkAgUJtknyORcLKZLcVZm4pQCgpwoI
C2NPSC92vrZnpzKhMeTMe9k=
=a57W
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbVICIV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbVICIV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbVICIVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:21:25 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:65464 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1161184AbVICIVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:21:23 -0400
Date: Sat, 3 Sep 2005 10:43:15 +0200
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@davemloft.net>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Netdev List <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: [PATCH 2/2] [NETFILTER] remove bogus hand-coded htonll()
Message-ID: <20050903084315.GD4415@rama.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@davemloft.net>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Netdev List <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, bunk@stusta.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s5/bjXLgkIwAv6Hi
Content-Type: multipart/mixed; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave, please apply the appended patch.

I somehow thought I had fixed this quite some time ago. Probably I lost
it with some merge :(

Thanks,
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="52-nfnetlink_queue-htonll.patch"
Content-Transfer-Encoding: quoted-printable

[NETFILTER] remove bogus hand-coded htonll() from nenetlink_queue

htonll() is nothing else than cpu_to_be64(), so we'd rather call the
latter.

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 0905251a08bf51d5e2d1996c21fcdc5acfbbde13
tree a8072738e54f24b0d4392cf33252594d4a6848e1
parent e8d296c78dff8485c5cd90217b91433185a58871
author Harald Welte <laforge@netfilter.org> Sa, 03 Sep 2005 10:31:19 +0200
committer Harald Welte <laforge@netfilter.org> Sa, 03 Sep 2005 10:31:19 +02=
00

 net/netfilter/nfnetlink_queue.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queu=
e.c
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -76,17 +76,6 @@ typedef int (*nfqnl_cmpfn)(struct nfqnl_
=20
 static DEFINE_RWLOCK(instances_lock);
=20
-u_int64_t htonll(u_int64_t in)
-{
-	u_int64_t out;
-	int i;
-
-	for (i =3D 0; i < sizeof(u_int64_t); i++)
-		((u_int8_t *)&out)[sizeof(u_int64_t)-1] =3D ((u_int8_t *)&in)[i];
-
-	return out;
-}
-
 #define INSTANCE_BUCKETS	16
 static struct hlist_head instance_table[INSTANCE_BUCKETS];
=20
@@ -497,8 +486,8 @@ nfqnl_build_packet_message(struct nfqnl_
 	if (entry->skb->tstamp.off_sec) {
 		struct nfqnl_msg_packet_timestamp ts;
=20
-		ts.sec =3D htonll(skb_tv_base.tv_sec + entry->skb->tstamp.off_sec);
-		ts.usec =3D htonll(skb_tv_base.tv_usec + entry->skb->tstamp.off_usec);
+		ts.sec =3D cpu_to_be64(skb_tv_base.tv_sec + entry->skb->tstamp.off_sec);
+		ts.usec =3D cpu_to_be64(skb_tv_base.tv_usec + entry->skb->tstamp.off_use=
c);
=20
 		NFA_PUT(skb, NFQA_TIMESTAMP, sizeof(ts), &ts);
 	}

--phCU5ROyZO6kBE05--

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDGWIjXaXGVTD0i/8RAlWlAJ4/JNu+2TOPDYn5FSag80z6s+dkQACeOHwm
JIZZOVoWHORMgaK4+kyhew0=
=Yo8m
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--

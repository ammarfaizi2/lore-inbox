Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTDSMUA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 08:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTDSMUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 08:20:00 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:37063 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263385AbTDSMT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 08:19:58 -0400
Date: Sat, 19 Apr 2003 15:28:35 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: James Morris <jmorris@intercode.com.au>
Cc: Andy Chou <acc@CS.Stanford.EDU>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 6 memory leaks
Message-ID: <20030419122835.GA7975@actcom.co.il>
References: <20030419094445.GA7283@actcom.co.il> <Mutt.LNX.4.44.0304192206470.31750-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0304192206470.31750-100000@blackbird.intercode.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2003 at 10:08:41PM +1000, James Morris wrote:
> On Sat, 19 Apr 2003, Muli Ben-Yehuda wrote:
>=20
> > This one appears to be exactly the same as the previous one, except
> > the line number is different. Does that mean the checker things there
> > are two leaks in this piece of code?=20
>=20
> This one was for the ipv6 version.  If you could make a patch for ipv6,=
=20
> I'll forward both to Dave Miller.

Here it is, thanks.=20

Index: net/ipv4/netfilter/ip_queue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/net/ipv4/netfilter/ip_queue.c,v
retrieving revision 1.13
diff -u -r1.13 ip_queue.c
--- net/ipv4/netfilter/ip_queue.c	3 Apr 2003 16:59:51 -0000	1.13
+++ net/ipv4/netfilter/ip_queue.c	19 Apr 2003 11:35:11 -0000
@@ -300,8 +300,9 @@
 	write_lock_bh(&queue_lock);
 =09
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb;=20
=20
+ 	/* netlink_unicast will either free the nskb or attach it to a socket */=
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
Index: net/ipv6/netfilter/ip6_queue.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/net/ipv6/netfilter/ip6_queue.c,v
retrieving revision 1.10
diff -u -r1.10 ip6_queue.c
--- net/ipv6/netfilter/ip6_queue.c	5 Apr 2003 01:30:47 -0000	1.10
+++ net/ipv6/netfilter/ip6_queue.c	19 Apr 2003 11:35:12 -0000
@@ -304,8 +304,9 @@
 	write_lock_bh(&queue_lock);
 =09
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb;=20
=20
+ 	/* netlink_unicast will either free the nskb or attach it to a socket */=
=20
 	status =3D netlink_unicast(ipqnl, nskb, peer_pid, MSG_DONTWAIT);
 	if (status < 0)
 		goto err_out_unlock;
@@ -316,6 +317,9 @@
=20
 	write_unlock_bh(&queue_lock);
 	return status;
+=09
+err_out_free_nskb:
+	kfree_skb(nskb);=20
 =09
 err_out_unlock:
 	write_unlock_bh(&queue_lock);

--=20
Muli Ben-Yehuda
http://www.mulix.org


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+oUDzKRs727/VN8sRAlUPAJ0aFVP9eYt6RVIiQJjLsDrqhCwBcQCgnAUl
5CzxCcNvnBngzGoh8pTcf+M=
=7o80
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTFGRSN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 13:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTFGRSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 13:18:13 -0400
Received: from cpt-dial-196-30-180-160.mweb.co.za ([196.30.180.160]:128 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263285AbTFGRSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 13:18:07 -0400
Subject: [PATCH][2.5] compile fixes for recent changes to include/net/sock.h
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oyWqBxfNgy+sW3ckt3S1"
Organization: 
Message-Id: <1055007025.6805.19.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 07 Jun 2003 19:30:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oyWqBxfNgy+sW3ckt3S1
Content-Type: multipart/mixed; boundary="=-2xmZoJ4gA1aU4CTYbHn/"


--=-2xmZoJ4gA1aU4CTYbHn/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

This fixes compile failures due to recent changes in include/net/sock.h.
Seems like a lot of struct sock's members had a 'sk_' appended, but
changes to following was missed:

 drivers/net/ethertap.c
 fs/smbfs/sock.c
 fs/smbfs/proc.c

If any queries, please also CC me at <fgs at lantic.net>, as current
mail offline until monday.


Regards,

--=20

Martin Schlemmer




--=-2xmZoJ4gA1aU4CTYbHn/
Content-Disposition: attachment; filename=linux-2.5.70-bk12-sock-fixes.patch
Content-Type: text/x-patch; name=linux-2.5.70-bk12-sock-fixes.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

diff -urpN linux-2.5.70bk12/drivers/net/ethertap.c linux-2.5.70bk12.sock_fi=
xes/drivers/net/ethertap.c
--- linux-2.5.70bk12/drivers/net/ethertap.c	2003-05-27 03:00:26.000000000 +=
0200
+++ linux-2.5.70bk12.sock_fixes/drivers/net/ethertap.c	2003-06-07 19:23:43.=
000000000 +0200
@@ -292,19 +292,19 @@ static __inline__ int ethertap_rx_skb(st
=20
 static void ethertap_rx(struct sock *sk, int len)
 {
-	struct net_device *dev =3D tap_map[sk->protocol];
+	struct net_device *dev =3D tap_map[sk->sk_protocol];
 	struct sk_buff *skb;
=20
 	if (dev=3D=3DNULL) {
 		printk(KERN_CRIT "ethertap: bad unit!\n");
-		skb_queue_purge(&sk->receive_queue);
+		skb_queue_purge(&sk->sk_receive_queue);
 		return;
 	}
=20
 	if (ethertap_debug > 3)
 		printk("%s: ethertap_rx()\n", dev->name);
=20
-	while ((skb =3D skb_dequeue(&sk->receive_queue)) !=3D NULL)
+	while ((skb =3D skb_dequeue(&sk->sk_receive_queue)) !=3D NULL)
 		ethertap_rx_skb(skb, dev);
 }
=20
@@ -320,7 +320,7 @@ static int ethertap_close(struct net_dev
=20
 	if (sk) {
 		lp->nl =3D NULL;
-		sock_release(sk->socket);
+		sock_release(sk->sk_socket);
 	}
=20
 	return 0;
diff -urpN linux-2.5.70bk12/fs/smbfs/proc.c linux-2.5.70bk12.sock_fixes/fs/=
smbfs/proc.c
--- linux-2.5.70bk12/fs/smbfs/proc.c	2003-05-27 03:00:24.000000000 +0200
+++ linux-2.5.70bk12.sock_fixes/fs/smbfs/proc.c	2003-06-07 19:24:05.0000000=
00 +0200
@@ -900,10 +900,10 @@ smb_newconn(struct smb_sb_info *server,=20
 	 * Store the server in sock user_data (Only used by sunrpc)
 	 */
 	sk =3D SOCKET_I(filp->f_dentry->d_inode)->sk;
-	sk->user_data =3D server;
+	sk->sk_user_data =3D server;
=20
 	/* chain into the data_ready callback */
-	server->data_ready =3D xchg(&sk->data_ready, smb_data_ready);
+	server->data_ready =3D xchg(&sk->sk_data_ready, smb_data_ready);
=20
 	/* check if we have an old smbmount that uses seconds for the=20
 	   serverzone */
diff -urpN linux-2.5.70bk12/fs/smbfs/sock.c linux-2.5.70bk12.sock_fixes/fs/=
smbfs/sock.c
--- linux-2.5.70bk12/fs/smbfs/sock.c	2003-05-27 03:00:38.000000000 +0200
+++ linux-2.5.70bk12.sock_fixes/fs/smbfs/sock.c	2003-06-07 19:23:56.0000000=
00 +0200
@@ -68,7 +68,7 @@ _recvfrom(struct socket *socket, unsigne
 static struct smb_sb_info *
 server_from_socket(struct socket *socket)
 {
-	return socket->sk->user_data;
+	return socket->sk->sk_user_data;
 }
=20
 /*
@@ -77,7 +77,7 @@ server_from_socket(struct socket *socket
 void
 smb_data_ready(struct sock *sk, int len)
 {
-	struct smb_sb_info *server =3D server_from_socket(sk->socket);
+	struct smb_sb_info *server =3D server_from_socket(sk->sk_socket);
 	void (*data_ready)(struct sock *, int) =3D server->data_ready;
=20
 	data_ready(sk, len);
@@ -117,7 +117,7 @@ smb_close_socket(struct smb_sb_info *ser
 		struct socket *sock =3D server_sock(server);
=20
 		VERBOSE("closing socket %p\n", sock);
-		sock->sk->data_ready =3D server->data_ready;
+		sock->sk->sk_data_ready =3D server->data_ready;
 		server->sock_file =3D NULL;
 		fput(file);
 	}
@@ -226,7 +226,7 @@ smb_receive_header(struct smb_sb_info *s
 	sock =3D server_sock(server);
 	if (!sock)
 		goto out;
-	if (sock->sk->state !=3D TCP_ESTABLISHED)
+	if (sock->sk->sk_state !=3D TCP_ESTABLISHED)
 		goto out;
=20
 	if (!server->smb_read) {
@@ -290,7 +290,7 @@ smb_receive_drop(struct smb_sb_info *ser
 	sock =3D server_sock(server);
 	if (!sock)
 		goto out;
-	if (sock->sk->state !=3D TCP_ESTABLISHED)
+	if (sock->sk->sk_state !=3D TCP_ESTABLISHED)
 		goto out;
=20
 	fs =3D get_fs();
@@ -345,7 +345,7 @@ smb_receive(struct smb_sb_info *server,=20
 	sock =3D server_sock(server);
 	if (!sock)
 		goto out;
-	if (sock->sk->state !=3D TCP_ESTABLISHED)
+	if (sock->sk->sk_state !=3D TCP_ESTABLISHED)
 		goto out;
=20
 	fs =3D get_fs();
@@ -400,7 +400,7 @@ smb_send_request(struct smb_request *req
 	sock =3D server_sock(server);
 	if (!sock)
 		goto out;
-	if (sock->sk->state !=3D TCP_ESTABLISHED)
+	if (sock->sk->sk_state !=3D TCP_ESTABLISHED)
 		goto out;
=20
 	msg.msg_name =3D NULL;

--=-2xmZoJ4gA1aU4CTYbHn/--

--=-oyWqBxfNgy+sW3ckt3S1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+4iExqburzKaJYLYRAvXRAJ9szsqby6vK6RXOyqt+a+As7vISwQCeKO/x
O7/RNXq4CaeodvMwTgqisXk=
=Nk1C
-----END PGP SIGNATURE-----

--=-oyWqBxfNgy+sW3ckt3S1--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268530AbTBWTnF>; Sun, 23 Feb 2003 14:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268533AbTBWTnF>; Sun, 23 Feb 2003 14:43:05 -0500
Received: from adsl-67-121-155-191.dsl.pltn13.pacbell.net ([67.121.155.191]:12005
	"EHLO influx.triplehelix.org") by vger.kernel.org with ESMTP
	id <S268530AbTBWTnC>; Sun, 23 Feb 2003 14:43:02 -0500
From: Joshua Kwan <joshk@triplehelix.org>
Date: Sun, 23 Feb 2003 11:52:00 -0800
To: John Weber <weber@nyc.rr.com>
Subject: Re: 2.5 weirdness
Message-ID: <20030223195200.GA10668@triplehelix.org>
References: <20030221221814.GA1316@triplehelix.org> <20030221152502.A9282@sonic.net> <3E592431.3080606@nyc.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <3E592431.3080606@nyc.rr.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2003 at 02:42:41PM -0500, John Weber wrote:
> The problem is a little stranger than that.  On my system, cardmgr only=
=20
> "believes" a card is inserted twice if a card is in the pccard slot when=
=20
>  cardmgr is intially run.  Otherwise, cardmgr and the drivers appear to=
=20
> function correctly.  Josh, can you try this?

This was true.

Dominik's patch which is attached has fixed that for me, at least. This
applies with some offset to 2.5.62, but it works.

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcmcia.patch"
Content-Transfer-Encoding: quoted-printable

diff -ruN linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-23 10:04:03.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-02-23 10:04:25.000000000 +0100
@@ -337,13 +337,14 @@
 		return -ENOMEM;
 	memset(s_info, 0, cls_d->nsock * sizeof(socket_info_t));
=20
+	cls_d->s_info =3D s_info;
+
 	/* socket initialization */
 	for (i =3D 0; i < cls_d->nsock; i++) {
 		socket_info_t *s =3D &s_info[i];
=20
-		cls_d->s_info[i] =3D s;
 		s->ss_entry =3D cls_d->ops;
-		s->sock =3D i;
+		s->sock =3D i + cls_d->sock_offset;
=20
 		/* base address =3D 0, map =3D 0 */
 		s->cis_mem.flags =3D 0;
diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux/drivers/pcmcia/p=
ci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-02-23 10:04:03.00000000=
0 +0100
+++ linux/drivers/pcmcia/pci_socket.c	2003-02-23 10:04:25.000000000 +0100
@@ -171,6 +171,16 @@
 	int err;
 =09
 	memset(socket, 0, sizeof(*socket));
+
+	/* prepare class_data */
+	socket->cls_d.sock_offset =3D nr;
+	socket->cls_d.nsock =3D 1; /* yenta is 1, no other low-level driver uses
+			     this yet */
+	socket->cls_d.ops =3D &pci_socket_operations;
+	socket->cls_d.use_bus_pm =3D 1;
+	dev->dev.class_data =3D &socket->cls_d;
+
+	/* prepare pci_socket_t */
 	socket->dev =3D dev;
 	socket->op =3D ops;
 	pci_set_drvdata(dev, socket);
@@ -186,18 +196,6 @@
=20
 int cardbus_register(struct pci_dev *p_dev)
 {
-	pci_socket_t *socket =3D pci_get_drvdata(p_dev);
-	struct pcmcia_socket_class_data *cls_d;
-
-	if (!socket)
-		return -EINVAL;
-
-	cls_d =3D &socket->cls_d;
-	cls_d->nsock =3D 1; /* yenta is 1, no other low-level driver uses
-			     this yet */
-	cls_d->ops =3D &pci_socket_operations;
-	cls_d->use_bus_pm =3D 1;
-	p_dev->dev.class_data =3D cls_d;
 	return 0;
 }
=20
@@ -227,14 +225,16 @@
 static int cardbus_suspend (struct pci_dev *dev, u32 state)
 {
 	pci_socket_t *socket =3D pci_get_drvdata(dev);
-	pcmcia_suspend_socket (socket->pcmcia_socket);
+	if (socket && socket->cls_d.s_info)
+		pcmcia_suspend_socket (socket->cls_d.s_info);
 	return 0;
 }
=20
 static int cardbus_resume (struct pci_dev *dev)
 {
 	pci_socket_t *socket =3D pci_get_drvdata(dev);
-	pcmcia_resume_socket (socket->pcmcia_socket);
+	if (socket && socket->cls_d.s_info)
+		pcmcia_resume_socket (socket->cls_d.s_info);
 	return 0;
 }
=20
diff -ruN linux-original/drivers/pcmcia/pci_socket.h linux/drivers/pcmcia/p=
ci_socket.h
--- linux-original/drivers/pcmcia/pci_socket.h	2003-02-23 10:04:03.00000000=
0 +0100
+++ linux/drivers/pcmcia/pci_socket.h	2003-02-23 10:04:25.000000000 +0100
@@ -20,7 +20,6 @@
 	socket_cap_t cap;
 	spinlock_t event_lock;
 	unsigned int events;
-	struct socket_info_t *pcmcia_socket;
 	struct work_struct tq_task;
 	struct timer_list poll_timer;
=20
diff -ruN linux-original/include/pcmcia/ss.h linux/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2003-02-23 10:04:12.000000000 +0100
+++ linux/include/pcmcia/ss.h	2003-02-23 10:04:25.000000000 +0100
@@ -145,12 +145,12 @@
  *  Calls to set up low-level "Socket Services" drivers
  */
=20
-#define MAX_SOCKETS_PER_DEV 8
-
 struct pcmcia_socket_class_data {
 	unsigned int nsock;			/* number of sockets */
+	unsigned int sock_offset;		/* socket # (which is
+	 * returned to driver) =3D sock_offset + (0, 1, .. , (nsock-1) */
 	struct pccard_operations *ops;		/* see above */
-	void *s_info[MAX_SOCKETS_PER_DEV];	/* socket_info_t */
+	void *s_info;				/* socket_info_t */
 	unsigned int use_bus_pm;
 };


--lrZ03NoBR/3+SXJZ--

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+WSZgT2bz5yevw+4RArdfAKCOis9Hhk5ouaKy2YV9sHOpQyWcZgCdHIBq
t0b2pOz/NeyJnztuc9C+O/U=
=7y7U
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

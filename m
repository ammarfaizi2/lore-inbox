Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263605AbREYHN3>; Fri, 25 May 2001 03:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263606AbREYHNT>; Fri, 25 May 2001 03:13:19 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:29961 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S263605AbREYHNN>;
	Fri, 25 May 2001 03:13:13 -0400
Date: Fri, 25 May 2001 11:13:13 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] lp486e.c: check region removal
Message-ID: <20010525111313.B18389@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
User-Agent: Mutt/1.0.1i
X-Uptime: 9:56am  up 26 days, 19:39,  1 user,  load average: 0.05, 0.02, 0.00
From: <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

patch for lp486e.c network driver attached.=20
Changes: check_region() call removed, added missing __init and __exit.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-lp486e-2
Content-Transfer-Encoding: quoted-printable

diff -ur -X /usr/dontdiff linux.vanilla/drivers/net/lp486e.c /linux/drivers=
/net/lp486e.c
--- linux.vanilla/drivers/net/lp486e.c	Mon May 21 23:49:44 2001
+++ /linux/drivers/net/lp486e.c	Fri May 25 22:23:22 2001
@@ -971,16 +971,17 @@
 	volatile struct i596_private *lp;
 	unsigned char eth_addr[6] =3D { 0, 0xaa, 0, 0, 0, 0 };
 	unsigned char *bios;
-	int i,j;
-	static int probed =3D 0;
+	int i, j;
+	int ret =3D -ENOMEM;
+	static int probed;
=20
 	if (probed)
 		return -ENODEV;
 	probed++;
=20
-	if (check_region(IOADDR, LP486E_TOTAL_SIZE)) {
-		printk("lp486e: IO address 0x%x in use\n", IOADDR);
-		return -ENODEV;
+	if (!request_region(IOADDR, LP486E_TOTAL_SIZE, dev->name)) {
+		printk(KERN_ERR "lp486e: IO address 0x%x in use\n", IOADDR);
+		return -EBUSY;
 	}
=20
 	/*
@@ -989,7 +990,7 @@
 	dev->mem_start =3D (unsigned long)
 		kmalloc(sizeof(struct i596_private) + 0x0f, GFP_KERNEL);
 	if (!dev->mem_start)
-		return -ENOMEM;
+		goto err_out;
 	dev->priv =3D (void *)((dev->mem_start + 0xf) & 0xfffffff0);
 	lp =3D (struct i596_private *) dev->priv;
 	memset((void *)lp, 0, sizeof(struct i596_private));
@@ -998,12 +999,10 @@
 	 * Do we really have this thing?
 	 */
 	if (i596_scp_setup(dev)) {
-		kfree ((void *) dev->mem_start);
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto err_out_kfree;
 	}
=20
-	request_region(IOADDR, LP486E_TOTAL_SIZE, "lp486e");
-
 	dev->base_addr =3D IOADDR;
 	dev->irq =3D IRQ;
=20
@@ -1053,6 +1052,12 @@
 	i596_port_do(dev, PORT_DUMP, "dump");
 #endif
 	return 0;
+
+err_out_kfree:
+	kfree ((void *) dev->mem_start);
+err_out:
+	release_region(IOADDR, LP486E_TOTAL_SIZE);
+	return ret;
 }
=20
 static void inline
@@ -1330,7 +1335,7 @@
 static int io =3D IOADDR;
 static int irq =3D IRQ;
=20
-static int lp486e_init_module(void) {
+static int __init lp486e_init_module(void) {
 	struct net_device *dev =3D &dev_lp486e;
 	dev->irq =3D irq;
 	dev->base_addr =3D io;
@@ -1342,7 +1347,7 @@
 	return 0;
 }
=20
-static void lp486e_cleanup_module(void) {
+static void __exit lp486e_cleanup_module(void) {
 	unregister_netdev(&dev_lp486e);
 	kfree((void *)dev_lp486e.mem_start);
 	dev_lp486e.priv =3D NULL;

--eJnRUKwClWJh1Khz--

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7DgYJBm4rlNOo3YgRAuB/AJ9kuGV5JChoH+2jzbEzVWRYzYSOdQCfYgoJ
xwsOj04L1MHzlyjYty+0M58=
=1b3a
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--

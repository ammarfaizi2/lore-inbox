Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbRGKOMh>; Wed, 11 Jul 2001 10:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267314AbRGKOM1>; Wed, 11 Jul 2001 10:12:27 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:32524 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S267312AbRGKOMJ>;
	Wed, 11 Jul 2001 10:12:09 -0400
Date: Wed, 11 Jul 2001 18:12:14 +0400
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's the status of kernel PNP?
Message-ID: <20010711181214.G4477@orbita1.ru>
In-Reply-To: <20010709125115.A19087@orbita1.ru> <20010709112502.3364.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010709112502.3364.qmail@science.horizon.com>; from linux@horizon.com on Mon, Jul 09, 2001 at 11:25:02AM -0000
X-Uptime: 4:37pm  up 11 days, 23:33,  3 users,  load average: 0.03, 0.09, 0.08
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: pazke@orbita1.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/i8j2F0k9BYX4qLc
Content-Type: multipart/mixed; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

please test the attached patch (2.4.6-ac2), it should add support for ISAPNP
PCMCIA card.=20

Best regards.

PS. Is your modem working now ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pcmcia-isapnp
Content-Transfer-Encoding: quoted-printable

diff -ur -X /usr/dontdiff /linux.vanilla/drivers/pcmcia/i82365.c /linux/dri=
vers/pcmcia/i82365.c
--- /linux.vanilla/drivers/pcmcia/i82365.c	Mon Jun 25 23:29:02 2001
+++ /linux/drivers/pcmcia/i82365.c	Wed Jul 11 20:55:19 2001
@@ -57,6 +57,10 @@
 #include <pcmcia/ss.h>
 #include <pcmcia/cs.h>
=20
+#ifdef CONFIG_ISAPNP
+#include <linux/isapnp.h>
+#endif
+
 /* ISA-bus controllers */
 #include "i82365.h"
 #include "cirrus.h"
@@ -816,10 +820,56 @@
=20
 #ifdef CONFIG_ISA
=20
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MO=
DULE))
+#define I82365_ISAPNP
+#endif
+
+#ifdef I82365_ISAPNP
+static struct isapnp_device_id id_table[] __initdata =3D {
+	{ 	ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('P', 'N', 'P'),
+		ISAPNP_FUNCTION(0x0e00), (unsigned long) "Intel 82365-Compatible=0D" },
+	{ 	ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('P', 'N', 'P'),
+		ISAPNP_FUNCTION(0x0e01), (unsigned long) "Cirrus Logic CL-PD6720" },
+	{ 	ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('P', 'N', 'P'),
+		ISAPNP_FUNCTION(0x0e02), (unsigned long) "VLSI VL82C146" },
+	{	0 }
+};
+MODULE_DEVICE_TABLE(isapnp, id_table);
+
+static struct pci_dev *i82365_pnpdev;
+#endif
+
 static void __init isa_probe(void)
 {
     int i, j, sock, k, ns, id;
     ioaddr_t port;
+#ifdef I82365_ISAPNP
+    struct isapnp_device_id *devid;
+    struct pci_dev *dev;
+
+    for (devid =3D id_table; devid->vendor; devid++) {
+	if ((dev =3D isapnp_find_dev(NULL, devid->vendor, devid->function, NULL))=
) {
+	    printk("ISAPNP ");
+
+	    if (dev->prepare && dev->prepare(dev) < 0) {
+		printk("prepare failed\n");
+		break;
+	    }
+
+	    if (dev->activate && dev->activate(dev) < 0) {
+		printk("activate failed\n");
+		break;
+	    }
+
+	    if ((i365_base =3D pci_resource_start(dev, 0))) {
+		printk("no resources ?\n");
+		break;
+	    }
+	    i82365_pnpdev =3D dev;
+	    break;
+	}
+    }
+#endif
=20
     if (check_region(i365_base, 2) !=3D 0) {
 	if (sockets =3D=3D 0)
@@ -1604,6 +1654,10 @@
 	i365_set(i, I365_CSCINT, 0);
 	release_region(socket[i].ioaddr, 2);
     }
+#if defined(CONFIG_ISA) && defined(I82365_ISAPNP)
+    if (i82365_pnpdev && i82365_pnpdev->deactivate)
+		i82365_pnpdev->deactivate(i82365_pnpdev);
+#endif
 } /* exit_i82365 */
=20
 module_init(init_i82365);

--f61P+fpdnY2FZS1u--

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7TF6+Bm4rlNOo3YgRAmthAJ4pSgBoqioTsM64UYTt7hOH6vNFVACfTghr
1aETiwFbya1badone6udG6E=
=n5KI
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--

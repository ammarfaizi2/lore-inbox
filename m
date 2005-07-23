Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVGWC6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVGWC6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 22:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVGWC6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 22:58:14 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:3752 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261489AbVGWC6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 22:58:12 -0400
Date: Sat, 23 Jul 2005 08:54:27 -0400
From: Harald Welte <laforge@netfilter.org>
To: David Miller <davem@davemloft.net>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
Message-ID: <20050723125427.GA11177@rama>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David Miller <davem@davemloft.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,
Hi Evgeniy,

the following patch fixes the illegal use of NETLINK_NFLOG by the
1wire drivers.  It assumes that the netlink tap families can now safely
be reclaimed, which is the case according to Dave at netconf'05.

I'm not sure who would be the right person to fix this, but this patch
needs to go into both 2.6.12.x and 2.6.13 trees, since it potentially
causes a security problem by preventing the iptables ULOG

This has been the third new piece of code that reuses NETLINK_NFLOG
within a couple of months.  I would really appreciate if people would
actually ask/apply for a new protocol number instead of just overloading
existing values and thereby causing breakage. =20

Thanks,
	Harald

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="06-w1-nflog.patch"
Content-Transfer-Encoding: quoted-printable

Give the 1-wire driver stack its own netlink protocol number, instead of
overloading NETLINK_NFLOG.

I wonder what I have done to people, that they always overload the
NETLINK_NFLOG protocol number and thereby effectively prevent the packet
filter logging mechanism.  Please don't re-use protocol numbers.

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit b4a566c332048b642506eff7de825fce710ff42c
tree 07ef162f6d449dd67c586c9c63680004787b86c5
parent d5d3fb40b6db511dbd47a84634a1249de6b7b297
author laforge <laforge@netfilter.org> Sa, 23 Jul 2005 08:41:24 -0400
committer laforge <laforge@netfilter.org> Sa, 23 Jul 2005 08:41:24 -0400

 drivers/w1/w1_int.c     |    4 ++--
 include/linux/netlink.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -88,10 +88,10 @@ static struct w1_master * w1_alloc_dev(u
=20
 	dev->groups =3D 23;
 	dev->seq =3D 1;
-	dev->nls =3D netlink_kernel_create(NETLINK_NFLOG, NULL);
+	dev->nls =3D netlink_kernel_create(NETLINK_W1, NULL);
 	if (!dev->nls) {
 		printk(KERN_ERR "Failed to create new netlink socket(%u) for w1 master %=
s.\n",
-			NETLINK_NFLOG, dev->dev.bus_id);
+			NETLINK_W1, dev->dev.bus_id);
 	}
=20
 	err =3D device_register(&dev->dev);
diff --git a/include/linux/netlink.h b/include/linux/netlink.h
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -20,7 +20,7 @@
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
 #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
-#define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
+#define NETLINK_W1		16	/* 16 to 31 are ethertap */
=20
 #define MAX_LINKS 32	=09
=20

--EVF5PPMfhYS0aIcm--

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC4j4CXaXGVTD0i/8RAtJfAJ4nZm4jdL2tokFY2jJMUgc60rdwygCgi0cS
1YUu+ztr0P23Ba+2FfiySNA=
=no53
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

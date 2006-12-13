Return-Path: <linux-kernel-owner+w=401wt.eu-S964848AbWLMLYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWLMLYg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWLMLYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:24:35 -0500
Received: from [84.244.112.36] ([84.244.112.36]:2824 "EHLO www.swac.cz"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S964848AbWLMLYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:24:34 -0500
X-Greylist: delayed 1392 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 06:24:34 EST
From: Hynek Petrak <hynek@swac.cz>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: PHY probe not working properly for ibm_emac (PPC4xx)
Date: Wed, 13 Dec 2006 12:01:19 +0100
User-Agent: KMail/1.9.5
X-Face: 5(Auj02BT~s>\3*HD8Zcg5ivgfYoiRqL#>r(@l-#9V}}h.xXqT(?Tx0FT~2d.2EWf;W+I;
	PP>ZJP6(u>/_"oCQ*P@Gw<i^D~I$jFyIId{L;G}aX]GwcD~z@V8ognNLhR1PF0"Lx4br{V
	o;
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1255156.tLLjhZmD1L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612131201.24274.hynek@swac.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1255156.tLLjhZmD1L
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[1.] One line summary of the problem:  =20

PHY probe not working properly for ibm_emac (PPC4xx)
=20
[2.] Full description of the problem/report:

I have a system with AMCC PowerPC 405EP and PHY Intel LXT971A.
Linux 2.6.18.3 is not able to detect the PHY ID correctly. The=20
PHY ID detected is 0, but should be 0x1d.=20

This is because phy_read() (__emac_mdio_read() resp.) from=20
drivers/net/ibm_emac/ibm_emac_core.c might return -ETIMEDOUT=20
or -EREMOTEIO on error. This is ignored inside the=20

int mii_phy_probe(struct mii_phy *phy, int address)=20
from drivers/net/ibm_emac/ibm_emac_phy.c

as the return value is assigned to an u32 variable.
Please consider the patch below ...=20

[3.] Keywords:

networking, kernel, problem, ibm_emac, ppc4xx, phy

[4.] Kernel version (from /proc/version):

2.6.18.3

[5.] Output of Oops.. message (if applicable) with symbolic=20
information resolved (see Documentation/oops-tracing.txt)

doesn't oops


[6.] A small shell script or example program which triggers the
     problem (if possible)

none required

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

ELDK 3.1.1 from www.denx.org

[7.2.] Processor information (from /proc/cpuinfo):

AMCC' PowerPC 405EP

PHY Intel LXT971A

[X.] Patch:

Index: drivers/net/ibm_emac/ibm_emac_phy.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- drivers/net/ibm_emac/ibm_emac_phy.c (revision 67)
+++ drivers/net/ibm_emac/ibm_emac_phy.c (revision 69)
@@ -309,7 +309,7 @@
 {
        struct mii_phy_def *def;
        int i;
=2D       u32 id;
+       int id;

        phy->autoneg =3D AUTONEG_DISABLE;
        phy->advertising =3D 0;
@@ -324,6 +324,8 @@

        /* Read ID and find matching entry */
        id =3D (phy_read(phy, MII_PHYSID1) << 16) | phy_read(phy,=20
MII_PHYSID2);
+        if (id < 0)
+            return -ENODEV;
        for (i =3D 0; (def =3D mii_phy_table[i]) !=3D NULL; i++)
                if ((id & def->phy_id_mask) =3D=3D def->phy_id)
                        break;


=2D-=20
Mgr. Hynek Petrak
=2D----------------
S.W.A.C. Bohemia spol. s r.o.
Heydukova 314, 38601 Strakonice
tel: +420 3834181-36 or +49 (89) 613866-51=20
PGP key: http://www.swac.cz/~hynek/hp.pgp
5CAC 7712 CFFD D076 0D74 A134 1EFD 728C 84CB 94CF


--nextPart1255156.tLLjhZmD1L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFf92EHv1yjITLlM8RAoGfAJ9HlFVfdq2lTrhRq19QPWgEpUA0mACgkYj7
r+WQy+HE3Xog3xvbCpGATo0=
=OAKI
-----END PGP SIGNATURE-----

--nextPart1255156.tLLjhZmD1L--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281762AbRLGOwn>; Fri, 7 Dec 2001 09:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281780AbRLGOwg>; Fri, 7 Dec 2001 09:52:36 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:13654 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S281759AbRLGOwU>; Fri, 7 Dec 2001 09:52:20 -0500
Date: Fri, 7 Dec 2001 15:48:15 +0100
From: Kurt Garloff <garloff@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, debian-alpha@lists.debian.org,
        axp-list@redhat.com, suse-axp@suse.com
Subject: Re: IDE DMA on AXP & barriers
Message-ID: <20011207154815.A14011@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	linux-alpha@vger.kernel.org, debian-alpha@lists.debian.org,
	axp-list@redhat.com, suse-axp@suse.com
In-Reply-To: <20011206061315.J13427@garloff.etpnet.phys.tue.nl> <20011206125935.A3930@jurassic.park.msu.ru> <20011207132505.B4229@garloff.etpnet.phys.tue.nl> <20011207170341.A9959@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20011207170341.A9959@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ivan,

On Fri, Dec 07, 2001 at 05:03:41PM +0300, Ivan Kokshaysky wrote:
> On Fri, Dec 07, 2001 at 01:25:05PM +0100, Kurt Garloff wrote:
> > So I  wonder where the bug actually is. Somewhere in hardware; but I wo=
nder
> > whether the CMD646 or the 2117x (PYXIS/CIA) is to blame. The QLogicISP =
seems
> > to happily do BM-DMA, so I'd point to the CMD646.
>=20
> Hmm, it seems to be a pyxis bug; the hardware workaround exists, but
> I guess that it might be not implemented properly on early miatas.
> This also explains why I don't have that problem on lx164 and sx164.
> >From pyxis manual:
> "A.1 Read Page Problem
>  PCI DMA reads that attempt to cross 8K page boundaries cause data corrup=
tion
>  problems. A fix has been implemented with an Altera 7032 and two Pericom
>  PI5C3400 bus switches and a diode."

Hey, where did you find that manual? I could not find one at Compaq's web
site.

I wouldn't mind to solder a diode on my board, but I don't know about the
rest ... The software workaround is even preferable, as it helps more people
than just me.

How do I recognize the broken PYXIS in software? (Except for waiting for
your hard disk to be corrupted?)

Unfortunately, I see no 21174 on my PCI bus where I could just check the
revision.
garloff@pws:~ $ /sbin/lspci=20
00:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43=
 (rev 30)
00:04.0 IDE interface: CMD Technology Inc PCI0646 (rev 01)
00:07.0 Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA Bri=
dge] (rev 43)
00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millenn=
ium] (rev 01)
00:14.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)
01:09.0 SCSI storage controller: Q Logic ISP1020 (rev 05)

Can I draw conclusions from the revision of the 21152?

Or should I just put an #ifdef CONFIG_ALPHA_PYXIS in my patch?
What about the users of generic alpha kernels?
Or a config option?

Attached is my current version of a workaround. It checks for CMD646, which
should probably be removed, because the bug is in PYXIS according to your
docs. It runs stably since a couple of hours with DMA on, now.


Could people test it?=20
Please report back to me whether you have that problem on your PWS ar
another Miata(PYXIS) board.
If the workaround helps you as well, I will prepare a nice patch and submit
it to Linux/Marcelo/Alan.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-dma.cmd646.miata.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.16.SuSE-2/drivers/ide/ide-dma.c	Mon Dec  3 01:28:08 2001
+++ linux-2.4.16.SuSE-2.axp/drivers/ide/ide-dma.c	Fri Dec  7 13:24:08 2001
@@ -379,6 +379,21 @@
 			xcount =3D bcount & 0xffff;
 			if (is_trm290_chipset)
 				xcount =3D ((xcount >> 2) - 1) << 16;
+#ifdef CONFIG_ALPHA_PYXIS
+			/* Don't cross page boundaries on PYXIS && CMD646 && write */
+			if (HWIF(drive)->chipset =3D=3D ide_cmd646 && func =3D=3D ide_dma_write=
) {
+				if (xcount =3D=3D0)=20
+					xcount =3D 0x10000;
+				while ((cur_addr & (PAGE_SIZE-1)) + xcount > PAGE_SIZE) {
+					u32 newcnt =3D PAGE_SIZE - (cur_addr & (PAGE_SIZE-1));
+					if (count++ >=3D PRD_ENTRIES)
+						goto use_pio_instead;
+					*table++ =3D cpu_to_le32(newcnt);
+					*table++ =3D cpu_to_le32(cur_addr +=3D newcnt);
+					xcount -=3D newcnt;
+				}
+			}
+#endif
 			if (xcount =3D=3D 0x0000) {
 				/*=20
 				 * Most chipsets correctly interpret a length
@@ -391,12 +406,14 @@
 					goto use_pio_instead;
=20
 				*table++ =3D cpu_to_le32(0x8000);
-				*table++ =3D cpu_to_le32(cur_addr + 0x8000);
+				*table++ =3D cpu_to_le32(cur_addr +=3D 0x8000);
 				xcount =3D 0x8000;
 			}
-			*table++ =3D cpu_to_le32(xcount);
-			cur_addr +=3D bcount;
+			cur_addr +=3D xcount;
 			cur_len -=3D bcount;
+			/* KG, 2001-12-07: Mark EOT (bit 31 in length field) */
+			// *table++ =3D cpu_to_le32(xcount | (cur_len? 0: 0x80000000));
+			*table++ =3D cpu_to_le32(xcount);
 		}
=20
 		sg++;
@@ -654,6 +692,10 @@
 			reading =3D 1 << 3;
 		case ide_dma_write:
 			SELECT_READ_WRITE(hwif,drive,func);
+#if 0 //def __alpha__
+			if (HWIF(drive)->chipset =3D=3D ide_cmd646 && func =3D=3D ide_dma_write)
+				return 1; /* For now, disable DMA writing CMD64x on AXP */
+#endif
 			if (!(count =3D ide_build_dmatable(drive, func)))
 				return 1;	/* try PIO instead of DMA */
 			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */

--WYTEVAkct0FjGQmd--

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ENauxmLh6hyYd04RAgeDAJ99IMIRY55r7D6ZdPbtubBObB2mBQCgy1R6
pq/97caP7HrG5TAOJIcqOKI=
=t0+I
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

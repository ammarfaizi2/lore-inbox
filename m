Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293708AbSCKLpy>; Mon, 11 Mar 2002 06:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293711AbSCKLpp>; Mon, 11 Mar 2002 06:45:45 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:8268 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S293708AbSCKLp3>; Mon, 11 Mar 2002 06:45:29 -0500
Date: Mon, 11 Mar 2002 12:45:11 +0100
From: Kurt Garloff <garloff@suse.de>
To: Jochen Friedrich <jochen@scram.de>
Cc: linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jay Estabrook <Jay.Estabrook@compaq.com>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
Message-ID: <20020311124511.J2346@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Jochen Friedrich <jochen@scram.de>, linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jay Estabrook <Jay.Estabrook@compaq.com>,
	Richard Henderson <rth@twiddle.net>
In-Reply-To: <Pine.NEB.4.33.0203111049580.1675-100000@www2.scram.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaPAUYI/0vT2YKpA"
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.33.0203111049580.1675-100000@www2.scram.de>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yaPAUYI/0vT2YKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jochen,

On Mon, Mar 11, 2002 at 10:57:40AM +0100, Jochen Friedrich wrote:
> it looks like the change to pci_iommu.c in 2.4.18 breaks busmaster DMA for
> alpha. The reason is that ISA_DMA_MASK is now 0xffffffff instead of
> 0x00ffffff as it was before. So the allocated memory is no longer
> reachable from the ISA card.
>=20
> I had to revert this change to make my ISA token ring card (tms380 based)
> work again on alpha.

You have a Miata mainboard, right?

The problem is that the chipset does corrupt data when you do busmaster DMA
read (from memory) over an 8k page boundary on the primary PCI bus.
(Secondary is not affected.)
Therefore you could e.g. not use IDE DMA on Miata.

I created a workaround specific to the ide-dma driver, but Ivan came up with
a much more general and better solution:
The PCI mapping via tbia is not used any more, but instead the PCI monster
window, which can map up to 4GB into PCI space. (Miata can theoretically ha=
ve
6GB, but I did not yet hear any complaints.)=20
It first broke floppy support as the pci_map would fail. The floppy chip is
an ISA device. But it can address full 32bit on Miata, so the ISA_DMA_MASK
was adapted to this.
(Ivan, correct me if I got the details wrong.)

Unfortunately, your ISA card does not seem to be able to address 32 bits.
(I guess no non-on-chip ISA adapter will.)

Seems we need two different ISA_DMA_MASKS ...

Maybe it would be easier to special case the floppy driver's calls to
pci_map when a Miata(21174) has been detected and the workaround been
applied.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--yaPAUYI/0vT2YKpA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8jJjHxmLh6hyYd04RAoLNAJ9+I/61603VdMz6r0hnMSicl29nqgCeJINk
giHwMRX0UGKSPo8P4FZGfDA=
=zzIG
-----END PGP SIGNATURE-----

--yaPAUYI/0vT2YKpA--

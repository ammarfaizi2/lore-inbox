Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265682AbUF2KTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUF2KTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 06:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUF2KTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 06:19:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:33494 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265682AbUF2KTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 06:19:19 -0400
Date: Tue, 29 Jun 2004 11:45:57 +0200
From: Kurt Garloff <garloff@suse.de>
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hwscan hangs on USB2 disk - SCSI_IOCTL_SEND_COMMAND
Message-ID: <20040629094557.GR4732@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Bart Hartgers <bart@etpmod.phys.tue.nl>, linux-kernel@vger.kernel.org
References: <20040629093739.40243364C@etpmod.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Content-Disposition: inline
In-Reply-To: <20040629093739.40243364C@etpmod.phys.tue.nl>
X-Operating-System: Linux 2.6.5-17-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bart,

On Tue, Jun 29, 2004 at 11:37:36AM +0200, Bart Hartgers wrote:
> The problem is that both hwscan and usb-storage get stuck in the 'D"
> state until I unplug the harddisk.
>=20
> A strace of hwscan shows:
>=20
> 21141 open("/dev/sda", O_RDONLY|O_NONBLOCK) =3D 3
> 21141 ioctl(3, 0x301, 0xbfffeba0)       =3D 0
> 21141 ioctl(3, BLKSSZGET, 0xbfffeb9c)   =3D 0
> 21141 ioctl(3, 0x80041272, 0xbfffeb90)  =3D 0
> 21141 ioctl(3, FIBMAP, 0xbfffec40)      =3D 0  <--- hwscan gets stuck here
>=20
> The last ioctl corresponds to this bit of code in
> hwinfo-8.38/src/hd/block.c:
>=20
> #ifndef SCSI_IOCTL_SEND_COMMAND
> #define SCSI_IOCTL_SEND_COMMAND 1
> #endif
>=20
> ...
>=20
>       memset(scsi_cmd_buf, 0, sizeof scsi_cmd_buf);
>       // ###### FIXME: smaller!
>       *((unsigned *) (scsi_cmd_buf + 4)) =3D sizeof scsi_cmd_buf - 0x100;
>       scsi_cmd_buf[8 + 0] =3D 0x12;
>       scsi_cmd_buf[8 + 1] =3D 0x01;
>       scsi_cmd_buf[8 + 2] =3D 0x80;
>       scsi_cmd_buf[8 + 4] =3D 0xff;
>=20
>       k =3D ioctl(fd, SCSI_IOCTL_SEND_COMMAND, scsi_cmd_buf);
>=20
> So it appears that the driver hangs because of a SCSI command. Is this
> kernel bug, and if so, where do I fix it?

To me it looks like a bug in the USB stick.
It probably locks up when you ask for VPD page 0x80 (serial number)
of the device with INQUIRY.=20
Some shitty USB devices lock up when you ask for more than 36 bytes
with INQUIRY. See code in scsi_scan.c and the BLIST_INQUIRY_36 and
_58 flags.
Your device may even do so when you don't ask for standard INQUIRY=20
data but for EVPD page 0x80 :-(

Does it work if you send the INQUIRY with 36 bytes allocation length?
scsi_cmd_buf[8 + 4] =3D 0x26;
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG / Novell, Nuernberg, DE               Director SUSE Labs

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4TpVxmLh6hyYd04RAvMGAJ9Gg4rbf8Aguozf3VYNKFFstpVQPwCgj+27
qi7F5XakIX/QAMdBOcW4UOQ=
=sD2F
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--

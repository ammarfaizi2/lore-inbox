Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270049AbRHGDSH>; Mon, 6 Aug 2001 23:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270048AbRHGDR6>; Mon, 6 Aug 2001 23:17:58 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:64784
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S270046AbRHGDRo>; Mon, 6 Aug 2001 23:17:44 -0400
Date: Mon, 6 Aug 2001 20:17:46 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Brent Baccala <baccala@freesoft.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Problem with usb-storage using HP 8200 external CD-ROM burner
Message-ID: <20010806201746.C6080@one-eyed-alien.net>
Mail-Followup-To: Brent Baccala <baccala@freesoft.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <3B68FB0C.5BC83115@freesoft.org> <20010806014626.K24225@one-eyed-alien.net> <3B6EF4DA.8899E1D3@freesoft.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B6EF4DA.8899E1D3@freesoft.org>; from baccala@freesoft.org on Mon, Aug 06, 2001 at 03:49:46PM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2001 at 03:49:46PM -0400, Brent Baccala wrote:
> Matthew Dharm wrote:
> > Of course, I'm interested in knowing how the command_abort function can=
 be
> > made safe -- I think there are already patches in the 2.4.8 kernel which
> > should fix the cause of this function getting called.
> >=20
> > Any ideas on how to fix this issue?
>=20
> Well, what comes to mind immediately is two things.
>=20
> First, does scsiglue.c's abort_command really need to handshake with the
> code in usb.c?  If not, just get rid of the down and its matching up.

Unfortunately, it does.  The SCSI layer seems to believe that once we've
returned from the abort_command() routine, the driver is in a position to
accept a new command.  Thus, some level of handshaking is necessary.

> Second, this code (in scsi_error.c):
>=20
>       774         spin_lock_irqsave(&io_request_lock, flags);
>       775         rtn =3D SCpnt->host->hostt->eh_abort_handler(SCpnt);
>       776         spin_unlock_irqrestore(&io_request_lock, flags);
>=20
> seems like a real shotgun approach.  Get rid of the spinlock stuff, and
> make sure that the abort handlers lock io_request_lock themselves if
> they need it.  Of course, this would require changes to all the scsi
> drivers.

Hrm... perhaps I could just unlock that spinlock and then re-lock it before
returning.  Anyone have a clue if this would work?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Would you mind not using our Web server? We're trying to have a game of=20
Quake here.
					-- Greg
User Friendly, 5/11/1998

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7b13az64nssGU+ykRAhi9AKDDR86RyGgJEiq+ZDOiSV8XoN9rkQCg/RVP
omYkrZfojY8DtJSWQlhMR10=
=BGo7
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

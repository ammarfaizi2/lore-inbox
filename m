Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSFTLZq>; Thu, 20 Jun 2002 07:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSFTLZp>; Thu, 20 Jun 2002 07:25:45 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:60703 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S313767AbSFTLZm>; Thu, 20 Jun 2002 07:25:42 -0400
Date: Thu, 20 Jun 2002 13:25:43 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020620112543.GD26376@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <20020620004442.GA19824@gum01m.etpnet.phys.tue.nl> <Pine.LNX.4.33.0206192149410.2638-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0206192149410.2638-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, Jun 19, 2002 at 10:03:16PM -0700, Linus Torvalds wrote:
> On Thu, 20 Jun 2002, Kurt Garloff wrote:
> >=20
> > find attached a patch (against 2.5.23-dj2) to the SCSI subsystem which=
=20
> > adds a file /proc/scsi/map, which provides a listing of SCSI devices,
> > enumerated by the CBTU/HCIL tuple and the high-level devices attached to
> > them.=20
>=20
> I really despise this.

Thanks for your feedback.

Actually, I think you want to address a different problem than I want to.

I do believe that the scsi subsystem does not expose enough information for
many things.=20

Look at /proc/scsi/scsi: The information is useful for the reader who wants
to know what devices he has and were found by the SCSI subsystem.

And completely useless for any program that wants to find a scanner,
CD-Writer, ... as there is no connection to the high-level drivers attached
to them. Which means that all these programs basically contain their own
SCSI scanning code, which means opnening all sg devices and collecting the
information. I do not think that this is a good idea that a lot of userspace
programs need to do a lot of effort to get some information that could just
be exported by the kernel.

But I indeed had persistent naming in mind as well and mentioned it, so this
is probably why the discussion went that way.
scsidev, which I took over from Eric Youngdale some time ago, tries to
provide persistent naming for SCSI devices and suffers the problem, that
it can't work reliably, as open() of sr/st/osst devices can fail because
devices are already in use (-EBUSY) or have no medium inserted. (O_NONBLOCK
does not always help.) And it can take considerable time or cause unwanted
side-effects.=20

You're right that just enumerating all scsi devices in a somewhat more
persistent way does not constitute a complete solution to the problem of
persistent naming of attached storage devices. That is something that would
need to be addressed at a higher level and not inside SCSI midlevel, of
course.

But I still think the SCSI subsystem should report which SCSI (low-level)
device is mapped to what high-level driver.
Would you accept a patch that adds a line like

Host: scsi3 Channel: 00 Id: 12 Lun: 00
  Vendor: IBM      Model: DPSS-336950N     Rev: S84D
  Type:   Direct-Access                    ANSI SCSI revision: 03
  Attached drivers: sg12(c:15:0c) sdf(b:08:50)
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
to /proc/scsi/scsi ?

Actually that was my first idea, but I was reluctant to change the format of
an existing file, as it might be parsed by existing code.=20
But, given the uselessness of /proc/scsi/scsi for code, I guess that's
a small risk ...=20

> It's just _wrong_ to have one file with a collection of devices in it, an=
d=20
> it is _doubly_ wrong when that one file
>=20
>  - is limited to a (arbitrary) subset of the disks in your system

You mean all disks driven by the SCSI subsystem, right?

>  - has completely bogus information about "location" that has nothing to=
=20
>    do with real life, yet pruports to be an "address" even though it=20
>    obviously isn't.

The CBTU tuple uniquely addresses a SCSI device in a running system.
It's just not persistent against configuration changes, unfortunately.
But it's reported by /proc/scsi/scsi as well and therefore useful to
find back in map, IMHO.

[...]
> Either you enumerate things without any structure (like the current SCSI
> layer does: disk0, disk1, disk2 ...) or you give full their addresses. =
=20
> Don't do the half-assed thing.

I would certainly like to see code at block layer that does provide the
infrastructure to see persistent names for all sort of attached devices,
especially disks.

> PLEASE don't add these kinds of SCSI-specific hacks, that are _useless_ to
> find other types of disks, and that makes no sense, and will not work for
> things like DAC960, for IDE, or for anything else that just ignores the=
=20
> SCSI layer (even if it physically uses SCSI disks, like the DAC960 setup).

Please consider the possibility of adding the reporting of the attached
high-level drivers to /proc/scsi/scsi

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Ebu2xmLh6hyYd04RAmwmAKCB/VE1UCLynm4h6A9TNmu9z/aTrACaAiPM
Xq1eAnWHUusy01yQAf1Z1Xw=
=0EFB
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSFRJDq>; Tue, 18 Jun 2002 05:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317369AbSFRJDp>; Tue, 18 Jun 2002 05:03:45 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:51485 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317365AbSFRJDm>; Tue, 18 Jun 2002 05:03:42 -0400
Date: Tue, 18 Jun 2002 11:03:43 +0200
From: Kurt Garloff <garloff@suse.de>
To: Doug Ledford <dledford@redhat.com>
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020618090343.GB6913@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Doug Ledford <dledford@redhat.com>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <20020617180818.C30391@redhat.com> <20020617230648.GA3448@gum01m.etpnet.phys.tue.nl> <20020617224046.A6590@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20020617224046.A6590@redhat.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Mon, Jun 17, 2002 at 10:40:47PM -0400, Doug Ledford wrote:
> On Tue, Jun 18, 2002 at 01:06:48AM +0200, Kurt Garloff wrote:
> > * For compiled in SCSI drivers, use scsihosts=3D
>=20
> No, this is not true.  If you add a new controller (for some new disks in=
=20
> a new external enclosure or whatever), and that controller uses the same=
=20
> driver as other controller(s) in your system, then you have no guarantee=
=20
> of order.  For example, adding a 4th aic7xxx controller to your system=20
> might or might not place the new controller at the end of the list=20
> depending on PCI scan order, etc.  There simply is *no* guarantee here of=
=20
> any consistent naming, so don't bother trying to claim there is.

You're right; there is no guarantee.

In scsidev, the IO port is added as identifier to the host number, but even
that may change in case your Plug'n'Pray BIOS assigns a different IO port
upon PCI configuration ...

> > But actually, the patch is not meant to be the holy grail of persistent
> > device naming. But it enables userspace tools to collect information=20
> > * reliably=20
> >   (fails so far due to possible open() failures with unknown
> >    relation to the corresponding sg device (which could be opened))
>=20
> This can be done without your patch (the mapping from /dev/sg to /dev/sd?=
=20
> or /dev/st? or /dev/scd? or whatever is not impossible from user space=20
> without your patch, it just requires a user space tool to open the files=
=20
> and start comparing host/bus/id/lun combinations from dev file to dev=20
> file).

No, it unfortunately can't. The reason is you just can't reliably open a
device to do the SCSI_IOCTL_GET_IDLUN to find out about CBTU.=20
Devices with removable media are a good example. The open on a tape
that is not inserted just fails. Or it may be in use

Or cause very nasty side effects, like stalling for a minute because the
tape driver rewinds the drive and looks for meta-information (osst).

This problem is really the reason why scsidev is not foolproof.
sg_map does not do magic either.

root@pckurt:~ $ sg_map=20
sg_map: close error: Input/output error
/dev/sg0  /dev/scd0
/dev/sg1  /dev/sda
/dev/sg2  /dev/sdb
/dev/sg3  /dev/sdc
/dev/sg4  /dev/sdd
/dev/sg5  /dev/sde
/dev/sg6  /dev/sdf
/dev/sg7  /dev/scd1
/dev/sg8  /dev/osst0
/dev/sg9  /dev/scd2
/dev/sg10  /dev/scd3
/dev/sg11
/dev/sg12  /dev/scd4

The /proc/scsi/map does provide the missing piece of information.

root@pckurt:~ $ cat /proc/scsi/map
# C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
0,0,00,00       0x05    1       sg0     c:15:00 sr0     b:0b:00
1,0,09,00       0x00    1       sg2     c:15:02 sdb     b:08:10
1,0,05,00       0x00    1       sg1     c:15:01 sda     b:08:00
1,0,01,00       0x05    1       sg7     c:15:07 sr1     b:0b:01
1,0,02,00       0x01    1       sg8     c:15:08 osst0   c:ce:00
1,0,03,00       0x05    1       sg9     c:15:09 sr2     b:0b:02
2,0,05,00       0x00    1       sg3     c:15:03 sdc     b:08:20
2,0,09,00       0x00    1       sg4     c:15:04 sdd     b:08:30
2,0,01,00       0x05    1       sg10    c:15:0a sr3     b:0b:03
2,0,02,00       0x01    1       sg11    c:15:0b osst1   c:ce:01
2,0,03,00       0x05    1       sg12    c:15:0c sr4     b:0b:04
3,0,10,00       0x00    1       sg5     c:15:05 sde     b:08:40
3,0,12,00       0x00    1       sg6     c:15:06 sdf     b:08:50

> > * without too much trouble
>=20
> This part is true enough, it is easier to read the map file than to=20
> program the information retrieval I mentioned above.
>=20
> > Both things I consider important and useful.
> >=20
> > The patch basically does provide two pieces of information:
> > * mapping between sg vs. other high level devices
>=20
> This I think is usefull.
>=20
> > * mapping CBTU to high-level devices
>=20
> This I don't think is usefull at all.  It's no more reliable than our=20
> current system and people that are depending on this to solve their "I=20
> can't tell what device is what" delima are going to be sorely upset when=
=20
> they realize that hardware changes can change this stuff around just as=
=20
> fast as it changes around the /dev/sd? mappings.

You less often build in new host adpaters or jumper your drives' IDs
differently than you switch on/off an external ZIP drive/scanner/ e.g.

And if you take a disk from one controller to another one, you arguably even
want the address to change as your path to the device changed. At least you
can expect it.

CBTU still gives you reasonable information about the path to a device.

The "C" identification may need improvement ... and I'm certainly open
for suggestions.

And I personally do think that at SCSI midlayer in kernel, you want to
report about this path to a device.

> > The latter one is enough for many setups,
>=20
> The latter one is just as broken in design as the original /dev/sd?=20
> enumeration problem (which stands to reason since this method also is an=
=20
> enumeration method, it's just that instead of enumerating the disks=20
> starting at 0, we are enumerating the SCSI controllers starting at the=20
> first one we find and going from there).

I don't think the original /dev/sd? design is broken. It's a choice that
makes some sense if you think about the fact that you only have a limited
amount of majors reserved for SCSI disks.
But it has some disadvantages ...

> > and the former can be used for
> > more elaborate solutions involving userspace tools more advanced than t=
he
> > simple script I included in the patch.
>=20
> Which is the much better way to go.

Expect a scsidev release (2.25) that does use /proc/scsi/map (if present) to
present a somewhat better mapping than the little script included.
It optionally does assign aliases based on the serial number
(INQUIRY,evpd=3D1,pg.cd. 0x80), which is rather stable in case your do prov=
ide
this piece of information. But not unique in case you provide multiple
paths to your devices (like having more than one SCSI host adapter on a bus,
which I BTW do for testing purposes).

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9DvduxmLh6hyYd04RAgQyAJ4kUiQQx4rzS+phh2AQNfJpvlv3TgCghUKL
H3APhr8Uc+mtZyMer/JrmTQ=
=j8Zk
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

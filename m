Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbULBMwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbULBMwR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 07:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULBMwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 07:52:17 -0500
Received: from smtp09.auna.com ([62.81.186.19]:51957 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261600AbULBMwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 07:52:00 -0500
Date: Thu, 02 Dec 2004 12:51:59 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
To: Jens Axboe <axboe@suse.de>
Cc: Markus Plail <linux-kernel@gitteundmarkus.de>,
       linux-kernel@vger.kernel.org
References: <1101763996l.13519l.0l@werewolf.able.es>
	<Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
	<1101765555l.13519l.1l@werewolf.able.es> <20041130071638.GC10450@suse.de>
	<87eki9bs33.fsf@plailis.daheim.bs> <20041202080709.GB10454@suse.de>
In-Reply-To: <20041202080709.GB10454@suse.de> (from axboe@suse.de on Thu Dec  2
	09:07:09 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101991919l.19902l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-J8sOZF5AbfALLqAEDGqW"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-J8sOZF5AbfALLqAEDGqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.12.02, Jens Axboe wrote:
> On Wed, Dec 01 2004, Markus Plail wrote:
> > Jens Axboe <axboe@suse.de> writes:
> >=20
> > > On Mon, Nov 29 2004, J.A. Magallon wrote:
> > >> dev=3DATAPI uses ide-scsi interface, through /dev/sgX. And:
> > >>=20
> > >> > scsibus: -1 target: -1 lun: -1
> > >> > Warning: Using ATA Packet interface.
> > >> > Warning: The related Linux kernel interface code seems to be unmai=
ntained.
> > >> > Warning: There is absolutely NO DMA, operations thus are slow.
> > >>=20
> > >> dev=3DATA uses direct IDE burning. Try that as root. In my box, as r=
oot:
> > >
> > > Oh no, not this again... Please check the facts: the ATAPI method use=
s
> > > the SG_IO ioctl, which is direct-to-device. It does _not_ go through
> > > /dev/sgX, unless you actually give /dev/sgX as the device name. It ha=
s
> > > nothing to do with ide-scsi. Period.
> > >
> > > ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
> > > burning, it's a crippled interface from the CDROM layer that should n=
ot
> > > be used for anything.  scsi-linux-ata.c should be ripped from the
> > > cdrecord sources, or at least cdrecord should _never_ select that
> > > transport for 2.6 kernels. For 2.4 you are far better off using
> > > ide-scsi.
> >=20
> > Are you sure you don't mix ATA with ATAPI? I think ATA is equivalent to
> > dev=3D/dev/hdX.=20
>=20
> I did mix them up, my apologies til Magallon. As always you should just
> use -dev=3D/dev/hdX and it will work the best, there's no need to give AT=
A
> or ATAPI. They are too easy to mix up as the names don't really give you
> any hints on what access method they will utilize. Using -dev also means
> there's no reason to run -scanbus at all, since you know where the
> device is. If you don't, then you probably should be using k3b or some
> other helper to work out things for you.
>=20

Ahh, I'm going to kick my head on the table...
Well, lets begin again. So:
- for 2.4, use ide-scsi
- for 2.6, use ATA
So cdrecord should stop to scan the ATAPI pseudo bus.

My problem is just that I want to set an easy way to burn for users.
In other systems you just hav an app onto you throw your mp3 and get=20
an audio disc, or d'n'd your files and get a cd.
And I don want to tell people to rune mkisofs with a ton of options
(jolliet, rr, long names, etc...). So they must use a GUI tool.
The best I like nowadays is gnomebaker.

The thing is that all frontends use cdrecord. In many you can't specify
the device by hand, they just give you a menu based on cdrecord -scan
output. They should tell cdrecord to scan SCSI and ATA buses, but not ATAPI=
.

And now, as root:

werewolf:~# cdrecord dev=3DATA -scanbus
...
scsibus1:
        1,0,0   100) 'HL-DT-ST' 'DVDRAM GSA-4120B' 'A102' Removable CD-ROM

werewolf:/store/tmp# cdrecord -dev=3DATA:1,0,0 -dao -dummy *.iso
Driver flags   : MMC-3 SWABAUDIO BURNFREE=20
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Speed set to 7056 KB/s
Starting to write CD/DVD at speed  40.0 in dummy SAO mode for single sessio=
n.
...

And as user:

werewolf:~> cdrecord dev=3DATA -scanbus
...
cdrecord: Permission denied. Cannot open '/dev/hda'. Cannot open SCSI drive=
r.
cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you are r=
oot.
cdrecord: For possible transport specifiers try 'cdrecord dev=3Dhelp'.

werewolf:/store/tmp> cdrecord -dev=3DATA:1,0,0 -dummy -dao *.iso
...
cdrecord: Permission denied. Cannot open '/dev/hda'. Cannot open SCSI drive=
r.
cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you are r=
oot.
cdrecord: For possible transport specifiers try 'cdrecord dev=3Dhelp'.

But:

werewolf:/store/tmp> cdrecord -dev=3D/dev/hdc -dummy -dao *.iso
...
cdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).
cdrecord: WARNING: This causes a high risk for buffer underruns.
cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
cdrecord: Permission denied. WARNING: Cannot set priority using setpriority=
().
cdrecord: WARNING: This causes a high risk for buffer underruns.
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
WARNING ! Cannot gain SYS_RAWIO capability !=20
: Operation not permitted
...
Driver flags   : MMC-3 SWABAUDIO BURNFREE=20
Supported modes:                                  < EMPTY AGAIN !!!!!
cdrecord: Drive does not support SAO recording.
cdrecord: Illegal write mode for this drive.

werewolf:/store/tmp> ll /dev/hdc
brw-rw-rw-  1 magallon cdwriter 22, 0 2004.12.01 23:27 /dev/hdc

(pam did it for the console ;))

There are some bugs here:
- One in cdrecord, that exits as soon as it can't open a device, instead
  of trying till it gets the cdwriter.
- Other in cdrecord, the system does not behave the same way if I
  give /dev/hdc or ATA:1,0,0.
- Other in the kernel, that does not allow to query capabilities of the
  drive to a normal user.

I can hackpatch cdrecord, but have no idea of what to do with the kernel.
I remember there were some mails time ago about adding allowed commands to
cdrom/cdwiters, but can't find them.

Perhaps, someday, somwhere, I could burn a disc in Linux as plain user.

Thanks for bearing me...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam4 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


--=-J8sOZF5AbfALLqAEDGqW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBrw/vRlIHNEGnKMMRAuDPAKCXoSHPfcTIFZLDq/Q06t2ffi6J3gCfZ2Mw
0yCwB+4LLR0OS3f3+y2+vbM=
=mcNb
-----END PGP SIGNATURE-----

--=-J8sOZF5AbfALLqAEDGqW--


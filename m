Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135353AbRD3PNQ>; Mon, 30 Apr 2001 11:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135346AbRD3PNG>; Mon, 30 Apr 2001 11:13:06 -0400
Received: from 212-71.dialup.cloud9.net ([168.100.212.71]:15108 "EHLO owl.zoo")
	by vger.kernel.org with ESMTP id <S135345AbRD3PMz>;
	Mon, 30 Apr 2001 11:12:55 -0400
Date: Mon, 30 Apr 2001 11:12:34 -0400
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: Seagate ST340824A and (un)clipping max LBA: 2.2.19+ide04092001 patch
Message-ID: <20010430111232.A8825@eagle.zoo>
In-Reply-To: <UTC200104272222.AAA33242.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <UTC200104272222.AAA33242.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Apr 28, 2001 at 12:22:07AM +0200
From: Alexander Stavitsky <astavitsky@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sat, Apr 28, 2001 at 12:22:07AM +0200, Andries.Brouwer@cwi.nl wrote:

> No. Maybe someone can tell us about its origin, but in your case
> of course this just works because 0xa intersects 0x306b. You might
> comment out this entire test.

If I comment out the entire test, it would try to unclip the capacity of all
drives. Is it safe? For my situation I would prefer to use "setmax"
or disk specific "seagate" (see later), but I do not know how to change
the kernel idea of drive geometry and capacity. I use 2.2.19 + ide patch.
Neither fdisk nor dd would not read past the clipped capacity before or aft=
er
software unclipping.

>=20
> In the case of this particular disk the manufacturer says:
> Use the Set Features command (EF) with subfunction F1.
> That tells the disk to report full capacity.
> (ATA-6 says that F1 is reserved for use by the Compact Flash Association)
>=20
> [Could you try that and report identify output before and after?]

Yes, I tried that and it does report unclipped capacity.
seagate.c is attached for reference.

stalex@eagle:~$ sudo hdparm -I /dev/hdb
/dev/hdb:

 Model=3DTS438042 A                              , FwRev=3D.350    , Serial=
No=3DH30E0186           =20
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D0
 BuffType=3Dunknown, BuffSize=3D2048kB, MaxMultSect=3D16, MultSect=3D?16?
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D66055248
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4=20
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5=20
stalex@eagle:~$ sudo /usr/src/seagate /dev/hdb
Using device /dev/hdb
Sending Set Features F1 subcommand
Done.
stalex@eagle:~$ sudo hdparm -I /dev/hdb

/dev/hdb:

 Model=3DTS438042 A                              , FwRev=3D.350    , Serial=
No=3DH30E0186           =20
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D0
 BuffType=3Dunknown, BuffSize=3D2048kB, MaxMultSect=3D16, MultSect=3D?16?
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D78165360
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4=20
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5=20


--=20
  =3D	mailto:astavitsky@yahoo.com
 =3D=3D=3D	http://www.geocities.com/astavitsky
=3D=3D=3D=3D=3D	GPG Key 0xF7343C8B: 68DD 1E1B 2C98 D336 E31F  C87B 91B9 524=
4 F734 3C8B
  |_____Alexander Stavitsky=20

--tThc/1wpZn/ma/RB
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="seagate.c"

#include <stdio.h>
#include <fcntl.h>
//#include <linux/ide.h>
#include <linux/hdreg.h>

#define SEAGATE_REPORT_FULL_CAPACITY	0xF1

int
get_identity(int fd) {
	unsigned char args[4+512] = {WIN_IDENTIFY,0,0,1,};
	struct hd_driveid *id = (struct hd_driveid *)&args[4];

	if (ioctl(fd, HDIO_DRIVE_CMD, &args)) {
		perror("HDIO_DRIVE_CMD");
		fprintf(stderr,
			"WIN_IDENTIFY failed - trying WIN_PIDENTIFY\n");
		args[0] = WIN_PIDENTIFY;
		if (ioctl(fd, HDIO_DRIVE_CMD, &args)) {
			perror("HDIO_DRIVE_CMD");
			fprintf(stderr,
			       "WIN_PIDENTIFY also failed - giving up\n");
			exit(1);
		}
	}

	printf("id->command_set_1: 0x%X\n", id->command_set_1);
	printf("id->lba_capacity: %lu\n", id->lba_capacity);
}

/*
 * result: in LBA mode precisely what is expected
 *         in CHS mode the correct H and S, and C mod 65536.
 */

int
set_feature(int fd) {
    unsigned char args[4] = {WIN_SETFEATURES,0,0xf1,0};
    int i;

    if (ioctl(fd, HDIO_DRIVE_CMD, &args)) {
	perror("HDIO_DRIVE_CMD failed WIN_SETFEATURES");
	for (i=0; i<4; i++)
	    printf("%d = 0x%X\n", args[i], args[i]);
	    exit(1);
    }

    return 0;
}

main(int argc, char **argv){
	int fd, c;

	char *device = NULL;	/* e.g. "/dev/hda" */
	int slave = 0;

	device = argv[1];
	if (!device) {
		fprintf(stderr, "no device specified - "
			"use e.g. \"seagate /dev/hdb\"\n");
		exit(1);
	}
	printf("Using device %s\n", device);

	fd = open(device, O_RDONLY);
	if (fd == -1) {
		perror("open");
		exit(1);
	}
	printf("Sending Set Features F1 subcommand\n");
	set_feature(fd);
	printf("Done.\n");

	return 0;
}

--tThc/1wpZn/ma/RB--

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67YDgkblSRPc0PIsRAl65AKCyuIbpYuhFZjb+/tGlp4CuRHkVrwCfTZo0
ryxo3vIU6odZh0gg8HVnE7U=
=k7DQ
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUJHUMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUJHUMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUJHUMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:12:06 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:20192 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263818AbUJHULy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:11:54 -0400
Date: Fri, 8 Oct 2004 21:11:46 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: blaisorblade_spam@yahoo.it, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is
 right for sector_t
In-Reply-To: <20041008121239.464151bd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0410082105351.26699@hermes-1.csi.cam.ac.uk>
References: <20041008144034.EB891B557@zion.localdomain>
 <20041008121239.464151bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-341398517-1097266306=:26699"
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-341398517-1097266306=:26699
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Oct 2004, Andrew Morton wrote:
> blaisorblade_spam@yahoo.it wrote:
> > The Device Manager code barfs when sector_t is 64bit wide (i.e. an u64)=
;
> > this can happen with CONFIG_LBD on i386, too, but sector_t is usually a=
 long.
> > And region_t, chunk_t are typedefs for sector_t.
> >=20
> > The problem is this code in drivers/md/dm.h (wouldn't we better fix the
> > FIXME?):
> >=20
> > /*
> >  * FIXME: I think this should be with the definition of sector_t
> >  * in types.h.
> >  */
> > #ifdef CONFIG_LBD
> > #define SECTOR_FORMAT "%Lu"
> > #else
> > #define SECTOR_FORMAT "%lu"
> > #endif
> >=20
> > Btw, x86_64 does not need to define sector_t on its own.
> > If there is any _good_ reason for that, the fix becomes adding a=20
> > #define SECTOR_FORMAT "%Lu"
> > in fact, gcc tries to be smart for warnings to ensure portability; so, =
even
> > when sizeof(long) =3D=3D sizeof(long long), "%ld" and "%Ld" are differe=
nt, for the
> > warnings).
> >=20
> > Sample warnings (from both 2.6.8.1 and 2.6.9-rc2):
> > drivers/md/dm-raid1.c: In function `get_mirror':
> > drivers/md/dm-raid1.c:930: warning: long unsigned int format, sector_t =
arg (arg 3)
> > drivers/md/dm-raid1.c: In function `mirror_status':
> > drivers/md/dm-raid1.c:1200: warning: long unsigned int format, region_t=
 arg (arg 4)
> > drivers/md/dm-raid1.c:1200: warning: long unsigned int format, region_t=
 arg (arg 5)
> > drivers/md/dm-raid1.c:1206: warning: long unsigned int format, sector_t=
 arg (arg 5)
> > drivers/md/dm-raid1.c:1212: warning: long unsigned int format, sector_t=
 arg (arg 5)
> >=20
>=20
> I would prefer that SECTOR_FORMAT be removed altogether.
>=20
> The industry-standard way of printing a sector_t is:
>=20
> =09printk("%llu", (unsigned long long)sector);
>=20
> Or %Ld or %llo or whatever.  The key point is that the format string shou=
ld
> specify long long and the argument should be typecast to long long.

Actually %Ld is completely wrong.  I know in the kernel it makes no=20
difference but people see it in the kernel and then go off an use it in=20
userspace and it generates junk output on at least some architectures. =20
This is because %L means "long double (floating point)" not "long long=20
integer" and when you stuff an integer into it it goes wrong (on some=20
architectures)...  From the printf(3) man page:

ll     (ell-ell).   A  following integer conversion corre=AD
       sponds to a long long int or unsigned long long int
       argument,  or  a following n conversion corresponds
       to a pointer to a long long int argument.

L      A following a, A, e, E, f, F, g,  or  G  conversion
       corresponds to a long double argument.  (C99 allows
       %LF, but SUSv2 does not.)

Best regards,

=09Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
--1870869256-341398517-1097266306=:26699--

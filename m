Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVBHR1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVBHR1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVBHR1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:27:21 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:30889 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261591AbVBHRZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:25:11 -0500
Date: Tue, 8 Feb 2005 11:24:50 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8)
Message-ID: <20050208172450.GA3598@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us> <20050207142603.A469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20050207142603.A469@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2005 at 02:26:03PM -0800, Chris Wright wrote:
> * Michael Halcrow (mhalcrow@us.ibm.com) wrote:
> > This is the third in a series of eight patches to the BSD Secure
> > Levels LSM.  It moves the claim on the block device from the inode
> > struct to the file struct in order to address a potential
> > circumvention of the control via hard links to block devices.  Thanks
> > to Serge Hallyn for pointing this out.
>=20
> Hard links still point to same inode, what's the issue that this
> addresses?

Actually, it turns out that hard links have nothing to do with the
vulnerability that this patch addresses:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

int main()
{
        int fd1, fd2;
        int rc;
        fd1 =3D open( "/dev/device", O_RDONLY );
        fd2 =3D open( "/dev/device", O_RDWR );
        close(fd1);
        getchar();
        rc =3D write( fd2, "0", 1 );
        printf( "write result: [%d]\n", rc );
        close( fd2 );
        return 0;
}

While the program is waiting for a keystroke, mount the block device.
Enter a keystroke.  The result without the patch is 1, which is a
security violation.  This occurs because the bd_release function will
bd_release(bdev) and set inode->i_security to NULL on the close(fd1).
Hence, we want to place the control at the level of the file struct,
not the inode.

Mike
=2E___________________________________________________________________.
                         Michael A. Halcrow                         =20
       Security Software Engineer, IBM Linux Technology Center      =20
GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D

The hokey pokey... What if that's really what it's all about?=20

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCCPXiLTz92j62YB0RAuGqAKDvDPB2Q6bqc6/DB6bfrKt6wl7frACg8jvg
FJG0b3v4CziKSzm0COYmFm4=
=VmGD
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

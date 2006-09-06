Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbWIFBwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbWIFBwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWIFBwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:52:14 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:13994 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S965226AbWIFBwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:52:12 -0400
Date: Tue, 5 Sep 2006 21:53:37 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, cmm@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       ext4 <linux-ext4@vger.kernel.org>
Subject: Re: BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
Message-ID: <20060906015337.GC16449@ele.uri.edu>
References: <20060905171049.GB27433@ele.uri.edu> <44FDE6E5.3090009@us.ibm.com> <20060905214703.GA16449@ele.uri.edu> <1157496228.23501.21.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <1157496228.23501.21.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.13 [Linux 2.6.17.11-grsec-b0rg i686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:43 Tue 05 Sep     , Badari Pulavarty wrote:
> On Tue, 2006-09-05 at 17:47 -0400, Will Simoneau wrote:
> > On 14:06 Tue 05 Sep     , Badari Pulavarty wrote:
> > > Will Simoneau wrote:
> > > >Has anyone seen this before? These three traces occured at different=
 times
> > > >today when three new user accounts (and associated quotas) were crea=
ted.=20
> > > >This
> > > >machine is an NFS server which uses quotas on an ext3 fs (dir_index =
is on).
> > > >Kernel is 2.6.17.11 on an x86 smp w/64G highmem; 4G ram is installed=
=2E The
> > > >affected filesystem is on a software raid1 of two hardware raid0 vol=
umes=20
> > > >from a
> > > >megaraid card.
> > > >
> > > >BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
> > > > <c01c5140> ext3_getblk+0x98/0x2a6  <c03b2806> md_wakeup_thread+0x26=
/0x2a
> > > > <c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0=
x1ae
> > > > <c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0=
x107
> > > > <c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1=
e7
> > > > <c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
>=20
> I think, we found your problem.
>=20
> ext3_getblk() is not handling HOLE correctly. Does this patch help ?
> Mingming, what do you think ?
>=20
> Thanks,
> Badari
>=20
> ext3_get_blocks_handle() returns number of blocks it mapped.
> It returns 0 in case of HOLE. ext3_getblk() should handle
> HOLE properly (currently its dumping warning stack and
> returning -EIO).
>=20
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> ---
>  fs/ext3/inode.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> Index: linux-2.6.18-rc5/fs/ext3/inode.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.18-rc5.orig/fs/ext3/inode.c	2006-08-27 20:41:48.000000000 -=
0700
> +++ linux-2.6.18-rc5/fs/ext3/inode.c	2006-09-05 15:32:57.000000000 -0700
> @@ -1009,11 +1009,12 @@ struct buffer_head *ext3_getblk(handle_t
>  	buffer_trace_init(&dummy.b_history);
>  	err =3D ext3_get_blocks_handle(handle, inode, block, 1,
>  					&dummy, create, 1);
> -	if (err =3D=3D 1) {
> +	/*
> +	 * ext3_get_blocks_handle() returns number of blocks
> +	 * mapped. 0 in case of a HOLE.
> +	 */
> +	if (err > 0) {
>  		err =3D 0;
> -	} else if (err >=3D 0) {
> -		WARN_ON(1);
> -		err =3D -EIO;
>  	}
>  	*errp =3D err;
>  	if (!err && buffer_mapped(&dummy)) {

Unfortunately this will be difficult for me to test as the machine is a
production server, I will try it when I get a chance to offline for a
few minutes.

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/iohLYBaX8VDLLURAvjfAJ0fPVvauhKyhzPW6cCxqqQZd0nF6wCgie2Z
dUGqN1QDcNtNy25WB3LSW04=
=6oUP
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

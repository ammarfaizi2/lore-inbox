Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbULGSUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbULGSUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbULGSUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:20:49 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:28126 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261879AbULGSQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:16:53 -0500
Date: Tue, 7 Dec 2004 11:16:50 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: BUG in fs/ext3/dir.c
Message-ID: <20041207181650.GK2064@schnapps.adilger.int>
Mail-Followup-To: Holger Kiehl <Holger.Kiehl@dwd.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Theodore Ts'o <tytso@mit.edu>
References: <Pine.LNX.4.58.0412070953190.11134@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lildS9pRFgpM/xzO"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412070953190.11134@diagnostix.dwd.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lildS9pRFgpM/xzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 07, 2004  09:56 +0000, Holger Kiehl wrote:
> When using readdir() on a directory with many files or long file names
> it can happen that it returns the same file name twice. Attached is
> a program that demonstrates this. To produce the error start the program
> as follows:
>=20
>      ./a.out 200 20
>      BUG: 00000000000000000061 appears twice!
>      stat() error (testbugdir/input/00000000000000000061) : No such file =
or directory
>      BUG: 00000000000000000061 appears twice!
>      unlink() error (testbugdir/output/00000000000000000061) : No such fi=
le or directory
>=20
> or:
>=20
>      ./a.out 50 61
>      BUG: 0000000000000000000000000000000000000000000000000000000000020 a=
ppears twice!
>      stat() error (testbugdir/input/0000000000000000000000000000000000000=
000000000000000000000020) : No such file or directory
>      unlink() error (testbugdir/output/0000000000000000000000000000000000=
000000000000000000000000020) : No such file or directory
>=20
> First parameter is the number of files, second the file name length.
>=20
> I have traced this problem back to linux-2.6.10-rc1-bk18 and all kernels
> after this one are effected. linux-2.6.10-rc1-bk17 is okay. If I reverse
> the following patch in linux-2.6.10-rc1-bk18, readdir() works again
> correctly:

This patch was added by Ted & Andrew because of some other problem when
handling duplicate hash values.  It looks like the relevant thread is at:

http://marc.theaimsgroup.com/?t=3D110062880800001&r=3D1&w=3D4

#       When there are more than one entry in fname linked list, the current
#       implementation of ext3_dx_readdir() can not traverse all entries
#       correctly in the case that call_filldir() fails.
#  =20
#       If we use system call readdir() to read entries in a directory which
#       happens that "." and ".." in the same fname linked list.  Each time=
 we
#       call readdir(), it will return the "." entry and never returns 0 wh=
ich
#       indicates that all entries are read.
#  =20
#       Although chances that more than one entry are in one fname linked l=
ist
#       are very slim, it does exist.

> diff -Nru linux-2.6.10-rc1-bk17/fs/ext3/dir.c linux-2.6.10-rc1-bk18/fs/ex=
t3/dir.c
> --- linux-2.6.10-rc1-bk17/fs/ext3/dir.c	2004-10-18 23:54:30.000000000 +02=
00
> +++ linux-2.6.10-rc1-bk18/fs/ext3/dir.c	2004-12-05 16:44:21.000000000 +01=
00
> @@ -418,7 +418,7 @@
>  				get_dtype(sb, fname->file_type));
>  		if (error) {
>  			filp->f_pos =3D curr_pos;
> -			info->extra_fname =3D fname->next;
> +			info->extra_fname =3D fname;
>  			return error;
>  		}
>  		fname =3D fname->next;
> @@ -457,9 +457,12 @@
>  	 * If there are any leftover names on the hash collision
>  	 * chain, return them first.
>  	 */
> -	if (info->extra_fname &&
> -	    call_filldir(filp, dirent, filldir, info->extra_fname))
> -		goto finished;
> +	if (info->extra_fname) {
> +		if(call_filldir(filp, dirent, filldir, info->extra_fname))
> +			goto finished;
> +		else
> +			goto next_entry;
> +	}
> =20
>  	if (!info->curr_node)
>  		info->curr_node =3D rb_first(&info->root);
> @@ -492,7 +495,7 @@
>  		info->curr_minor_hash =3D fname->minor_hash;
>  		if (call_filldir(filp, dirent, filldir, fname))
>  			break;
> -
> +next_entry:
>  		info->curr_node =3D rb_next(info->curr_node);
>  		if (!info->curr_node) {
>  			if (info->next_hash =3D=3D ~0) {
>=20
> Regards,
> Holger
> --=20
> #include <stdio.h>
> #include <string.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <dirent.h>
> #include <fcntl.h>
> #include <errno.h>
>=20
> int
> main(int argc, char *argv[])
> {
>    int           fd, filename_length, i, j, no_of_files;
>    char          pathname[256], *ptr,
>                  prevname[256],
>                  to_pathname[256], *to_ptr;
>    DIR           *dp;
>    struct dirent *p_dir;
>    struct stat   stat_buf;
>=20
>    if (argc !=3D 3)
>    {
>       fprintf(stderr, "Usage: %s <no. of files> <filename length>\n", arg=
v[0]);
>       exit(1);
>    }
>    else
>    {
>       no_of_files =3D atoi(argv[1]);
>       filename_length =3D atoi(argv[2]);
>    }
>=20
>    /* Create necessary dirs. */
>    (void)mkdir("testbugdir", S_IRUSR|S_IWUSR|S_IXUSR);
>    (void)mkdir("testbugdir/input", S_IRUSR|S_IWUSR|S_IXUSR);
>    (void)mkdir("testbugdir/output", S_IRUSR|S_IWUSR|S_IXUSR);
>=20
>    /* Create input files. */
>    strcpy(pathname, "testbugdir/input/");
>    ptr =3D pathname + strlen(pathname);
>    for (i =3D 0; i < no_of_files; i++)
>    {
>       sprintf(ptr, "%0*d", filename_length, i);
>       if ((fd =3D open(pathname, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR)=
) =3D=3D -1)
>       {
>          fprintf(stderr, "open() error %s : %s\n", pathname, strerror(err=
no));
>          exit(1);
>       }
>       close(fd);
>    }
>=20
>    /* Move input files to output. */
>    strcpy(to_pathname, "testbugdir/output/");
>    to_ptr =3D to_pathname + strlen(to_pathname);
>    *ptr =3D '\0';
>    if ((dp =3D opendir(pathname)) =3D=3D NULL)
>    {
>       fprintf(stderr, "opendir() error (%s) : %s\n",
>               pathname, strerror(errno));
>       exit(1);
>    }
>    prevname[0] =3D '\0';
>    while ((p_dir =3D readdir(dp)) !=3D NULL)
>    {
>       if (p_dir->d_name[0] =3D=3D '.')
>       {
>          continue;
>       }
>       if (strcmp(prevname, p_dir->d_name) =3D=3D 0)
>       {
>          fprintf(stderr, "BUG: %s appears twice!\n", p_dir->d_name);
>       }
>       strcpy(prevname, p_dir->d_name);
>       strcpy(ptr, p_dir->d_name);
>       if (stat(pathname, &stat_buf) < 0)
>       {
>          fprintf(stderr, "stat() error (%s) : %s\n",
>                  pathname, strerror(errno));
>          continue;
>       }
>       strcpy(to_ptr, p_dir->d_name);
>       if (rename(pathname, to_pathname) =3D=3D -1)
>       {
>          fprintf(stderr, "rename() error (file %d) : %s\n",
>                  pathname, strerror(errno));
>       }
>    }
>    (void)closedir(dp);
>=20
>    /* Remove everyting. */
>    *to_ptr =3D '\0';
>    if ((dp =3D opendir(to_pathname)) =3D=3D NULL)
>    {
>       fprintf(stderr, "opendir() error (%s) : %s\n",
>               to_pathname, strerror(errno));
>       exit(1);
>    }
>    prevname[0] =3D '\0';
>    while ((p_dir =3D readdir(dp)) !=3D NULL)
>    {
>       if (p_dir->d_name[0] =3D=3D '.')
>       {
>          continue;
>       }
>       if (strcmp(prevname, p_dir->d_name) =3D=3D 0)
>       {
>          fprintf(stderr, "BUG: %s appears twice!\n", p_dir->d_name);
>       }
>       strcpy(prevname, p_dir->d_name);
>       strcpy(to_ptr, p_dir->d_name);
>       if (unlink(to_pathname) =3D=3D -1)
>       {
>          fprintf(stderr, "unlink() error (%s) : %s\n",
>                  to_pathname, strerror(errno));
>          continue;
>       }
>    }
>    (void)closedir(dp);
>    if (rmdir("testbugdir/input") =3D=3D -1)
>    {
>       fprintf(stderr, "rmdir() error (testbugdir/input) : %s\n",
>               strerror(errno));
>    }
>    if (rmdir("testbugdir/output") =3D=3D -1)
>    {
>       fprintf(stderr, "rmdir() error (testbugdir/output) : %s\n",
>               strerror(errno));
>    }
>    if (rmdir("testbugdir") =3D=3D -1)
>    {
>       fprintf(stderr, "rmdir() error (testbugdir) : %s\n", strerror(errno=
));
>    }
>=20
>    exit(0);
> }


Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--lildS9pRFgpM/xzO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBtfOSpIg59Q01vtYRAvPfAKCksoaGYVn6Q0U6vVTvzhMMCjdfFACg76TP
GA/Uac2egCFv/TOMlHEEhTA=
=80BL
-----END PGP SIGNATURE-----

--lildS9pRFgpM/xzO--

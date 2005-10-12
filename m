Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVJLInm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVJLInm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 04:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVJLInm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 04:43:42 -0400
Received: from cimice0.lam.cz ([212.71.168.90]:23751 "EHLO cimice.yo.cz")
	by vger.kernel.org with ESMTP id S932401AbVJLInl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 04:43:41 -0400
Date: Wed, 12 Oct 2005 10:43:24 +0200
From: Jan Hudec <bulb@ucw.cz>
To: David Teigland <teigland@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051012084323.GC21612@djinn>
References: <20051010171052.GL22483@redhat.com> <20051010213748.GQ7992@ftp.linux.org.uk> <20051011213811.GA15913@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <20051011213811.GA15913@redhat.com>
User-Agent: Mutt/1.5.11
X-Spam-Score: -4.5 (----)
X-Spam-Report: Spam detection software, running on "shpek.cybernet.src", has inspected this
	incomming email and gave it -4.5 points (spam is above 5.0)
	Content analysis details:
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.9 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2005 at 16:38:11 -0500, David Teigland wrote:
> On Mon, Oct 10, 2005 at 10:37:48PM +0100, Al Viro wrote:
> > On Mon, Oct 10, 2005 at 12:10:52PM -0500, David Teigland wrote:
> > > There are a variety of mount options, tunable parameters, internal
> > > statistics, and methods of online file system manipulation.
> >=20
> > Could you explain WTF are you doing with rename here?  This pile of
> > ioctls is every bit as bad as sys_reiser4(); kindly provide a detailed
> > description of the API you've introduced and explain why nothing saner
> > would do...
>=20
> First some background that I've copied from elsewhere:  The superblock
> contains a pointer to a "master" directory that contains various system
> inodes.  The inodes in the master directory are:
>=20
> 1) A directory named "jindex" containing all the journal files.  The
>    journals are named "journal0", "journal1", ..., "journalX"
>=20
> 2) A directory named "per_node" that contains a bunch of files where
>    each node can store data specific to that node.  Each node has
>    files "inum_rangeX", "statfs_changeX", "unlinked_tagX", and
>    "quota_changeX".  So, there are a set of these four files for each
>    journal in the jindex directory.
>=20
> 3) A file named "inum" that contains the next cluster-wide inode number.
>=20
> 4) A file named "statfs" that contains the cluster-wide statfs
>    information.
>=20
> 5) A file named "rindex" that contains the locations of all the RGs in
>    the filesystem.  (RG's =3D=3D resource groups =3D=3D allocation groups)
>=20
> 6) A file named "quota" that contains the quota values (UID and GID)
>    for the filesystem.
>=20
> 7) A directory named "root" that is the root directory of the
>    user-visible filesystem.
>=20
> The ioctls "hfile_stat", "hfile_read", "hfile_write", "hfile_trunc" are
> used to operate on the hidden system files.  I notice we're not using
> trunc, so it can be removed.  stat/read/write could be replaced with a few
> specific ioctl's if that's preferred.

They are normal directories and normal files, except they are not
exposed in the mount-point, right? Then why don't you simply provide a
directory handle for the master directory and use normal filesystem
operations for the rest?

That way you would have just one ioctl -- getmasterdir. The tool would
fchdir to the handle returned and manipulate the files from there with
normal syscalls. It would still see to the user-visible part throught
the root directory too (since bind mounts are supported, this should not
be a problem).

Or you could do even without ioctls. Just expose the files via /proc

> The next issue is adding journals (and the associated system files) to a
> fs.  The gfs2_jadd command does this with the fs online.  If you created
> the fs with 8 journals and you now want 12 machines to mount it at once,
> you need to add 4 journals by running "gfs2_jadd -j 4 /path/to/fs".
>=20
> Say gfs2_jadd is adding a 9th journal (id 8) ...
>=20
>   creates ordinary file /.gfs2_admin/new_inode
>   writes to new_inode initializing it as an inum_range file
>   moves .gfs2_admin/new_inode to per_node/inum_range8
>=20
>   creates ordinary file /.gfs2_admin/new_inode
>   writes to new_inode initializing it as a statfs_change file
>   moves .gfs2_admin/new_inode to per_node/statfs_change8
>=20
>   same for unlinked_tag8 and quota_change8
>=20
>   creates ordinary file /.gfs2_admin/new_inode
>   writes to new_inode initializing it as a journal file
>   moves .gfs2_admin/new_inode to jindex/journal8
>=20
>   (keeping in mind that the "per_node" and "jindex" dirs and the files
>    under them are in the hidden/system portion of the fs)
>=20
> The create and write steps use ordinary system calls.  The "move" step
> uses the "rename2system" ioctl to move .gfs2_admin/new_inode to the
> specified system file.  The new files are synced before being renamed so
> in case of a crash only correctly formed files are found in the hidden
> dirs.  Only when the final journal file is moved into place is the fs
> ready to accept a new mounter.

And with directory handle, you would just chdir there and do:
rename("root/.gfs2_admin/new_inode", "jindex/journal8")

> Next is exapanding the size of the fs.  To do this, gfs2_grow first opens
> the device and initializes the new space with RG headers.  Second, it uses
> the "resize_add_rgrps" ioctl to add new structures defining the space to
> the "rindex" system file.  I'm looking into using hfile_write for this.

Ok, if it can't be done with write, it probably needs something like
ioctl. Though it could be an ioctl on that file, not on the device...

> Other ioctls:
>   get_super - copy struct gfs2_sb to user space
>   get_file_stat - copy struct gfs2_dinode to user space for given file
>   set_file_flag - set gfs-specific flag in inode
>   get_bmap - map file block to disk block
>   get_file_meta - return all the metadata for a file or dir
>   do_file_flush - sync out all dirty data and drop the cache and lock
>   do_quota_sync - sync outstanding quota change (moving to sysfs)
>   do_quota_refresh - refresh quota lvb from the quota file (moving to sys=
fs)
>   do_quota_read - read quota values from quota file
>=20
> Some of these we could do without if they're objectionable.  Regardless,
> we'll take a closer look to see if any don't qualify as useful enough.

Some of them would be better off as procfs or sysfs entries.

IIRC get_bmap exists elsewhere too, so that should be ok. And
get_file_meta probably won't do without ioctl either.

Wouldn't the get_file_stat be included in get_file_meta?

> Finally, how ioctl is implemented.  All the commands above are multiplexed
> through one actual ioctl (GFS2_IOCTL_SUPER) that passes in:
>=20
> struct gfs2_ioctl {
>         unsigned int gi_argc;
>         char **gi_argv;
>=20
>         char __user *gi_data;
>         unsigned int gi_size;
>         uint64_t gi_offset;
> };
>=20
> - argv[0] is the command string, e.g. "set_file_flag", "rename2system",
> - argv[x] are other string arguments for the command, e.g. for set_file_f=
lag
>   argv[1] is either "set" or "clear".  For rename2system argv[1] is the
>   destination directory and argv[2] is the new name.
> - gi_data, gi_size, gi_offset - data returned to caller when needed
>=20
> This could be exchanged, of course, for the more tradition ioctl mess if
> that's any saner.

Well, if you get rid of the access to files in the master directory by
making that directory visible somehow, you will be left with a bunch of
ioctls on files, which are different enough to warrant individual ioctl
numbers for sake of efficiency.

--
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDTMyrRel1vVwhjGURAqBKAJ9Z5U01L9DYL2Am4uhFCKX9NP38IgCdFHDm
KivdPZt3fI3ir73J/Z8wyOY=
=3G1H
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--

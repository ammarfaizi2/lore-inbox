Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSIAVb5>; Sun, 1 Sep 2002 17:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSIAVb5>; Sun, 1 Sep 2002 17:31:57 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:61346
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318086AbSIAVbn>; Sun, 1 Sep 2002 17:31:43 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15730.27061.640906.564411@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb> <15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb> <15730.4100.308481.326297@charged.uio.no>
	<1030890821.2145.67.camel@ldb> <15730.17012.61365.788871@charged.uio.no>
	<1030905777.2145.91.camel@ldb>  <15730.27061.640906.564411@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-tjMVGSUB1skzMNX0Xo1g"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 23:36:05 +0200
Message-Id: <1030916165.1993.348.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tjMVGSUB1skzMNX0Xo1g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 21:25, Trond Myklebust wrote:
> >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
> 
>      > But you'll need to modify the declaration of the various
>      > function pointers whose implementations might need credentials
>      > and modify all functions that call them and deal with
>      > permissions.  Instead with my proposal the credentials are
> 
> Yes... And this is a useful activity in itself, as the existence of
> all these hacks that temporarily change uid/gid/whatever... show.
I disagree.
It reduces performance, and results in huge patches.
Furthermore you can't predict whether the target of a function pointer
will need credentials or not.

>      > automatically immutable across the syscall without needing to
>      > worry at all about locks, counts and sharing.
> 
> I still have no opinion about your proposal for implementing CLONE_CRED.
> 
> What I fail to see is why you appear to insist it would be
> incompatible with the idea of copy-on-write VFS credentials (which I
> explained are interesting for other purposes).
I don't insist on that (see below).
> I also fail to understand why you insist that we need to drop the idea
> of copy-on-write credentials in order to optimize for this fringe case
> in which somebody calls sys_access() or exec with euid != fsuid.
I do not propose to remove the idea of copy-on-write credentials, just
to use copy-on-write only for groups and "copy-always" for uid and gid
so that access to uid and gid doesn't need to go through the credentials
pointer.

You have code like this:
+                cred = get_current_vfscred();
                 fdata->fd_do_lml = 0;
-                fdata->fd_fsuid = current->fsuid;
-                fdata->fd_fsgid = current->fsgid;
+                fdata->fd_fsuid = cred->uid;
+                fdata->fd_fsgid = cred->gid;
                 fdata->fd_mode = file->f_dentry->d_inode->i_mode;
-                fdata->fd_ngroups = current->ngroups;
-                for (i=0 ; i<current->ngroups ; i++)
-                        fdata->fd_groups[i] = current->groups[i]; 
+                fdata->fd_ngroups = cred->ngroups;
+                for (i=0 ; i<cred->ngroups ; i++)
+                        fdata->fd_groups[i] = cred->groups[i]; 
                 fdata->fd_bytes_written = 0; /*when open,written data is zero*/ 
                 file->private_data = fdata; 
+                put_vfscred(cred);

The get/put here only make sense if something else can modify the
credentials without it.
Otherwise, you can skip them since the reference count will always be >
0 because nothing else can change the current->vfscred pointer, and that
will contribute to the reference count.

What I'm trying to do is to design credentials in such a way that, even
with shared credentials, the get/put won't be necessary.
I'm also trying to put such credentials directly in task_struct so that
the code doesn't need to get a pointer from task_struct and then fetch
the credentials from the structure it points to.

The order of likelyhood of credential operations is assumed to be the
following:
1. Use/copy/local temporary modification of uid and gid
2. Use/copy/local temporary modification of groups
3. Permanent modification of something
* Local temporary modification means that the modification only has
effect on the current task and is revert before the end of the syscall

To optimize for this I propose to:
1. Put uid and gid directly in task_struct (optimize for 1)
2. Use copy-on-write on groups so that we avoid copying an big array
(optimize for 2.copy)
3. Change credentials only when not performing a syscall (optimize for 1
and 2)

>   "changing fsuid/fsgid is *not* the common case that needs optimization."
I completely agree with this, that's the whole point!


--=-tjMVGSUB1skzMNX0Xo1g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cohFdjkty3ft5+cRAngrAKCnV6XCPI3rWgJhA0CHLmX84NQ88wCfdGYy
5mgYrhseoJtLwRqXDkNAE6I=
=RXkm
-----END PGP SIGNATURE-----

--=-tjMVGSUB1skzMNX0Xo1g--

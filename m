Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSHaXJj>; Sat, 31 Aug 2002 19:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSHaXJj>; Sat, 31 Aug 2002 19:09:39 -0400
Received: from ppp-217-133-220-240.dialup.tiscali.it ([217.133.220.240]:49110
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318058AbSHaXJg>; Sat, 31 Aug 2002 19:09:36 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15729.17279.474307.914587@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>  <15729.17279.474307.914587@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-rLUTxxZwM/K9ZY5fJlzx"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 01:13:55 +0200
Message-Id: <1030835635.1422.39.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rLUTxxZwM/K9ZY5fJlzx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-09-01 at 00:30, Trond Myklebust wrote:
> >>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
> 
>      > Then the rest of the code doesn't need to know at all that
>      > credentials are shared and is simpler and faster.  We have
>      > however a larger penalty on credential change but, as you say,
>      > that's extremely rare (well, perhaps not necessarily extremely,
>      > but still rare).
> 
> What if I, in a fit of madness/perversion, decide to use CLONE_CRED
> between 2 kernel threads (i.e. no 'kernel entry')?
You don't or you manually patch the task_struct of the other threads.
This isn't a serious concern.

> Leaving CLONE_CRED aside, please do not forget that most of the
> motivation for vfs_cred is the need to *cache* credentials.
> This is something which we already do today in several filesystems:
> Coda, Intermezzo, NFS, to name but the most obvious.
> The result of the lack of a VFS-sanctioned credential is that we have
> to use 'struct file' as a vehicle for passing credentials in, for
> instance, the address_space_operations, and that each filesystem ends
> up having to keep its own private copies of those credentials in
> file->private_data.
I'm not proposing to not use vfs_cred (the pseudocode I written includes
it).
I'm just suggesting a way to speed up access to credentials.
Your code does get_current_vfscred()/put_vfscred() in normal paths and
accesses credentials with an indirect pointer.
Furthermore, setting the uid and gid are very expensive since they need
to break copy-on-write.
If we instead only allow changes to credentials on kernel mode entry, we
don't have to worry about changing credentials and the code becomes
simpler and faster.
It also seems better to only copy-on-write groups and just copy uid and
gid.


For example, rather than this;
-               uid_t saved_fsuid = current->fsuid;
+               struct vfs_cred *saved_cred = get_current_vfscred();
                kernel_cap_t saved_cap = current->cap_effective;
 
                /* Create RPC socket as root user so we get a priv port
*/
-               current->fsuid = 0;
+               setfsuid(0);
                cap_raise (current->cap_effective,
CAP_NET_BIND_SERVICE);
                xprt = xprt_create_proto(host->h_proto, &host->h_addr,
NULL);
-               current->fsuid = saved_fsuid;
+               set_current_vfscred(saved_cred);
+               put_vfscred(saved_cred);

you can just do this:
-               uid_t saved_fsuid = current->fsuid;
+               uid_t saved_fsuid = current->fscred.uid;
                kernel_cap_t saved_cap = current->cap_effective;
 
                /* Create RPC socket as root user so we get a priv port
*/
-               current->fsuid = 0;
+               current->fscred.uid = 0;
                cap_raise (current->cap_effective,
CAP_NET_BIND_SERVICE);
                xprt = xprt_create_proto(host->h_proto, &host->h_addr,
NULL);
-               current->fsuid = saved_fsuid;
+               current->fscred.uid = saved_fsuid;

(here the fscred is the one called cred in the pseudocode: fscred is a
better name).

This code uses vfs_cred but is as fast as the old one while the one in
your patch is significantly slower (e.g. compare your setfsuid with
current->fscred.uid = xxx).
If you then need to keep the vfs_cred data for longer than a single
syscall, just copy it like you would do in the propagation code.
That means copying the structure and then incrementing the reference
count on groups.


--=-rLUTxxZwM/K9ZY5fJlzx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cU2ydjkty3ft5+cRAh/KAJ4qQEbGwGDrHwWOZAcSXCOAjxd5SQCgvOXj
7Rh5tF2rEn3SZ9C0atPvPdU=
=558f
-----END PGP SIGNATURE-----

--=-rLUTxxZwM/K9ZY5fJlzx--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWBTEdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWBTEdW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 23:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWBTEdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 23:33:22 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:26088 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932610AbWBTEdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 23:33:22 -0500
Date: Mon, 20 Feb 2006 15:32:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: apgo@patchbomb.org, linuxppc64-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>,
       "David S. Miller" <davem@davemloft.net>,
       LKML <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: [PATCH] Fix compile for CONFIG_SYSVIPC=n or CONFIG_SYSCTL=n
Message-Id: <20060220153226.30ee4b13.sfr@canb.auug.org.au>
In-Reply-To: <17400.23551.904754.47979@cargo.ozlabs.ibm.com>
References: <20060218100849.GA1869@krypton>
	<17400.23551.904754.47979@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__20_Feb_2006_15_32_26_+1100_qotKnBzPXZAVYPoN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__20_Feb_2006_15_32_26_+1100_qotKnBzPXZAVYPoN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The compat syscalls are added to sys_ni.c since they are not defined
if the above CONFIG options are off. Also, nfs would not build with
CONFIG_SYSCTL off.

Noticed by Arthur Othieno.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/linux/nfs_fs.h |    2 +-
 kernel/sys_ni.c        |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

On Sun, 19 Feb 2006 22:52:31 +1100 Paul Mackerras <paulus@samba.org> wrote:
>
> Arthur Othieno writes:
>=20
> > --- a/arch/powerpc/kernel/sys_ppc32.c
> > +++ b/arch/powerpc/kernel/sys_ppc32.c
> > @@ -440,7 +440,13 @@ long compat_sys_ipc(u32 call, u32 first,
> > =20
> >  	return -ENOSYS;
> >  }
> > -#endif
> > +#else
> > +long compat_sys_ipc(u32 call, u32 first, u32 second, u32 third, compat=
_uptr_t ptr,
> > +	       u32 fifth)
> > +{
> > +	return -ENOSYS;
> > +}
> > +#endif /* CONFIG_SYSVIPC */
>=20
> Can't we just add a couple of cond_syscall lines to kernel/sys_ni.c
> instead?

Linus, can we have this applied for 2.6.16.  It presumably affects sparc64
(at least for CONFIG_SYSVIPC) as well as powerpc.  The NFS fix would
affect all architectures, I think?

This has been compile tested with the CONFIG options on and off for powerpc.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

c1a27bc400a1412c7c758775bb695e8b98d1c0c3
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 547d649..b4dc6e2 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -398,7 +398,7 @@ extern struct inode_operations nfs_symli
 extern int nfs_register_sysctl(void);
 extern void nfs_unregister_sysctl(void);
 #else
-#define nfs_register_sysctl() do { } while(0)
+#define nfs_register_sysctl() 0
 #define nfs_unregister_sysctl() do { } while(0)
 #endif
=20
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 17313b9..1067090 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -104,6 +104,8 @@ cond_syscall(sys_setreuid16);
 cond_syscall(sys_setuid16);
 cond_syscall(sys_vm86old);
 cond_syscall(sys_vm86);
+cond_syscall(compat_sys_ipc);
+cond_syscall(compat_sys_sysctl);
=20
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
--=20
1.2.1


--Signature=_Mon__20_Feb_2006_15_32_26_+1100_qotKnBzPXZAVYPoN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD+UZaFdBgD/zoJvwRAhUcAJwLauf5ZXKgi7hkdTC9OofcuD1fCQCeKvo/
08JkqBfA7JjSJ3PX9Vw5Rz8=
=XgGe
-----END PGP SIGNATURE-----

--Signature=_Mon__20_Feb_2006_15_32_26_+1100_qotKnBzPXZAVYPoN--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTENEpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 00:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTENEpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 00:45:21 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:11232 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S261878AbTENEpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 00:45:03 -0400
Date: Wed, 14 May 2003 07:57:44 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: David Howells <dhowells@redhat.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PAG support only
Message-ID: <20030514045744.GQ11374@actcom.co.il>
References: <8943.1052843591@warthog.warthog>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NEaRsfQExFH3jWtg"
Content-Disposition: inline
In-Reply-To: <8943.1052843591@warthog.warthog>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NEaRsfQExFH3jWtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2003 at 05:33:11PM +0100, David Howells wrote:
>=20
> Hi Linus,
>=20
> Due to the slight unpopularity of the AFS multiplexor, here's a patch with
> only the PAG support.
>=20
> David

Hi David,=20

Some quetions/comments about the code:=20

> diff -uNr linux-2.5.69/include/linux/cred.h linux-2.5.69-cred/include/lin=
ux/cred.h
> --- linux-2.5.69/include/linux/cred.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.5.69-cred/include/linux/cred.h	2003-05-13 13:20:06.000000000 =
+0100
> @@ -0,0 +1,79 @@
> +#ifndef _LINUX_CRED_H
> +#define _LINUX_CRED_H
> +
> +#ifdef __KERNEL__
> +
> +#include <linux/param.h>
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include <linux/rbtree.h>
> +#include <asm/atomic.h>
> +
> +/*
> + * VFS session authentication token cache
> + *
> + * This is used to store the data required for extra levels of filesystem
> + * security (such as AFS/NFS kerberos keys, Samba workgroup/user/pass, o=
r NTFS
> + * ACLs).
> + *
> + * VFS authentication tokens contain a single blob of data, consisting o=
f three
> + * parts, all next to each other:
> + *   (1) An FS name
> + *   (2) A key
> + *   (3) An arbitrary chunk of data
> + *
> + * Token blobs must not be changed once passed to the core kernel for ma=
nagement

If you know the type of the data, why keep it all in one binary blob,
instead of a struct? cache effects?=20

> diff -uNr linux-2.5.69/kernel/cred.c linux-2.5.69-cred/kernel/cred.c
> --- linux-2.5.69/kernel/cred.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.5.69-cred/kernel/cred.c	2003-05-13 13:21:06.000000000 +0100
> @@ -0,0 +1,367 @@
> +/* cred.c: authentication credentials management
> + *
> + * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/string.h>
> +#include <linux/sched.h>
> +#include <linux/cred.h>
> +
> +static kmem_cache_t *vfs_token_cache;
> +static kmem_cache_t *vfs_pag_cache;
> +
> +static struct rb_root	vfs_pag_tree;
> +static spinlock_t	vfs_pag_lock =3D SPIN_LOCK_UNLOCKED;
> +static pag_t		vfs_pag_next =3D 1;
> +
> +static void vfs_pag_init_once(void *_vfspag, kmem_cache_t *cachep, unsig=
ned long flags)
> +{
> +	struct vfs_pag *vfspag =3D _vfspag;
> +
> +	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) =3D=3D SLAB_CTOR=
_CONSTRUCTOR) {
> +		memset(vfspag,0,sizeof(*vfspag));
> +		INIT_LIST_HEAD(&vfspag->tokens);
> +		rwlock_init(&vfspag->lock);
> +	}
> +}
> +
> +static void vfs_token_init_once(void *_vtoken, kmem_cache_t *cachep, uns=
igned long flags)
> +{
> +	struct vfs_token *vtoken =3D _vtoken;
> +
> +	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) =3D=3D SLAB_CTOR=
_CONSTRUCTOR) {
> +		memset(vtoken,0,sizeof(*vtoken));
> +		INIT_LIST_HEAD(&vtoken->link);
> +	}
> +}
> +
> +void __init credentials_init(void)
> +{
> +	vfs_pag_cache =3D kmem_cache_create("vfs_pag",
> +					      sizeof(struct vfs_pag),
> +					      0,
> +					      SLAB_HWCACHE_ALIGN,
> +					      vfs_pag_init_once, NULL);
> +	if (!vfs_pag_cache)
> +		panic("Cannot create vfs pag SLAB cache");
> +
> +	vfs_token_cache =3D kmem_cache_create("vfs_token",
> +					    sizeof(struct vfs_token),
> +					    0,
> +					    SLAB_HWCACHE_ALIGN,
> +					    vfs_token_init_once, NULL);
> +	if (!vfs_token_cache)
> +		panic("Cannot create vfs token SLAB cache");
> +}
> +
> +/***********************************************************************=
******/
> +/*
> + * join an existing PAG (+ve), run without PAG (0), or create and join n=
ew PAG (-1)
> + * - returns ID of PAG joined or 0 if now running without a PAG
> + */
> +int sys_setpag(pag_t pag)
> +{
> +	struct task_struct *tsk =3D current;
> +	struct vfs_pag *vfspag, *xvfspag;
> +	struct rb_node **p, *parent;
> +
> +	if (pag>0) {
> +		/* join existing PAG */
> +		if (tsk->vfspag->pag &&

Isn't the check here meant to be against tsk->vfspag? If not, there
should be.=20

> +		    tsk->vfspag->pag=3D=3Dpag)
> +			return pag;
> +
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		spin_lock(&vfs_pag_lock);
> +
> +		parent =3D NULL;
> +		p =3D &vfs_pag_tree.rb_node;
> +
> +		while (*p) {
> +			parent =3D *p;
> +			vfspag =3D rb_entry(parent,struct vfs_pag,node);
> +
> +			if (pag < vfspag->pag)
> +				p =3D &(*p)->rb_left;
> +			else if (pag > vfspag->pag)
> +				p =3D &(*p)->rb_right;
> +			else
> +				goto pag_found;
> +		}
> +
> +		spin_unlock(&vfs_pag_lock);
> +		return -ENOENT;
> +
> +	pag_found:
> +		xvfspag =3D xchg(&current->vfspag,vfs_pag_get(vfspag));
> +		spin_unlock(&vfs_pag_lock);
> +
> +		if (xvfspag) vfs_pag_put(xvfspag);
> +		return pag;
> +	}
> +	else if (pag=3D=3D0) {
> +		/* run without a PAG */
> +		xvfspag =3D xchg(&current->vfspag,NULL);
> +
> +		if (xvfspag) vfs_pag_put(xvfspag);
> +		return 0;
> +	}
> +	else if (pag!=3D-1) {
> +		     return -EINVAL;
> +	}
> +
> +	/* start new PAG */
> +	vfspag =3D kmem_cache_alloc(vfs_pag_cache,SLAB_KERNEL);
> +	if (!vfspag)
> +		return -ENOMEM;
> +
> +	atomic_set(&vfspag->usage,1);
> +
> +	/* PAG IDs must be +ve, >0 and unique */
> +	spin_lock(&vfs_pag_lock);
> +
> +	vfspag->pag =3D vfs_pag_next++;
> +	if (vfspag->pag<1)
> +		vfspag->pag =3D 1;

If vfs_pag_next wraps around, you will get two pag's with the value
'1'.=20

> +
> +	parent =3D NULL;
> +	p =3D &vfs_pag_tree.rb_node;
> +
> +	while (*p) {
> +		parent =3D *p;
> +		xvfspag =3D rb_entry(parent,struct vfs_pag,node);
> +
> +		if (vfspag->pag < xvfspag->pag)
> +			p =3D &(*p)->rb_left;
> +		else if (vfspag->pag > xvfspag->pag)
> +			p =3D &(*p)->rb_right;
> +		else
> +			goto pag_exists;
> +	}
> +	goto insert_here;
> +
> +	/* we found a PAG of the same ID - walk the tree from that point
> +	 * looking for the next unused PAG */
> + pag_exists:
> +	for (;;) {
> +		vfspag->pag =3D vfs_pag_next++;
> +		if (vfspag->pag<1)
> +			vfspag->pag =3D 1;

Likewise.=20

> +struct vfs_token *vfs_pag_find_token(const char *fsname,
> +				     unsigned short klen,
> +				     const void *key)
> +{
> +	struct vfs_token *vtoken;
> +	struct vfs_pag *vfspag =3D current->vfspag;
> +
> +	if (!vfspag) return NULL;
> +
> +	read_lock(&vfspag->lock);
> +
> +	list_for_each_entry(vtoken,&vfspag->tokens,link) {
> +		if (vtoken->d_off-vtoken->k_off =3D=3D klen &&
> +		    strcmp(vtoken->blob,fsname)=3D=3D0 &&
> +		    memcmp(vtoken->blob+vtoken->k_off,key,klen)=3D=3D0)
> +			goto found;		   =20
> +	}
> +
> +	read_unlock(&vfspag->lock);
> +	return NULL;
> +
> + found:
> +	read_unlock(&vfspag->lock);
> +	return vtoken;
> +} /* end vfs_pag_find_token() */

Nothing in this patch appears to be using it. You aren't taking a
reference to the token here, what's protecting it from disappearing
after the return and before the caller gets a chance to do something
with it?

> +
> +EXPORT_SYMBOL(vfs_pag_find_token);
> +
> +/***********************************************************************=
******/
> +/*
> + * withdraw a token from a pag list
> + */
> +void vfs_pag_withdraw_token(struct vfs_token *vtoken)
> +{
> +	struct vfs_pag *vfspag =3D current->vfspag;
> +
> +	if (!vfspag)
> +		return;
> +
> +	write_lock(&vfspag->lock);
> +	list_del_init(&vtoken->link);
> +	write_unlock(&vfspag->lock);
> +
> +	vfs_token_put(vtoken);
> +
> +} /* end vfs_pag_withdraw_token() */
> +
> +EXPORT_SYMBOL(vfs_pag_withdraw_token);
> +
> +/***********************************************************************=
******/
> +/*
> + * withdraw all tokens for the named filesystem from the current PAG
> + */
> +void vfs_unpag(const char *fsname)
> +{
> +	struct list_head *_n, *_p;
> +	struct vfs_token *vtoken;
> +	struct vfs_pag *vfspag =3D current->vfspag;
> +
> +	if (!vfspag)
> +		return;
> +
> +	write_lock(&vfspag->lock);
> +
> +	list_for_each_safe(_p,_n,&vfspag->tokens) {
> +		vtoken =3D list_entry(_p,struct vfs_token,link);
> +
> +		if (strcmp(fsname,vtoken->blob)=3D=3D0) {
> +			list_del_init(&vtoken->link);
> +			vfs_token_put(vtoken);
> +		}
> +	}
> +
> +	write_unlock(&vfspag->lock);
> +
> +} /* end vfs_unpag() */

--=20
Muli Ben-Yehuda
http://www.mulix.org


--NEaRsfQExFH3jWtg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wczIKRs727/VN8sRAk5VAKCXsCXyzrfuPB6dw60ACEut3rsAhwCeLXBh
0Y+6LAQifk8VgguWBPHAVc0=
=BJ4f
-----END PGP SIGNATURE-----

--NEaRsfQExFH3jWtg--

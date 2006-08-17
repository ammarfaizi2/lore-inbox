Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWHQXWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWHQXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWHQXWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:22:09 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:38888 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S965154AbWHQXWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:22:06 -0400
Date: Thu, 17 Aug 2006 16:22:03 -0700
From: Seth Arnold <seth.arnold@suse.de>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 2/8] Integrity Service API and dummy provider
Message-ID: <20060817232202.GN2584@suse.de>
Mail-Followup-To: Kylene Jo Hall <kjhall@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSM ML <linux-security-module@vger.kernel.org>,
	Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
	Serge Hallyn <sergeh@us.ibm.com>
References: <1155844392.6788.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="33vRkRs1qLSKUE7/"
Content-Disposition: inline
In-Reply-To: <1155844392.6788.56.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--33vRkRs1qLSKUE7/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2006 at 12:53:12PM -0700, Kylene Jo Hall wrote:
> --- linux-2.6.18-rc3/security/integrity_dummy.c	1969-12-31 18:00:00.00000=
0000 -0600
> +++ linux-2.6.18-rc3-working/security/integrity_dummy.c	2006-08-04 15:30:=
41.000000000 -0500
> @@ -0,0 +1,77 @@
> +/*
> + * integrity_dummy.c
> + *
> + * Instantiate integrity subsystem
> + *
> + * Copyright (C) 2005,2006 IBM Corporation
> + * Author: Mimi Zohar <zohar@us.ibm.com>
> + *
> + *      This program is free software; you can redistribute it and/or mo=
dify
> + *      it under the terms of the GNU General Public License as publishe=
d by
> + *      the Free Software Foundation, version 2 of the License.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/integrity.h>
> +
> +/*
> + *  Return the extended attribute
> + */
> +static int dummy_verify_metadata(struct dentry *dentry, char *xattr_name,
> +				 char **xattr_value, int *xattr_value_len,
> +				 int *status)
> +{
> +	char *value;
> +	int size;
> +	int error;
> +
> +	if (!xattr_value || !xattr_value_len || !status)
> +		return -EINVAL;
> +
> +	if (!dentry || !dentry->d_inode || !dentry->d_inode->i_op
> +	    || !dentry->d_inode->i_op->getxattr) {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	size =3D dentry->d_inode->i_op->getxattr(dentry, xattr_name, NULL, 0);
> +	if (size < 0) {
> +		if (size =3D=3D -ENODATA) {
> +			*status =3D INTEGRITY_NOLABEL;
> +			return 0;
> +		}
> +		return size;
> +	}
> +
> +	value =3D kzalloc(size + 1, GFP_KERNEL);
> +	if (!value)=20
> +		return -ENOMEM;
> +
> +	error =3D dentry->d_inode->i_op->getxattr(dentry, xattr_name,
> +						value, size);
> +	*xattr_value_len =3D size;
> +	*xattr_value =3D value;
> +	*status =3D INTEGRITY_PASS;
> +	return error;
> +}

If the second call to ->getxattr returns an error, is it a good idea to
overwrite the values in xattr_value_len and *xattr_value? Does the
integrity really "pass" if there is an error?

(Or is the point of the 'dummy' verification that .. well .. no
verification is done?)

> +static int dummy_verify_data(struct dentry *dentry, int *status)
> +{
> +	if (status)
> +		*status =3D INTEGRITY_PASS;
> +	return 0;
> +}
> +
> +static void dummy_measure(struct dentry *dentry,
> +			  const unsigned char *filename, int mask)
> +{
> +	return;
> +}
> +
> +struct integrity_operations dummy_integrity_ops =3D {
> +	.verify_metadata =3D dummy_verify_metadata,
> +	.verify_data =3D dummy_verify_data,
> +	.measure =3D dummy_measure
> +};
> --- linux-2.6.18-rc3/include/linux/integrity.h	1969-12-31 18:00:00.000000=
000 -0600
> +++ linux-2.6.18-rc3-working/include/linux/integrity.h	2006-08-04 15:30:4=
1.000000000 -0500
> @@ -0,0 +1,90 @@
> +/*
> + * integrity.h
> + *
> + * Copyright (C) 2005,2006 IBM Corporation
> + * Author: Mimi Zohar <zohar@us.ibm.com>
> + *
> + *      This program is free software; you can redistribute it and/or mo=
dify
> + *      it under the terms of the GNU General Public License as publishe=
d by
> + *      the Free Software Foundation, version 2 of the License.
> + */
> +
> +#ifndef _LINUX_INTEGRITY_H
> +#define _LINUX_INTEGRITY_H
> +
> +#include <linux/fs.h>
> +
> +/*
> + * struct integrity_operations - main integrity structure
> + *
> + * @verify_data:
> + *	Verify the integrity of a dentry.
> + *	@dentry contains the dentry structure to be verified.
> + *	@status contains INTEGRITY_PASS, INTEGRITY_FAIL, or
> + * 		INTEGRITY_NOLABEL
> + *	Return 0 on success or errno values
> + *
> + * @verify_metadata:
> + *	Verify the integrity of a dentry's metadata; return the value
> + * 	of the requested xattr_name and the verification result of the
> + *	dentry's metadata.
> + *	@dentry contains the dentry structure of the metadata to be verified.
> + *	@xattr_name, if not null, contains the name of the xattr
> + *		 being requested.
> + *	@xattr_value, if not null, is a pointer for the xattr value.
> + *	@xattr_val_len will be set to the length of the xattr value.
> + *	@status contains INTEGRITY_PASS, INTEGRITY_FAIL, or
> + * 		INTEGRITY_NOLABEL
> + *	Return 0 on success or errno values
> + *
> + * @measure:
> + *	Update an aggregate integrity value with the inode's measurement.
> + *	The aggregate integrity value is maintained in secure storage such
> + *	as in a TPM PCR.
> + *	@dentry contains the dentry structure of the inode to be measured.
> + *	@filename either contains the full pathname/short file name.
> + *	@mask contains the filename permission status(i.e. read, write, appen=
d).
> + *
> + */

I wouldn't normally expect a function named 'measure' to update a
datastructure, especially not one potentially stored in hardware. Is
this just my unfamiliarity with TPM nomenclature?
What is the proper use of the filename?

> +#define PASS_STR "INTEGRITY_PASS"
> +#define FAIL_STR "INTEGRITY_FAIL"
> +#define NOLABEL_STR "INTEGRITY_NOLABEL"
> +
> +struct integrity_operations {
> +	int (*verify_metadata) (struct dentry *dentry, char *xattr_name,
> +			char **xattr_value, int *xattr_val_len, int *status);
> +	int (*verify_data) (struct dentry *dentry, int *status);
> +	void (*measure) (struct dentry *dentry,
> +			const unsigned char *filename, int mask);
> +};
> +extern int register_integrity(struct integrity_operations *ops);
> +extern int unregister_integrity(struct integrity_operations *ops);
> +
> +/* global variables */
> +extern struct integrity_operations *integrity_ops;
> +enum integrity_verify_status {
> +	INTEGRITY_PASS =3D 0, INTEGRITY_FAIL =3D -1, INTEGRITY_NOLABEL =3D -2
> +};
> +
> +/* inline stuff */
> +static inline int integrity_verify_metadata(struct dentry *dentry,
> +			char *xattr_name, char **xattr_value,
> +			int *xattr_val_len, int *status)
> +{
> +	return integrity_ops->verify_metadata(dentry, xattr_name,
> +			xattr_value, xattr_val_len, status);
> +}
> +
> +static inline int integrity_verify_data(struct dentry *dentry,=20
> +					int *status)
> +{
> +	return integrity_ops->verify_data(dentry, status);
> +}
> +
> +static inline void integrity_measure(struct dentry *dentry,
> +			const unsigned char *filename, int mask)
> +{
> +	return integrity_ops->measure(dentry, filename, mask);
> +}
> +#endif
> --- linux-2.6.18-rc3/security/Makefile	2006-07-30 01:15:36.000000000 -0500
> +++ linux-2.6.18-rc3-working/security/Makefile	2006-08-01 12:21:24.000000=
000 -0500
> @@ -12,6 +13,7 @@ endif
> =20
>  # Object file lists
>  obj-$(CONFIG_SECURITY)			+=3D security.o dummy.o inode.o
> +obj-$(CONFIG_SECURITY)			+=3D integrity.o integrity_dummy.o

Not CONFIG_SECURITY_INTEGRITY or similar?

>  # Must precede capability.o in order to stack properly.
>  obj-$(CONFIG_SECURITY_SELINUX)		+=3D selinux/built-in.o
>  obj-$(CONFIG_SECURITY_CAPABILITIES)	+=3D commoncap.o capability.o

Thanks

--33vRkRs1qLSKUE7/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFE5Poa+9nuM9mwoJkRAqg/AJ42+SA68antWbbwf+l8C1nzA4UQcQCcCG9i
O4+j0f5ZJlkgieWPPENa6js=
=VmIR
-----END PGP SIGNATURE-----

--33vRkRs1qLSKUE7/--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWHVUBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWHVUBQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWHVUBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:01:16 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:31649 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751206AbWHVUBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:01:14 -0400
Subject: Re: [RFC][PATCH 2/8] Integrity Service API and dummy provider
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Seth Arnold <seth.arnold@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060817232202.GN2584@suse.de>
References: <1155844392.6788.56.camel@localhost.localdomain>
	 <20060817232202.GN2584@suse.de>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 13:01:17 -0700
Message-Id: <1156276877.6720.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments inline below.

On Thu, 2006-08-17 at 16:22 -0700, Seth Arnold wrote: 
> On Thu, Aug 17, 2006 at 12:53:12PM -0700, Kylene Jo Hall wrote:
> > --- linux-2.6.18-rc3/security/integrity_dummy.c	1969-12-31 18:00:00.000000000 -0600
> > +++ linux-2.6.18-rc3-working/security/integrity_dummy.c	2006-08-04 15:30:41.000000000 -0500
> > @@ -0,0 +1,77 @@
> > +/*
> > + * integrity_dummy.c
> > + *
> > + * Instantiate integrity subsystem
> > + *
> > + * Copyright (C) 2005,2006 IBM Corporation
> > + * Author: Mimi Zohar <zohar@us.ibm.com>
> > + *
> > + *      This program is free software; you can redistribute it and/or modify
> > + *      it under the terms of the GNU General Public License as published by
> > + *      the Free Software Foundation, version 2 of the License.
> > + */
> > +
> > +#include <linux/config.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/integrity.h>
> > +
> > +/*
> > + *  Return the extended attribute
> > + */
> > +static int dummy_verify_metadata(struct dentry *dentry, char *xattr_name,
> > +				 char **xattr_value, int *xattr_value_len,
> > +				 int *status)
> > +{
> > +	char *value;
> > +	int size;
> > +	int error;
> > +
> > +	if (!xattr_value || !xattr_value_len || !status)
> > +		return -EINVAL;
> > +
> > +	if (!dentry || !dentry->d_inode || !dentry->d_inode->i_op
> > +	    || !dentry->d_inode->i_op->getxattr) {
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	size = dentry->d_inode->i_op->getxattr(dentry, xattr_name, NULL, 0);
> > +	if (size < 0) {
> > +		if (size == -ENODATA) {
> > +			*status = INTEGRITY_NOLABEL;
> > +			return 0;
> > +		}
> > +		return size;
> > +	}
> > +
> > +	value = kzalloc(size + 1, GFP_KERNEL);
> > +	if (!value) 
> > +		return -ENOMEM;
> > +
> > +	error = dentry->d_inode->i_op->getxattr(dentry, xattr_name,
> > +						value, size);
> > +	*xattr_value_len = size;
> > +	*xattr_value = value;
> > +	*status = INTEGRITY_PASS;
> > +	return error;
> > +}
> 
> If the second call to ->getxattr returns an error, is it a good idea to
> overwrite the values in xattr_value_len and *xattr_value? Does the
> integrity really "pass" if there is an error?
> 
> (Or is the point of the 'dummy' verification that .. well .. no
> verification is done?)
Yes that is the point of the dummy.

> 
> > +static int dummy_verify_data(struct dentry *dentry, int *status)
> > +{
> > +	if (status)
> > +		*status = INTEGRITY_PASS;
> > +	return 0;
> > +}
> > +
> > +static void dummy_measure(struct dentry *dentry,
> > +			  const unsigned char *filename, int mask)
> > +{
> > +	return;
> > +}
> > +
> > +struct integrity_operations dummy_integrity_ops = {
> > +	.verify_metadata = dummy_verify_metadata,
> > +	.verify_data = dummy_verify_data,
> > +	.measure = dummy_measure
> > +};
> > --- linux-2.6.18-rc3/include/linux/integrity.h	1969-12-31 18:00:00.000000000 -0600
> > +++ linux-2.6.18-rc3-working/include/linux/integrity.h	2006-08-04 15:30:41.000000000 -0500
> > @@ -0,0 +1,90 @@
> > +/*
> > + * integrity.h
> > + *
> > + * Copyright (C) 2005,2006 IBM Corporation
> > + * Author: Mimi Zohar <zohar@us.ibm.com>
> > + *
> > + *      This program is free software; you can redistribute it and/or modify
> > + *      it under the terms of the GNU General Public License as published by
> > + *      the Free Software Foundation, version 2 of the License.
> > + */
> > +
> > +#ifndef _LINUX_INTEGRITY_H
> > +#define _LINUX_INTEGRITY_H
> > +
> > +#include <linux/fs.h>
> > +
> > +/*
> > + * struct integrity_operations - main integrity structure
> > + *
> > + * @verify_data:
> > + *	Verify the integrity of a dentry.
> > + *	@dentry contains the dentry structure to be verified.
> > + *	@status contains INTEGRITY_PASS, INTEGRITY_FAIL, or
> > + * 		INTEGRITY_NOLABEL
> > + *	Return 0 on success or errno values
> > + *
> > + * @verify_metadata:
> > + *	Verify the integrity of a dentry's metadata; return the value
> > + * 	of the requested xattr_name and the verification result of the
> > + *	dentry's metadata.
> > + *	@dentry contains the dentry structure of the metadata to be verified.
> > + *	@xattr_name, if not null, contains the name of the xattr
> > + *		 being requested.
> > + *	@xattr_value, if not null, is a pointer for the xattr value.
> > + *	@xattr_val_len will be set to the length of the xattr value.
> > + *	@status contains INTEGRITY_PASS, INTEGRITY_FAIL, or
> > + * 		INTEGRITY_NOLABEL
> > + *	Return 0 on success or errno values
> > + *
> > + * @measure:
> > + *	Update an aggregate integrity value with the inode's measurement.
> > + *	The aggregate integrity value is maintained in secure storage such
> > + *	as in a TPM PCR.
> > + *	@dentry contains the dentry structure of the inode to be measured.
> > + *	@filename either contains the full pathname/short file name.
> > + *	@mask contains the filename permission status(i.e. read, write, append).
> > + *
> > + */
> 
> I wouldn't normally expect a function named 'measure' to update a
> datastructure, especially not one potentially stored in hardware. Is
> this just my unfamiliarity with TPM nomenclature?
> What is the proper use of the filename?
> 
measure is standard TCG nomenclature refering to calculating the hash of
a file and extending that value into the TPM to be able to verify what
has run on the system.  Here are a couple of references for sample term
use: [1]
http://domino.research.ibm.com/comm/research_projects.nsf/pages/ssd_ima.index.html
[2] https://www.trustedcomputinggroup.org/news/articles/rc23363.pdf

The filename can be either and is used for logging such that the TPM PCR
aggregate of the measurements can be verified later.  Which is needed
would be implementation specific with full pathname probably preferable
when available.

> > +#define PASS_STR "INTEGRITY_PASS"
> > +#define FAIL_STR "INTEGRITY_FAIL"
> > +#define NOLABEL_STR "INTEGRITY_NOLABEL"
> > +
> > +struct integrity_operations {
> > +	int (*verify_metadata) (struct dentry *dentry, char *xattr_name,
> > +			char **xattr_value, int *xattr_val_len, int *status);
> > +	int (*verify_data) (struct dentry *dentry, int *status);
> > +	void (*measure) (struct dentry *dentry,
> > +			const unsigned char *filename, int mask);
> > +};
> > +extern int register_integrity(struct integrity_operations *ops);
> > +extern int unregister_integrity(struct integrity_operations *ops);
> > +
> > +/* global variables */
> > +extern struct integrity_operations *integrity_ops;
> > +enum integrity_verify_status {
> > +	INTEGRITY_PASS = 0, INTEGRITY_FAIL = -1, INTEGRITY_NOLABEL = -2
> > +};
> > +
> > +/* inline stuff */
> > +static inline int integrity_verify_metadata(struct dentry *dentry,
> > +			char *xattr_name, char **xattr_value,
> > +			int *xattr_val_len, int *status)
> > +{
> > +	return integrity_ops->verify_metadata(dentry, xattr_name,
> > +			xattr_value, xattr_val_len, status);
> > +}
> > +
> > +static inline int integrity_verify_data(struct dentry *dentry, 
> > +					int *status)
> > +{
> > +	return integrity_ops->verify_data(dentry, status);
> > +}
> > +
> > +static inline void integrity_measure(struct dentry *dentry,
> > +			const unsigned char *filename, int mask)
> > +{
> > +	return integrity_ops->measure(dentry, filename, mask);
> > +}
> > +#endif
> > --- linux-2.6.18-rc3/security/Makefile	2006-07-30 01:15:36.000000000 -0500
> > +++ linux-2.6.18-rc3-working/security/Makefile	2006-08-01 12:21:24.000000000 -0500
> > @@ -12,6 +13,7 @@ endif
> >  
> >  # Object file lists
> >  obj-$(CONFIG_SECURITY)			+= security.o dummy.o inode.o
> > +obj-$(CONFIG_SECURITY)			+= integrity.o integrity_dummy.o
> 
> Not CONFIG_SECURITY_INTEGRITY or similar?
> 
This is probably a good idea.  I'll incorporate.

> >  # Must precede capability.o in order to stack properly.
> >  obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
> >  obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
> 
> Thanks


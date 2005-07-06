Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVGFIl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVGFIl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 04:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVGFIl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 04:41:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39833 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262170AbVGFGxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:53:10 -0400
Date: Wed, 6 Jul 2005 02:52:47 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Greg KH <greg@kroah.com>
cc: Tony Jones <tonyj@suse.de>, <serge@hallyn.com>, <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
In-Reply-To: <20050703204423.GA17418@kroah.com>
Message-ID: <Xine.LNX.4.44.0507060243500.6302-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2005, Greg KH wrote:

> Good idea.  Here's a patch to do just that (compile tested only...)
> 
> Comments?

Looks promising so far.

I'm currently porting selinuxfs funtionality to securityfs, although I'm
not sure if we'll be ok during early initialization.  selinuxfs is
currently kern_mounted via an initcall.  We may need an initcall
kern_mount() of securityfs before SELinux kicks in.

Stephen: opinions on this?

Otherwise, it looks like it'll allow SELinux to drop some code.  Generally 
it will mean that other LSM components won't have to create their own 
filesystems, and their subdirectories will be hanging off /security (or 
wherever selinuxfs is mounted), rather than scattered across /

Some of the SELinux code may be useful as part of securityfs later, as 
well.


> +struct dentry *securityfs_create_file(const char *name, mode_t mode,
> +				   struct dentry *parent, void *data,
> +				   struct file_operations *fops)
> +{
> +	struct dentry *dentry = NULL;
> +	int error;
> +
> +	pr_debug("securityfs: creating file '%s'\n",name);
> +
> +	error = simple_pin_fs("securityfs", &mount, &mount_count);
> +	if (error)
> +		goto exit;
> +
> +	error = create_by_name(name, mode, parent, &dentry);
> +	if (error) {
> +		dentry = NULL;
> +		goto exit;
> +	}
> +
> +	if (dentry->d_inode) {
> +		if (data)
> +			dentry->d_inode->u.generic_ip = data;
> +		if (fops)
> +			dentry->d_inode->i_fop = fops;
> +	}
> +exit:
> +	return dentry;
> +}
> +EXPORT_SYMBOL_GPL(securityfs_create_file);

How about having all API functions which return a pointer be converted to 
use ERR_PTR() ?

This will allow errors to be propagated to the calling code.


- James
-- 
James Morris
<jmorris@redhat.com>



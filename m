Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUJJKl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUJJKl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 06:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUJJKl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 06:41:29 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:19204 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268238AbUJJKlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 06:41:18 -0400
Date: Sun, 10 Oct 2004 11:41:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041010104113.GC28456@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	chrisw@osdl.org, linux-kernel@vger.kernel.org
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your filesystem handling code is completely superflous (and buggy).  Please
remove all the code dealing with chroot-lookalikes.  In your userland script
you simpl have to clone(.., CLONE_NEWNS) to detach your namespace from your
parent, then you can lazly unmount all filesystems and setup your new namespace
before starting the jail.  The added advantage is that you don't need any
cludges to keep the user from exiting the chroot.

> +#include <linux/ip.h>
> +#include <net/ipv6.h>
> +#include <linux/mount.h>
> +#include <asm/uaccess.h>

Please always include <asm/*.h> headers after <linux/*.h>

> +#include <linux/smp_lock.h>

I don't see you using the BKL anywhere.

> 
>
>
> 
> +#include <linux/kref.h>

Why that many blank lines?

> +static int jail_debug = 0;

no need to initialize to 0

> +MODULE_PARM(jail_debug, "i");

please user module_param

> +static int secondary = 0;

again no need to itnialize.

> +	char *ip4_addr_name;  /* char * containing ip4 addr to use for jail */
> +	char *ip6_addr_name;  /* char * containing ip6 addr to use for jail */

How do you habdle non-ip networking?  This really needs to be handled
more generally.

> +	/* won't let ourselves be removed until this jail goes away */
> +	try_module_get(THIS_MODULE);

must be __module_get

> +/*
> + * LSM /proc/<pid>/attr hooks.
> + * You may write into /proc/<pid>/attr/exec:
> + *    root /some/path
> + *    ip 2.2.2.2
> + * These values will be used on the next exec() to set up your jail
> + *  (assuming you're not already in a jail)

That's a really awkward interface.

> +jail_file_send_sigiotask(struct task_struct *tsk, struct fown_struct *fown,
> +       int fd, int reason)
> +{
> +	struct file *file;
> +	struct jail_struct *tsec, *fsec;
> +
> +	if (!in_jail(current))
> +		return 0;
> +
> +        file = (struct file *) ((long)fown - offsetof(struct file, f_owner));

bah.  Please use container_of or better get lsm folks to just pass you
a struct file *

> +jail_proc_inode_permission(struct inode *inode, int mask,
> +				    struct nameidata *nd)
> +{
> +	struct jail_struct *tsec = current->security;
> +	struct dentry *dentry = nd->dentry;
> +	unsigned pid;
> +
> +	pid = name_to_int(dentry);
> +	if (pid == ~0U) {
> +		struct qstr *dname = &dentry->d_name;
> +		if (strcmp(dname->name, "scsi") == 0 ||
> +			strcmp(dname->name, "sys") == 0 ||
> +			strcmp(dname->name, "ide") == 0)
> +			return -EPERM;
> +		return 0;

oh, please.  Don't submit such a crap.

if you want to disable sysctl access do it on the sysctl, not procfs level.
And disabling access to /proc/ide and /proc/scsi as two very special cases
(what about /proc/md, /proc/cciss or /proc/cpqarray?) is totally bullocks,
if they allow hardware interaction without checking for capabailities
fix them in the driver code.

This half-aided security by obscurity crap _is_ going to bite later on.


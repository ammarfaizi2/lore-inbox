Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUDHNwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 09:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUDHNwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 09:52:35 -0400
Received: from vapor.arctrix.com ([66.220.1.99]:38663 "HELO vapor.arctrix.com")
	by vger.kernel.org with SMTP id S261421AbUDHNwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 09:52:24 -0400
Date: Thu, 8 Apr 2004 09:52:23 -0400
From: Neil Schemenauer <nas@arctrix.com>
To: linux-kernel@vger.kernel.org
Subject: capwrap: granting capabilities without fs support
Message-ID: <20040408135223.GA15870@mems-exchange.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It seems people are once again wondering how to make use of
capabilities in Linux.  This module enables the use of Linux
capabilities on filesystems that do not support them.

To grant capabilities to an executable, a small wrapper file is
created that includes the path to an executable followed a
capability set written in hexadecimal.  When this file is executed
by the kernel, the executable is granted the specified capabilities.
The wrapper file must be owned by root and have the SUID bit set.

For example, to grant the CAP_NET_RAW (bit 13) capability to ping:

    # chmod -s /bin/ping
    # mv /bin/ping /bin/ping_real
    # echo '&/bin/ping_real 2000' > /bin/ping
    # chmod +xs /bin/ping

Another example is to grant the CAP_NET_BIND_SERVICE (bit 10) to
Apache:

    # echo '&/usr/sbin/apache 400' > httpd
    # chmod +xs httpd

The module is very small.  Perhaps it could be considered for
inclusion in the standard kernel.  I can work on a patch if people
are interested.

  Neil 

--a8Wt8u1KmwUX3Y2C
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="binfmt_capwrap.c"

/*
 *  linux/fs/binfmt_capwrap.c
 *
 *  Copyright (C) 2002  Neil Schemenauer
 */

#include <linux/module.h>
#include <linux/string.h>
#include <linux/kernel.h>
#include <linux/stat.h>
#include <linux/slab.h>
#include <linux/binfmts.h>
#include <linux/init.h>
#include <linux/file.h>
#include <linux/smp_lock.h>
#include <linux/mount.h>
#include <linux/fs.h>


static int parse_cap(char **cp, unsigned int *cap)
{
	char *tok, *endp;
	int n;
	if ((tok = strsep(cp, " \t")) == NULL)
		return 0;
	n = simple_strtol(tok, &endp, 16);
	if (*endp != '\0')
		return 0;
	*cap = n;
	return 1;
}

static void grant_capabilities(struct linux_binprm *bprm, unsigned int caps)
{
	/* This may have to be more complicated if the kernel
	 * representation of capabilities changes.  Right now it's trivial.
	 */
	bprm->cap_effective |= caps;
	bprm->cap_permitted |= caps;
}

static int load_capwrap(struct linux_binprm *bprm, struct pt_regs *regs)
{
        struct inode * inode = bprm->file->f_dentry->d_inode;
	int mode = inode->i_mode;
	char exec_name[BINPRM_BUF_SIZE];
	char *cp, *tok;
	unsigned int caps = 0;
	struct file *file;
	int retval;

	/* must have magic */
	if ((bprm->buf[0] != '&'))
		return -ENOEXEC;

	/* must be owned by root */
	if (inode->i_uid != 0)
		return -ENOEXEC;

	/* must be SUID */
	if ((bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID) ||
			!(mode & S_ISUID))
		return -ENOEXEC;

	/*
	 * Okay, parse the wrapper.
	 */

	allow_write_access(bprm->file);
	fput(bprm->file);
	bprm->file = NULL;

	/* terminate first line */
	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
	if ((cp = strchr(bprm->buf, '\n')) == NULL)
		cp = bprm->buf+BINPRM_BUF_SIZE-1;
	*cp = '\0';

	/* name */
	cp = bprm->buf+1;
	if ((tok = strsep(&cp, " \t")) == NULL)
		return -ENOEXEC;
	strcpy(exec_name, tok);

	/* capabilities to add */
	if (!parse_cap(&cp, &caps))
		return -ENOEXEC;

	/*
	 * Restart the process with real executable's dentry.
	 */
	file = open_exec(exec_name);
	if (IS_ERR(file))
		return PTR_ERR(file);

	bprm->file = file;
	retval = prepare_binprm(bprm);
	if (retval < 0)
		return retval;

	grant_capabilities(bprm, caps);
	printk(KERN_DEBUG "capwrap: granted %s %x effective now %x\n",
			exec_name, caps, bprm->cap_effective);

	return search_binary_handler(bprm, regs);
}

struct linux_binfmt capwrap_format = {
	.module		= THIS_MODULE,
	.load_binary	= load_capwrap,
};

static int __init init_capwrap_binfmt(void)
{
	return register_binfmt(&capwrap_format);
}

static void __exit exit_capwrap_binfmt(void)
{
	unregister_binfmt(&capwrap_format);
}

module_init(init_capwrap_binfmt)
module_exit(exit_capwrap_binfmt)
MODULE_LICENSE("GPL");

--a8Wt8u1KmwUX3Y2C--

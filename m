Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264773AbUEKOtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264773AbUEKOtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUEKOtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:49:33 -0400
Received: from vapor.arctrix.com ([66.220.1.99]:32275 "HELO vapor.arctrix.com")
	by vger.kernel.org with SMTP id S264773AbUEKOtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:49:19 -0400
Date: Tue, 11 May 2004 10:49:18 -0400
From: Neil Schemenauer <nas@arctrix.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511144918.GA4764@mems-exchange.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[Andrew Morton]
> Has been discussed on this list.  It requires worrisome changes to
> the capability system, changes to PAM, changes to login and
> changes to applications.

Have you seen my capwrap[1] module?  I wouldn't call it elegant but
it is very simple and flexible.

  Neil

1. http://marc.theaimsgroup.com/?l=linux-kernel&m=108143257710466&w=2

--CE+1k2dSO48ffgeK
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

--CE+1k2dSO48ffgeK--

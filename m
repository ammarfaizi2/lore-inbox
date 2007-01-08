Return-Path: <linux-kernel-owner+w=401wt.eu-S932080AbXAHVcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbXAHVcd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbXAHVcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:32:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45013 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbXAHVcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:32:32 -0500
Date: Mon, 8 Jan 2007 13:28:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 04/24] Unionfs: Common file operations
Message-Id: <20070108132841.944e53f2.akpm@osdl.org>
In-Reply-To: <11682295972786-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<11682295972786-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Jan 2007 23:12:56 -0500
"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:

> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> 
> This patch contains helper functions used through the rest of the code which
> pertains to files.
> 
> Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
> Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
>
> ...
>
> +#include "union.h"
> +
> +/* 1) Copyup the file
> + * 2) Rename the file to '.unionfs<original inode#><counter>' - obviously
> + * stolen from NFS's silly rename
> + */
> +static int copyup_deleted_file(struct file *file, struct dentry *dentry,
> +			       int bstart, int bindex)
> +{
> +	static unsigned int counter;
> +	const int i_inosize = sizeof(dentry->d_inode->i_ino) * 2;
> +	const int countersize = sizeof(counter) * 2;
> +	const int nlen = sizeof(".unionfs") + i_inosize + countersize - 1;
> +	char name[nlen + 1];
> +
> +	int err;
> +	struct dentry *tmp_dentry = NULL;
> +	struct dentry *hidden_dentry = NULL;
> +	struct dentry *hidden_dir_dentry = NULL;
> +
> +	hidden_dentry = unionfs_lower_dentry_idx(dentry, bstart);

Slightly strange to initialise a variable twice in a row like this.

> +	sprintf(name, ".unionfs%*.*lx",
> +			i_inosize, i_inosize, hidden_dentry->d_inode->i_ino);
> +
> +	tmp_dentry = NULL;
> +	do {
> +		char *suffix = name + nlen - countersize;
> +
> +		dput(tmp_dentry);
> +		counter++;
> +		sprintf(suffix, "%*.*x", countersize, countersize, counter);
> +
> +		printk(KERN_DEBUG "unionfs: trying to rename %s to %s\n",
> +				dentry->d_name.name, name);
> +
> +		tmp_dentry = lookup_one_len(name, hidden_dentry->d_parent,
> +					    UNIONFS_TMPNAM_LEN);
> +		if (IS_ERR(tmp_dentry)) {
> +			err = PTR_ERR(tmp_dentry);
> +			goto out;
> +		}
> +	} while (tmp_dentry->d_inode != NULL);	/* need negative dentry */
> +
> +	err = copyup_named_file(dentry->d_parent->d_inode, file, name, bstart,
> +				bindex, file->f_dentry->d_inode->i_size);
> +	if (err)
> +		goto out;
> +
> +	/* bring it to the same state as an unlinked file */
> +	hidden_dentry = unionfs_lower_dentry_idx(dentry, dbstart(dentry));
> +	hidden_dir_dentry = lock_parent(hidden_dentry);
> +	err = vfs_unlink(hidden_dir_dentry->d_inode, hidden_dentry);
> +	unlock_dir(hidden_dir_dentry);
> +
> +out:
> +	return err;
> +}
> +
> +/* put all references held by upper struct file and free lower file pointer
> + * array
> + */

Where in this patchset would the reader go to understand what an "upper
file" is, what a "lower file" is?  The relationship between them, lifecycle
management, locking, etc?

<looks at the data structures in union.h>

That's the place.  It would be useful to describe things in there a lot
better.  For example, bstart, bend and bindev could do with help.

unionfs_get_nlinks() is huge.  it has twelve callsites and two out-of-line
copies are generated.  Suggest that it not be inlined ;)

alloc_whname() should be out-of-line.

lock_parent() and unlock_dir() are poorly named.

> +long unionfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	long err;
> +
> +	if ((err = unionfs_file_revalidate(file, 1)))
> +		goto out;
> +
> +	/* check if asked for local commands */
> +	switch (cmd) {
> +		case UNIONFS_IOCTL_INCGEN:
> +			/* Increment the superblock generation count */
> +			err = -EACCES;
> +			if (!capable(CAP_SYS_ADMIN))
> +				goto out;
> +			err = unionfs_ioctl_incgen(file, cmd, arg);
> +			break;
> +
> +		case UNIONFS_IOCTL_QUERYFILE:
> +			/* Return list of branches containing the given file */
> +			err = unionfs_ioctl_queryfile(file, cmd, arg);
> +			break;
> +
> +		default:
> +			/* pass the ioctl down */
> +			err = do_ioctl(file, cmd, arg);
> +			break;
> +	}

We normally use one tabstop less than this.



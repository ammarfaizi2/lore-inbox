Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946217AbWJTElG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946217AbWJTElG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946228AbWJTElG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:41:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946217AbWJTElD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:41:03 -0400
Date: Thu, 19 Oct 2006 21:40:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 1/2] VFS: Make d_materialise_unique() enforce directory
 uniqueness
Message-Id: <20061019214056.6f82641b.akpm@osdl.org>
In-Reply-To: <20061019210358.6797.64655.stgit@lade.trondhjem.org>
References: <1161291638.5506.9.camel@lade.trondhjem.org>
	<20061019210358.6797.64655.stgit@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 17:03:58 -0400
Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> +static struct dentry *__d_unalias(struct dentry *dentry, struct dentry *alias)
> +{
> +	struct mutex *m1 = NULL, *m2 = NULL;
> +	struct dentry *ret;
> +
> +	/* If alias and dentry share a parent, then no extra locks required */
> +	if (alias->d_parent == dentry->d_parent)
> +		goto out_unalias;
> +
> +	/* Check for loops */
> +	ret = ERR_PTR(-ELOOP);
> +	if (d_isparent(alias, dentry))
> +		goto out_err;
> +
> +	/* See lock_rename() */
> +	ret = ERR_PTR(-EBUSY);
> +	if (!mutex_trylock(&dentry->d_sb->s_vfs_rename_mutex))
> +		goto out_err;
> +	m1 = &dentry->d_sb->s_vfs_rename_mutex;
> +	if (!mutex_trylock(&alias->d_parent->d_inode->i_mutex))
> +		goto out_err;
> +	m2 = &alias->d_parent->d_inode->i_mutex;
> +out_unalias:
> +	d_move_locked(alias, dentry);
> +	ret = alias;
> +out_err:
> +	spin_unlock(&dcache_lock);
> +	if (m2)
> +		mutex_unlock(m2);
> +	if (m1)
> +		mutex_unlock(m1);
> +	return ret;
> +}

The locking in there is, of course, gruesome.  There is no way in which it
can be made reliable?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVJGGC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVJGGC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 02:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVJGGC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 02:02:58 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:3086 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751373AbVJGGC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 02:02:57 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128633138.31797.52.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Thu, 06 Oct 2005 17:12:18 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu> <1128633138.31797.52.camel@lade.trondhjem.org>
Message-Id: <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 08:01:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I just think that filesystem code should _never_ need to care about
> > mounts.  If you want to do the lookup+open, you somehow will have to
> > deal with mounts, which is ugly.
> 
> You appear to think that atomic lookup+open is a question of choice. It
> is not.

Atomic lookup+open is an optimization, and as such a question of
choice.  Atomic create+open is not.

I know you are thinking of the non-exclusive create case when between
the lookup and the open the file is removed or transmuted on the
server.

Yes, it's tricky to sovle, but by no means impossible without atomic
lookup+open.  E.g. consider this pseudo-code (only the atomic
open+create case) in open_namei():

	down(&dir->d_inode->i_sem);
	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
do_last:

	error = PTR_ERR(dentry);
	if (IS_ERR(dentry)) {
		up(&dir->d_inode->i_sem);
		goto exit;
	}

	/* Negative dentry, just create the file */
	if (!dentry->d_inode)
		if (!IS_POSIXACL(dir->d_inode))
			mode &= ~current->fs->umask;
		vfs_create_open(...);
		up(&dir->d_inode->i_sem);
		dput(nd->dentry);
		nd->dentry = dentry;
		goto exit;
	} else if (!(flag & O_EXCL) && may_create(dir)) {
		if (__follow_mount(&path)) {
			up(&dir->d_inode->i_sem);
			goto mount_followed;
		}
		vfs_create_open(...);
		up(&dir->d_inode->i_sem);
		dput(nd->dentry);
		nd->dentry = dentry;
		goto exit;
	}

	/*
	 * It already exists.
	 */
	up(&dir->d_inode->i_sem);

	error = -EEXIST;
	if (flag & O_EXCL)
		goto exit_dput;

	if (__follow_mount(&path)) {
		error = -ELOOP;
		if (flag & O_NOFOLLOW)
			goto exit_dput;
	}
mount_followed:


Miklos

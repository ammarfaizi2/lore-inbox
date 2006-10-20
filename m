Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422848AbWJTEyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWJTEyW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWJTEyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:54:22 -0400
Received: from mx2.netapp.com ([216.240.18.37]:36898 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1161413AbWJTEyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:54:21 -0400
X-IronPort-AV: i="4.09,332,1157353200"; 
   d="scan'208"; a="419751914:sNHT48108080"
Subject: Re: [PATCH 1/2] VFS: Make d_materialise_unique() enforce directory
	uniqueness
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <20061019214056.6f82641b.akpm@osdl.org>
References: <1161291638.5506.9.camel@lade.trondhjem.org>
	 <20061019210358.6797.64655.stgit@lade.trondhjem.org>
	 <20061019214056.6f82641b.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Fri, 20 Oct 2006 00:54:18 -0400
Message-Id: <1161320058.5497.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 20 Oct 2006 04:54:39.0362 (UTC) FILETIME=[D940CE20:01C6F403]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 21:40 -0700, Andrew Morton wrote:
> On Thu, 19 Oct 2006 17:03:58 -0400
> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> 
> > +static struct dentry *__d_unalias(struct dentry *dentry, struct dentry *alias)
> > +{
> > +	struct mutex *m1 = NULL, *m2 = NULL;
> > +	struct dentry *ret;
> > +
> > +	/* If alias and dentry share a parent, then no extra locks required */
> > +	if (alias->d_parent == dentry->d_parent)
> > +		goto out_unalias;
> > +
> > +	/* Check for loops */
> > +	ret = ERR_PTR(-ELOOP);
> > +	if (d_isparent(alias, dentry))
> > +		goto out_err;
> > +
> > +	/* See lock_rename() */
> > +	ret = ERR_PTR(-EBUSY);
> > +	if (!mutex_trylock(&dentry->d_sb->s_vfs_rename_mutex))
> > +		goto out_err;
> > +	m1 = &dentry->d_sb->s_vfs_rename_mutex;
> > +	if (!mutex_trylock(&alias->d_parent->d_inode->i_mutex))
> > +		goto out_err;
> > +	m2 = &alias->d_parent->d_inode->i_mutex;
> > +out_unalias:
> > +	d_move_locked(alias, dentry);
> > +	ret = alias;
> > +out_err:
> > +	spin_unlock(&dcache_lock);
> > +	if (m2)
> > +		mutex_unlock(m2);
> > +	if (m1)
> > +		mutex_unlock(m1);
> > +	return ret;
> > +}
> 
> The locking in there is, of course, gruesome.  There is no way in which it
> can be made reliable?

The generic lookup() code will grab the dir->i_mutex for the parent
directory before we get anywhere near __d_alias(). That pretty much
limits us to using mutex_trylock() since otherwise we break the nesting
rules for lock_rename(), and I can't see that we can release the
problematic dir->i_mutex without causing worse races.

Cheers,
  Trond

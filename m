Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWAFUH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWAFUH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbWAFUH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:07:58 -0500
Received: from pat.uio.no ([129.240.130.16]:1220 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751413AbWAFUH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:07:57 -0500
Subject: Re: d_instantiate_unique / NFS inode leakage?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
In-Reply-To: <20060105080933.GK5743@linuxhacker.ru>
References: <20060105010047.GJ5743@linuxhacker.ru>
	 <1136424407.7847.37.camel@lade.trondhjem.org>
	 <20060105080933.GK5743@linuxhacker.ru>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 15:07:49 -0500
Message-Id: <1136578069.7843.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.867, required 12,
	autolearn=disabled, AWL 1.13, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 10:09 +0200, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Jan 05, 2006 at 02:26:47AM +0100, Trond Myklebust wrote:
> > >    Searching for inode leakage in NFS code (seen in 2.6.14 and 2.6.15 at least,
> > >    have not tried earlier versions), I see suspicious place in
> > >    d_instantiate_unique (the only user happens to be NFS).
> > >    There if we have found aliased dentry that we return, inode reference is
> > >    not dropped and inode is not attached anywhere, so it seems the reference
> > >    to inode is leaked in that case.
> > Yep, that looks like it ought to be the correct behaviour. Could you
> > please also add a note to this effect in the DocBook header for
> > d_instantiate_unique?
> 
> Sure.

Looks good to me. ACKed

Cheers,
  Trond

> --- fs/dcache.c.orig	2006-01-05 02:28:57.000000000 +0200
> +++ fs/dcache.c	2006-01-05 10:04:02.000000000 +0200
> @@ -808,10 +808,14 @@ void d_instantiate(struct dentry *entry,
>   *
>   * Fill in inode information in the entry. On success, it returns NULL.
>   * If an unhashed alias of "entry" already exists, then we return the
> - * aliased dentry instead.
> + * aliased dentry instead and drop one reference to inode.
>   *
>   * Note that in order to avoid conflicts with rename() etc, the caller
>   * had better be holding the parent directory semaphore.
> + *
> + * This also assumes that the inode count has been incremented
> + * (or otherwise set) by the caller to indicate that it is now
> + * in use by the dcache.
>   */
>  struct dentry *d_instantiate_unique(struct dentry *entry, struct inode *inode)
>  {
> @@ -838,6 +842,7 @@ struct dentry *d_instantiate_unique(stru
>  		dget_locked(alias);
>  		spin_unlock(&dcache_lock);
>  		BUG_ON(!d_unhashed(alias));
> +		iput(inode);
>  		return alias;
>  	}
>  	list_add(&entry->d_alias, &inode->i_dentry);
> 
> Bye,
>     Oleg


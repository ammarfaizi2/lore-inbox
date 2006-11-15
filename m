Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030702AbWKOQxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030702AbWKOQxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030701AbWKOQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:53:13 -0500
Received: from pat.uio.no ([129.240.10.15]:51419 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030702AbWKOQxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:53:11 -0500
Subject: Re: [PATCH 05/19] NFS: Use local caching
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
In-Reply-To: <26454.1163606424@redhat.com>
References: <1163603377.5691.113.camel@lade.trondhjem.org>
	 <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
	 <20061114200632.12943.72086.stgit@warthog.cambridge.redhat.com>
	 <26454.1163606424@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 11:52:45 -0500
Message-Id: <1163609565.5691.167.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.218, required 12,
	autolearn=disabled, AWL 1.65, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 16:00 +0000, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > Why is fscache being given a vote on whether or not the NFS page can be
> > removed from the mapping? If the file has changed on the server, so that
> > we have to invalidate the mapping, then I don't care about the fact that
> > fscache is busy: the page has to go.
> 
> This is releasepage() not invalidatepage().  It is conditional.

...and invalidate_complete_page2() calls try_to_release_page() which
again calls releasepage(). Success or failure of the latter should
therefore not depend on the internal fscache state.

> > > @@ -942,11 +954,13 @@ static int nfs_update_inode(struct inode
> > > ...
> > > +			nfs_fscache_set_size(inode);
> > 
> > Doesn't nfs_fscache_set_size try to grab rw_semaphores? This function is
> > _always_ called with the inode->i_lock spinlock held.
> 
> Hmmm...  I wonder if I need to do this in nfs_update_inode() at all.  Won't the
> pages and the cache object attached to an inode be discarded anyway if the file
> attributes returned by the server change?

In the case of a read-only file, yes. That is not true of a read/write
file.

> > >  static void nfs_readpage_release(struct nfs_page *req)
> > >  {
> > > +	struct inode *d_inode = req->wb_context->dentry->d_inode;
> > > +
> > > +	if (PageUptodate(req->wb_page))
> > > +		nfs_readpage_to_fscache(d_inode, req->wb_page, 0);
> > > +
> > 
> > Will usually be called from an rpciod context. Should therefore not be
> > grabbing semaphores, doing memory allocation etc.
> 
> Is it possible to make an NFS kernel thread that can have completed nfs_page
> structs queued for writing to the cache?

Why should we add extra context switches for the non-fscache case? Just
move the call to nfs_readpage_to_fscache into its own kernel thread.

Trond


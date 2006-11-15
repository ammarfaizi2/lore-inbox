Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030766AbWKORxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030766AbWKORxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030773AbWKORxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:53:55 -0500
Received: from pat.uio.no ([129.240.10.15]:51877 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030766AbWKORxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:53:54 -0500
Subject: Re: [PATCH 05/19] NFS: Use local caching
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
In-Reply-To: <31660.1163610473@redhat.com>
References: <1163609565.5691.167.camel@lade.trondhjem.org>
	 <1163603377.5691.113.camel@lade.trondhjem.org>
	 <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
	 <20061114200632.12943.72086.stgit@warthog.cambridge.redhat.com>
	 <26454.1163606424@redhat.com>   <31660.1163610473@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 12:53:31 -0500
Message-Id: <1163613211.5691.204.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.158, required 12,
	autolearn=disabled, AWL 1.71, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 17:07 +0000, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > > This is releasepage() not invalidatepage().  It is conditional.
> > 
> > ...and invalidate_complete_page2() calls try_to_release_page() which
> > again calls releasepage(). Success or failure of the latter should
> > therefore not depend on the internal fscache state.
> 
> Okay... invalidate_complete_page2() passes __GFP_WAIT through.  I'll make
> nfs_fscache_release_page() check for that, and if it's set, it'll wait for
> FS-Cache to finish with the page before returning true.
> 
> This sounds like invalidate_inode_pages2() is doing the wrong thing.  After
> all, releasepage() _is_ conditional.  It sounds like it should be calling
> invalidatepage() instead.  Either that or NFS should be calling something
> else entirely.

No! invalidate_inode_pages2() is supposed to be non-destructive w.r.t.
dirty pages. That is why it calls try_to_release_page(). If you want a
destructive truncate, then you should be calling truncate_inode_pages().

> > > Hmmm...  I wonder if I need to do this in nfs_update_inode() at all.
> > > Won't the pages and the cache object attached to an inode be discarded
> > > anyway if the file attributes returned by the server change?
> > 
> > In the case of a read-only file, yes. That is not true of a read/write
> > file.
> 
> So I can assume that, as we're only caching read-only files, I don't need to
> invoke FS-Cache here.

I would assume so.

> > > > >  static void nfs_readpage_release(struct nfs_page *req)
> > > > >  {
> > > > > +	struct inode *d_inode = req->wb_context->dentry->d_inode;
> > > > > +
> > > > > +	if (PageUptodate(req->wb_page))
> > > > > +		nfs_readpage_to_fscache(d_inode, req->wb_page, 0);
> > > > > +
> > > > 
> > > > Will usually be called from an rpciod context. Should therefore not be
> > > > grabbing semaphores, doing memory allocation etc.
> > > 
> > > Is it possible to make an NFS kernel thread that can have completed nfs_page
> > > structs queued for writing to the cache?
> > 
> > Why should we add extra context switches for the non-fscache case? Just
> > move the call to nfs_readpage_to_fscache into its own kernel thread.
> 
> Sorry, I meant can I make use of the nfs_page struct that was handed to
> nfs_readpage_release() by queuing it for an auxiliary thread to call
> nfs_readpage_to_fscache() on?  I didn't intend to call nfs_readpage_release()
> in another thread.

If you do, then you will either have to get rid of the call to
nfs_clear_request(), or track the struct page yourself.

At this point, I think that removing the call to nfs_clear_request is
safe: there should be nothing that checks page_count() in the mm layer
that we can race with AFAICS.

Cheers,
  Trond


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbWKOQCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbWKOQCy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbWKOQCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:02:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030613AbWKOQCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:02:53 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1163603377.5691.113.camel@lade.trondhjem.org> 
References: <1163603377.5691.113.camel@lade.trondhjem.org>  <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200632.12943.72086.stgit@warthog.cambridge.redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       sds@tycho.nsa.gov, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 05/19] NFS: Use local caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 16:00:24 +0000
Message-ID: <26454.1163606424@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> Why is fscache being given a vote on whether or not the NFS page can be
> removed from the mapping? If the file has changed on the server, so that
> we have to invalidate the mapping, then I don't care about the fact that
> fscache is busy: the page has to go.

This is releasepage() not invalidatepage().  It is conditional.

At this point you can't get rid of the page if FS-Cache is still using it
because FS-Cache will call the netfs callback on the page when it has finished.

You also can't cancel the I/O because it may involve a BIO which itself can't
be cancelled.

You may not be able to sleep to wait for FS-Cache to finish because gfp might
not include __GFP_WAIT.

The whole point is to find out whether a page is releasable and recycle it if
it is, not to force it to be released; for that, invalidatepage() exists.

In my opinion, it is better to tell the VM that this page is not currently
available, and let it get on with trying to find one that is rather than
holding up the page allocator until the page becomes available.

> You are missing the NFSv4 change attribute. The latter is supposed to
> override mtime/ctime/size concerns in NFSv4.

Is that stored in the inode?  I don't recall offhand.  It's easy enough to add
if it is.

> > @@ -84,6 +84,7 @@ void nfs_clear_inode(struct inode *inode
> ...
> What about nfs4_clear_inode?

It calls nfs_clear_inode()...

> > +	nfs_fscache_zap_fh_cookie(inode);
> 
> The cache will be zapped upon the next revalidation anyway. and the
> whole point of nfs_zap_caches is to allow fast invalidation in contexts
> where we cannot sleep. nfs_fscache_zap_fh_cookie calls
> fscache_relinquish_cookie(), which sleeps, grabs rw_semaphores, etc.

Okay...  It sounds like I should be able to drop that call there.

Perhaps you should add a comment to that function to note this...

> > @@ -376,6 +383,7 @@ void nfs_setattr_update_inode(struct ino
> >  	if ((attr->ia_valid & ATTR_SIZE) != 0) {
> >  		nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
> >  		inode->i_size = attr->ia_size;
> > +		nfs_fscache_set_size(inode);
> 
> Why? Isn't this supposed to be a read-only inode?

I suppose.  This is a holdover from when I supported R/W inodes too.

> > @@ -942,11 +954,13 @@ static int nfs_update_inode(struct inode
> > ...
> > +			nfs_fscache_set_size(inode);
> 
> Doesn't nfs_fscache_set_size try to grab rw_semaphores? This function is
> _always_ called with the inode->i_lock spinlock held.

Hmmm...  I wonder if I need to do this in nfs_update_inode() at all.  Won't the
pages and the cache object attached to an inode be discarded anyway if the file
attributes returned by the server change?

When can an inode be left with its data attached when modified on the server?
Is this an NFSv4 thing?

> >  static void nfs_readpage_release(struct nfs_page *req)
> >  {
> > +	struct inode *d_inode = req->wb_context->dentry->d_inode;
> > +
> > +	if (PageUptodate(req->wb_page))
> > +		nfs_readpage_to_fscache(d_inode, req->wb_page, 0);
> > +
> 
> Will usually be called from an rpciod context. Should therefore not be
> grabbing semaphores, doing memory allocation etc.

Is it possible to make an NFS kernel thread that can have completed nfs_page
structs queued for writing to the cache?

> > +
> > +	nfs_writepage_to_fscache(inode, page);
> > +
> 
> Why are we doing this, if the cache is turned off whenever the file is
> open for writes?

Good point again; for the moment, this can be discarded - though we could do it
for NFS4 under some circumstances, I believe.

David

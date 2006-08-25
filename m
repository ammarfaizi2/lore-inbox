Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422890AbWHYUVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbWHYUVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWHYUVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:21:01 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:7062 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S932284AbWHYUU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:20:59 -0400
Subject: Re: [PATCH 4/6] nfs: Teach NFS about swap cache pages
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>
In-Reply-To: <1156536228.5927.17.camel@localhost>
References: <20060825153709.24254.28118.sendpatchset@twins>
	 <20060825153751.24254.20709.sendpatchset@twins>
	 <1156536228.5927.17.camel@localhost>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 22:20:14 +0200
Message-Id: <1156537214.26945.6.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 16:03 -0400, Trond Myklebust wrote:
> On Fri, 2006-08-25 at 17:37 +0200, Peter Zijlstra wrote:
> > Teach the NFS client how to treat PG_swapcache pages.
> > 
> > Replace all occurences of page->index and page->mapping in the NFS client
> > with the new page_file_index() and page_file_mapping() functions.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > ---
> >  fs/nfs/dir.c      |    4 ++--
> >  fs/nfs/file.c     |    6 +++---
> >  fs/nfs/pagelist.c |    8 ++++----
> >  fs/nfs/read.c     |   10 +++++-----
> >  fs/nfs/write.c    |   34 +++++++++++++++++-----------------
> >  5 files changed, 31 insertions(+), 31 deletions(-)
> 
> <snip>
> 
> > @@ -821,7 +821,7 @@ int nfs_updatepage(struct file *file, st
> >  		unsigned int offset, unsigned int count)
> >  {
> >  	struct nfs_open_context *ctx = (struct nfs_open_context *)file->private_data;
> > -	struct inode	*inode = page->mapping->host;
> > +	struct inode	*inode = page_file_mapping(page)->host;
> >  	struct nfs_page	*req;
> >  	int		status = 0;
> >  
> > @@ -854,12 +854,12 @@ int nfs_updatepage(struct file *file, st
> >  		offset = 0;
> >  		if (unlikely(end_offs < 0)) {
> >  			/* Do nothing */
> > -		} else if (page->index == end_index) {
> > +		} else if (page_file_index(page) == end_index) {
> 
> Is this necessary? When will we ever call nfs_updatepage() with a swap
> page? AFAICS, the swap stuff always uses page dirtying and (ugh)
> writepage().

Yes, swap uses writepage(), Nikita Danilov had a patch that did cluster
pageout using writepages(), however that tended to deadlock even on
local disk.

> >  			unsigned int pglen;
> >  			pglen = (unsigned int)(end_offs & (PAGE_CACHE_SIZE-1)) + 1;
> >  			if (count < pglen)
> >  				count = pglen;
> > -		} else if (page->index < end_index)
> > +		} else if (page_file_index(page) < end_index)
> >  			count = PAGE_CACHE_SIZE;
> >  	}
> >  
> > Index: linux-2.6/fs/nfs/dir.c
> > ===================================================================
> > --- linux-2.6.orig/fs/nfs/dir.c
> > +++ linux-2.6/fs/nfs/dir.c
> > @@ -177,7 +177,7 @@ int nfs_readdir_filler(nfs_readdir_descr
> >  
> >  	dfprintk(DIRCACHE, "NFS: %s: reading cookie %Lu into page %lu\n",
> >  			__FUNCTION__, (long long)desc->entry->cookie,
> > -			page->index);
> > +			page_file_index(page));
> >  
> >   again:
> >  	timestamp = jiffies;
> > @@ -201,7 +201,7 @@ int nfs_readdir_filler(nfs_readdir_descr
> >  	 * Note: assumes we have exclusive access to this mapping either
> >  	 *	 through inode->i_mutex or some other mechanism.
> >  	 */
> > -	if (page->index == 0)
> > +	if (page_file_index(page) == 0)
> >  		invalidate_inode_pages2_range(inode->i_mapping, PAGE_CACHE_SIZE, -1);
> >  	unlock_page(page);
> >  	return 0;
> 
> Why are we worried about the possibility of NFS readdir pages being swap
> pages?

Indiscriminate search and replace followed by a manual check for
correctness. They might not be needed, but they're not wrong either.

Would you prefer I take them out?


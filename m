Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWFSShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWFSShz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWFSShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:37:55 -0400
Received: from chen.mtu.ru ([195.34.34.232]:18956 "EHLO chen.mtu.ru")
	by vger.kernel.org with ESMTP id S932383AbWFSShy (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:37:54 -0400
Subject: Re: batched write
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060619162740.GA5817@schatzie.adilger.int>
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>
	 <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de>
	 <1149766000.6336.29.camel@tribesman.namesys.com>
	 <20060608121006.GA8474@infradead.org>
	 <1150322912.6322.129.camel@tribesman.namesys.com>
	 <20060617100458.0be18073.akpm@osdl.org>
	 <20060619162740.GA5817@schatzie.adilger.int>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 22:28:48 +0400
Message-Id: <1150741728.6383.146.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Mon, 2006-06-19 at 09:27 -0700, Andreas Dilger wrote:
> On Jun 17, 2006  10:04 -0700, Andrew Morton wrote:
> > On Thu, 15 Jun 2006 02:08:32 +0400
> > "Vladimir V. Saveliev" <vs@namesys.com> wrote:
> > 
> > > The core of generic_file_buffered_write is 
> > > do {
> > > 	grab_cache_page();
> > > 	a_ops->prepare_write();
> > > 	copy_from_user();
> > > 	a_ops->commit_write();
> > > 	
> > > 	filemap_set_next_iovec();
> > > 	balance_dirty_pages_ratelimited();
> > > } while (count);
> > > 
> > > 
> > > Would it make sence to rework this code with adding new address_space
> > > operation - fill_pages so that looks like:
> > > 
> > > do {
> > > 	a_ops->fill_pages();
> > > 	filemap_set_next_iovec();
> > > 	balance_dirty_pages_ratelimited();
> > > } while (count);
> > > 
> > > generic implementation of fill_pages would look like:
> > > 
> > > generic_fill_pages()
> > > {
> > > 	grab_cache_page();
> > > 	a_ops->prepare_write();
> > > 	copy_from_user();
> > > 	a_ops->commit_write();
> > > }
> > > 
> > 
> > There's nothing which leaps out and says "wrong" in this.  But there's
> > nothing which leaps out and says "right", either.  It seems somewhat
> > arbitrary, that's all.
> > 
> > We have one filesystem which wants such a refactoring (although I don't
> > think you've adequately spelled out _why_ reiser4 wants this).
> > 
> > To be able to say "yes, we want this" I think we'd need to understand which
> > other filesystems would benefit from exploiting it, and with what results?
> 
> With the caveat that I didn't see the original patch, if this can be a step
> down the road toward supporting delayed allocation at the VFS level then
> I'm all for such changes.
> 

Doesn't writepages method operation of address space provide enough
freedom for a filesystem to perform delayed allocation?

The goal of the patch was just to allow a filesystem to perform metadata
update for several newly added to a file pages at once. Currently,
filesystem is asked to do that once per page. Filesystems which have
complex algorithms involved into that may find this possibility useful
to improve performance.

> Lustre goes to some lengths to batch up reads and writes on the client into
> large (1MB+) RPCs in order to maximize performance.  Similarly on the
> server we essentially bypass the VFS in order to allocate all of the RPC's
> blocks in one call and do a large bio write in a second.  It just isn't
> possible to maximize performance if everything is split into PAGE_SIZE
> chunks.
> 
> I believe XFS would benefit from delayed allocation, and the ext3-delalloc
> patches from Alex also provide a large part of the performance wins for
> userspace IO, when they allow large sys_write() and VM cache flush to
> efficiently call into the filesystem to allocate many blocks at once, and
> then push them out to disk in large chunks.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> Principal Software Engineer
> Cluster File Systems, Inc.
> 
> 


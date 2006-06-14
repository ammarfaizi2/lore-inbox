Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWFNWLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWFNWLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWFNWLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:11:43 -0400
Received: from muan.mtu.ru ([195.34.34.229]:30469 "EHLO muan.mtu.ru")
	by vger.kernel.org with ESMTP id S932410AbWFNWLm (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Jun 2006 18:11:42 -0400
Subject: batched write
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060608121006.GA8474@infradead.org>
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>
	 <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de>
	 <1149766000.6336.29.camel@tribesman.namesys.com>
	 <20060608121006.GA8474@infradead.org>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 02:08:32 +0400
Message-Id: <1150322912.6322.129.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 2006-06-08 at 13:10 +0100, Christoph Hellwig wrote:
> On Thu, Jun 08, 2006 at 03:26:40PM +0400, Vladimir V. Saveliev wrote:
> > > > It may go to the kernel as a 64MB write, but VFS sends it to the FS as
> > > > 64MB/4k separate 4k writes.
> > > 
> > > Nonsense, 
> > 
> > Hans refers to generic_file_write which does
> > prepare_write
> > copy_from_user
> > commit_write
> > for each page.
> 
> That's not really the vfs but the generic pagecache routines.  For some
> filesystems (e.g. XFS) only reservations for delayed allocations are
> performed in this path so it doesn't really matter.  For not so advanced
> filesystems batching these calls would definitly be very helpful.  Patches
> to get there are very welcome.
> 

The core of generic_file_buffered_write is 
do {
	grab_cache_page();
	a_ops->prepare_write();
	copy_from_user();
	a_ops->commit_write();
	
	filemap_set_next_iovec();
	balance_dirty_pages_ratelimited();
} while (count);


Would it make sence to rework this code with adding new address_space
operation - fill_pages so that looks like:

do {
	a_ops->fill_pages();
	filemap_set_next_iovec();
	balance_dirty_pages_ratelimited();
} while (count);

generic implementation of fill_pages would look like:

generic_fill_pages()
{
	grab_cache_page();
	a_ops->prepare_write();
	copy_from_user();
	a_ops->commit_write();
}

I believe that filesystem developers will want to exploit that
operation. 

Any opinion on this plan is welcomed. I would try to code whatever we
will have developed (I hope) in result of this discussion.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbUDASvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbUDASvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:51:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:6062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263039AbUDASvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:51:36 -0500
Date: Thu, 1 Apr 2004 10:51:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20040401105123.3dd5e969.akpm@osdl.org>
In-Reply-To: <1080834032.2626.94.camel@sisko.scot.redhat.com>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	<Pine.LNX.4.58.0403311433240.1116@ppc970.osdl.org>
	<1080776487.1991.113.camel@sisko.scot.redhat.com>
	<Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
	<1080834032.2626.94.camel@sisko.scot.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> > Tha advantage of the current MS_ASYNC is absolutely astoundingly HUGE: 
> > because we don't wait for in-progress IO, it can be used to efficiently 
> > synchronize multiple different areas, and then after that waiting for them 
> > with _one_ single fsync().
> 
> The Solaris one manages to preserve those properties while still
> scheduling the IO "soon".  I'm not sure how we could do that in the
> current VFS, short of having a background thread scheduling deferred
> writepage()s as soon as the existing page becomes unlocked.

filemap_flush() will do exactly this.  So if you want the Solaris
semantics, calling filemap_flush() intead of filemap_fdatawrite() should do
it.

> posix_fadvise() seems to do something a little like this already: the
> FADV_DONTNEED handler tries
> 
> 		if (!bdi_write_congested(mapping->backing_dev_info))
> 			filemap_flush(mapping);
> 
> before going into the invalidate_mapping_pages() call.  Having that (a)
> limited to the specific file range passed into the fadvise(), and (b)
> available as a separate function independent of the DONTNEED page
> invalidator, would seem like an entirely sensible extension.  
> 
> The obvious implementations would be somewhat inefficient in some cases,
> though --- currently __filemap_fdatawrite simply list_splice()s the
> inode dirty list into the io list.  Walking a long dirty list to flush
> just a few pages from a narrow range could get slow, and walking the
> radix tree would be inefficient if there are only a few dirty pages
> hidden in a large cache of clean pages.

The patches I have queued in -mm allow us to do this.  We use
find_get_pages_tag() to iterate over only the dirty pages in the tree.

That still has the efficiency problem that when searching for dirty pages
we also visit pages which are both dirty and under writeback (we're not
interested in those pages if it is a non-blocking flush), although I've
only observed that to be a problem when the queue size was bumped up to
10,000 requests and I fixed that up for the common cases by other means.


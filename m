Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267493AbUHSXPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267493AbUHSXPE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUHSXPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:15:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24205 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267493AbUHSXOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:14:14 -0400
Date: Thu, 19 Aug 2004 19:13:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filemap_fdatawait() wait_on_page_writeback_range(mapping, 0, -1)?
Message-ID: <20040819221304.GD5278@logos.cnet>
References: <20040819201729.GC5278@logos.cnet> <20040819144947.7ad18256.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819144947.7ad18256.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 02:49:47PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > Hi Andrew,
> > 
> > I dont understand why we do call wait_on_page_writeback_range() with -1 
> > as the "end" argument.
> 
> "every page in the file".
> 
> > -1 sounds pretty stupid at first, it does unnecessary calls to 
> > the radix lookup code.
> 
> I guess it could cause one extra call into the lookup code.  There's an
> additional check in -mm's wait_on_page_writeback_range() which would prevent
> that.

this? 

+                       /* until radix tree lookup accepts end_index */
+                       if (page->index > end)
+                               continue;

I dont see why that would make a difference. 

What seem to happen is that when we get near the EOF, the min calculation 
which could make sense, doesnt:

min(end - index, (pgoff_t)PAGEVEC_SIZE-1)

and some unnecessary cycles will be spent doing search at __lookup_tag(). And 
using i_size_read() is more meaningful anyway.

What I'm trying to do is make wait_on_page_writeback_range() do reverse
search instead ascending. Since we write pages in ascending order, doing 
the wait on reverse order makes sense and will avoid possibly tons of 
wakeups.

Naive me tried to implement that using pagevec_lookup_tag(), but I'm
convinced we need pagevec_reverse_lookup_tag() do reverse search
on the radix tree. I'll try getting that done on the weekend.

What you think about it?

> > --- a/mm/filemap.c.orig      2004-08-19 14:36:02.000000000 -0300
> > +++ b/mm/filemap.c.isize     2004-08-19 18:17:14.000000000 -0300
> > @@ -231,7 +231,7 @@
> >   */
> >  int filemap_fdatawait(struct address_space *mapping)
> >  
> > -       return wait_on_page_writeback_range(mapping, 0, -1);
> > +       return wait_on_page_writeback_range(mapping, 0, i_size_read(mapping->host));
> >  }
> 
> That would need a >> PAGE_CACHE_SHIFT

Oh yes, right. I was too excited :)

Fixed version with changelog, against 2.6.8.1-mm2:

filemap_fdatawait() calls wait_on_page_writeback_range() with -1 as "end" parameter.
This is not needed since we know the EOF from the inode. Use that instead.

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

diff -u linux-2.6.8/mm/filemap.c.orig linux-2.6.8/mm/filemap.c
--- linux-2.6.8/mm/filemap.c.orig       2004-08-19 20:11:52.000000000 -0300
+++ linux-2.6.8/mm/filemap.c    2004-08-19 20:12:40.000000000 -0300
@@ -288,7 +288,8 @@
  */
 int filemap_fdatawait(struct address_space *mapping)
 {
-       return wait_on_page_writeback_range(mapping, 0, -1);
+       return wait_on_page_writeback_range(mapping, 0,
+                       i_size_read(mapping->host) >> PAGE_CACHE_SHIFT);
 }
 EXPORT_SYMBOL(filemap_fdatawait);
  


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTLaJtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 04:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTLaJtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 04:49:39 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:28660 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263953AbTLaJth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 04:49:37 -0500
Date: Wed, 31 Dec 2003 15:25:03 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-ID: <20031231095503.GA4069@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3FCD4B66.8090905@us.ibm.com> <1070674185.1929.9.camel@ibm-c.pdx.osdl.net> <1070907814.707.2.camel@ibm-c.pdx.osdl.net> <1071190292.1937.13.camel@ibm-c.pdx.osdl.net> <1071624314.1826.12.camel@ibm-c.pdx.osdl.net> <20031216180319.6d9670e4.akpm@osdl.org> <20031231091828.GA4012@in.ibm.com> <20031231013521.79920efd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231013521.79920efd.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 01:35:21AM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > It seems like the case Daniel is thinking about is when 
> > a process has issued writes to the page cache, and then filemap_fdatawrite
> > is called, while these pages are being written back to disk parallely by 
> > another thread (not holding i_sem). The filemap_fdatawrite wouldn't see
> > pages that are in the process of being written out by the background
> > thread so it doesn't mark them for writeback.
> 
> If those pages are under writeout then they are clean and
> filemap_fdatawrite() has nothing to do.

Sure, it doesn't, because the other thread is about to issue
a writeout on them. But it does mean that there is no guarantee
that those pages are already marked as writeback when 
filemap_fdatawrite returns and filemap_fdatawait is called.

> 
> If, however, those pages were redirtied while under I/O then they are
> dirty, on dirty_pages and are under writeout.  In that case
> filemap_fdatawrite() must wait for the current write to complete and must
> start a new write.
> 
> > The following filemap_fdatawait 
> > would find these pages on the locked_pages list all right, but if its
> > unlucky enough to be in the window that Daniel mentions where PG_dirty 
> > is cleared but PG_writeback hasn't yet been set, then the page would
> > have move to the clean list without waiting for the actual writeout
> > to complete !
> 
> If you are referring to this code in mpage_writepage():
> 
> 		lock_page(page);
> 
> 		if (wbc->sync_mode != WB_SYNC_NONE)
> 			wait_on_page_writeback(page);
> 
> 		if (page->mapping == mapping && !PageWriteback(page) &&
> 					test_clear_page_dirty(page)) {
> 
> 
> then I don't see the race - the page lock synchronises the two threads?
> 

But filemap_fdatawait does not look at the page lock. So there's a
tiny window when the page is on locked_pages with PG_dirty cleared
and PG_writeback not set. Does that make sense, or is there something
I overlook ?

Daniel's patch precisely tried to fill that gap - he added a check for page 
lock in filemap_datawait.

Regards
Suparna

> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


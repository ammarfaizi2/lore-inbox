Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTLaKmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTLaKmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:42:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:39395 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264229AbTLaKmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:42:33 -0500
Date: Wed, 31 Dec 2003 16:18:01 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-ID: <20031231104801.GB4099@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1070907814.707.2.camel@ibm-c.pdx.osdl.net> <1071190292.1937.13.camel@ibm-c.pdx.osdl.net> <1071624314.1826.12.camel@ibm-c.pdx.osdl.net> <20031216180319.6d9670e4.akpm@osdl.org> <20031231091828.GA4012@in.ibm.com> <20031231013521.79920efd.akpm@osdl.org> <20031231095503.GA4069@in.ibm.com> <20031231015913.34fc0176.akpm@osdl.org> <20031231100949.GA4099@in.ibm.com> <20031231021042.5975de04.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231021042.5975de04.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 02:10:42AM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> >  > OK, but the thread which is running fdatawrite/fdatawait isn't interested
> >  > in that page, because it must have been dirtied _after_ this thread has
> >  > passed through filemap_fdatawrite(), yes?
> > 
> >  Not exactly. The page could actually have been dirtied _before_ this 
> >  thread passes through filemap_datawrite, but is just being parallely 
> >  written back by a background thread.
> 
> I still don't see it.  If the page was dirtied before this thread entered
> filemap_fdatawrite() then this thread will either start writeout
> immediately, or will wait on the writeout and start new writeout.  And
> the page lock avoids the timing window which you have mentioned.

>From filemap_fdatawait:

while (!list_empty(&mapping->locked_pages)) {
                struct page *page;
                                                                                
                page = list_entry(mapping->locked_pages.next,struct page,list);
                list_del(&page->list);
                if (PageDirty(page))
                        list_add(&page->list, &mapping->dirty_pages);
                else
                        list_add(&page->list, &mapping->clean_pages);
                                                                                
---->           if (!PageWriteback(page)) {
		                        if (++progress > 32) {
                                if (need_resched()) {
                                        spin_unlock(&mapping->page_lock);
                                        __cond_resched();
                                        goto restart;
                                }
                        }
---->                  continue;
                }
	
If PG_writeback is not set, it moves on to process the next page -- without
falling through to wait_on_page_writeback, isn't that so ? 
Another thread could have pulled the page off io_pages, put it on locked
pages, and not set PG_writeback as yet.

How does the page lock guard against this ? 
filemap_fdatawait seems to ignore the page lock.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


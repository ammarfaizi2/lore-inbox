Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUEEQ4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUEEQ4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264736AbUEEQ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:56:53 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:4237 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S264734AbUEEQ4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:56:50 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16537.7377.317729.849584@laputa.namesys.com>
Date: Wed, 5 May 2004 20:56:49 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of
 mapped pages
In-Reply-To: <20040504195753.0a9e4a54.akpm@osdl.org>
References: <20040505002029.11785.qmail@web12821.mail.yahoo.com>
	<20040504180345.099926ec.akpm@osdl.org>
	<40984E89.6070501@yahoo.com.au>
	<20040504195753.0a9e4a54.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
 > >
 > > Andrew Morton wrote:
 > > > Shantanu Goel <sgoel01@yahoo.com> wrote:
 > > > 
 > > >>Presently the kernel does not collection information
 > > >>about the percentage of memory that processes have
 > > >>dirtied via mmap until reclamation.  Nothing analogous
 > > >>to balance_dirty_pages() is being done for mmap'ed
 > > >>pages.  The attached patch adds collection of dirty
 > > >>page information during kswapd() scans and initiation
 > > >>of background writeback by waking up bdflush.
 > > > 
 > > > 
 > > > And what were the effects of this patch?
 > > > 
 > > 
 > > I havea modified patch from Nikita that does the
 > > if (ptep_test_and_clear_dirty) set_page_dirty from
 > > page_referenced, under the page_table_lock.
 > 
 > Dude.  I have lots of patches too.  The question is: what use are they?

Learning patch-scripts? :)

 > 
 > In this case, given that we have an actively mapped MAP_SHARED pagecache
 > page, marking it dirty will cause it to be written by pdflush.  Even though
 > we're not about to reclaim it, and even though the process which is mapping
 > the page may well modify it again.  This patch will cause additional I/O.

Dirty bit is transferred to the struct page when page is moved to the
inactive list, where pages are not supposedly referenced/dirtied
frequently. Besides, additional IO, if any, will be done through
->writepages() which is much more efficient than single-page pageout
from tail of the inactive list.

 > 
 > So we need to understand why it was written, and what effects were
 > observed, with what workload, and all that good stuff.

Another possible scenario where early transfer of dirty bit could be
useful: huge file consisting of single hole is mmapped, and user level
starts dirtying all pages. Current VM thinks happily that all memory is
clean, ->writepages() is not invoked. VM scanning starts, shrink_list()
dirties page-at-a-time
(shrink_list()->try_to_unmap()->set_page_dirty()), and calls
->writepage() that has to insert meta-data for the hole page (extent,
indirect pointer, whatever), and to submit IO. As order of pages at the
inactive list corresponds to the order of page faults (i.e., random),
this will result in the horrible fragmentation.

Nikita.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUEEC6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUEEC6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 22:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUEEC6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 22:58:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:39834 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261610AbUEEC6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 22:58:13 -0400
Date: Tue, 4 May 2004 19:57:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of
 mapped pages
Message-Id: <20040504195753.0a9e4a54.akpm@osdl.org>
In-Reply-To: <40984E89.6070501@yahoo.com.au>
References: <20040505002029.11785.qmail@web12821.mail.yahoo.com>
	<20040504180345.099926ec.akpm@osdl.org>
	<40984E89.6070501@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Shantanu Goel <sgoel01@yahoo.com> wrote:
> > 
> >>Presently the kernel does not collection information
> >>about the percentage of memory that processes have
> >>dirtied via mmap until reclamation.  Nothing analogous
> >>to balance_dirty_pages() is being done for mmap'ed
> >>pages.  The attached patch adds collection of dirty
> >>page information during kswapd() scans and initiation
> >>of background writeback by waking up bdflush.
> > 
> > 
> > And what were the effects of this patch?
> > 
> 
> I havea modified patch from Nikita that does the
> if (ptep_test_and_clear_dirty) set_page_dirty from
> page_referenced, under the page_table_lock.

Dude.  I have lots of patches too.  The question is: what use are they?

In this case, given that we have an actively mapped MAP_SHARED pagecache
page, marking it dirty will cause it to be written by pdflush.  Even though
we're not about to reclaim it, and even though the process which is mapping
the page may well modify it again.  This patch will cause additional I/O.

So we need to understand why it was written, and what effects were
observed, with what workload, and all that good stuff.

> It doesn't do the wakeup_bdflush thing, but that sounds
> like a good idea. What does wakeup_bdflush(-1) mean?

It appears that it will cause pdflush to write out down to
dirty_background_ratio.

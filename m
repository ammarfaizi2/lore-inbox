Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbUCNJCz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 04:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbUCNJCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 04:02:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:61851 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263331AbUCNJCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 04:02:47 -0500
Date: Sun, 14 Mar 2004 01:02:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: raybry@sgi.com, ak@suse.de, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory
 machines.......
Message-Id: <20040314010239.1d105f1c.akpm@osdl.org>
In-Reply-To: <20040314005737.7f57b8ad.akpm@osdl.org>
References: <40528383.10305@sgi.com>
	<20040313034840.GF4638@wotan.suse.de>
	<20040313184547.6e127b51.akpm@osdl.org>
	<40541A09.3050600@sgi.com>
	<20040314005737.7f57b8ad.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Well that's just a dumb implementation.  hugetlb_prefault() doesn't need
>  page_table_lock while it is zeroing the page: just drop it, test for
>  -EEXIST returned from add_to_page_cache().
> 
>  In fact we need to do that anyway: the current code is buggy if some other
>  process with a different mm gets in there and instantiates the page in the
>  pagecache before this process does: hugetlb_prefault() will return -EEXIST
>  instead of simply accepting the race and using the page which someone else
>  put there.
> 
>  After we have the page in pagecache we need to retake page_table_lock and
>  check that the target pte is still pte_none().  If it is not, you know that
>  some other thread has already instantiated a pte there so the new ref to
>  the pagecache page can simply be dropped.  See how do_no_page() handles it.
>  Of course, this only applies if mmap_sem is no longer held in there.

But before implementing any of this we should move hugetlb_prefault() and
any other generic-looking functions into mm/hugetlbpage.c.  We're getting
too much duplication in there.


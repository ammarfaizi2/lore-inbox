Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbULKAxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbULKAxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 19:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbULKAxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 19:53:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:64726 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261895AbULKAxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 19:53:33 -0500
Date: Fri, 10 Dec 2004 16:57:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: clameter@sgi.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041210165745.38c1930e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0412110036330.807-100000@localhost.localdomain>
References: <20041210161835.5b0b0828.akpm@osdl.org>
	<Pine.LNX.4.44.0412110036330.807-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Fri, 10 Dec 2004, Andrew Morton wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > > But why is do_anonymous_page adding anything to lru_cache_add_active,
> > > when its other callers leave it at that?  What's special about the
> > > do_anonymous_page case?
> > 
> > do_swap_page() is effectively doing the same as do_anonymous_page(). 
> > do_wp_page() and do_no_page() appear to be errant.
> 
> Demur.  do_swap_page has to mark_page_accessed because the page from
> the swap cache is already on the LRU, and for who knows how long.

Well.  Some of the time.  If the page was just read from swap, it's known
to be on the active list.

> The others (and count in fs/exec.c's install_arg_page) are dealing
> with a freshly allocated page they are putting onto the active LRU.
> 
> My inclination would be simply to remove the mark_page_accessed
> from do_anonymous_page; but I have no numbers to back that hunch.
> 

With the current implementation of page_referenced() the
software-referenced bit doesn't matter anyway, as long as the pte's
referenced bit got set.  So as long as the thing is on the active list, we
can simply remove the mark_page_accessed() call.

Except one day the VM might get smarter about pages which are both
software-referenced and pte-referenced.

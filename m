Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVAEVql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVAEVql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVAEVqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:46:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:28330 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262611AbVAEVp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:45:27 -0500
Date: Wed, 5 Jan 2005 13:44:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105134457.03aca488.akpm@osdl.org>
In-Reply-To: <20050105174934.GC15739@logos.cnet>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
	<20050105020859.3192a298.akpm@osdl.org>
	<20050105180651.GD4597@dualathlon.random>
	<Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
	<20050105174934.GC15739@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Wed, Jan 05, 2005 at 01:50:51PM -0500, Rik van Riel wrote:
> > On Wed, 5 Jan 2005, Andrea Arcangeli wrote:
> > 
> > >Another unrelated problem I have in this same area and that can explain
> > >VM troubles at least theoretically, is that blk_congestion_wait is
> > >broken by design. First we cannot wait on random I/O not related to
> > >write back. Second blk_congestion_wait gets trivially fooled by
> > >direct-io for example. Plus the timeout may cause it to return too early
> > >with slow blkdev.

That's true, as we discussed a couple of months back.  But the current code
is nice and simple and has been there for a couple of years with no
observed problems.


> > Or the IO that just finished, finished for pages in
> > another memory zone, or pages we won't scan again in
> > our current go-around through the VM...
> 
> Thing is there is no distinction between pages which have been written out 
> for what purpose at the block level. 
> 
> One can conjecture the following: per-zone waitqueue to be awakened from 
> end_page_writeback() (for PG_reclaim pages only of course), and a function
> to wait on the perzone waitqueue:
> 
>  wait_vm_writeback (zone, timeout);
> 
> Instead of the current blk_congestion_wait() on try_to_free_pages/balance_pgdat.
> 

The caller would need to wait on all the zones which can satisfy the
caller's allocation request.  A bit messy, although not rocket science. 
One would have to be careful to avoid additional CPU consumption due to
delivery of multiple wakeups at each I/O completion.

We should be able to demonstrate that such a change really fixes some
problem though.  Otherwise, why bother?



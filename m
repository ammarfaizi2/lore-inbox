Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVAEUZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVAEUZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVAEUZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:25:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28379 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262643AbVAEUYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:24:52 -0500
Date: Wed, 5 Jan 2005 15:49:35 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050105174934.GC15739@logos.cnet>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com> <20050105020859.3192a298.akpm@osdl.org> <20050105180651.GD4597@dualathlon.random> <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 01:50:51PM -0500, Rik van Riel wrote:
> On Wed, 5 Jan 2005, Andrea Arcangeli wrote:
> 
> >Another unrelated problem I have in this same area and that can explain
> >VM troubles at least theoretically, is that blk_congestion_wait is
> >broken by design. First we cannot wait on random I/O not related to
> >write back. Second blk_congestion_wait gets trivially fooled by
> >direct-io for example. Plus the timeout may cause it to return too early
> >with slow blkdev.
> 
> Or the IO that just finished, finished for pages in
> another memory zone, or pages we won't scan again in
> our current go-around through the VM...

Thing is there is no distinction between pages which have been written out 
for what purpose at the block level. 

One can conjecture the following: per-zone waitqueue to be awakened from 
end_page_writeback() (for PG_reclaim pages only of course), and a function
to wait on the perzone waitqueue:

 wait_vm_writeback (zone, timeout);

Instead of the current blk_congestion_wait() on try_to_free_pages/balance_pgdat.

It will probably slow the reclaiming procedure in general, though, and has
other side effects, but its the only way of strictly following VM writeback
progress from VM reclaiming routines.

Does it make any sense?

> >blk_congestion_wait is a fundamental piece to get oom detection right
> >during writeback and unfortunately it's fundamentally fragile in 2.6
> >(this as usual wasn't the case in 2.4).
> 
> Indeed ;(

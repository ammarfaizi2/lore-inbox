Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVAESIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVAESIF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVAESHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:07:43 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53854
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262529AbVAESGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:06:41 -0500
Date: Wed, 5 Jan 2005 19:06:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050105180651.GD4597@dualathlon.random>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com> <20050105020859.3192a298.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105020859.3192a298.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 02:08:59AM -0800, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> >
> > Still untested, but posting the concept here anyway, since this
> >  could explain a lot...
> > 
> >  OOM kills have been observed with 70% of the pages in lowmem being
> >  in the writeback state.  If we count those pages in sc->nr_scanned,
> >  the VM should throttle and wait for IO completion, instead of OOM
> >  killing.
> > 
> >  Signed-off-by: Rik van Riel <riel@redhat.com>
> > 
> >  --- linux-2.6.9/mm/vmscan.c.screclaim	2005-01-03 12:17:56.547148905 -0500
> >  +++ linux-2.6.9/mm/vmscan.c	2005-01-03 12:18:16.855965416 -0500
> >  @@ -376,10 +376,10 @@
> > 
> >    		BUG_ON(PageActive(page));
> > 
> >  +		sc->nr_scanned++;
> >    		if (PageWriteback(page))
> >    			goto keep_locked;
> > 
> >  -		sc->nr_scanned++;
> 
> Patch looks very sane.  It in fact restores that which we were doing until
> 12 June 2004, when the rampant `struct scan_control' depredations violated
> the tree.

Agreed.

Another unrelated problem I have in this same area and that can explain
VM troubles at least theoretically, is that blk_congestion_wait is
broken by design. First we cannot wait on random I/O not related to
write back. Second blk_congestion_wait gets trivially fooled by
direct-io for example. Plus the timeout may cause it to return too early
with slow blkdev.

blk_congestion_wait is a fundamental piece to get oom detection right
during writeback and unfortunately it's fundamentally fragile in 2.6
(this as usual wasn't the case in 2.4).

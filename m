Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbUC2WvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUC2WvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:51:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46234
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263158AbUC2Wu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:50:58 -0500
Date: Tue, 30 Mar 2004 00:50:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa5
Message-ID: <20040329225057.GM3808@dualathlon.random>
References: <Pine.LNX.4.44.0403291843320.18876-100000@localhost.localdomain> <Pine.GSO.4.58.0403291615540.13685@eecs2340u28.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403291615540.13685@eecs2340u28.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 04:30:51PM -0500, Rajesh Venkatasubramanian wrote:
> 
> Andrew Moroton <akpm@osld.org> wrote:
> >> Andrea Arcangeli <andrea@suse.de> wrote:
> >>
> >> Notably there is a BUG_ON(page->mapping) triggering in
> >> page_remove_rmap in the pagecache case. that could be ex-pagecache
> >> being
> >> removed from pagecache before all ptes have been zapped, infact the
> >> page_remove_rmap triggers in the vmtruncate path.
> >
> > Confused.  vmtruncate zaps the ptes before removing pages from
> > pagecache,
> > so I'd expect a non-null ->mapping in page_remove_rmap() is a very
> > common
> > thing.  truncate a file which someone has mmapped and it'll happen every
> > time, will it not?
> 
> Andrea missed a not (!) in the BUG_ON. It is BUG_ON(!page->mapping).

Yep sorry ;)

> 
> The race Andrea hit _may_ be the mremap vs. vmtruncate race I hit:
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=107720111303624
> 
> A first truncate that raced with mremap and left an orphaned pte.
> The following truncate tried to clear the orphaned pte, and reached
> page_remove_rmap with page->mapping == NULL.
> 
> Yes. It can happen in all 2.4 and 2.6 kernels.

ok fine, so my WARN_ON should work.

> Hugh has a better fix than mine for the mremap vs. truncate race
> in his anobjrmap 7/6 patch.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107998825716363
> 
> With prio_tree we have to modify Hugh's fix, though.

Hugh are you interested to extract the fix against mainline? The
anobjrmap 7/6 is doing most of stuff I don't really need with anon-vma.

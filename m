Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbTGBXQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265674AbTGBXQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:16:21 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55193
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265615AbTGBXQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:16:17 -0400
Date: Thu, 3 Jul 2003 01:30:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702233014.GW23578@dualathlon.random>
References: <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random> <20030702214032.GH20413@holomorphy.com> <20030702220246.GS23578@dualathlon.random> <20030702221551.GH26348@holomorphy.com> <20030702222641.GU23578@dualathlon.random> <20030702231122.GI26348@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702231122.GI26348@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 04:11:22PM -0700, William Lee Irwin III wrote:
> On Wed, Jul 02, 2003 at 03:15:51PM -0700, William Lee Irwin III wrote:
> >> What complexity? Just unmap it if you can't allocate a pte_chain and
> >> park it on the LRU.
> 
> On Thu, Jul 03, 2003 at 12:26:41AM +0200, Andrea Arcangeli wrote:
> > the complexity in munlock to rebuild what you destroyed in mlock, that's
> > linear at best (and for anonymous mappings there's no objrmap, plus
> > objrmap isn't even linear but quadratic in its scan [hence the problem
> > with it], though in practice it would be normally faster than the linear
> > of the page scanning ;)
> 
> Computational complexity; okay.
> 
> It's not quadratic; at each munlock(), it's not necessary to do

yes, as said above it's linear with the number of virtual pages mapped
unless you use the objrmap to rebuild rmap.

> anything more than:

is this munmap right?

> 
> for each page this mlock()'er (not _all_ mlock()'ers) maps of this thing
> 	grab some pagewise lock
> 	if pte_chain allocation succeeded
> 		add pte_chain

allocated sure, but it has no information yet, you dropped the info in
mlock

> 	else
> 		/* you'll need to put anon pages in swapcache in mlock() */
> 		unmap the page

how to unmap? there's no rmap. also there may not be swap at all to
allocate swapcache from

> 	decrement lockcount
> 	if lockcount vanished
> 	park it on the LRU
> 	drop the pagewise lock
> 
> Individual mappers whose mappings are not mlock()'d add pte_chains when
> faulting the things in just like before.

Tell me how you reach the pagetable from munlock to do the unmap. If you
can reach the pagetable, the unmap isn't necessary and you only need to
rebuild the rmap. and if you can reach the pagetable efficiently w/o
rmap, it means rmap is useless in the first place.

Andrea

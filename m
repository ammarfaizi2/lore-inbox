Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbUCLR0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUCLR0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:26:16 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31248
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262373AbUCLRZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:25:19 -0500
Date: Fri, 12 Mar 2004 18:26:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040312172600.GC30940@dualathlon.random>
References: <20040310080000.GA30940@dualathlon.random> <Pine.LNX.4.44.0403100759550.7125-100000@chimarrao.boston.redhat.com> <20040310135012.GM30940@dualathlon.random> <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403121149400.2624@sapphire.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 12:05:27PM -0500, Rajesh Venkatasubramanian wrote:
> 
> 
> >> have a devastating effect on vma usage, yes) issue of vma merging, but
> >> what about the (mandatory) vma splitting? ...[snip]
> 
> > you're right about vma_split, the way I implemented it is wrong,
> > basically the as.vma/PageDirect idea is falling apart with vma_split.
> 
> Why do you have to fix up all page structs' PageDirect and as.vma
> fields when a vma_split or vma_merge occurs.
> 
> Can't you do it lazily on the next page_referenced or page_add_rmap,

I cannot do it lazily unfortunately because the paging routine will
start from the page, so if the page is not uptodate it will go to
read into nirvana.

> etc. Anyway we can get to the anon_vma using as.vma->anon_vma.
> 
> I understand that currenly your code assumes that if PageDirect is
> set, then there cannot be an anon_vma corresponding to the page.

correct, though I will have to change that for the above problem ;(

Well, another way is to just do the pagetable walk and fixup the
page->as.vma to be a page->as.anon_vma during split/merge (actually
merge is already taken care of by forbidding merging in the interesting
cases, what I missed was the split, oh well ;). But preallocating the
anon_vma is such a little cost that it should be a lot better than
slowing down the split.

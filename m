Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUCLRMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUCLRMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:12:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16656
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262429AbUCLRMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:12:24 -0500
Date: Fri, 12 Mar 2004 18:13:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312171307.GA30940@dualathlon.random>
References: <20040312131103.GS30940@dualathlon.random> <Pine.LNX.4.44.0403121121500.6494-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403121121500.6494-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 11:25:27AM -0500, Rik van Riel wrote:
> pointing to a struct address_space with its anonymous
> memory.  On exec() the mm_struct gets a new address_space,
> on fork parent and child share them.

isn't this what anonmm is already doing? are you suggesting something
different?

> There's no difference between mremap() of anonymous memory
> and mremap() of part of an mmap() range of a file...
> 
> At least, there doesn't need to be.

the anonmm simply cannot work because it's not reaching vmas, it only
reaches mm, and with an mm and a virtual address you cannot reach the
right vma if it was moved around by mremap, you don't even see any
vm_pgoff during the lookup, no way to fix anonmm with a prio_tree.

something in between anon_vma and anonmm that could handle mremap too
would been possible but it has downsides not fixable with a prio_tree,
and it consists in queueing all the _vmas_ (not the mm!) into an
anon_vma object, then you've to fixup the vma merging code to obey to
forbid merging with different vm_pgoff. That would be like anon_vma but
it would not be finegriend like anon_vma is, you'll end up scanning very
old vma segments in other address spaces despite you're working with
direct memory now. Such model (let's call it anon_vma_global) would save
8 bytes per vma of anonvma objects.  Maybe that's the model that DaveM
implemented originally? I think my anon_vma is superior because more
finegriend (it also avoids the need of a prio_tree even if in theory we
could stack a prio_tree on top of every anon_vma, but it's really not
needed) and the memory usage is minimal anyways (the per-vma memory cost
is the same for anon_vma and anon_vma_global, only the total number of
anon_vma objects vary). the prio_tree wouldn't fix the intermediate
model because the vma ranges could match fine in all address spaces, so
you would need the prio_tree adding another 12 bytes to each vma (on top
of the 12 bytes addred by the anon_vma_global), but the pages would be
different because the vma->vm_mm is different and there can be copy on
writes.  this cannot happen with an inode, so the prio_tree fixes the
inode completely while it doesn't fix the anon_vma_global design with 1
anon_vma only allocated at fork for all childs. anon_vma gets that
optimally instead (with a 8byte cost).  so overall I think anon_vma is a
much better utilizations of the 12 bytes, rather than having a prio_tree
stacked on top of a anon_vma_global, I prefer to be finegrined and to
track the stuff that not even a prio tree can track when the vma->vm_mm
has different pages for every vma in the same range.

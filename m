Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVF1GgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVF1GgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVF1GgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:36:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:2709 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261963AbVF1G0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:26:54 -0400
Subject: Re: increased translation cache footprint in v2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, akpm@osdl.org,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <6a3846d2436994d94aeacb0b0850d5f5@embeddededge.com>
References: <20050626172334.GA5786@logos.cnet>
	 <20050626164939.2f457bf6.akpm@osdl.org> <20050626185210.GB6091@logos.cnet>
	 <20050626.173338.41634345.davem@davemloft.net>
	 <20050626190944.GC6091@logos.cnet>
	 <6a3846d2436994d94aeacb0b0850d5f5@embeddededge.com>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 16:21:28 +1000
Message-Id: <1119939689.5133.200.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 11:46 -0400, Dan Malek wrote:
> On Jun 26, 2005, at 3:09 PM, Marcelo Tosatti wrote:
> 
> > Thats a very interesting idea, will probably optimize performance in
> > general ("why did nobody thought of it before?" kind).
> 
> I've done this before, used the pgd/pmd or pte  to hold large page
> size entries.  The problem is the amount of code needed in the
> tlbmiss handler to implement this.  The Linux page table structure
> doesn't allow us to easily format this information, so we have lots
> of code in the handler to fabricate these entries.  It's a significant
> overhead for the normal 4K path that was hard to justify.

How so ? the linux page table structure allow you to format the PTE and
PMD contents pretty much the way you want ...

> We need to be optimizing the applications, since that is where the
> real work is done and where the system spends most of it's time.
> The kernel is easy to optimize with pinned entries, then we have the
> best solution.  A minimal overhead for the 4K pages, plus an optimal
> kernel mapping.

Pinned entry are never a good solution, more like a workaround... It's
never good to pin an entry on such a small TLB (though I can understand
that you may want to always pin the kernel first entry) I don't think
it's necessary.

> I do want the solution of variable page sizes in the kernel, because
> we don't have to reserve wired entries, providing the best solution.
> I'm always thinking of this and experiment with it from time to time, 
> but
> I haven't found a solution that is satisfactory to me :-)  Maybe 
> something
> like an early kernel/user test and separate code paths, but I now have
> a solution that eliminates our current test, and I don't want to put it
> back in :-)  My holy grail is a 4 instruction tlb miss handler, but I 
> haven't
> been able to get the PTEs formatted correctly so everyone is happy.

Paul told me the 8xx has some restrictions about what goes at the "PMD"
level that is a problem for us (is it cache inhibited bit ?) and thus we
cannot completely do the PMD/PTE thingy, but I don't know the details,
can you tell me more ?

For the kernel address space, however, we are pretty much free to do
what we want. The only thing for which the kernel need page tables is
the vmalloc space. The rest can be implemented the way you want by arch
code (though it's often useful to also use page tables for io space).

Ben.



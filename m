Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUCLRnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUCLRnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:43:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54032
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261706AbUCLRnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:43:47 -0500
Date: Fri, 12 Mar 2004 18:44:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040312174429.GE30940@dualathlon.random>
References: <20040312171307.GA30940@dualathlon.random> <Pine.LNX.4.44.0403121217440.6494-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403121217440.6494-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 12:23:22PM -0500, Rik van Riel wrote:
> On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> > On Fri, Mar 12, 2004 at 11:25:27AM -0500, Rik van Riel wrote:
> > > pointing to a struct address_space with its anonymous
> > > memory.  On exec() the mm_struct gets a new address_space,
> > > on fork parent and child share them.
> > 
> > isn't this what anonmm is already doing? are you suggesting something
> > different?
> 
> I am suggesting a pointer from the mm_struct to a
> struct address_space ...

that's the anonmm:

+	mm->anonmm = anonmm;

> > > There's no difference between mremap() of anonymous memory
> > > and mremap() of part of an mmap() range of a file...
> > > 
> > > At least, there doesn't need to be.
> > 
> > the anonmm simply cannot work because it's not reaching vmas, it only
> > reaches mm, and with an mm and a virtual address you cannot reach the
> > right vma if it was moved around by mremap,
> 
> ... and use the offset into the struct address_space as
> the page->index, NOT the virtual address inside the mm.
> 
> On first creation of anonymous memory these addresses
> could be the same, but on mremap inside a forked process
> (with multiple processes sharing part of anonymous memory)
> a page could have a different offset inside the struct
> address space than its virtual address....
> 
> Then on mremap you only need to adjust the start and
> end offsets inside the VMAs, not the page->index ...

I don't see how this can work, each vma needs its own vm_off or a single
address space can't handle them all. Also the page->index is the virtual
address (or the virtual offset with anon_vma), it cannot be replaced
with something global, it has to be per-page.

> Isn't being LESS finegrained the whole reason for moving
> from pte based to object based reverse mapping ? ;))

the object is to cover ranges, instead of forcing per-page overhread.
Being finegrined at the vma is fine, being finegrined less than a vma is
desiderable only if there's no downside.

> > (it also avoids the need of a prio_tree even if in theory we could stack
> > a prio_tree on top of every anon_vma, but it's really not needed)
> 
> We need the prio_tree anyway for files.  I don't see

As I said in the last email the prio_tree will not work for the
anonvmas, because every vma in the same range will map to different
pages. So you'll find more vmas than the ones you're interested about.
This doesn't happen with inodes. with inodes every vma queued into the
i_mmap will be mapping to the right page _if_ it's pte_present == 1.

with your anonymous address space shared by childs the prio_tree will
find lots of vmas in different vma->vm_mm, each one pointing to
different pages. so to unmap a direct page after a malloc, you may end
up scanning all the address spaces by mistake. This cannot happen with
anon_vma. Furthermore the prio_tree will waste 12 bytes per vma, while
the anon_vma design will waste _at_most_ 8 bytes per vma (actually less
if the anon_vma are shared). And with anon_vma in practice you won't
need a prio_tree stacked on top of anon_vma. You could put one if you
want paying another 12bytes per vma, but it doesn't worth it. So
anon_vma takes less memory and it's more efficent as far as I can tell.

> Having the same code everywhere will definately help
> simplifying things.

Reusing the same code would be good I agree, but I don't think it would
work as well as with the inodes, and with the inodes it's really needed
only for a special 32bit case, so normally the lookup would be immdiate,
while here we need it for real expensive lookups if one has many
anonymous vmas in the childs even on 64bit apps. So I prefer a design
where the prio_tree or not the cost for good apps 64bit archs is the
same. prio_tree is not free, it's still O(log(N)) and I prefer a design
where the common case is N == 1 like with anon_vma (with your
address-space design N would be >1 normally in a server app).

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTJCHhe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 03:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbTJCHhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 03:37:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55726
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263593AbTJCHh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 03:37:29 -0400
Date: Fri, 3 Oct 2003 09:37:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1
Message-ID: <20031003073747.GI13360@velociraptor.random>
References: <20031002152648.GB1240@velociraptor.random> <20031003005116.GD13051@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031003005116.GD13051@matchmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 05:51:16PM -0700, Mike Fedyk wrote:
> On Thu, Oct 02, 2003 at 05:26:48PM +0200, Andrea Arcangeli wrote:
> > Only in 2.4.23pre6aa1: 05_vm_27-pte-dirty-bit-in-hardware-1
> > 
> > 	This fixes a longstanding bug for a number of archs that haven't the
> > 	dirty bit updated in hardware. For those archs we can't mark the pte
> > 	writeable when it's still in swap cache, unless we don't mark it dirty
> > 	too at the same time. Otherwise the cpu will go ahead writing to the
> > 	page, no fault will happen and the swapcache will be still clean, and
> > 	the data will be lost at the next zeroIO swapout leading to userspace
> > 	data corruption and segfaults during swap. Affected archs are
> > 	alpha/s390/s390x for example.
> > 
> > 	This bug was specific to the -aa VM, it couldn't happen
> > 	in mainline. In my tree I optimized the code to exploited
> > 	properties of archs that updates the bit in hardware for the
> > 	first time. Hence the first need of a #define to differentiate the
> > 	two code paths. The logic in the software-dirty-bit case will
> > 	be less efficient of course (that's why there's a difference
> > 	in the first place).
> 
> What does rmap do in this case then?

no idea, but likely it wasn't affected. This was an ultra optimization I
did, it was very aggressive and it broke the archs with the pte-dirty
bit handled in software.

this is also the proof that the pte_* abstraction is not trasparent at
all, and we definitely need a compile time #define to differentiate the
two cases (I added it in the above patch for x86 and x86-64 and as said
above this patch is infact an obvious noop for those two archs).

This is the code that broke it. the 'page' pointed by the pte is an
exclusive page at that point, it means it's not shared by any other
"mm" and it's of course an anonymous page. It can be in the swapcache or
not, it doesn't make any difference (if it's not in the swapcache it's
guaranteed to be marked PG_dirty at the phyiscal level).

		if (write_access)
			pte = pte_mkdirty(pte);
		if (vma->vm_flags & VM_WRITE)
			pte = pte_mkwrite(pte);

This code is perfectly correct and it's more efficient than the
software-dirty-bitflag because it avoids a copy-on-write page fault if
this was a read access. If it was a read access we want to mark the pte
writeable but not dirty, so if the page is still in the swapcache and
nobody writes to it, we can swap out it zerocost. And at the same time
we avoid any copy-on-write pagefault if somebody writes later to the
page after we instantiated the mapping.

This is instead the version needed by archs with the dirty bit in
software like ppc/s390/s390x/ppc64/alpha (there maybe more).

		if (write_access)
			pte = pte_mkdirty(pte_mkwrite(pte));

On these archs we simply can't mark the pte writeable if we don't mark
it dirty too, or somebody can write to the swappage and we would never
notice, and the kernel would think it can swapout zerocost (swapcache
still clean), while it really should do the I/O in that case.

The bug wasn't too bad, just a segfault or data corruption in userspace
during heavy swapping. The kernel was stable, there's no way to crash
the kernel forgetting a dirty bit. So it was also hardly noticeable. And
if you had zero swap it simply couldn't trigger because no swapcache
could be allocated. So the workaround swapoff -a is 100% reliable.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbVLWUx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbVLWUx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbVLWUx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:53:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161049AbVLWUx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:53:26 -0500
Date: Fri, 23 Dec 2005 12:53:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: michael.bishop@APPIQ.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
In-Reply-To: <20051223.111940.17674086.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
References: <DF925A10E7204748977502BECE3D11230100CD7C@exch02.appiq.com>
 <20051223.111940.17674086.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Hugh and Nick added to Cc, just in case they can see anything wrong with 
  this. It's actually very simple, but I hoped to avoid having to support
  the insane cases. I guess it was naive of me to think that there isn't 
  always _some_ insane user ;^]

David: please read the final note before the patch about software 
dirty/accessed bits. It may or may not be an issue on sparc64, I don't 
know where you do the dirty/accessed bit handling.

On Fri, 23 Dec 2005, David S. Miller wrote:
> 
> Linus, X.org is doing a MAP_PRIVATE mmap() of these discontiguous
> I/O mappings of the sparc frame buffer device it seems.  So the
> MAP_SHARED check in is_cow_mapping() doesn't pass.

Ok. I actually had a backup plan for that too, but was hoping that nobody 
would be quite that insane.

And doing a private mapping on a device and then expecting to do writes 
through that mapping is just totally insane. The fact that it happened to 
work before was arguably very much a bug (as it didn't actually create a 
private mapping).

But hey, here's the backup plan. It's entirely untested, but it is 
actually very simple, and has way more comments than actual code, so 
hopefully it's understandable and "obviously right" (yeah sure, famous 
last words ;).

NOTE! This very much means that an insane user that first does a private 
writable mapping of a device like this , and then a fork(), will _not_ see 
the mapping in the child. It will remain "private" and writable in the 
parent instead (writable only if the page protections that were passed in 
to remap_pfn_range() were writable, of course).

The reason? Doing a COW after the fork would be insane. Both from a VM 
complexity issue (it's what all the work has been trying to avoid), but 
also from a "what the hell does it mean?" kind of issue. 

So I'm pretty damn sure nobody depends on _that_ at least (old kernels 
would have done the insane and meaningless thing: it would basically be 
mapped shared until the fork() happened, and then it would be 
copy-on-write in _both_ processes after the fork).

NOTE NOTE NOTE! This will _not_ work if the pages need a software-dirty 
and/or software-accessed bit, and the low-level architecture page fault 
handler says "this is a write to a nonwritable area" and raises a SIGSEGV. 

So it may be that the insane sparc remap_pfn_range() users need to set the 
dirty/accessed bits in the page protection flags by hand before to avoid 
that. David?

Michael, can you test this patch (with the note that David may need to 
change something else too)?

So there are certainly some subtle issues left with this, and I'm not 
saying it's quite this simple, but they should be easy enough to handle.

			Linus

----
diff --git a/mm/memory.c b/mm/memory.c
index d8dde07..a93654d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1326,9 +1326,32 @@ int remap_pfn_range(struct vm_area_struc
 	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
 	 */
 	if (is_cow_mapping(vma->vm_flags)) {
-		if (addr != vma->vm_start || end != vma->vm_end)
-			return -EINVAL;
-		vma->vm_pgoff = pfn;
+		/*
+		 * We can do a real COW mapping _if_ it covers the whole area,
+		 * at which point we do the magic "vm_pgoff" trick.
+		 *
+		 * Otherwise we will have to turn it into non-copyable shared
+		 * area which has VM_WRITE turned off.
+		 *
+		 * NOTE NOTE NOTE! If the remap_pfn_range() was called with
+		 * a writable page protection, this means that the pages will
+		 * still be writable, but we will refuse to ever take a
+		 * write fault on any pages that weren't so.
+		 *
+		 * Also, we refuse to do the SHARED conversion if we already
+		 * have taken a C-O-W fault on the area.
+		 *
+		 * This is all just for insane old X servers, which map the
+		 * video pages private.
+		 */
+		if (addr == vma->vm_start && end == vma->vm_end) {
+			vma->vm_pgoff = pfn;
+		} else {
+			if (vma->anon_vma)
+				return -EINVAL;
+			vma->vm_flags |= VM_DONTCOPY | VM_SHARED;
+			vma->vm_flags &= ~(VM_WRITE | VM_MAYWRITE);
+		}
 	}
 
 	vma->vm_flags |= VM_IO | VM_RESERVED | VM_PFNMAP;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVCWN3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVCWN3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVCWN3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:29:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:9829 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261443AbVCWN3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:29:39 -0500
Date: Wed, 23 Mar 2005 13:28:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, davem@davemloft.net, tony.luck@intel.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <1111534250.16224.22.camel@gaston>
Message-ID: <Pine.LNX.4.61.0503231248510.13752@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com> 
    <20050322034053.311b10e6.akpm@osdl.org> 
    <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com> 
    <1111534250.16224.22.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Benjamin Herrenschmidt wrote:
> On Tue, 2005-03-22 at 16:37 +0000, Hugh Dickins wrote:
> > 
> > I cannot see those arches doing pte_allocs outside their vmas,
> > that of course could cause it.  And nr_ptes is initialized to 0
> > once by memset and again by assignment, so it should be starting
> > out even zeroer than most fields.
> 
> We do funny things in arch/ppc64/mm/init.c in the ioremap_mm, where we
> don't use VMAs but our own mecanism (yah, ugly, but that's some legacy
> we have from the original port, though I do intend to change that at one
> point).

Thanks for the warning, Ben, but I don't see a problem there: that's
in your separate ioremap_mm, which is rather like init_mm, and won't
ever go through exit_mmap, and doesn't need its page tables freed -
isn't that right?

But it was worth auditing the different architectures for this: there
seems to be just one problem, where the x86_64 32-bit vsyscall page
is mapped into userspace by __map_syscall32 without linking a real
vma into mm.  Which Andi has already marked with his "RED-PEN".

That's not something I can fix up in a hurry.  Yes, as the comment
suggests we should probably allocate a real vma for it, but that might
have a few consequences (if only /proc/<pid>/maps showing two vdsos?).
I'll have to let someone else deal with that.

For the moment, I think the behaviour of x86_64 32bit-support with
the freepgt patches will depend on personality - ADDR_LIMIT_32BIT
should usually work fine (unless the app moves its stack elsewhere
and munmaps the old one: that might well unmap its vdso too); but
ADDR_LIMIT_3GB will be liable to leak tables (if get_user_pages or
its /proc/<pid>/maps has been examined).  I don't know how common
ADDR_LIMIT_3GB use is, but whatever: okay for testing, but not for
including the patches in a release.

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVA0UuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVA0UuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVA0Urw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:47:52 -0500
Received: from holomorphy.com ([66.93.40.71]:1456 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261182AbVA0UpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:45:12 -0500
Date: Thu, 27 Jan 2005 12:44:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050127204455.GM10843@holomorphy.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com> <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com> <20050127142500.A775@flint.arm.linux.org.uk> <20050127151211.GB10843@holomorphy.com> <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, William Lee Irwin III wrote:
>> The only claim above is the effect of clobbering virtual page 0 and
>> referring to this phenomenon by the macro. I was rather careful not to
>> claim a specific lower boundary to the address space.

On Thu, Jan 27, 2005 at 02:22:50PM -0500, Rik van Riel wrote:
> OK, here is a patch that does compile against the current
> 2.6 kernel.  It it obvious we need a cutoff somewhere, so
> I've chosen one that's sure to spark up a conversation
> and I'll let others decide what that cutoff value is ;)))

Okay, 2 comments:

(a) The most permissive scheme possible given architectural constraints
	I'm aware of (thanks, rmk) would only disallow below PAGE_SIZE,
	or basically !vma->vm_start. mm->brk affects executables with
	high load addresses and prevents the use of the lower 128MB on
	ia32, which I personally make extensive use of in order to move
	program stacks out of the way of larger mmap()'s and to conserve
	pagetable memory.
(b) sys_mremap() isn't covered.

Does the following give you any new ideas?


-- wli

Index: mm1-2.6.11-rc2/mm/mmap.c
===================================================================
--- mm1-2.6.11-rc2.orig/mm/mmap.c	2005-01-26 00:30:38.000000000 -0800
+++ mm1-2.6.11-rc2/mm/mmap.c	2005-01-27 12:33:34.000000000 -0800
@@ -1258,7 +1258,7 @@
 		 * return with success:
 		 */
 		vma = find_vma(mm, addr);
-		if (!vma || addr+len <= vma->vm_start)
+		if (addr && (!vma || addr+len <= vma->vm_start))
 			/* remember the address as a hint for next time */
 			return (mm->free_area_cache = addr);
 
Index: mm1-2.6.11-rc2/mm/mremap.c
===================================================================
--- mm1-2.6.11-rc2.orig/mm/mremap.c	2005-01-26 00:26:43.000000000 -0800
+++ mm1-2.6.11-rc2/mm/mremap.c	2005-01-27 12:34:34.000000000 -0800
@@ -297,6 +297,8 @@
 	if (flags & MREMAP_FIXED) {
 		if (new_addr & ~PAGE_MASK)
 			goto out;
+		if (!new_addr)
+			goto out;
 		if (!(flags & MREMAP_MAYMOVE))
 			goto out;
 

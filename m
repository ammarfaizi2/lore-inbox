Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUKECX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUKECX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUKECX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:23:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63713 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262547AbUKECXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:23:14 -0500
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041105020831.GI8229@dualathlon.random>
References: <4188118A.5050300@us.ibm.com>
	 <20041103013511.GC3571@dualathlon.random> <418837D1.402@us.ibm.com>
	 <20041103022606.GI3571@dualathlon.random> <418846E9.1060906@us.ibm.com>
	 <20041103030558.GK3571@dualathlon.random>
	 <1099612923.1022.10.camel@localhost> <1099615248.5819.0.camel@localhost>
	 <20041105005344.GG8229@dualathlon.random>
	 <1099619740.5819.65.camel@localhost>
	 <20041105020831.GI8229@dualathlon.random>
Content-Type: multipart/mixed; boundary="=-AjjCEpVRAe0rnMQOxPHT"
Message-Id: <1099621391.5819.72.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 04 Nov 2004 18:23:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AjjCEpVRAe0rnMQOxPHT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-11-04 at 18:08, Andrea Arcangeli wrote:
> On Thu, Nov 04, 2004 at 05:55:40PM -0800, Dave Hansen wrote:
> > What happens when a pte page is bootmem-allocated?  I *think* that's the
> > situation that I'm hitting.  In that case, we can either try to hunt
> > down the real 'struct pages' after everything is brought up, or we can
> > just skip the BUG_ON() if the page is reserved.  Any thoughts?
> 
> Skipping BUG_ON if the page is reserved is something you can certainly
> try.
> 
> However if all usages are symmetric, the only pte that should ever get
> freed, is the pte that change_page_attr itself has allocated via
> split_large_page.
> 
> I tried the debug option right now, without the fixes I get a crash in
> X (but not in pageattr.c, it's an invalid page fault in some direct
> mapping), that might be a real bug or another false positive.
> 
> with the fixes applied I get this, so I can reproduce at least ;)

Here we go again :)

I think we're being naughty about page_count()s for pages that never hit
the page allocator (ones that never hit free_all_bootmem()).  They keep
an initial page_count() of 0, which is a no no if they're used as pte
pages and noticed by __change_page_attr().  This discrepancy isn't
noticed until the page is get'd 512 times, then completely __put'd as
things get allocated into space mapped by the page.  The final __put
hits the BUG_ON().  To find this earlier, we could also have a
BUG_ON(!page_count(kpte_page)) in __change_page_attr() right after we
find the kpte_page, in addition to the check after the count is
modified.  

This patch defaults the page counts to 1 instead of 0 for all pages in
the zone initialization.  Any pages that go though free_all_bootmem()
are set back to a state where they cleanly go in to the allocator.  

I'm not quite sure if this has any other weird effects, so I'll hold on
to it for a week or so and see if anything turns up.  

-- Dave

--=-AjjCEpVRAe0rnMQOxPHT
Content-Disposition: attachment; filename=Z0-bootmem_page_counts.patch
Content-Type: text/x-patch; name=Z0-bootmem_page_counts.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 memhotplug1-dave/mm/bootmem.c    |    1 +
 memhotplug1-dave/mm/page_alloc.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff -puN mm/bootmem.c~Z0-bootmem_page_counts mm/bootmem.c
--- memhotplug1/mm/bootmem.c~Z0-bootmem_page_counts	2004-11-04 18:16:20.000000000 -0800
+++ memhotplug1-dave/mm/bootmem.c	2004-11-04 18:16:42.000000000 -0800
@@ -289,6 +289,7 @@ static unsigned long __init free_all_boo
 				if (j + 16 < BITS_PER_LONG)
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
+				set_page_count(page + j, 0);
 			}
 			__free_pages(page, ffs(BITS_PER_LONG)-1);
 			i += BITS_PER_LONG;
diff -puN mm/page_alloc.c~Z0-bootmem_page_counts mm/page_alloc.c
--- memhotplug1/mm/page_alloc.c~Z0-bootmem_page_counts	2004-11-04 18:16:20.000000000 -0800
+++ memhotplug1-dave/mm/page_alloc.c	2004-11-04 18:16:47.000000000 -0800
@@ -1824,7 +1824,7 @@ void __devinit memmap_init_zone(unsigned
 
 	for (page = start; page < (start + size); page++) {
 		set_page_zone(page, NODEZONE(nid, zone));
-		set_page_count(page, 0);
+		set_page_count(page, 1);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
 		INIT_LIST_HEAD(&page->lru);
_

--=-AjjCEpVRAe0rnMQOxPHT--


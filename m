Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270553AbTGaWD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbTGaWDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:03:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:35509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274883AbTGaWDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:03:22 -0400
Date: Thu, 31 Jul 2003 14:51:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mremap sleeping in incorrect context
Message-Id: <20030731145132.64ab1574.akpm@osdl.org>
In-Reply-To: <1059658728.2417.112.camel@gaston>
References: <1059586337.2420.44.camel@gaston>
	<20030730153439.7df44a69.akpm@osdl.org>
	<1059658728.2417.112.camel@gaston>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> 
> > oops.  What are your CONFIG_HIGHMEM and CONFIG_HIGHPTE settings there?
> 
> this is on ppc32, HIGHPTE doesn't exist, HIGHMEM is enabled (1Gb of
> RAM)
> 

OK, thanks.  Seems that I made a little bug.  This should fix it.  With a
changelog like this, it _has_ to be right ;)






move_one_page() is awkward.  It grabs an atomic_kmap of the source pte
(because it needs to know if there's really a page there) and then it needs
to allocate a pte for the dest.  But it cannot allocate the dest pte while
holding the src's atomic kmap.

So it performs this little dance peeking at pagetables to predict if
alloc_one_pte_map() might need to perform a pte page allocation.

When I wrote this code I made it conditional on CONFIG_HIGHPTE.  But that was
bogus: even in the !CONFIG_HIGHPTE case, get_one_pte_map_nested() will run
atomic_kmap() against the pte page, which disables preemption.

Net effect: with CONFIG_HIGHMEM && !CONFIG_HIGHPTE we can end up performing a
GFP_KERNEL pte page allocation while preemption is disabled.  It triggers a
might_sleep() warning and indeed is buggy.

So the patch removes the conditionality: even in the !CONFIG_HIGHPTE case we
still do the pagetable peek and drop the kmap if necessary.

(Arguably, we shouldn't be performing the atomic_kmap() at all if
!CONFIG_HIGHPTE: all it does is a pointless preemption disable).

(Arguably, kmap_atomic() should not be disabling preemption if the target
page is not highmem.  But we're doing it anyway at present for consistency
(ie: debug coverage) and because the filemap.c pagecache copying functions
rely on kmap_atomic() disabling do_no_page() for all pages: see
do_no_page()'s use of in_atomic()).



 25-akpm/mm/mremap.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN mm/mremap.c~mremap-atomicity-fix mm/mremap.c
--- 25/mm/mremap.c~mremap-atomicity-fix	Thu Jul 31 14:37:05 2003
+++ 25-akpm/mm/mremap.c	Thu Jul 31 14:37:15 2003
@@ -56,7 +56,6 @@ end:
 	return pte;
 }
 
-#ifdef CONFIG_HIGHPTE	/* Save a few cycles on the sane machines */
 static inline int page_table_present(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -68,9 +67,6 @@ static inline int page_table_present(str
 	pmd = pmd_offset(pgd, addr);
 	return pmd_present(*pmd);
 }
-#else
-#define page_table_present(mm, addr)	(1)
-#endif
 
 static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long addr)
 {

_


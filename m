Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129418AbQJaP7h>; Tue, 31 Oct 2000 10:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbQJaP7R>; Tue, 31 Oct 2000 10:59:17 -0500
Received: from kanga.kvack.org ([209.82.47.3]:57104 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129418AbQJaP7K>;
	Tue, 31 Oct 2000 10:59:10 -0500
Date: Tue, 31 Oct 2000 10:57:51 -0500 (EST)
From: <kernel@kvack.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Brian Gerst <bgerst@didntduck.org>, Andi Kleen <ak@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
In-Reply-To: <E13qcv6-0007yy-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1001031101815.27969D-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Alan Cox wrote:

> > The code for vmalloc allocates the pages at vmalloc time, not after.  The
> > TLB is populated lazily, but most definately not the page tables.
> 
> Is the lazy tlb population interrupt safe or do I need to change any driver
> using vmalloced memory from an IRQ ?

It should be safe since it's just copying pgd/pmd pointers into the
per-process page tables; the pte's are still shared.

That said, reading vmalloc.c leads to the discovery that
vmalloc_area_pages will currently race on SMP (the pmd/pte allocation
routines are not SMP safe).  Untested/obvious patch below.  Ultimately
we'll have to move the locking into pmd_alloc/pte_alloc, but I'm not sure 
if that's appropriate so close to 2.4.

		-ben


--- v2.4.0-test10-pre7/mm/vmalloc.c	Mon Oct 30 16:02:27 2000
+++ test-10-7/mm/vmalloc.c	Tue Oct 31 10:58:47 2000
@@ -121,7 +121,11 @@
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		pte_t * pte = pte_alloc_kernel(pmd, address);
+		pte_t * pte;
+
+		lock_kernel();
+		pte = pte_alloc_kernel(pmd, address);
+		unlock_kernel();
 		if (!pte)
 			return -ENOMEM;
 		if (alloc_area_pte(pte, address, end - address, gfp_mask, prot))
@@ -142,8 +146,10 @@
 	flush_cache_all();
 	do {
 		pmd_t *pmd;
-		
+
+		lock_kernel();
 		pmd = pmd_alloc_kernel(dir, address);
+		unlock_kernel();
 		if (!pmd)
 			return -ENOMEM;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

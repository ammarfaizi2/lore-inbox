Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUKEIIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUKEIIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 03:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKEIII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 03:08:08 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:39592 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261356AbUKEIHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 03:07:38 -0500
Date: Fri, 5 Nov 2004 09:07:16 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041105080716.GL8229@dualathlon.random>
References: <20041028192104.GA3454@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028192104.GA3454@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 09:21:04PM +0200, Andrea Arcangeli wrote:
> This first patch fixes silent memleak in the pageattr code that I found
> while searching for the bug Andi fixed in the second patch below
> (basically reference counting in split page was done on the pmd instead
> of the pte).
> 
> Signed-off-by: Andrea Arcangeli <andrea@novell.com>
> 
> Index: linux-2.5/arch/i386/mm/pageattr.c
> ===================================================================
> RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/mm/pageattr.c,v
> retrieving revision 1.13
> diff -u -p -r1.13 pageattr.c
> --- linux-2.5/arch/i386/mm/pageattr.c	27 Aug 2004 17:35:39 -0000	1.13
> +++ linux-2.5/arch/i386/mm/pageattr.c	28 Oct 2004 19:11:20 -0000
> @@ -117,22 +117,23 @@ __change_page_attr(struct page *page, pg
>  	kpte_page = virt_to_page(kpte);
>  	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) { 
>  		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
> -			pte_t old = *kpte;
> -			pte_t standard = mk_pte(page, PAGE_KERNEL); 
>  			set_pte_atomic(kpte, mk_pte(page, prot)); 
> -			if (pte_same(old,standard))
> -				get_page(kpte_page);
>  		} else {
>  			struct page *split = split_large_page(address, prot); 
>  			if (!split)
>  				return -ENOMEM;
> -			get_page(kpte_page);
>  			set_pmd_pte(kpte,address,mk_pte(split, PAGE_KERNEL));
> +			kpte_page = split;
>  		}	
> +		get_page(kpte_page);
>  	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
>  		set_pte_atomic(kpte, mk_pte(page, PAGE_KERNEL));
>  		__put_page(kpte_page);
> -	}
> +	} else
> +		BUG();
> +
> +	/* memleak and potential failed 2M page regeneration */
> +	BUG_ON(!page_count(kpte_page));
>  
>  	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
>  		list_add(&kpte_page->lru, &df_list);
> Index: linux-2.5/arch/x86_64/mm/pageattr.c
> ===================================================================
> RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/x86_64/mm/pageattr.c,v
> retrieving revision 1.12
> diff -u -p -r1.12 pageattr.c
> --- linux-2.5/arch/x86_64/mm/pageattr.c	27 Jun 2004 17:54:00 -0000	1.12
> +++ linux-2.5/arch/x86_64/mm/pageattr.c	28 Oct 2004 19:11:20 -0000
> @@ -124,28 +124,33 @@ __change_page_attr(unsigned long address
>  	kpte_flags = pte_val(*kpte); 
>  	if (pgprot_val(prot) != pgprot_val(ref_prot)) { 
>  		if ((kpte_flags & _PAGE_PSE) == 0) { 
> -			pte_t old = *kpte;
> -			pte_t standard = mk_pte(page, ref_prot); 
> -
>  			set_pte(kpte, mk_pte(page, prot)); 
> -			if (pte_same(old,standard))
> -				get_page(kpte_page);
>  		} else {
> +			/*
> +			 * split_large_page will take the reference for this change_page_attr
> +			 * on the split page.
> +			 */
>  			struct page *split = split_large_page(address, prot, ref_prot); 
>  			if (!split)
>  				return -ENOMEM;
> -			get_page(kpte_page);
>  			set_pte(kpte,mk_pte(split, ref_prot));
> +			kpte_page = split;
>  		}	
> +		get_page(kpte_page);
>  	} else if ((kpte_flags & _PAGE_PSE) == 0) { 
>  		set_pte(kpte, mk_pte(page, ref_prot));
>  		__put_page(kpte_page);
> -	}
> +	} else
> +		BUG();
>  
> -	if (page_count(kpte_page) == 1) {
> +	switch (page_count(kpte_page)) {
> +	case 1:
>  		save_page(address, kpte_page); 		     
>  		revert_page(address, ref_prot);
> -	} 
> +		break;
> +	case 0:
> +		BUG(); /* memleak and failed 2M page regeneration */
> +	}
>  	return 0;
>  } 
>  

this new patch obsoletes the above one and fixes one issue with the
direct mapping near physical address 0 that is apparently still backed
by 4k ptes (i.e. reserved ptes with page_count == 0). That generated a
bugcheck false positive. But the bugcheck must be retained, since it
signaled a true memleak during normal usage (DEBUG_PAGELLOC is the only
special usage that end up calling change_page_attr near phys addr 0,
maybe agp could do it too in theory, but it's generally very unlikely to
trigger without the debugging knob enabled, especially given we start
allocating ram from high zones first). anyways this new patch fixes
PAGEALLOC_DEBUG. thanks to Dave Hansen for spotting the problem with
bootmem memory and for providing all the useful debugging info.

I added a further bugcheck on x86-64, so that if the bugcheck page_count
== 0 triggers, we'll also know if it was a reserved page or not (i.e.
the reserved bugcheck will trigger first). I wrote the paging part of
head.S of x86-64 and I recall I avoided any usage of 4k pages for the
initial direct mapping before firing up the paging engine. So I'm
confident x86-64 didn't require any modification and that it would never
run into bootmem allocated 4k pages like x86 can run into. the
additional bugcheck is just in case (mostly for documentation purposes
between the differences of the x86 and x86-64 implementation of
pageattr).

I was overoptimistic that these fixes (both this and Andi's ioremap
symmetry fix combined) would be enough to fix the real life crash.
Something is still not right, but I doubt there's any more bug in
pageattr right now.  More likely ioremap stuff is still buggy (infact an
experimental patch from Andi that doesn't touch pageattr.c at all is
reported to fix the problem in practice, problem is I don't see why that
patch is fixing anything, I suspect some off by one bit). Anyways I'm
quite optimistic the below won't require another modification to the
file (I mean unless we want to create a true universal API that doesn't
require perfect symmetry to the usage).

DEBUG_PAGEALLOC oopses the X server on 2.6.5 based kernel, but not on a
2.6.9rc based kernel, so it could be a true 2.6.5 bug that I've seen
with debug pagealloc (and not a false positive), but that's unrelated to
this topic.

This works for me on x86 (with debug pagealloc enabled too) and x86-64.

Signed-off-by: Andrea Arcangeli <andrea@novell.com>

Index: linux-2.5/arch/i386/mm/pageattr.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/mm/pageattr.c,v
retrieving revision 1.13
diff -u -p -r1.13 pageattr.c
--- linux-2.5/arch/i386/mm/pageattr.c	27 Aug 2004 17:35:39 -0000	1.13
+++ linux-2.5/arch/i386/mm/pageattr.c	5 Nov 2004 07:54:25 -0000
@@ -117,27 +117,35 @@ __change_page_attr(struct page *page, pg
 	kpte_page = virt_to_page(kpte);
 	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) { 
 		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
-			pte_t old = *kpte;
-			pte_t standard = mk_pte(page, PAGE_KERNEL); 
 			set_pte_atomic(kpte, mk_pte(page, prot)); 
-			if (pte_same(old,standard))
-				get_page(kpte_page);
 		} else {
 			struct page *split = split_large_page(address, prot); 
 			if (!split)
 				return -ENOMEM;
-			get_page(kpte_page);
 			set_pmd_pte(kpte,address,mk_pte(split, PAGE_KERNEL));
+			kpte_page = split;
 		}	
+		get_page(kpte_page);
 	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
 		set_pte_atomic(kpte, mk_pte(page, PAGE_KERNEL));
 		__put_page(kpte_page);
-	}
+	} else
+		BUG();
 
-	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
-		list_add(&kpte_page->lru, &df_list);
-		revert_page(kpte_page, address);
-	} 
+	/*
+	 * If the pte was reserved, it means it was created at boot
+	 * time (not via split_large_page) and in turn we must not
+	 * replace it with a largepage.
+	 */
+	if (!PageReserved(kpte_page)) {
+		/* memleak and potential failed 2M page regeneration */
+		BUG_ON(!page_count(kpte_page));
+
+		if (cpu_has_pse && (page_count(kpte_page) == 1)) {
+			list_add(&kpte_page->lru, &df_list);
+			revert_page(kpte_page, address);
+		}
+	}
 	return 0;
 } 
 
Index: linux-2.5/arch/x86_64/mm/pageattr.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/x86_64/mm/pageattr.c,v
retrieving revision 1.12
diff -u -p -r1.12 pageattr.c
--- linux-2.5/arch/x86_64/mm/pageattr.c	27 Jun 2004 17:54:00 -0000	1.12
+++ linux-2.5/arch/x86_64/mm/pageattr.c	5 Nov 2004 07:54:25 -0000
@@ -124,28 +124,36 @@ __change_page_attr(unsigned long address
 	kpte_flags = pte_val(*kpte); 
 	if (pgprot_val(prot) != pgprot_val(ref_prot)) { 
 		if ((kpte_flags & _PAGE_PSE) == 0) { 
-			pte_t old = *kpte;
-			pte_t standard = mk_pte(page, ref_prot); 
-
 			set_pte(kpte, mk_pte(page, prot)); 
-			if (pte_same(old,standard))
-				get_page(kpte_page);
 		} else {
+			/*
+			 * split_large_page will take the reference for this change_page_attr
+			 * on the split page.
+			 */
 			struct page *split = split_large_page(address, prot, ref_prot); 
 			if (!split)
 				return -ENOMEM;
-			get_page(kpte_page);
 			set_pte(kpte,mk_pte(split, ref_prot));
+			kpte_page = split;
 		}	
+		get_page(kpte_page);
 	} else if ((kpte_flags & _PAGE_PSE) == 0) { 
 		set_pte(kpte, mk_pte(page, ref_prot));
 		__put_page(kpte_page);
-	}
+	} else
+		BUG();
+
+	/* on x86-64 the direct mapping set at boot is not using 4k pages */
+	BUG_ON(PageReserved(kpte_page));
 
-	if (page_count(kpte_page) == 1) {
+	switch (page_count(kpte_page)) {
+	case 1:
 		save_page(address, kpte_page); 		     
 		revert_page(address, ref_prot);
-	} 
+		break;
+	case 0:
+		BUG(); /* memleak and failed 2M page regeneration */
+	}
 	return 0;
 } 
 

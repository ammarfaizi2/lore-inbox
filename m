Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVCVXbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVCVXbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVCVXbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:31:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:63889 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262392AbVCVXbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:31:18 -0500
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       davem@davemloft.net, tony.luck@intel.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	 <20050322034053.311b10e6.akpm@osdl.org>
	 <Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 10:30:50 +1100
Message-Id: <1111534250.16224.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 16:37 +0000, Hugh Dickins wrote:
> On Tue, 22 Mar 2005, Andrew Morton wrote:
> > 
> > With these six patches the ppc64 is hitting the BUG in exit_mmap():
> > 
> >         BUG_ON(mm->nr_ptes);    /* This is just debugging */
> > 
> > fairly early in boot.
> 
> So ppc64 is in the same boat as sparc64 (yet ia64 okay so far).
> 
> Sorry, I'm still clueless.
> 
> I cannot see those arches doing pte_allocs outside their vmas,
> that of course could cause it.  And nr_ptes is initialized to 0
> once by memset and again by assignment, so it should be starting
> out even zeroer than most fields.

We do funny things in arch/ppc64/mm/init.c in the ioremap_mm, where we
don't use VMAs but our own mecanism (yah, ugly, but that's some legacy
we have from the original port, though I do intend to change that at one
point).

> I should probably be paying more attention to the repellent
> notion that my code is broken.
> 
> If you and David could try the lame patch below,
> it'll at least give us a slight clue of where to be looking -
> every mm exiting with nr_ptes 1 means something different from
> every mm exiting with nr_ptes -1 means something different from
> occasional mms exiting with nr_ptes something positive.
> 
> I'm not sure whether the patch would ever get to show a more
> interesting proc name than "?".
> 
> And does memory leak away into lost pagetables if you continue
> running, or does it actually carry on running fine, and the
> problem appear to be with the BUG_ON itself?
> 
> Thanks,
> Hugh
> 
> --- freepgt6/mm/mmap.c	2005-03-22 04:28:40.000000000 +0000
> +++ testing/mm/mmap.c	2005-03-22 15:45:00.000000000 +0000
> @@ -1896,6 +1896,7 @@ EXPORT_SYMBOL(do_brk);
>  /* Release all mmaps. */
>  void exit_mmap(struct mm_struct *mm)
>  {
> +	static unsigned long good_mms, bad_mms;
>  	struct mmu_gather *tlb;
>  	struct vm_area_struct *vma = mm->mmap;
>  	unsigned long nr_accounted = 0;
> @@ -1931,7 +1932,14 @@ void exit_mmap(struct mm_struct *mm)
>  		vma = next;
>  	}
>  
> -	BUG_ON(mm->nr_ptes);	/* This is just debugging */
> +	if (mm->nr_ptes && bad_mms < 250) {
> +		printk(KERN_ERR "exit_mmap: %s nr_ptes %ld good_mms %lu\n",
> +			current->mm == mm? current->comm: "?",
> +			(long)mm->nr_ptes, good_mms);
> +		good_mms = 0;
> +		bad_mms++;
> +	} else
> +		good_mms++;
>  }
>  
>  /* Insert vm structure into process list sorted by address
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>


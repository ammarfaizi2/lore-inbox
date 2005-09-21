Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVIUTur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVIUTur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVIUTur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:50:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932143AbVIUTuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:50:44 -0400
Date: Wed, 21 Sep 2005 12:49:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: torvalds@osdl.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] uml: avoid fixing faults while atomic
Message-Id: <20050921124957.437cf069.akpm@osdl.org>
In-Reply-To: <20050921172908.10219.57644.stgit@zion.home.lan>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921172908.10219.57644.stgit@zion.home.lan>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Following i386, we should maybe refuse trying to fault in pages when we're
> doing atomic operations, because to handle the fault we could need to take
> already taken spinlocks.
> 
> Also, if we're doing an atomic operation (in the sense of in_atomic()) we're
> surely in kernel mode and we're surely going to handle adequately the failed
> fault, so it's safe to behave this way.
> 
> Currently, on UML SMP is rarely used, and we don't support PREEMPT, so this is
> unlikely to create problems right now, but it might in the future.
> 

That's not really an accurate explanation/understanding of what's going on
in there.

There's an extremely special-case in the pagefault handlers where we fail
the fault if in_atomic().  It's unrelated to spinlocks (spinlocks don't
even cause in_atomic() to become true if !CONFIG_PREEMPT).

It has to do with kmap_atomic().  There's tricksy code in mm/filemap.c
which will fault the target page in by hand and will then take an atomic
kmap and will then raise current->preempt_count by hand, so in_atomic()
becomes true even if !COFNIG_PREEMPT.

So at this stage we expect to be able to do a copy_to/from_user to/from
pagecache without taking a fault, because we just faulted the page in by
hand.  And we're not allowed to take a fault, because we're holding an
atomic kmap.  But if we _do_ take a fault (extreme memory pressure, racing
munmap, etc) then we want to fail the pagefault immediately.

The in_atomic() test in x86's do_page_fault() is in fact a message passed
into it from filemap.c's kmap_atomic().  It has accidental side-effects,
such as making copy_to_user() fail if inside spinlocks when
CONFIG_PREEMPT=y.


So I think this change is only needed if UML implements kmap_atomic, as in
arch/i386/mm/highmem.c, which it surely does not do?


> 
> diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
> --- a/arch/um/kernel/trap_kern.c
> +++ b/arch/um/kernel/trap_kern.c
> @@ -40,6 +40,12 @@ int handle_page_fault(unsigned long addr
>  	int err = -EFAULT;
>  
>  	*code_out = SEGV_MAPERR;
> +
> +	/* If the fault was during atomic operation, don't take the fault, just
> +	 * fail. */
> +	if (in_atomic())
> +		goto out_nosemaphore;
> +
>  	down_read(&mm->mmap_sem);
>  	vma = find_vma(mm, address);
>  	if(!vma) 
> @@ -90,6 +96,7 @@ survive:
>  	flush_tlb_page(vma, address);
>  out:
>  	up_read(&mm->mmap_sem);
> +out_nosemaphore:
>  	return(err);
>  
>  /*

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWDZOqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWDZOqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWDZOqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:46:35 -0400
Received: from silver.veritas.com ([143.127.12.111]:46884 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964786AbWDZOqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:46:35 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="37629805:sNHT24401856"
Date: Wed, 26 Apr 2006 15:46:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Jan Beulich <jbeulich@novell.com>
cc: linux-kernel@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
In-Reply-To: <444F95D8.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com>
References: <444F95D8.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Apr 2006 14:46:34.0572 (UTC) FILETIME=[36DA08C0:01C66940]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006, Jan Beulich wrote:

> During Xen development we noticed that writes to 64-bit variables may get
> coded as high-word-before-low-word writes by gcc. Consequently, when
> invalidating a PAE page table entry, the low word must be explicitly written
> first, as otherwise, as pointed out by Keir, speculative execution may result
> in a partially modified (and still valid) translation to be used, which has,
> according to the specification, the potential of dead-locking the machine.

If that's so (I don't trust my judgement on matters of speculative
execution), then I think you'd do better to replace the *ptep = __pte(0)
by pte_clear(mm, addr, ptep), and so avoid your ugly #ifdef'ing: please
check, but I think you'll find that reduces to just the barrier you want.
CC'ed Zach since it's his optimization, and he'll judge that spexecution.

Hugh

> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
> 
> diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/include/asm-i386/pgtable.h
> 2.6.17-rc2-i386-pae-ptep_get_and_clear_full/include/asm-i386/pgtable.h
> --- /home/jbeulich/tmp/linux-2.6.17-rc2/include/asm-i386/pgtable.h	2006-04-26 10:56:03.000000000 +0200
> +++ 2.6.17-rc2-i386-pae-ptep_get_and_clear_full/include/asm-i386/pgtable.h	2006-04-24 12:28:37.000000000 +0200
> @@ -268,7 +268,15 @@ static inline pte_t ptep_get_and_clear_f
>  	pte_t pte;
>  	if (full) {
>  		pte = *ptep;
> +#ifdef CONFIG_X86_PAE
> +		/* Cannot do this in a single step, as the compiler
> +		   may issue the two stores in either order. */
> +		ptep->pte_low = 0;
> +		barrier();
> +		ptep->pte_high = 0;
> +#else
>  		*ptep = __pte(0);
> +#endif
>  	} else {
>  		pte = ptep_get_and_clear(mm, addr, ptep);
>  	}
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274332AbRITG0M>; Thu, 20 Sep 2001 02:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274333AbRITG0C>; Thu, 20 Sep 2001 02:26:02 -0400
Received: from [195.223.140.107] ([195.223.140.107]:3326 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274332AbRITGZq>;
	Thu, 20 Sep 2001 02:25:46 -0400
Date: Thu, 20 Sep 2001 08:26:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010920082602.A701@athlon.random>
In-Reply-To: <20010920071240.P720@athlon.random> <Pine.LNX.4.33.0109192255360.2852-100000@penguin.transmeta.com> <20010920080837.A719@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920080837.A719@athlon.random>; from andrea@suse.de on Thu, Sep 20, 2001 at 08:08:37AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 08:08:37AM +0200, Andrea Arcangeli wrote:
> --- 2.4.10pre12aa1/mm/memory.c.~1~	Thu Sep 20 07:20:03 2001
> +++ 2.4.10pre12aa1/mm/memory.c	Thu Sep 20 08:06:29 2001
> @@ -1155,15 +1155,8 @@
>  	pte = mk_pte(page, vma->vm_page_prot);
>  
>  	swap_free(entry);
> -	if (exclusive_swap_page(page)) {	
> -#if 0
> -		if (write_access)
> -			pte = pte_mkwrite(pte_mkdirty(pte));
> -#else
> +	if (exclusive_swap_page(page))
>  		delete_from_swap_cache_nolock(page);
> -		pte = pte_mkwrite(pte_mkdirty(pte));
> -#endif
> -	}

forget that, of course if write_access is set it means we can write to
the page or the page fault would be finished much earlier. This looks
much better:

--- 2.4.10pre12aa1/mm/memory.c.~1~	Thu Sep 20 07:20:03 2001
+++ 2.4.10pre12aa1/mm/memory.c	Thu Sep 20 08:24:03 2001
@@ -1156,13 +1156,11 @@
 
 	swap_free(entry);
 	if (exclusive_swap_page(page)) {	
-#if 0
 		if (write_access)
 			pte = pte_mkwrite(pte_mkdirty(pte));
-#else
+		else if (vma->vm_flags & VM_WRITE)
+			pte = pte_mkwrite(pte);
 		delete_from_swap_cache_nolock(page);
-		pte = pte_mkwrite(pte_mkdirty(pte));
-#endif
 	}
 	UnlockPage(page);
 

(we'll avoid the page fault this way in the "read" swapin too, by
checking if we're allowed to write to it or not, looks worthwhile check,
however it matters only for the archs where the dirty bit is set in
hardware)

Andrea

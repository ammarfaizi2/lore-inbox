Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274320AbRITGIl>; Thu, 20 Sep 2001 02:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274322AbRITGIb>; Thu, 20 Sep 2001 02:08:31 -0400
Received: from [195.223.140.107] ([195.223.140.107]:63997 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274320AbRITGIX>;
	Thu, 20 Sep 2001 02:08:23 -0400
Date: Thu, 20 Sep 2001 08:08:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010920080837.A719@athlon.random>
In-Reply-To: <20010920071240.P720@athlon.random> <Pine.LNX.4.33.0109192255360.2852-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109192255360.2852-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Sep 19, 2001 at 10:58:43PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 10:58:43PM -0700, Linus Torvalds wrote:
> 
> On Thu, 20 Sep 2001, Andrea Arcangeli wrote:
> >
> > when the page is exclusive we definitely can write to it
> 
> NO!
> 
> If it is a read-only mapping, we must NOT mark it writable.
> 
> The fact is, the page may have been written to earlier, marked read-only
> with mprotect(), and the page is dirty but read-only, and swapping it in

ah, I didn't thought at mprotect.

> MUST NOT markt it writable even if it is our last exclusive copy.
> 
> Which we've gotten wrong for a long time, actually. But you #if 0'ed the
> fix that happened fairly recently.

hmm, the stuff inside #if 0 doesn't seem to be correct either there,
write_access doesn't mean we have the right to write to it, it just mean
we're trying to.

anyways here it is the fix:

--- 2.4.10pre12aa1/mm/memory.c.~1~	Thu Sep 20 07:20:03 2001
+++ 2.4.10pre12aa1/mm/memory.c	Thu Sep 20 08:06:29 2001
@@ -1155,15 +1155,8 @@
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	swap_free(entry);
-	if (exclusive_swap_page(page)) {	
-#if 0
-		if (write_access)
-			pte = pte_mkwrite(pte_mkdirty(pte));
-#else
+	if (exclusive_swap_page(page))
 		delete_from_swap_cache_nolock(page);
-		pte = pte_mkwrite(pte_mkdirty(pte));
-#endif
-	}
 	UnlockPage(page);
 
 	flush_page_to_ram(page);

thanks,
Andrea

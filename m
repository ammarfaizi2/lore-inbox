Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272856AbRI0NkC>; Thu, 27 Sep 2001 09:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272859AbRI0Njx>; Thu, 27 Sep 2001 09:39:53 -0400
Received: from [204.177.156.37] ([204.177.156.37]:4275 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S272856AbRI0Njl>; Thu, 27 Sep 2001 09:39:41 -0400
Date: Thu, 27 Sep 2001 14:41:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Olivier Sessink <olivier@lx.student.wau.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: weird memory related problems, negative memory usage
 or fake memory usage?
In-Reply-To: <20010925200728.A30860@redhat.com>
Message-ID: <Pine.LNX.4.21.0109271427220.993-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Benjamin LaHaise wrote:
> 
> This should fix it.
> 
> -			freed ++;
> +			struct page *page = pte_page(pte);
> +			if (!PageReserved(page) && VALID_PAGE(page))
> +				freed ++;

NO!  I expect that fixes the rss, but crashes my system: 
must test VALID_PAGE(page) _before_ !PageReserved(page).

Hugh

--- linux-2.4.10/mm/memory.c	Sun Sep 23 04:36:50 2001
+++ linux/mm/memory.c	Thu Sep 27 14:29:28 2001
@@ -319,7 +319,9 @@
 		if (pte_none(pte))
 			continue;
 		if (pte_present(pte)) {
-			freed ++;
+			struct page *page = pte_page(pte);
+			if (VALID_PAGE(page) && !PageReserved(page))
+				freed ++;
 			/* This will eventually call __free_pte on the pte. */
 			tlb_remove_page(tlb, ptep, address + offset);
 		} else {


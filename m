Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132299AbQL1Man>; Thu, 28 Dec 2000 07:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132287AbQL1Mad>; Thu, 28 Dec 2000 07:30:33 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:40660 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132175AbQL1MaW>; Thu, 28 Dec 2000 07:30:22 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmem_unuse race fix
In-Reply-To: <Pine.LNX.4.21.0012272025190.528-100000@dual.transmeta.com>
From: Christoph Rohland <cr@sap.com>
Message-ID: <m31yuswyig.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 28 Dec 2000 13:02:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 27 Dec 2000, Christoph Rohland wrote:
> Woul dyou mind testing this alternate fix instead:

Does not work, but is the right direction I think.

First we need the following patch since otherwise we use a swap entry
without having the count increased:

--- 4-13-4/mm/vmscan.c  Fri Dec 22 10:05:38 2000
+++ m4-13-4/mm/vmscan.c Thu Dec 28 11:57:57 2000
@@ -93,8 +93,8 @@
                entry.val = page->index;
                if (pte_dirty(pte))
                        SetPageDirty(page);
-set_swap_pte:
                swap_duplicate(entry);
+set_swap_pte:
                set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
                UnlockPage(page);
@@ -185,7 +185,7 @@
         * we have the swap cache set up to associate the
         * page with that swap entry.
         */
-       entry = get_swap_page();
+       entry = __get_swap_page(2);
        if (!entry.val)
                goto out_unlock_restore; /* No swap space left */


Second there look at this in handle_pte_fault:

		/*
		 * If it truly wasn't present, we know that kswapd
		 * and the PTE updates will not touch it later. So
		 * drop the lock.
		 */
		spin_unlock(&mm->page_table_lock);
		if (pte_none(entry))
			return do_no_page(mm, vma, address, write_access, pte);
		return do_swap_page(mm, vma, address, pte, pte_to_swp_entry(entry), write_access);

The comment is wrong. try_to_unuse will touch it. This stumbles over a
bad swap entry after try_to_unuse complaining about an undead swap
entry.

If I retry in try_to_unuse it goes into an infinite loop since it
deadlocks with this.

Ideas?
        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

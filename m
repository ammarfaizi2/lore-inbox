Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbQL0TEk>; Wed, 27 Dec 2000 14:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129812AbQL0TEb>; Wed, 27 Dec 2000 14:04:31 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:56047 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129757AbQL0TEU> convert rfc822-to-8bit; Wed, 27 Dec 2000 14:04:20 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmem_unuse race fix
In-Reply-To: <Pine.LNX.4.21.0012271309510.11471-100000@freak.distro.conectiva>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.21.0012271309510.11471-100000@freak.distro.conectiva>
Message-ID: <m3ae9haf4x.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: 27 Dec 2000 19:36:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> I think that incrementing the swap entry count will not allow swap from
> removing the swap entry (as the comment says)

I think the culprit is somewhere else. The error occurs in nopage of a
process, not in swapoff.

Looking  at the following in try_to_unuse:

	found_entry:
		entry = SWP_ENTRY(type, i);

		/* Get a page for the entry, using the existing swap
                   cache page if there is one.  Otherwise, get a clean
                   page and read the swap into it. */
		page = read_swap_cache(entry);
		if (!page) {
			swap_free(entry);
  			return -ENOMEM;
		}
		if (PageSwapCache(page))
			delete_from_swap_cache(page);
		read_lock(&tasklist_lock);
		for_each_task(p)
			unuse_process(p->mm, entry, page);
		read_unlock(&tasklist_lock);
		shmem_unuse(entry, page);

and in unuse_pte:
	if (pte_present(pte)) {
		/* If this entry is swap-cached, then page must already
                   hold the right address for any copies in physical
                   memory */
		if (pte_page(pte) != page)
			return;
		/* We will be removing the swap cache in a moment, so... */
		ptep_mkdirty(dir);
		return;
	}


I see at least a wrong comment. There is no swap cache any more... And
another thought is: why can we remove the swap cache entry before
finding the process? What prevent reallocation of the swap cache entry
by a page fault?

BTW you can reproduce the problem on a UP system quite easily by
trashing and always disablingænabling two swap partitions round robin.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

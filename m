Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVHBMYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVHBMYe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVHBMYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:24:34 -0400
Received: from gold.veritas.com ([143.127.12.110]:17418 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261484AbVHBMY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:24:26 -0400
Date: Tue, 2 Aug 2005 13:26:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
Message-ID: <Pine.LNX.4.61.0508021309470.3005@goblin.wat.veritas.com>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Aug 2005 12:24:22.0347 (UTC) FILETIME=[1CF491B0:01C5975D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005, Martin Schwidefsky wrote:
> 
> Why do we require the !pte_dirty(pte) check? I don't get it. If a writeable
> clean pte is just fine then why do we check the dirty bit at all? Doesn't
> pte_dirty() imply pte_write()?

Not quite.  This is all about the peculiar ptrace case, which sets "force"
to get_user_pages, and ends up handled by the little maybe_mkwrite function:
we sometimes allow ptrace to modify the page while the user does not have
have write access to it via the pte.

Robin discovered a race which proves it's unsafe for get_user_pages to
reset its lookup_write flag (another stage in this peculiar path) after
a single try, Nick proposed a patch which adds another VM_ return code
which each arch would need to handle, Linus looked for something simpler
and hit upon checking pte_dirty rather than pte_write (and removing
the then unnecessary lookup_write flag).

Linus' changes are in the 2.6.13-rc5 mm/memory.c,
but that leaves s390 broken at present.

> With the additional !pte_write(pte) check (and if I haven't overlooked
> something which is not unlikely) s390 should work fine even without the
> software-dirty bit hack.

I agree the pte_write check ought to go back in next to the pte_dirty
check, and that will leave s390 handling most uses of get_user_pages
correctly, but still failing to handle the peculiar case of strace
modifying a page to which the user does not currently have write access
(e.g. setting a breakpoint in readonly text).

Hugh

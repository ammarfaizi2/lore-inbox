Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbTJHRPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTJHRPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 13:15:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39229 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S261762AbTJHRPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 13:15:13 -0400
Date: Wed, 8 Oct 2003 18:15:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rik van Riel <riel@redhat.com>
cc: Matt_Domsch@Dell.com, <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <Pine.LNX.4.44.0310081156320.5568-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0310081752140.3312-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, Rik van Riel wrote:
> 
> 1) cpu A adds page P to the swap cache, loading page->flags
>    and modifying it locally

Right, the add_to_swap_cache in try_to_swap_out.

> 2) a second thread scans a page table entry and sees that
>    the page was accessed, so cpu B moves page P to the
>    active list

Right, the mark_page_accessed in try_to_swap_out
(I don't see any other mark_page_accessed as problematic).
Or the del_page_from_active_list in refill_inactive.

> 3) cpu A undoes the PG_inactive -> PG_active bit change,
>    corrupting the page->flags of P

(Mainline is easier than -rmap since no separate PG_inactive bit.)

Thanks a lot for explaining, I see it now.  Personally I'd prefer a
lighter weight patch, either pagemap_lru_lock within add_to_swap_cache,
or better moving the PG_flags clearing from __add_to_page_cache into
__free_pages_ok, where I still believe it can be done non-atomically.

But you've proved your point, and I understand you preferring a more
straightforward and future-proof way.  I'm not writing an alternative
patch, don't let me stand in the way of progress...

A little of the above explanation in the change comment would be nice.

Thanks,
Hugh


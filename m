Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTIBDVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 23:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTIBDVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 23:21:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3685 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263429AbTIBDVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 23:21:44 -0400
Date: Tue, 2 Sep 2003 04:23:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
In-Reply-To: <Pine.LNX.4.44.0309012053110.1817-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309020355160.1923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Hugh Dickins wrote:
> 
> 5. If you're not doing anything in __remove_from_page_cache (rightly
> trying to avoid hotpath), you do need to futex_rehash in mm/swap_state.c
> __delete_from_swap_cache (last time I did say without the __s, but that
> would miss an instance you need to catch).  That will handle the swapoff
> case amongst others.

Of course, the reason I originally said without the __s, was because
move_from_swap_cache uses __delete_from_swap_cache, and we don't want
interference there.  So best convert that to use __remove_from_page_cache
instead, with INC_CACHE_INFO(del_total) outside the locking, after the
set_page_dirty: would improve symmetry between move_from_ and move_to_.

The instance of __delete_from_swap_cache I say you need to catch, is
that in remove_exclusive_swap_page; though I think its count restrictions
limit it to cornercases like your test program, rather than real
communication between processes.  But hold on, in such a cornercase
(no other references to the swap), what if the process unmaps the vma
containing the futex while it is swapped out and not even in page cache?
Unclear.

Hugh


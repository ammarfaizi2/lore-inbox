Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTH0If4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 04:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbTH0If4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 04:35:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:1068 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263088AbTH0Ifz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 04:35:55 -0400
Date: Wed, 27 Aug 2003 09:37:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Andrew Morton <akpm@osdl.org>, <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-Reply-To: <20030827051853.181C92C0C1@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0308270846580.2063-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not pinning the pages, and going by mapping,index (including
swapper_space,swap_index case) seems fine; with a special case
of struct page * for the anonymous not yet assigned to swap.

(Very tempting to assign to swap early to avoid that special
case; but swapoff,swapless,swapon make that unreasonable.)

But I do not understand how futex_wake can still be doing a
this->page == page test: its __pin_page will ensure that some
page is faulted in, but that's not necessarily the same page
as in this->page.

I believe you need mapping,index in struct futex_q (with
swapper_space just one possibility for mapping), and the
struct page * considered an exceptional (though common) case.

I strongly agree with Andrew that add_to_swap and
delete_from_swap_cache (probably the one without the __s)
are the places for switching the anonymous, not page_io.c:
page->mapping will be set and unset in those, and it's
page->mapping that you're keying off in hash_futex.

But I disagree over move_to/from_swap_cache: nothing should
be done there at all.  Once you have mapping,index in struct
futex_q, it's irrelevant what tmpfs might be doing to the
page->mapping,page->index of the unmapped page.

I dare not think what locking may be necessary, to manage
the switch from hashing by struct page * to hashing by
swapper_space,index.

Hugh


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbSIZWs7>; Thu, 26 Sep 2002 18:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbSIZWs7>; Thu, 26 Sep 2002 18:48:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12298 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261547AbSIZWsW>; Thu, 26 Sep 2002 18:48:22 -0400
Date: Thu, 26 Sep 2002 15:56:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
In-Reply-To: <Pine.LNX.4.33.0209261533230.1345-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0209261550590.1573-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Linus Torvalds wrote:
> 
> and then when we pin a page, we do
> 
> 	/* This is part of the 
> 	struct page_change_struct pinned_data;

That "This is part of the " comment should continue with "struct futex_q", 
but I went off and was supposed to check what the futex data structure was 
called, and forgot about updating it.

Anyway, the point being that this needs no new allocations in _any_ path,
and only extends a structure that we already need for the slow case for
futexes. It does imply a new lock, though, and the COW path would have to
check that hash (which should scale pretty well, since we only have
entries here when somebody is blocked on a futex).

Oh, and we need a new hash table, since the native futex hash can't just
be re-used due to different indexing - the futex hash is based on physical
page and offset, while the page_change_struct hash is based on virtual
address and the mm.

(I initially thought we could make the page_change_struct hash be based on 
physical page, but there can be multiple instances of the same physical 
page being mapped into the same VM, so that wouldn't be a good thing - 
we'd get callbacks for the wrong virtual address being COW'ed).

		Linus


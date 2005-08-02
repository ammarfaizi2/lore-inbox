Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVHBQ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVHBQ0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVHBQZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 12:25:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261588AbVHBQZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 12:25:39 -0400
Date: Tue, 2 Aug 2005 09:25:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
 <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Aug 2005, Hugh Dickins wrote:
> 
> But have I just realized a non-s390 problem with your pte_dirty
> technique?  The ptep_set_wrprotect in fork's copy_one_pte.
> 
> That's specifically write-protecting the pte to force COW, but leaving
> the dirty bit: so now get_user_pages will skip COW-ing it (in all write
> cases, not just the peculiar ptrace force one).

Damn, you're right. We could obviously move the dirty bit from the page
tables to the "struct page" in fork() (that may have other advantages:  
we're scanning the dang thing anyway, after all) to avoid that special
case, but yes, that's nasty.

One of the reasons I _liked_ the pte_dirty() test is that there's the
reverse case: a mapping that used to be writable, and got dirtied (and
COW'ed as necessary), and then was mprotected back, and the new test would
happily write to it _without_ having to do any extra work. Which in that
case is correct.

But yeah, fork() does something special.

In fact, that brings up another race altogether: a thread that does a
fork() at the same time as get_user_pages() will have the exact same
issues. Even with the old code. Simply because we test the permissions on
the page long before we actually do the real access (ie it may be dirty
and writable when we get it, but by the time the write happens, it might
have become COW-shared).

Now, that's probably not worth worrying about, but it's kind of 
interesting.

		Linus

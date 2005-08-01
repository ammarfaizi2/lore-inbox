Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVHATnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVHATnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVHATno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:43:44 -0400
Received: from gold.veritas.com ([143.127.12.110]:48738 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261195AbVHATlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:41:51 -0400
Date: Mon, 1 Aug 2005 20:43:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@elte.hu>, Robin Holt <holt@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Roland McGrath <roland@redhat.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <42EE0021.3010208@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0508012030050.5373@goblin.wat.veritas.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <20050801091956.GA3950@elte.hu>
 <42EDEAFE.1090600@yahoo.com.au> <20050801101547.GA5016@elte.hu>
 <42EE0021.3010208@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Aug 2005 19:41:49.0703 (UTC) FILETIME=[0F2F8170:01C596D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Nick Piggin wrote:
> Ingo Molnar wrote:
> > Hugh's posting said:
> > 
> > "it's trying to avoid an endless loop of finding the pte not writable 
> > when ptrace is modifying a page which the user is currently protected
> > against writing to (setting a breakpoint in readonly text, perhaps?)"
> > 
> > i'm wondering, why should that case generate an infinite fault? The first
> > write access should copy the shared-library page into a private page and
> > map it into the task's MM, writable. If this make-writable 
> 
> It will be mapped readonly.

Yes.  Sorry to leave you so long pondering over my words!

> > operation races with a read access then we return a minor fault and the
> > page is still readonly, but retrying the write should then break up the
> > COW protection and generate a writable page, and a subsequent
> > follow_page() success. If the page cannot be made writable, shouldnt the
> > vma flags reflect this fact by not having the VM_MAYWRITE flag, and hence
> > get_user_pages() should have returned with -EFAULT earlier?
> 
> If it cannot be written to, then yes. If it can be written to
> but is mapped readonly then you have the problem.

Yes.  The problem case is the one where "maybe_mkwrite" finds !VM_WRITE
and so doesn't set writable (but as Linus has observed, dirty is set).

I'm no expert on that case, was just guessing its use, I think Robin
determined that Roland is the expert on it; but what's very clear is
that it's intentional, allowing strace to write where the user cannot
currently write.

> Aside, that brings up an interesting question - why should readonly
> mappings of writeable files (with VM_MAYWRITE set) disallow ptrace
> write access while readonly mappings of readonly files not? Or am I
> horribly confused?

Either you or I.  You'll have to spell that out to me in more detail,
I don't see it that way.

What I do see and am slightly disturbed by, is that do_wp_page on a
shared maywrite but not currently writable area, will go the break
cow route in mainline, and has done so forever; whereas my page_mkwrite
fixes in -mm inadvertently change that to go the the reuse route.

I think my inadvertent change is correct, and the current behaviour
(putting anonymous pages into a shared vma) is surprising, and may
have bad consequences (would at least get the overcommit accounting
wrong).

Hugh

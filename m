Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266897AbUHITJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUHITJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUHITJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:09:21 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:18115 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266876AbUHITIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:08:18 -0400
Date: Mon, 9 Aug 2004 20:08:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Oskar Berggren <beo@sgs.o.se>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Bug in 2.6.8-rc3 at mm/page_alloc.c:792 and mm/rmap.c:407
In-Reply-To: <Pine.LNX.4.44.0408081930050.2366-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0408092007000.5981-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Hugh Dickins wrote:
> On Sun, 8 Aug 2004, Oskar Berggren wrote:
> > Two BUG's I've been seeing, one in page_alloc.c and one in rmap.c.
> 
> This is not the first report of an rmap.c:407,
> Denis reported one a week ago (on 2.6.7-bk20).
> 
> I don't know what's behind it, but I am wondering if PageReserved
> might be getting cleared while page is still mapped into userspace.

That was just a guess, I've no evidence, and now doubt that.

> You both have sound modules in, are you using audio?

You weren't actually using it (you mention in other mail),
even if Denis was, so audio no longer looks like a suspect.

> Could you mail me (privately) your /var/log/messages, Oskar, I don't
> have a clear picture of the relation between your page_alloc.c:792s,
> your rmap.c:407s and your other oopses.

Thanks a lot for the /var/log/messages.

The frustrating thing is that the most interesting lines are missing:
the "unqualified" printks, e.g. handle_BUG's "--- [ cut here ] ---" line
and stack traces do appear; but handle_BUG's KERN_ALERT "kernel BUG..."
and bad_page's very useful KERN_EMERG messages do not appear at all.

The "kernel BUG" messages you've already told us, but the missing
bad_page lines might, _might_ be really helpful.  Do you have some
klogd option set, not to print out the most important messages ;-?
I hope someone can tell us how to fix that.

I notice the page_remove_rmap BUG (which we know to be rmap.c:407
from your mail) was preceded 10 minutes earlier by a bad_page; and
one of the things bad_page will do is force page->mapcount to 0,
which would trigger the page_remove_rmap BUG, if that page being
freed was actually still in use in some process address space.

Most of the other BUGs (mostly page_alloc.c:792s, __free_pages called
from below shrink_cache or sock_release, finding page_count already 0)
were also preceded, less immediately, by bad_pages; though not all.

It's all consistent with pages being freed while still in use,
but I don't think I'm saying anything new there.  It doesn't look
to me like random corruption or bad memory, I don't think those would
show up so consistently as page freeing errors.  (Though if KERN_ERRs
aren't getting into /var/log/messages, there might be page table
corruption swap_free errors missing too.)

But I've no idea of where to look for the culprit: I'd better get
on with other things, and hope someone else can take this further.

Hugh


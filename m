Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbTHaCyg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 22:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbTHaCyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 22:54:36 -0400
Received: from dp.samba.org ([66.70.73.150]:61072 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262399AbTHaCyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 22:54:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Thu, 28 Aug 2003 21:17:44 MST."
             <20030828211744.3081a058.akpm@osdl.org> 
Date: Sat, 30 Aug 2003 17:49:51 +1000
Message-Id: <20030831025435.10B652C29C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030828211744.3081a058.akpm@osdl.org> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > Well, the patch I posted adds a futex_rehash to ___add_to_page_cache,
> 
> That's a real hotpath.  Certainly we couldn't take a global lock there.

Agreed.

> Need to find a way to rehash when moving pages around only in swapcache.  I
> thought the earlier patches were structured that way?

Yes, but I'm fairly sure they were racy.  Which is enough for me to
dislike it.

Rehashing when the ->mapping changes is simple and clear.  It's fairly
easy to push it up to the callers, and then I'll figure out which ones
are adding new pages, and which ones are moving pages from one
->mapping to another (these ones we care about).  But it has to be
under the same locks (ie. rehashing and changing the mapping an atomic
operation) otherwise someone has to prove that noone can do a futex
lookup on the page with the new mapping before it's been updated in
the hash.

The other possibility is to use some lock we already have, rather than
the futex_lock, to protect that PG_futexed bit.

I'll keep working on it.  I'm learning more about the VM, at least.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

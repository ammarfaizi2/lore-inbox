Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSG2EQ4>; Mon, 29 Jul 2002 00:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318008AbSG2EQ4>; Mon, 29 Jul 2002 00:16:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6916 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318007AbSG2EQz>; Mon, 29 Jul 2002 00:16:55 -0400
Date: Sun, 28 Jul 2002 21:21:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <20020728.204302.44950225.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207282117030.1003-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, David S. Miller wrote:
>    From a page cache standpoint softirq's are 100% equivalent to
>    hardware irq's, so that doesn't much help here.
>
> Wait are we trying to make the final freeing of (potentially)
> LRU/page-cache pages from any non-base context illegal?

We're not "trying to". It's always been hugely illegal, because we don't
protect the LRU lists against interrupts etc, so anything that happens at
irq (or bh) time will mess up the LRU lists if it tries to remove a page
from them.

But the thing is, nobody should normally have a reference to such a page
anyway. The only way they happen is by something mapping a page from user
space, and saving it away, while the user space goes away and drops its
references to the page.

And the page cache won't drop its own reference to the page as long as
somebody holds on to it - with the extra special case of truncate(), which
at least used to remove it from the LRU's before it did that. I think one
of Andrews patches undid that truncate() thing, though. I suspect we'll
have to fix _that_ patch, not the other paths.

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318036AbSG2GML>; Mon, 29 Jul 2002 02:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318038AbSG2GML>; Mon, 29 Jul 2002 02:12:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318036AbSG2GML>; Mon, 29 Jul 2002 02:12:11 -0400
Date: Sun, 28 Jul 2002 23:16:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <20020728.224302.36837419.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207282256460.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, David S. Miller wrote:
>
>    But the thing is, nobody should normally have a reference to such a
>    page anyway. The only way they happen is by something mapping a
>    page from user space, and saving it away, while the user space goes
>    away and drops its references to the page.
>
> Ignoring for a moment whether you agree with the idea of zero-copying
> userspace pages over sockets, I would at least like to retain the
> ability to experiment with something like this.

Oh, you misunderstand.. (probably because I'm unclear)

I'm not saying that getting a page from a user space mapping is bad: a lot
of places do that independently of zero-copy.

But hopefully nobody should have the problematic last reference to a LRU
page _except_ the user space itself. That should be safe for page cache
pages thanks to the truncate change.

And for anonymous pages, I really think that the right solution is to do
the same remove-from-LRU thing for the "last unmap" (which should be
trivial to notice with rmap).

I'm trying to come up with what kept us safe in 2.4.x for anonymous pages,
and I get this sinking feeling that we really aren't.

Which may imply that Andrew's irq-safe LRU list is the right thing to do
after all. At least on 2.4.x (and if you do it there, then my arguments
about it being unnecessary on 2.5.x due to "design" just totally cruble
away, since clearly Andrew was rigth and the "design argument" was total
crud.

Let me sleep on this. Does anybody have any intelligent thoughts?

			Linus


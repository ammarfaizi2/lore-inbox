Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270653AbRHJVzp>; Fri, 10 Aug 2001 17:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270654AbRHJVzf>; Fri, 10 Aug 2001 17:55:35 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:61451 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270653AbRHJVz0>; Fri, 10 Aug 2001 17:55:26 -0400
Date: Fri, 10 Aug 2001 14:55:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps getting _VERY_ long
In-Reply-To: <20010806194120.A5803@thefinal.cern.ch>
Message-ID: <Pine.LNX.4.33.0108101445350.7596-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Jamie Lokier wrote:
>
> There are garbage collectors that use mprotect() and SEGV trapping per
> page.  It would be nice if there was a way to change the protections per
> page without requiring a VMA for each one.

This is actually how Linux used to work a long long time ago - all
protection information was in the page tables, and you could do per-page
things without having to worry about piddling details like vma's.

It does work, but it had major downsides. Trivial things like re-creating
the permission after throwing a page out or swapping it out.

We used to have these "this is a COW page" and "this is shared writable"
bits in the page table etc - there are two sw bits on x86, and I think we
used them both.

These days, the vma's just have too much information, and the page tables
can't be counted on to have enough bits.

So on one level I basically agree with you, but at the same time it's just
not feasible any more. The VM got a lot better, and got ported to other
architectures. And it started needing more information - it used to be
enough to know whether a page was shared writable or privately writable or
not writable at all, but back then we didn't really support the full
semantics of shared memory or mprotect, so we didn't need all the
information we have to have now.

They were "the good old days", but trust me, you really don't want them
back. The vma's have some overhead, but it is not excessive, and they
really make things like a portable VM layer possible..

It's very hard to actually see any performance impact of the VMA handling.
It's a small structure, with reasonable lookup algorithms, and the common
case is still to not have all that many of them.

		Linus


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280814AbRKRHgR>; Sun, 18 Nov 2001 02:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280822AbRKRHgI>; Sun, 18 Nov 2001 02:36:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19976 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280814AbRKRHfy>; Sun, 18 Nov 2001 02:35:54 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: VM-related Oops: 2.4.15pre1
Date: Sun, 18 Nov 2001 07:31:15 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9t7o43$1am$1@penguin.transmeta.com>
In-Reply-To: <20011118051023.A25232@athlon.random> <Pine.LNX.4.33.0111172220300.1290-100000@penguin.transmeta.com> <20011118073730.C25232@athlon.random>
X-Trace: palladium.transmeta.com 1006068947 31136 127.0.0.1 (18 Nov 2001 07:35:47 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 18 Nov 2001 07:35:47 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011118073730.C25232@athlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>
>I know all is right if GCC just overwrites the page->flags with data
>that keeps PG_locked set. But GCC doesn't guarantee that.  GCC can as
>well do:
>
>	flags = page->flags;
>	page->flags = 0;
>
>	change flags here
>
>	page->flags = flags

Sure.

>From a C language lawyer standpoing a C compiler can do pretty much
whatever it damn well chooses to do, including temporarily changing
"page->flags" even if the C source doesn't have any reference to
"page->flags" at _all_.  The compiler might decide that it temporarily
wants to use that memory for something else, and since "Strictly
conforming ANSI C" does not have a notion of threads etc interesting
issues, you can probably argue that just about _anything_ falls under
"gcc doesn't guarantee that". 

>probably gcc doesn't, but that's still a kernel bug.

No. It would be a _gcc_ bug if gcc did things to "page->flags" that the
code did not ask it to do. And that is _regardless_ of any notions of
"strictly conforming C code". The fact is, that if gcc were to clear a
bit that the code never clears, that is a HUGE AND GAPING GCC BUG.

Not kernel bug.

The fact is, if we write code that leaves a certain bit unmodified, gcc
MUST NOT modify that bit. If gcc generated code that temporarily
modifies the bit, I can show user-level code that would break with
signals. See "sig_atomic_t" and friends - the compiler simply _has_ to
guarantee that the semantics you write in C code are actually upheld.

		Linus


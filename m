Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbTBLFsL>; Wed, 12 Feb 2003 00:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbTBLFsL>; Wed, 12 Feb 2003 00:48:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20744 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266917AbTBLFsK>; Wed, 12 Feb 2003 00:48:10 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Date: Wed, 12 Feb 2003 05:54:37 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b2cnit$7e6$1@penguin.transmeta.com>
References: <629040000.1045013743@flay> <20030212041848.GA9273@bjl1.jlokier.co.uk>
X-Trace: palladium.transmeta.com 1045029463 8849 127.0.0.1 (12 Feb 2003 05:57:43 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Feb 2003 05:57:43 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030212041848.GA9273@bjl1.jlokier.co.uk>,
Jamie Lokier  <jamie@shareable.org> wrote:
>
>A cute and wonderful hack is to use the 6 words in the TSS prior to
>&tss->es as the trampoline. Now that __switch_to is done in software,
>those words are not used for anything else.

No!! 

That's not cute and wonderful, that's _horrible_.

Mixing data and code on the same page is very very slow on a P4 (well, I
think it's "same half-page", but the point is that you should not EVER
mix data and code - it ends up being slow on modern CPU's).

>Other fixed offsets from &tss->esp0 are possible - especially nice
>would be to share a cache line with the GDT's hot cache line.  (To do
>this, place GDT before TSS, make KERNEL_CS near the end of the GDT,
>and then the accesses to GDT, trampoline and tss->esp0 will all touch
>the same cache line if you're lucky).

Since almost all x86 CPU's have some kind of cacheline exclusion policy
between the I$ and the D$ (to handle the strict x86 I$ coherency
requirements), your "if you're lucky" is completely bogus.  In fact,
you'd be the _pessimal_ cache behaviour for something like that, ie you
get lines that ping-pong between the L2 and the two instruction caches. 

Don't do it. Keep data and code on separate pages.

			Linus

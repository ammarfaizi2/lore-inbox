Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbTBLFnH>; Wed, 12 Feb 2003 00:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTBLFnG>; Wed, 12 Feb 2003 00:43:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3080 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266851AbTBLFnG>; Wed, 12 Feb 2003 00:43:06 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Date: Wed, 12 Feb 2003 05:49:26 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b2cn96$7dk$1@penguin.transmeta.com>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk> <20030212042143.GB9273@bjl1.jlokier.co.uk>
X-Trace: palladium.transmeta.com 1045029152 8644 127.0.0.1 (12 Feb 2003 05:52:32 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Feb 2003 05:52:32 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030212042143.GB9273@bjl1.jlokier.co.uk>,
Jamie Lokier  <jamie@shareable.org> wrote:
>Dave Jones wrote:
>> I feel I'm missing something obvious here, but is this part the
>> low-hanging fruit that it seems ?
>
>You have eliminated one MSR write very cleanly, although there are
>still a few unnecessary conditionals when compared with grabbing a
>whole branch of the fruit tree, as it were.
>
>That leaves the other MSR write, which is also unnecessary.

No, the other one _is_ necessary.  I did timings, and having it in the
context switch path made system calls clearly faster on a P4 (as
compared to my original trampoline approach).

It may be only two instructions difference ("movl xx,%esp ; jmp common")
in the system call path, but it was much more than two cycles.  I don't
know why, but I assume the system call causes a total pipeline flush,
and then the immediate jmp basically means that the P4 has a hard time
getting the pipe restarted.

This might be fixable by moving more (all?) of the kernel-side fast
system call code into the per-cpu trampoline page, so that you wouldn't
have the immediate jump. Somebody needs to try it and time it, otherwise
the wrmsr stays in the context switch.

I want fast system calls. Most people don't see it yet (because you need
a glibc that takes advantage of it), but those fast system calls are
more than enough to make up for some scheduling overhead.

			Linus

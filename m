Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266893AbUHITkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266893AbUHITkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUHITjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:39:42 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:13021 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S266893AbUHITiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:38:17 -0400
Date: Mon, 9 Aug 2004 12:38:16 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
In-Reply-To: <Pine.LNX.4.58.0408060941550.24588@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408091207430.25286@twinlark.arctic.org>
References: <2qbyt-1Op-45@gated-at.bofh.it> <2qemF-3Pj-49@gated-at.bofh.it>
 <m3wu0cgv6q.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0408060941550.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Linus Torvalds wrote:

> work to first check that the FP context is safed. Even _without_ the extra
> work I simply cannot imagine that a "movd reg,mmx" is faster than a plain
> "movl reg,stackslot".

p3/p-m have datapaths specifically for movd -- apparently a path for
int->mmx and a separate path for mmx->int.  the paths are latency 1,
throughput one per clock.

however that line of x86 processors is essentially unique in this
respect...

my measurement methodology is to pair a bunch of movd back and forth
between (int,mmx) register pairs, then measure the avg latency per
round-trip as i increase the number of pairs (i.e. to see how much
parallelism is available.)

i.e. for 2 in parallel my code is this fragment repeated 100 times:

	movd %eax,%mm0
	movd %ebx,%mm1
	movd %mm0,%eax
	movd %mm1,%ebx

here's the average round-trip latency (in cycles) per movd/movd pair
for various processors i have access to, and availble parallelisms:

                       available parallelism
             1       2       3       4       5       6
p-m         2.00    1.30    1.00    1.04    1.01    1.00
p4-2        8.00    4.05    2.67    2.50    2.40    2.33
p4-3       11.02    5.50    3.67    2.75    2.40    2.33
opteron    14.67    6.00    5.33    5.00    5.00    5.00
efficeon    7.06    3.55    2.80    2.97    2.95    3.08

i'm pretty sure the gladman code was tuned on processors like
p3/p-m... where movd is an improvement over using memory.  actually i've
been kind of puzzled why nobody ever used mmx for the XORing on a p3
-- i think the 1 cycle latency mmx plus the 1 cycle latency movd makes
it all pay off fine... but this won't pay off anywhere else because of
2-cycle mmx latency, and long latency between int/mmx register files.

i've seen another totally slimy AES trick for this problem -- store %esp
in a global memory location then use it as a general purpose register.
there's a benchmark which does this, i consider it wholly inappropriate
for general code though :)

-dean

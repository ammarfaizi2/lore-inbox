Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVASFdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVASFdW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVASFbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:31:18 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:59919 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261591AbVASFao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:30:44 -0500
Date: Wed, 19 Jan 2005 06:14:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Testing optimize-for-size suitability?
Message-ID: <20050119051442.GO7048@alpha.home.local>
References: <200501161040.12907.swsnyder@insightbb.com> <20050119041739.GI1841@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119041739.GI1841@stusta.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Jan 19, 2005 at 05:17:39AM +0100, Adrian Bunk wrote:
> In theory, -O2 should produce faster code.
> 
> In practice, I don't know about any recent benchmarks comparing -Os/-O2 
> kernels.
> 
> In practice, I doubt it would make any noticable difference if the 
> kernel might be faster by let's say 1% with one option compared to the 
> other one.
> 
> The main disadvantage of -Os is that it's much less tested for kernel 
> compilations, and therefore miscompilations are slightly more likely.
 
In fact, I've been compiling all my kernels with -Os for at least 2 years
with gcc-2.95.3. -Os and -O2 produce nearly the same code on this compiler,
it's even difficult to find algorithms which produce fairly different code
with it. But things get different with gcc-3.3. -Os produces *really*
smaller code (sometimes up to 20% smaller than -Os on gcc-2.95.3), but this
code also becomes fairly slower, and disassembling it sometimes shows what
can be called stupid code, because speed optimization completely disappears
eventhough sometimes both size and speed could be optimized (eg: by switching
two instructions to prevent pipelines stalls). On various code, I found
gcc-3.3 -Os to deliver about 30% less performance than -O2. On the other hand,
gcc-3.3 -O2 produces bigger and sometimes faster code than gcc-2.95 -O2.
So it's difficult to say which one is better, it really depends on what you
do with it.

I have not benchmarked any gcc-3.3 -Os kernel yet, though I've already been
running some of them accidentely because of an old .config which gets rebuild
on a machine which only has gcc-3.3. I've not noticed miscompilations nor
really perceptible slowdowns, but I've not measured this last point.

What I often found efficient to both reduce code size and improve speed is
to play with code alignment and stack boundary. Using
"-mpreferred-stack-boundary=2" keeps the stack 32-bit aligned, which removes
some entry and leave code in all functions (and esp, ...). Code alignment
with -malign-loops=0, -malign-jumps=0 and -malign-functions=0 reduces the
code size while not really affecting its speed (or just slightly increase
some of these params if you find speed problem).

Regards,
Willy


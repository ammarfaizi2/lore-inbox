Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTDHNCq (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTDHNCq (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:02:46 -0400
Received: from ns.suse.de ([213.95.15.193]:11537 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261366AbTDHNCo (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 09:02:44 -0400
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
References: <20030408134240.45cdad7e.skraw@ithnet.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Apr 2003 15:14:05 +0200
In-Reply-To: <20030408134240.45cdad7e.skraw@ithnet.com.suse.lists.linux.kernel>
Message-ID: <p73n0j1xhb5.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> writes:

> during tests with latest SuSE distro 8.2 compiling 2.4.21-pre6 showed a lot of
> "comparison between signed and unsigned" warnings. It looks like SuSE ships gcc

The warning is in earlier gccs too, but turned off by default there.

I don't know why it was turned on by default in gcc 3.3 by the gcc maintainers,
but it gives so much noise that I tend to turn it off during the build (-Wno-sign-compare) 

Fixing it is usually not trivial. Yes, you could go through the source
and add casts to the comparisons, but that would miss the point
(assuming there is a point in this warning, I'm not 100% sure on that
;) Really it needs someone to audit these comparisons and determine
what signedness the comparisons should be in.  But that requires some
understanding of the code; it's not a brainless "janitor job" even 
if it looks like this on the first look.

Most of them come from a few headers.
e.g. I already submitted patches for the skbuff.h warnings for 2.5.

> 3.3 (prerelease). Is this compiler known to work for kernel compilation? Should
> therefore all these warnings be fixed?

I use it to build kernels and have not found a compiler caused problem with
it yet. Most of the kernel problems with specific gcc versions used to 
be kernel bugs anyways (like broken inline assembly or missing compile barriers) 
and most of them should be weeded out now from the experience with previous
gcc versions.

It does not accept unprotected new lines in strings anymore. Some
versions of the aic7xxx driver use that. Fixing it is trivial,
also the new aic7xxx driver in 2.4.21pre7 has it now fixed too.

The only thing what's a bit fishy in that compiler is the inlining algorithm
which tends to not inline functions anymore that have been previously inlined.
causing constant propagation to fail and some unnecessary code be generated.
This can be worked around though by putting

#define inline __attribute__((always_inline)) inline
#define __inline __attribute__((always_inline)) inline
#define __inline__ __attribute__((always_inline)) inline

into linux/compiler.h. This is more an code quality than correctness
issue for i386 (x86-64 had one case where it broke code, but that's
fixed already) 

But really, it does generate significantly better code for some things
than 3.2.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVIQHSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVIQHSi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 03:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVIQHSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 03:18:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37838
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750983AbVIQHSh (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 03:18:37 -0400
Date: Sat, 17 Sep 2005 00:18:22 -0700 (PDT)
Message-Id: <20050917.001822.46482906.davem@davemloft.net>
To: zippel@linux-m68k.org
Cc: rmk+lkml@arm.linux.org.uk, nickpiggin@yahoo.com.au,
       Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0509170234180.3743@scrub.home>
References: <Pine.LNX.4.61.0509150010100.3728@scrub.home>
	<20050914232106.H30746@flint.arm.linux.org.uk>
	<Pine.LNX.4.61.0509170234180.3743@scrub.home>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>
Date: Sat, 17 Sep 2005 02:59:50 +0200 (CEST)

> My biggest problem here is the lack of gcc support to get the
> condition code out of an asm.

I agree, this is the biggest deficiency in gcc inline assembly and I
run into it all the time.

Things like __builtin_trap() would never even be needed if we could
communicate condition code state into and out of inline asm
statements, for example.

Sparc32 and sparc64 both have "trap on condition code" instructions.
__builtin_trap() will do the right thing, _BUT_ I want to emit nice
bug table entries like ppc64 does in asm-ppc64/bug.h, but I can't do
that without generating really crappy code.  And the whole limitation
comes from the fact that I can't tell ask gcc for "the condition codes
that result from test X" as the input for an asm.

So what would be great is something akin to:

	__asm__ __volatile__("t%cc	0x5"
			     : "=C" (test));

or something like that.  The "%cc" thing would be expand to the
appropriate two/three letter condition test type code, for example
"ne", "eq", "ge", "ltu" and the like.  GCC could choose the best
comparison + %cc code, as it already does for conditional branch
generation.

It could even help on platforms like ppc64 where the trap condition
instruction does a test of a register against an immediate value.
Something like "BUG_ON(a != 2)" is probably emitting something like:

	sub	%a, 2, %tmp
	tdnei	%tmp, 0

whereas this could be:

	tdnei	%tmp, 2

if GCC has some inline asm condition code input facility like the
above.

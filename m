Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132689AbRDKSGQ>; Wed, 11 Apr 2001 14:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDKSGG>; Wed, 11 Apr 2001 14:06:06 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:8722 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132689AbRDKSF5>; Wed, 11 Apr 2001 14:05:57 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] i386 rw_semaphores fix
Date: 11 Apr 2001 11:05:31 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9b26db$3t2$1@cesium.transmeta.com>
In-Reply-To: <20010411021318.A21221@khan.acc.umu.se> <Pine.LNX.4.31.0104101750320.15069-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.31.0104101750320.15069-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Note that the "fixup" approach is not necessarily very painful at all,
> from a performance standpoint (either on 386 or on newer CPU's). It's not
> really that hard to just replace the instruction in the "undefined
> instruction"  handler by having strict rules about how to use the "xadd"
> instruction.
> 
> For example, you would not actually fix up the xadd to be a function call
> to something that emulates "xadd" itself on a 386. You would fix up the
> whole sequence of "inline down_write()" with a simple call to an
> out-of-line "i386_down_write()" function.
> 
> Note that down_write() on an old 386 is likely to be complicated enough
> that you want to do it out-of-line anyway, so the code-path you take
> (afetr the first time you've trapped on that particular location) would be
> the one you would take for an optimized 386 kernel anyway. And similarly,
> the restrictions you place on non-386-code to make it fixable are simple
> enough that it probably shouldn't make a difference for performance on
> modern chips.
> 

This reminds me a lot of how FPU emulation was done on 16-bit x86
CPUs, which didn't have the #EM trap on FPU instructions.  Each FPU
instruction would actually be assembled as CD + <FPU insn>, except
that the first byte of the FPU insn had its top bits modified.  Of
course the CD is the first byte of the INT instruction, so it would
dispatch to a very small set of interrupt vectors based on the first
byte of the FPU instruction; in case there really was an FPU it would
patch in <FPU insn>+NOP, otherwise it would patch in CALL <FPU
emulation routine> if you were running in a small-code model, or just
emulate it in a large-code model (since the far CALL wouldn't fit.)

This is a very nice way to deal with this, since your performance
impact is virtually nil in either case, since you're only taking the
trap once per call site.  A little bit of icache footprint, that's
all.

Now, if you're compiling for 486+ anyway, you would of course not add
the extra padding, and skip the trap handler.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

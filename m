Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbUDGD6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 23:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUDGD6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 23:58:11 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:60236 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264090AbUDGD6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 23:58:03 -0400
Date: Tue, 6 Apr 2004 20:55:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040406205527.56317c03.pj@sgi.com>
In-Reply-To: <1081255616.28514.72.camel@bach>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
	<20040405010839.65bf8f1c.pj@sgi.com>
	<1081227547.15274.153.camel@bach>
	<20040405230601.62c0b84c.pj@sgi.com>
	<1081233543.15274.190.camel@bach>
	<20040405234552.23f810cd.pj@sgi.com>
	<1081235999.28514.9.camel@bach>
	<20040406034055.1dbe2eac.pj@sgi.com>
	<1081255616.28514.72.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty suggested:
> 1) I think you only want the fastpath when it's eliminated by the
> compiler, so perhaps:
> 	if (__builtin_constant_p(nbits) && nbits <= BITS_PER_LONG)

It's not quite a cut and dried decision.

Define a 'small' system to be one where NR_CPUS <= BITS_PER_LONG, and a
'large' system to be those that aren't small.

If one had a bitmap operator called in a performance critical path on a
'small' system with a non-constant (unknown to the optimizer) bitmap
size, then one would _not_ want the above check for builtin_constant.

Leaving out the buildin_constant check results in code that checks the
variable size at runtime, performs the fast inline instructions on a
single word if it fits, else jumps to an out-of-line block of code that
calls the real __bitmap_op() function.

Since on a 'small' system, the bitmap size probably fits in a word, and
since on a performance critical path, it's worth checking for the fast
inline instruction opportunity, avoiding a jump out of line and avoiding
a real function call, the code obtained by leaving out the check for
builtin_constant is ideal.

However ... it costs you a half dozen machine instructions of text
space, for the out-of-line code block to handle the slow case that calls
the real __bitmap_op() function.

Since almost all systems are small, and since almost all bitmap operations
are not on critical paths, and since almost all bitmap operations are
called with a constant bitmap size, these half dozen machine instructions
are almost never worth a slug of warm spit.

Better to do just as Rusty suggests - if called with a non-constant
size, just say screw it and call the __bitmap_op() routine.  While that
call might not have been necessary (might even be an 'issue' in a
performance critical path), it's not worth the half-dozen machine
instructions to find out.

So I guess the real question is:

	Is it worth the slug of warm source code spit, the
	extra __builtin_constant_p(nbits) condition, to get rid
	of these six instructions for each bitmap_op() call
	made with a non-constant bitmap size?

Or the real real question - is this discussion worth a slug of warm
lkml posts ... ;)?

				===

Aha - I just built an 8 CPU SMP i386 config with my latest stuff.
Exactly one call appears to any __bitmap_* function, in the routine
bitmap_parse() of lib/bitmap.c:

	bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);

Ok - change this to the following, and save six text instructions
testing for the possibility that nmaskbits < BITS_PER_LONG:

	__bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);

There .. now the inline bitmap_* operators are _always_ seeing
constant bitmap sizes (for this exhaustive sampling of size one ;).

Conclusions:

     1) To heck with the extra __builtin_constant_p(nbits) condition.

	It's not worth polluting the source code with stuff to futz
	with a six instruction space/time tradeoff in some situation
	that doesn't yet exist, and if it did exist, might or might
	not want such a tradeoff.

     2) No - this post wasn't worth a slug of warm spit ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

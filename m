Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUCTAtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 19:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUCTAtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 19:49:14 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:7983 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263191AbUCTAtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 19:49:12 -0500
Date: Fri, 19 Mar 2004 16:47:26 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040319164726.02e5f417.pj@sgi.com>
In-Reply-To: <1079737773.17841.67.camel@arrakis>
References: <1BeOx-7ax-55@gated-at.bofh.it>
	<1BgGq-DU-5@gated-at.bofh.it>
	<1BgZN-Vk-1@gated-at.bofh.it>
	<m37jxhvbgm.fsf@averell.firstfloor.org>
	<1079737773.17841.67.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the case of a single unsigned long, the bitmap operations aren't
> as efficient as just doing a 
> 	res = (mask1 & mask2);
> vs.
> 	bitmask_and(&res, &mask1, &mask2);

This is probably the same as Matt is thinking, but what I imagine has
the inline efficiency (a machine instruction or two) of the openly coded
first example above, but is always written more in the style of the
second example above.

The 'mask_and()' macro can be an inline or define that collapses in the
one word case (by far the most common) to the same machine instruction
or two as the open code does.  We _do_ know, at compile time, the
_exact_ size of any given instance of these, so gcc has sufficient
information to collapse the inline code, if we present it right, to the
legitimate minimum.

For example, mask_and might be:

=========================================================================
#define __mask(bits)    struct { unsigned long _m[BITS_TO_LONGS(bits)]; }
typedef __mask(NR_CPUS) cpumask_t;

#define mask_and(d,s1,s2)                               \
do {                                                    \
        if (sizeof(d) == sizeof(unsigned long))         \
                d._m[0] = s1._m[0] & s2._m[0];          \
        else                                            \
                bitmask_and(d._m, s1._m, s2._m);        \
} while(0)
=========================================================================

With this, mask_and() on some cpumask_t's, when NR_CPUS is 64,  _does_
collapse to a simple:

        and r32 = r8, r32

on my ia64 with gcc 3.2.3.

The mask.h I appended yesterday uses bitmap calls such as bitmap_and()
unconditionally (even in the one word case).  This is probably worth
fixing, in the manner shown above, at least for such cases such as
'and', 'or', 'empty', 'complement', 'shift_left' and 'shift_right'.

No use of multiple architecturally chosen implementations, such as we
do now with cpumask, is required.  Just a little bit of special case
code for the one-word case, in 6 or 8 of the macros.

I still think, that with just a few lines of compile time logic such as
above, we can have a single implementation that is pretty close to
ideal, for almost all architectures, using a struct holding an array of
unsigned longs.

The one obvious exception, sparc64, should have its own arch specific
implementation under include/asm-sparc64 and perhaps arch/sparc64.  It
should not be embedded in a thicket of pseudo-generic ifdefs and
conditional includes as part of the apparently generic implementation.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

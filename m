Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVG2Ojy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVG2Ojy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 10:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVG2Ojx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 10:39:53 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32005 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262598AbVG2Ojt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 10:39:49 -0400
Date: Fri, 29 Jul 2005 15:39:55 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org>
Message-ID: <Pine.LNX.4.61L.0507291456540.21257@blysk.ds.pg.gda.pl>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>  <1122565640.29823.242.camel@localhost.localdomain>
  <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
 <1122569848.29823.248.camel@localhost.localdomain> <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Linus Torvalds wrote:

> There may be more upsides on other architectures (*cough*ia64*cough*) that 
> have strange scheduling issues and other complexities, but on x86 in 
> particular, the __builtin_xxx() functions tend to be a lot more pain than 
> they are worth. Not only do they have strange limitations (on selection of 

 They can be buggy, sure, just like any code.  If they indeed are we may 
want to avoid them rather than requiring a GCC upgrade, of course.

> opcodes but also for compiler versions), but they aren't well documented, 
> and semantics aren't clear.

 Hmm, that's what's in the GCC info pages for the relevant functions 
(I've omitted the "l" and "ll" variants):

"-- Built-in Function: int __builtin_ffs (unsigned int x)
     Returns one plus the index of the least significant 1-bit of X, or
     if X is zero, returns zero.

 -- Built-in Function: int __builtin_clz (unsigned int x)
     Returns the number of leading 0-bits in X, starting at the most
     significant bit position.  If X is 0, the result is undefined.

 -- Built-in Function: int __builtin_ctz (unsigned int x)
     Returns the number of trailing 0-bits in X, starting at the least
     significant bit position.  If X is 0, the result is undefined."

If that's not enough, then what would be?  I'm serious -- if you find it 
inadequate, then perhaps it could be improved.

> In contrast, the gcc builtins probably match some standard that is not 
> only harder to find, but also has some _other_ definition for what happens 
> for the zero case, so the builtins automatically end up having problems 
> due to semantic mis-match between the CPU and the standard.

 GCC should know the semantics of underlying CPU instructions used and be 
able to optimize expressions for common cases, e.g. like:

	return x == 0 ? 32 : __builtin_ctz(x);

when the CPU provides a "ctz" operation that returns 32 for 0.

> Basic rule: inline assembly is _better_ than random compiler extensions. 
> It's better to have _one_ well-documented extension that is very generic 
> than it is to have a thousand specialized extensions.

 It depends on how many submodel-specific variants of inline assembly you 
need, how many reloads are required for constraints, possibly defeating 
the gain, etc.

 In this particular case "bsf" and "bsr" are notoriously slow for some 
i386 submodels, so using the generic O(log n) algorithm may result in 
better performance for them.  E.g. the execution time for "bsf" for the 
original i386 is 11 + 3n clock ticks (n refers to the resulting bit 
index), "bsr" for the i486 is 7 - 104 ticks (so again 3n), for Pentium -- 
7 - 72 ticks (2n, then).  It does not immediately mean they are worse, but 
they are slow enough for the pessimistic case checking alternatives is not 
unreasonable.

  Maciej

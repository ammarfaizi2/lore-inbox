Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTDRDUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 23:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTDRDUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 23:20:23 -0400
Received: from science.horizon.com ([192.35.100.1]:16947 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262792AbTDRDUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 23:20:22 -0400
Date: 18 Apr 2003 03:32:13 -0000
Message-ID: <20030418033213.32695.qmail@science.horizon.com>
From: linux-kernel@horizon.com
To: 76306.1226@compuserve.com
Subject: Re: [PATCH] only use 48-bit lba when necessary
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
>> FYI, GCC as of 3.2.3 doesn't yet reduce the if(...) form to branchless
>> code but the & and && versions come out the same with -O2.

And Chuck Ebbert replied:
>   The operands of & can be evaluated in any order, while && requires
> left-to-right and does not evaluate the right operand if the left one
> is false.  Only the simplest cases could possibly generate the same
> code.

The code must execute AS IF the right operand is only evaluated if the left
operand is true.

If an optimizer can prove that evaluating an operand has no side effects
(which a halfway-decent optimizer can usually do for simple expressions),
then it is free to evaluate it in any way that will produce the same
result.

For example, if both operands of && have no side effects, then the compiler
is free to convert

if ( expensive() && cheap() ) {...}

into

if ( cheap() && expensive() ) {...}

although I expect most assume the programmer was sensible enough to
put the most commonly failed tests first.


The compiler is also free to do the same to

if ( !!cheap() & !!expensive() ) {...}

Again, it has to behave AS IF !!expensive() were evaluated in every
case, but if it can prove that there are no side effects, it can
skip expensive() entirely if there appears to be reason to do so.


The upshot of this is that, if the conditions have no side effects and
the compiler is decent, there should be NO DIFFERENCE in the compiled code.

Since it is only legal to convert between && and & if the right operand
has no side effects and does not depend on any side effects of the left
operand, the only time it makes sense to choose one over the other for
any reason but coding style is if A) the code is speed-critical, and B)
you know the conditions are met but you don't think the optimizer can
figure it out.

Which is pretty uncommon.


Regarding style, personally I'm used to C's zero/non-zero boolean tests
and prefer to write "while (p)" and "if (x & MASK)".  Using bare &
between such expressions is more difficult to read for two reasons:
A) the reader has to parse the "!!(...) " or "... != 0" clutter around
   each operand, and
B) the reader has to figure out that the "1 & 2" case never happens.

With |. that can often be avoided, but not with pointer operands.

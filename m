Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUFZS7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUFZS7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUFZS7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:59:14 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:31671 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266333AbUFZS7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:59:10 -0400
Subject: Re: [PATCH] Fix the cpumask rewrite
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> 
	<Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
	<1088268405.1942.25.camel@mulgrave> 
	<Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
	<1088270298.1942.40.camel@mulgrave> 
	<Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Jun 2004 13:59:02 -0500
Message-Id: <1088276343.1750.105.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 13:01, Linus Torvalds wrote:
> So?
> 
> You're ignoring my point. 

You're making 3 points, I think

1) Volatility is a property of the code path, not the data, which I
agree with.

2) the bit operators need to operate on volatile data (i.e. need a
volatile in their prototypes) without gcc issuing a qualifier dropped
warning.

This I disagree with because we have no volatile data currently in the
kernel that necessitates this behavour.

3) The parisc bit operator implementations as inline functions need to
have volatile data in their function templates because otherwise gcc
will not implement them correctly and may optimise them away when it
shouldn't.

I disagree with this too...although I'm on shakier ground, and I'd
prefer gcc experts quantify why this happens, but if, on parisc, I look
at the assembly output of your example

        while (test_and_set_bit(xxx, field))
                while (test_bit(xx, field)) /* Nothing */;

I find it to be coded exactly correctly.  Even without using a volatile
pointer in our test_and_set_bit() and test_bit() implementations, the
compiler still does both checks in the loop.

So my contention is that even without the volatile pointers in our
implementation, we still correctly treat this code path as having
volatile (i.e. we test the bits each time around the loop).  All the
addition of the volatile to the cpumask patch does is cause us to emit
spurious warnings.

> And in this case, test_bit() has the "I must re-load this value" rule for 
> historical reasons. 

Right, I agree exactly with this.  However, empirically we do do this,
even without having to declare the data as volatile.

> AND PA-RISC IS WRONG IF IT DOESN'T FOLLOW THE RULES!

I belive we do follow the rules.

> Final note: I might be willing to just change the rules, if people can 
> show that no paths that might need the volatile behaviour exist any more. 
> They definitely used to exist, though, and that's a BIG decision to make.

Actually, I don't want to change the rules, I just want parisc to be
able to implement them without being forced to have a performance
killing volatile in its implementation functions.

James



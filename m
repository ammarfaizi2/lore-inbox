Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUAVGDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 01:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUAVGDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 01:03:05 -0500
Received: from are.twiddle.net ([64.81.246.98]:63382 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S264372AbUAVGDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 01:03:01 -0500
Date: Wed, 21 Jan 2004 22:02:53 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Valdis.Kletnieks@vt.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@twiddle.net>
Subject: Re: 2.6.1-mm5 versus gcc 3.5 snapshot
Message-ID: <20040122060253.GA18719@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Valdis.Kletnieks@vt.edu,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401212236.i0LMaNuh020491@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401212043200.2123@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401212043200.2123@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 08:51:14PM -0800, Linus Torvalds wrote:
> > include/asm/rwsem.h:126: warning: read-write constraint does not allow
> > a register
> 
> To me that says "compiler on crack". I don't see why a register couldn't 
> be rw. After all, it clearly can be read, and written to, and gcc does 
> explicitly mention the '&' modifier in the documentation.
> 
> But maybe Richard has some input on what has happened, and can explain the 
> compiler side of it.. Richard?

You're reading that wrong way-round.  It's "+m" and "=m"/"0" that's
disallowed.  I.e. if you have matching constraints (or read-write
constrants, which are exactly short-hand for matching constraints),
then you *must* have a register alternative.  I.e. you'll get this
warning if you *only* allow memories.

The problem is partially conceptual -- what in the world does

	"=m"(x) : "0"(y)

mean?  Logically, this makes no sense.  The only way it can be resolved
is to create a new memory, copy y in, and copy x out.  But that violates
the lvalue promises we've made that make memory constraints useful for
atomic operations.

Partially it's implementation -- if you write

	"=m"(x) : "0"(x)

it *requires* that the optimizer be run and that it *must* identify the
common sub-expression.  Failure to do so means that the compiler has to
assume we have the x/y situation above, which of course results in a
diagnostic.

Obviously such a computational requirement is impossible with arbitrarily
complex expressions, so that begs the question of "how complex is too
complex".  Drawing an arbitrary line that you can explain to users is
impossible.  It is easier to simply disallow it entirely.

Finally, the whole thing is pointless.  Given the lvalue semantics, you
get *exactly* the same effect from

	"=m"(x) : "m"(x)

Since this works for any version of gcc, at any optimization level,
on any arbitrarily complex expression, we strongly recommend (ahem)
that code be modified to use this form.


r~

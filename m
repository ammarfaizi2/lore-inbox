Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266342AbUFZSBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266342AbUFZSBh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266350AbUFZSBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:01:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:57285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266342AbUFZSBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 14:01:21 -0400
Date: Sat, 26 Jun 2004 11:01:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <1088270298.1942.40.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave>  <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
 <1088268405.1942.25.camel@mulgrave>  <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
 <1088270298.1942.40.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, James Bottomley wrote:
> 
> But in the current kernel, there are no bitops on volatile data in the
> parisc tree.  This cpumask is the first such one that we've come
> across...

So?

You're ignoring my point. 

I'm saying that data structures ARE NOT VOLATILE. I personally believe 
that the notion of a "volatile" data structure is complete and utter shit.

But _code_ can act "with volatility". For bitops, it's just another way of 
saying "people may use this function without locking", because it's 
totally valid to use "test_bit()" to actually implement a lock.

So the rule has always been (and this has nothing to do with parisc, and 
parisc DOES NOT GET TO SET THE RULES!) that "test_bit()" acts in a 
volatile manner, and that you traditionally could write

	while (test_and_set_bit(xxx, field))
		while (test_bit(xx, field)) /* Nothing */;

to do a lock.

NOTE! There are no volatile data structures _anywhere_, because as
mentioned, I think that whole notion is a total piece of crap, and is not
even a well-defined part of the C language. But the test_bit() function
has to act as if the data it is passed down can change. To repeat:  
_codepaths_ may have volatility attributes depending on usage of the data.

Now, we generally discouage this kind of hand-written locking code, and we
these days have a "bit_spin_lock()" helper function to do the above (which
also has the appropriate "cpu_relax()" in place), but the point is that
this code has existed, and test_bit() HAS TO FOLLOW THE RULES. Even on
pa-risc.

I repeat: this has NOTHING to do with "volatile data structures". The
kernel does not belive in that notion, and you generally have to use locks
to make sure that all accesses are serialized.

But sometimes non-locked accesses are ok. test_bit() historically is very
much one of those things. A classic example of this is how something like
bh->b_flags is not marked volatile (some fields of it require explicit
locking rules), but it's ok to check for certain bits of it asynchronously
without having locked the bh.

See? 

 - CODE can be volatile ("I must re-load this value").
 - DATA has access rules ("this value should only be changed with write
   lock xxx held").

And in this case, test_bit() has the "I must re-load this value" rule for 
historical reasons. 

AND PA-RISC IS WRONG IF IT DOESN'T FOLLOW THE RULES!

Final note: I might be willing to just change the rules, if people can 
show that no paths that might need the volatile behaviour exist any more. 
They definitely used to exist, though, and that's a BIG decision to make.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUAFSCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUAFSCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:02:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:25516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264893AbUAFSCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:02:38 -0500
Date: Tue, 6 Jan 2004 10:02:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>, johnstul@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
In-Reply-To: <Pine.LNX.4.53.0401061807070.9108@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.58.0401060945090.9166@home.osdl.org>
References: <1073405053.2047.28.camel@mulgrave> <20040106081947.3d51a1d5.akpm@osdl.org>
 <Pine.LNX.4.58.0401060826570.2653@home.osdl.org>
 <Pine.LNX.4.53.0401061807070.9108@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ This is a big rant against using "volatile" on data structures. Feel 
  free to ignore it, but the fact is, I'm right. You should never EVER use
  "volatile" on a data structure. ]

On Tue, 6 Jan 2004, Tim Schmielau wrote:
> 
> We then need to make jiffies_64 volatile, since we violate the rule to 
> never read it.

No, we should _never_ make anything volatile. There just isn't any reason 
to. The compiler will never do any "better" with a volatile, it will only 
ever do worse.

If there are memory ordering constraints etc, the compiler won't be able 
to handle them anyway, and volatile will be a no-op. That's why we have 
"barrier()" and "mb()" and friends.

The _only_ acceptable use of "volatile" is basically:

 - in _code_ (not data structures), where we might mark a place as making 
   a special type of access. For example, in the PCI MMIO read functions, 
   rather than use inline assembly to force the particular access (which
   would work equally well), we can force the pointer to a volatile type.

   Similarly, we force this for "test_bit()" macros etc, because they are 
   documented to work on SMP-safe. But it's the _code_ that works that 
   way, not the data structures.

   And this is an important distinctions: there are specific pieces of 
   _code_ that may be SMP-safe (for whatever reasons the writer thinks). 
   Data structures themselves are never SMP safe.

   Ergo: never mark data structures "volatile". It's a sure sign of a bug 
   if the thing isn't a memory-mapped IO register (and even then it's 
   likely a bug, since you really should be using the proper functions).

   (Some driver writers use "volatile" for mailboxes that are updated by
   DMA from the hardware. It _can_ be correct there, but the fact is, you 
   might as well put the "volatile" in the code just out of principle).

That said, the "sure sign of a bug" case has one specific sub-case:

 - to paste over bugs that you really don't tink are worth fixing any 
   other way. This is why "jiffies" itself is declared volatile: just to 
   let people write code that does "while (time_before(xxx, jiffies))".

But the "jiffies" case is safe only _exactly_ because it's an atomic read. 
You always get a valid value - so it's actually "safe" to mark jiffies as 
baing volatile. It allows people to be sloppy (bad), but at least it 
allows people to be sloppy in a safe way.

In contrast, "jiffies_64" is _not_ an area where you can safely let the 
compiler read a unstable value, so "volatile" is fundamentally wrong for 
it. You need to have some locking, or to explicitly say "we don't care in 
this case", and in both cases it would be wrong to call the thing 
"volatile". With locking, it _isn't_ volatile, and with "we don't care", 
it had better not make any difference. In either case the "volatile" is 
wrong.

We had absolutely _tons_ of bugs in the original networking code, where 
clueless people thougth that "volatile" somehow means that you don't need 
locking. EVERY SINGLE CASE, and I mean EVERY ONE, was a bug.

There are some other cases where the "volatile" keyword is fine, notably
inline asm has a specific meaning that is pretty well-defined and very
useful. But in all other cases I'd suggest having the volatile be part of 
the code, possibly with an explanation _why_ it is ok to use volatile 
there unless it is obvious.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266494AbUFZWsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUFZWsr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUFZWsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:48:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266494AbUFZWsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:48:41 -0400
Date: Sat, 26 Jun 2004 15:48:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <20040626221802.GA12296@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
 <20040626221802.GA12296@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, Chris Wedgwood wrote:
> 
> I recently had to change jiffies_64 (include/linux/jiffies.h) to be
> volatile as gcc produced code that didn't work as a result of it.

"jiffies" is one of the few things that I accept as volatile, since it's 
basically read-only and accessed directly and has no internal structure 
(ie it's a single word).

However, "jiffies_64" should _not_ be accessed directly. Anything that 
does so is likely buggy.

But for most data structures, the way to control access is either with 
proper locking (at which point they aren't volatile any more) or through 
proper accessor functions (ie "jiffies_64" should generally only be 
accessed with something that understands about low/high word and update 
ordering and re-testing).

And once you do that proper access function, you should put the volatile 
_there_ - since THAT is the place that understands what the access 
requireemnts are, not the compiler.

I repeat: it is the _code_ that knows about volatile rules, not the data
structure.

> Clearly in some cases gcc does know about volatile and does produce
> 'the right thing' --- I don't really see why people claim volatile is
> a bad thing, there are clearly places where we need this and gcc seems
> to do the right thing.

See above. There are basically _no_ places where the compiler can do the 
right thing except by pure luck. "Programming-by-luck" may work, but it's 
not a good idea.

So please tell me where the jiffies64 thing was suddenly correct as a 
"volatile", and I can almost guarantee you that you were WRONG to mark it 
volatile. It may work 99% of the time, but since the only correct way to 
access jiffies_64 is either:

 - knowing that you are the person that updates it (under xtime_lock),
   thus making it non-volatile
 - using "get_jiffies_64()", using the proper seq_begin() etc.

But you're right, on a 64-bit architecture, jiffies_64 falls back to the
"jiffies" case, and there it would be acceptable to make it volatile. Bit 
since it had better be accessed with "get_jiffies_64()" anyway, you're 
much better off putting the volatile THERE, and not cause problems for 
code generation in the places that don't need it.

See? The volatile is (again) wrong on the data structure (jiffies_64), and
you should have added it to the code (get_jiffies_64).

		Linus

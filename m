Return-Path: <linux-kernel-owner+willy=40w.ods.org-S290330AbUKAXy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S290330AbUKAXy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUKAXrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:47:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:52398 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S290355AbUKAXmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 18:42:17 -0500
Date: Mon, 1 Nov 2004 15:42:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0411011756470.27540@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0411011531100.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
 <41826A7E.6020801@domdv.de> <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
 <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0411011651580.26464@chaos.analogic.com>
 <Pine.LNX.4.58.0411011424110.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0411011756470.27540@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Nov 2004, linux-os wrote:
> 
> No. You've just shown that you like to argue. I recall that you
> recently, like within the past 24 hours, supplied a patch that
> got rid of the time-consuming stack operations in your semaphore
> code. Remember, you changed it to pass parameters in registers.

... because that fixed a _bug_.

> Why would you bother if stack operations are free?

I didn't say that instructions are free. I just tried (unsuccessfully) to 
tell you that "lea" is not free either, and that "lea" has some serious 
problems on several setups, ranging from old cpu's (AGI stalls) to new 
CPU's (stack engine stalls). And that "pop" is often faster.

And you have been arguing against it despite the fact that I ended up 
writing a small test-program to show that it's true. It's a _stupid_ 
test-program, but the fact is, you only need a single test-case to prove 
some theory wrong.

Your theory that "lea" is somehow always cheaper than "pop" is wrong. 

> It's not a total focus. It's just necessary emphasis. Any work
> done by your computer, ultimately comes from and goes to memory.

Not so.

A lot of work is done in cache. Any access that doesn't change the state
of the cache is a no-op as far as the memory bus is concerned. Ie a store
to a cacheline that is already dirty is just a cache access, as is a load
from a cacheline that is already loaded.

This is especially true on x86 CPU's, where the lack of registers means 
that the core has been highly optimized for doing cached operations. 
Remember: a CPU is not some kind of abstract entity - it's a very 
practical piece of engineering that has been highly optimized for certain 
usage patterns.

And the fact is, "lea" on %esp is not a common usage pattern. Which is 
why, in practice, you will find CPU's that end up not optimizing for it. 
While "pop"+"pop" is a _very_ common pattern, and why existing CPU's 
do them efficiently.

		Linus

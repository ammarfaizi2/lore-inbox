Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWGFQII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWGFQII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWGFQII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:08:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030226AbWGFQIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:08:06 -0400
Date: Thu, 6 Jul 2006 09:07:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, linux-os (Dick Johnson) wrote:
> 
> Then GCC must be fixed. The keyword volatile is correct. It should
> force the compiler to read the variable every time it's used.

No.

"volatile" really _is_ misdesigned. The semantics of it are so unclear as 
to be totally useless. The only thing "volatile" can ever do is generate 
worse code, WITH NO UPSIDES.

Historically (and from the standpoint of the C standard), the definition 
of "volatile" is that any access is "visible" in the machine, and it 
really kind of makes sense for hardware accesses, except these days 
hardware accesses have other rules that are _not_ covered by "volatile", 
so you can't actually use them for that.

And for accesses that have some software rules (ie not IO devices etc), 
the rules for "volatile" are too vague to be useful. 

So if you actually have rules about how to access a particular piece of 
memory, just make those rules _explicit_. Use the real rules. Not 
volatile, because volatile will always do the wrong thing.

Also, more importantly, "volatile" is on the wrong _part_ of the whole 
system. In C, it's "data" that is volatile, but that is insane. Data 
isn't volatile - _accesses_ are volatile. So it may make sense to say 
"make this particular _access_ be careful", but not "make all accesses to 
this data use some random strategy".

So the only thing "volatile" is potentially useful for is:

 - actual accessor functions can use it in a _cast_ to make one particular 
   access follow the rules of "don't cache this one dereference". That is 
   useful as part of a _bigger_ set of rules about that access (ie it 
   might be the internal implementation of a "readb()", for example).

 - for "random number generation" data locations, where you literally 
   don't _have_ any rules except "it's a random number". The only really 
   valid example of this is the "jiffy" timer tick.

Any other use of "volatile" is almost certainly a bug, or just useless. 

It's a bug if the volatile means that you don't follow the proper protocol 
for accessing the data, and it's useless (and generally generates worse 
code) if you already do.

So just say NO! to volatile except under the above circumstances.

			Linus

Return-Path: <linux-kernel-owner+w=401wt.eu-S964891AbWLMBtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWLMBtb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWLMBtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:49:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39312 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964885AbWLMBta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:49:30 -0500
X-Greylist: delayed 740 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:49:30 EST
Date: Tue, 12 Dec 2006 17:36:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, davem@davemloft.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an atomic-bitops
 safe assignment
In-Reply-To: <20061212225443.GA25902@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612121726150.3535@woody.osdl.org>
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
 <20061212225443.GA25902@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2006, Russell King wrote:
> 
> This seems to be a very silly question (and I'm bound to be utterly
> wrong as proven in my last round) but why are we implementing a new
> set of atomic primitives which effectively do the same thing as our
> existing set?
> 
> Why can't we just use atomic_t for this?

Well, others have answered that ("wrong sizes"), but I'm wavering on using 
atomic_long_t. I have to admit that I'd rather not add a new accessor 
function, when it _should_ be easier to use the current ones.

That does depend on every arch maintainer saying they're ok with mixing 
bitops and "atomic*_t"s. It would also require us to at least add some 
_minimal_ function to get at the actual value, and turn the pointer into a 
"unsigned long *" for the bitop functions.

I would _hope_ that people hopefully already use the same locking for 
atomic_t and for bitops, and that arch maintainers could just say "sure, 
that works for me". Obvously, anybody with LL/SC or otherwise just 
basically atomic bitops (which covers a fair part of the spectrum) should 
be ok, but sparc and the usual cast of suspects would have to say that 
it's ok.

Should we also just make the rule be that the architecture _must_ allow 
the silly

	(atomic_long_t *) -> (unsigned long *)

casting (so that we can make _one_ generic inline function that takes an 
atomic_long_t and returns the same pointer as an "unsigned long *" to make 
bitop functions happy), or would this have to be another arch-specific 
function?

Comments? 

			Linus

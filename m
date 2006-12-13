Return-Path: <linux-kernel-owner+w=401wt.eu-S964889AbWLMCIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWLMCIX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWLMCIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:08:22 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:28014 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964889AbWLMCIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:08:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Jl+mnjZZhISOCJ2js5MYTf50hJLDjw6GDIiLZvPUhljqL9XZte9FvQkH2facvdNV7iUBBVmQ0VAPZEgUIsb9gfX2+cfg8Fk3g16J3dk5U+FIzNeIYRJHw7Es2TRo5mhhORgnJnWH5Vv4TNrrBmCwBmUv/Qnf2L7Ragp70jkTyCY=  ;
X-YMail-OSG: 8PJ1SKwVM1lKUs3B8sVIn5tfEF9J1HPq9BSQUcwITqBqx7rL.g8uhBrxpN.qehs0b.VNP4.GjGRoQLx62tlkQmUroYw3p67JIp0OrrS0dc3iH0TWd3Y_ZA--
Message-ID: <457F606B.70805@yahoo.com.au>
Date: Wed, 13 Dec 2006 13:07:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org, davem@davemloft.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an atomic-bitops
 safe assignment
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com> <20061212225443.GA25902@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612121726150.3535@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612121726150.3535@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 12 Dec 2006, Russell King wrote:
> 
>>This seems to be a very silly question (and I'm bound to be utterly
>>wrong as proven in my last round) but why are we implementing a new
>>set of atomic primitives which effectively do the same thing as our
>>existing set?
>>
>>Why can't we just use atomic_t for this?
> 
> 
> Well, others have answered that ("wrong sizes"), but I'm wavering on using 
> atomic_long_t. I have to admit that I'd rather not add a new accessor 
> function, when it _should_ be easier to use the current ones.

I agree.

> That does depend on every arch maintainer saying they're ok with mixing 
> bitops and "atomic*_t"s. It would also require us to at least add some 
> _minimal_ function to get at the actual value, and turn the pointer into a 
> "unsigned long *" for the bitop functions.
> 
> I would _hope_ that people hopefully already use the same locking for 
> atomic_t and for bitops, and that arch maintainers could just say "sure, 
> that works for me". Obvously, anybody with LL/SC or otherwise just 
> basically atomic bitops (which covers a fair part of the spectrum) should 
> be ok, but sparc and the usual cast of suspects would have to say that 
> it's ok.

parisc seems to, but sparc uses its own open coded spinlock for bitops, and
the array of regular spinlocks for atomic ops. OTOH, consolidating them
might give more scalable code *and* a smaller cacheline footprint?

> Should we also just make the rule be that the architecture _must_ allow 
> the silly
> 
> 	(atomic_long_t *) -> (unsigned long *)
> 
> casting (so that we can make _one_ generic inline function that takes an 
> atomic_long_t and returns the same pointer as an "unsigned long *" to make 
> bitop functions happy), or would this have to be another arch-specific 
> function?
> 
> Comments? 

AFAIK no architecture does anything special, so maybe a generic converter
would be best, until one comes along that does. (the only thing of note
really is that half of the atomics use volatile types and half don't, is
that a problem?).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+w=401wt.eu-S1762636AbWLKHhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762636AbWLKHhJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 02:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762640AbWLKHhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 02:37:08 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:38975 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762636AbWLKHhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 02:37:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QZR4AHOpWYgNbY5cbtOv2m/h9iAce9vZj4mB3+hZLF9MGRLTCIcGOwCus3pzbj/8na6HJwrtpGxrhFAPDHnjbTXAzUn5aVpVHs6VyBLh5glFPmUfw/GofqCO60Xm4ql9oYVtN3ct4o5e57VosimH9fjo3ED5DSmaaYvcAIIOi3k=  ;
X-YMail-OSG: 6D1i9tkVM1lYKwlaffOCzfUvFsv0TMv267xc3bZ6LNNL8r0EKZdRGGLg1YvejUrgT39BG2Cn7CP5CZrOQXvvGXNqfHZx7POuEni09lJ6j.rd00LoyBhksB8mQKugid2Iz_I9EJAZn86xd1rftKx3.PkO.A6N5viFa4QTtFJdBjKcJXn2LnC2TagQVq_D
Message-ID: <457D0A6A.1090806@yahoo.com.au>
Date: Mon, 11 Dec 2006 18:36:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux@horizon.com
CC: linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an
References: <20061211061751.22553.qmail@science.horizon.com>
In-Reply-To: <20061211061751.22553.qmail@science.horizon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
>> atomic_ll() / atomic_sc() with the restriction that they cannot be
>> nested, you cannot write any C code between them, and may only call
>> into some specific set of atomic_llsc_xxx primitives, operating on
>> the address given to ll, and must not have more than a given number
>> of instructions between them. Also, the atomic_sc won't always fail
>> if there were interleaving stores.
> 
> 
> I'm not entirely sure what you're talking about.  You generally want

I'm talking about what a generic API (which you were proposing) would
look like.

> to keep the amount of code between ll and sc to an absolute minimum
> to avoid interference which causes livelock.  Processor timeouts
> are generally much longer than any reasonable code sequence.

"Generally" does not mean you can just ignore it and hope the C compiler
does the right thing. Nor is it enough for just SOME of the architectures
to have the properties you require.

> I hear you and Linus say that loads and stores are not allowed.
> I'm trying to find that documented somewhere.  Let's see... Wikipedia
> says that LL/SC is implemented on Alpha, MIPS, PowerPC, and ARM.

Ralf tells us that MIPS cannot execute any loads, stores, or sync
instructions on MIPS. Ivan says no loads, stores, taken branches etc
on Alpha.

MIPS also has a limit of 2048 bytes between the ll and sc.

So you almost definitely cannot have gcc generated assembly between. I
think we agree on that much. So what remains is for you to propose your
API.

> Okay, so Alpha is the special case; write those primitives directly
> in asm.  It's still possible to get three out of four.

Yes, but the code *between* the time you call atomic_ll and atomic_sc
has to be performed in arch calls as well. Ie. you cannot write:

    do {
      val = atomic_ll(&A);
      if (val == blah) {
        ...
    } while (!atomic_sc(&A, newval));

AFAIKS, you cannot even write:

   do {
     val = atomic_ll(&A);
     val++;
   } while(!atomic_sc(&A, val));

Is the do {} while loop itself even safe? I'm not sure, I don't think
we could guarantee it.

On the other hand, atomic_cmpxchg can be used in arbitrary C code, and
has no restrictions on use whatsoever.

> In truth, however, realizing that we're only talking about three
> architectures (wo of which have 32 & 64-bit versions) it's probably not
> worth it.  If there were five, it would probably be a savings, but 3x
> code duplication of some small, well-defined primitives is a fair price
> to pay for avoiding another layer of abstraction (a.k.a. obfuscation).
> 
> And it lets you optimize them better.
> 
> I apologize for not having counted them before.

I disagree. It wouldn't be another layer of abstraction, it would be
an abstraction on pretty much the same level as the other atomic
primitives. What it would be is a bad abstraction if it leaked all
these architecture specific details into generic C code. But if you
can get around that...

I also disagree that the architectures don't matter. ARM and PPC are
pretty important, and I believe Linux on MIPS is growing too.

I also think it is really nice to be able to come up with an optimal
implementation over a wider range of architectures even if they are
relatively rare. It often implies that you have come up with a better
API[*].

One proposal that I could buy is an atomic_ll/sc API, which mapped
to a cmpxchg emulation even on those llsc architectures which had
any sort of restriction whatsoever. This could be used in regular C
code (eg. you indicate powerpc might be able to do this). But it may
also help cmpxchg architectures optimise their code, because the
load really wants to be a "load with intent to store" -- and is
IMO the biggest suboptimal aspect of current atomic_cmpxchg.

[*] Of course you can take this in the wrong direction. For example, the
2 which implement SMP atomic operations with spinlocks would often prefer
to use a spinlock in the data structure being modified than hashed off
the address of the atomic (much better locality of reference). But
doing this all over the kernel is idiotic.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

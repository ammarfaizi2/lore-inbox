Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTH2Tks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTH2Tks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:40:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13440 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261539AbTH2Tko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:40:44 -0400
Date: Fri, 29 Aug 2003 15:41:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: Antonio Vargas <wind@cocodriloo.com>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
In-Reply-To: <20030829184847.GA2069@werewolf.able.es>
Message-ID: <Pine.LNX.4.53.0308291517001.32044@chaos>
References: <20030828223511.GA23528@werewolf.able.es> <20030829152418.GB709@wind.cocodriloo.com>
 <20030829184847.GA2069@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003, J.A. Magallon wrote:

>
> On 08.29, Antonio Vargas wrote:
> > On Fri, Aug 29, 2003 at 12:35:11AM +0200, J.A. Magallon wrote:
> [...]
> > >
> > > A collateral question: why is the reason for this function ?
> > > long long assignments are not atomic in gcc ?
> >
> > On x86, long long int == 64 bits but the chip is 32 bits wide,
> > so it uses 2 separate memory accesses. There are 64bit-wide
> > instructions which do bus-locking so that the are atomic,
> > but gcc will not use them directly.
> >
>
> I know, my question was why gcc does not generate cmpxchg8b on
> a 64 bits assign. Or it should not ?
>

It's not an assignment operator. The fact that you 'could' use
it as one is not relevant. For instance, using XOR you can
exchange the values of two operands. However, you would not
really like a 'C' compiler to do that. Instead, you would
expect it to stash some invisible temporary variable some-
where, hopefully in a register. If you really want to
swap values using the ^ operator, then you can code it yourself.


Wana play?

int main()
{
    int a, b;
    a = 0xaaaaaaaa;
    b = 0xbbbbbbbb;
   printf("a = %08x b = %08x \n", a, b);
// Swap
   a ^= b;
   b ^= a;
   a ^= b;
   printf("a = %08x b = %08x \n", a, b);
    return 0;
}

The generated code is awful:

	movl -8(%ebp),%edx
	xorl %edx,-4(%ebp)
	movl -4(%ebp),%edx
	xorl %edx,-8(%ebp)
	movl -8(%ebp),%edx
	xorl %edx,-4(%ebp)
	movl -8(%ebp),%eax

gcc doesn't care that some xchg operations are atomic. If there
was an 'atomic_t' type that 'C' (generically) knew about, then
the code-generator might try to find some strange sequence that
would perform 64-bit atomic operations on a 32-bit processor as
a side-effect, which is what it is with the compare/exchange-8-bytes
opcode.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.



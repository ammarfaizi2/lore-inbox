Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbTH3I7d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 04:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbTH3I7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 04:59:33 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:40431
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S263043AbTH3I7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 04:59:30 -0400
Date: Sat, 30 Aug 2003 08:27:44 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Antonio Vargas <wind@cocodriloo.com>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Message-ID: <20030830062744.GE640@wind.cocodriloo.com>
References: <20030828223511.GA23528@werewolf.able.es> <20030829152418.GB709@wind.cocodriloo.com> <20030829184847.GA2069@werewolf.able.es> <Pine.LNX.4.53.0308291517001.32044@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308291517001.32044@chaos>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 03:41:32PM -0400, Richard B. Johnson wrote:
> On Fri, 29 Aug 2003, J.A. Magallon wrote:
> 
> >
> > On 08.29, Antonio Vargas wrote:
> > > On Fri, Aug 29, 2003 at 12:35:11AM +0200, J.A. Magallon wrote:
> > [...]
> > > >
> > > > A collateral question: why is the reason for this function ?
> > > > long long assignments are not atomic in gcc ?
> > >
> > > On x86, long long int == 64 bits but the chip is 32 bits wide,
> > > so it uses 2 separate memory accesses. There are 64bit-wide
> > > instructions which do bus-locking so that the are atomic,
> > > but gcc will not use them directly.
> > >
> >
> > I know, my question was why gcc does not generate cmpxchg8b on
> > a 64 bits assign. Or it should not ?
> >
> 
> It's not an assignment operator. The fact that you 'could' use
> it as one is not relevant. For instance, using XOR you can
> exchange the values of two operands. However, you would not
> really like a 'C' compiler to do that. Instead, you would
> expect it to stash some invisible temporary variable some-
> where, hopefully in a register. If you really want to
> swap values using the ^ operator, then you can code it yourself.
> 
> 
> Wana play?
> 
> int main()
> {
>     int a, b;
>     a = 0xaaaaaaaa;
>     b = 0xbbbbbbbb;
>    printf("a = %08x b = %08x \n", a, b);
> // Swap
>    a ^= b;
>    b ^= a;
>    a ^= b;
>    printf("a = %08x b = %08x \n", a, b);
>     return 0;
> }
> 
> The generated code is awful:
> 
> 	movl -8(%ebp),%edx
> 	xorl %edx,-4(%ebp)
> 	movl -4(%ebp),%edx
> 	xorl %edx,-8(%ebp)
> 	movl -8(%ebp),%edx
> 	xorl %edx,-4(%ebp)
> 	movl -8(%ebp),%eax
> 
> gcc doesn't care that some xchg operations are atomic. If there
> was an 'atomic_t' type that 'C' (generically) knew about, then
> the code-generator might try to find some strange sequence that
> would perform 64-bit atomic operations on a 32-bit processor as
> a side-effect, which is what it is with the compare/exchange-8-bytes
> opcode.
> 

That was my fault for introducing an exchange instruction
into an assignement discussion, but I don't know of any
x86 instruction which can load 64bits to memory atomically,
is there any???

Greets, Antonio.


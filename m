Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268361AbRGXRGm>; Tue, 24 Jul 2001 13:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268365AbRGXRG1>; Tue, 24 Jul 2001 13:06:27 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:9995 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268361AbRGXRF3>; Tue, 24 Jul 2001 13:05:29 -0400
Date: Tue, 24 Jul 2001 09:59:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Alexander Viro <viro@math.psu.edu>, Jonathan Lundell <jlundell@pobox.com>,
        Jan Hubicka <jh@suse.cz>, <linux-kernel@vger.kernel.org>,
        <user-mode-linux-user@lists.sourceforge.net>,
        Jeff Dike <jdike@karaya.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <XFMail.20010724095229.davidel@xmailserver.org>
Message-ID: <Pine.LNX.4.33.0107240949460.29448-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Tue, 24 Jul 2001, Davide Libenzi wrote:
>
> Look, you're not going to request any kind of black magic over that variable.
> You're simply telling the compiler the way it has to ( not ) optimize the code.

Ehh.

But it shouldn't optimize it that way _every_ time. You only want the
specific optimizations in specific places. Which is why you use
"barrier()" or volatile in the _code_, not the data declaration.

For example, if you're holding a lock that protects it or you otherwise
know that nothing is touching it at the same time, you do NOT want to have
the compiler generate bad code.

And trust me, "volatile" generates _bad_ code a lot more often than it
generates correct code.

Look at this:

	volatile int i;
	int j;

	int main()
	{
	        i++;
	        j++;
	}

turning into this:

	main:
	        movl i,%eax
	        incl %eax
	        movl %eax,i
	        incl j
	        ret

Now, ask yourself why? The two _should_ be the same. Both do a
read-modify-write cycle. But the fact is, that when you add "volatile" to
the register, it really tells gcc "Be afraid.  Be very afraid. This user
expects some random behaviour that is not actually covered by any
standard, so just don't ever use this variable for any optimizations, even
if they are obviously correct. That way he can't complain".

See? "volatile" is evil. It has _no_ standard semantics, which makes it
really hard to implement sanely for the compiler. It also means that the
compiler can change the semantics of what "volatile" means, without you
really being able to complain.

Also note how the "incl j" instruction is actually _better_ from a
"atomicity" standpoint than the "load+inc+store" instruction. In this
case, adding a "volatile" actually made the accesses to "i" be _less_
likely to be correct - you could have had an interrupt happen in between
that also updated "i", and got lost when we wrote the value back.

Moral of the story: don't use volatile. If you want to have a counter that
is updated in interrupts etc, use "atomic_t" or locking. "volatile" makes
things worse or better based on completely random criteria that don't
necessarily have anything to do with what you _want_ to do.

			Linus


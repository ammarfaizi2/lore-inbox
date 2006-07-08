Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWGHULU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWGHULU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWGHULU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:11:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030317AbWGHULT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:11:19 -0400
Date: Sat, 8 Jul 2006 13:11:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <acahalan@gmail.com>
cc: tglx@linutronix.de, joe.korty@ccur.com, linux-kernel@vger.kernel.org,
       linux-os@analogic.com, khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <787b0d920607081233w3e0e99a9n706ff510c3de458b@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607081256170.3869@g5.osdl.org>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com> 
 <20060708094556.GA13254@tsunami.ccur.com>  <1152354244.24611.312.camel@localhost.localdomain>
  <787b0d920607080849p322a6349g7a5fd98f78aa9f32@mail.gmail.com> 
 <1152383487.24611.337.camel@localhost.localdomain>
 <787b0d920607081233w3e0e99a9n706ff510c3de458b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jul 2006, Albert Cahalan wrote:
> > 
> > 1. The volatile implementation of gcc is correct. The standard does not
> > talk about busses, not even about SMP.
> 
> The standard need not. An implementation must deal
> with whatever odd hardware happens to be in use.

Not really.

The fact is, "volatile" simply doesn't inform the compiler enough about 
what the effect of an access could be under various different situations.

So the compiler really has no choice. It has to balance the fact that the 
standard requires it to do _something_ different, with the fact that 
there's really not a lot of information that the user gave, apart from the 
one bit of "it's volatile".

So the compiler really has no choice.

Btw, I think that the whole standard definition of "volatile" is pretty 
weak and useless. The standard could be improved, and a way to improve the 
definition of volatile would actually be to say something like

	"volatile" implies that the access to that entity can alias with 
	any other access.

That's actually a lot simpler for a compiler writer (a C compiler already 
has to know about the notion of data aliasing), and gives a lot more 
useful (and strict) semantics to the whole concept.

So to look at the previous example of

	extern int a;
	extern int volatile b;

	void testfn(void)
	{
		a++;
		b++;
	}

_my_ definition of "volatile" is actually totally unambiguous, and not 
just simpler than the current standard, it is also stronger. It would make 
it clearly invalid to read the value of "b" until the value of "a" has 
been written, because (by my definition), "b" may actually alias the value 
of "a", so you clearly cannot read "b" until "a" has been updated.

At the same time, there's no question that

	addl $1,a
	addl $1,b

is a clearly valid instruction sequence by my simpler definition of 
volatile. The fact that "b" can alias with itself is a tautology, and is 
true of normal variables too, so any combination of ops on one variable 
(any variable always aliases _itself_) is by definition clearly always 
valid on a "volatile" variable too, and thus a compiler that can do the 
combination of "load + increment + store" on a normal variable should 
always do so on a volatile one too.

In contrast, the current C standard definition of "volatile" is not only 
cumbersome and inconvenient, it's also badly defined when it comes to 
accesses to _other_ data, making it clearly less useful.

I personally think that my simpler definition of volatile is actually a 
perfectly valid implementation of the current definition of volatile, and 
I suggested it to some gcc people as a better way to handle "volatile" 
inside gcc while still being standards-conforming (ie the "can alias 
anything" thing is not just clearer and simpler, it's strictly a subset of 
what the C standard allows, meaning that I think you can adopt my 
definition _without_ breaking any old programs or standards).

But there really is no way to "fix" volatile. You will always invariably 
need other things too (inline assembly with "lock" prefixes etc) to 
actually create true lock primitives. The suggested "can alias anything" 
semantics just clarify what it means, and thus make it less ambiguous. It 
doesn't make it fundamentally more useful in general.

			Linus

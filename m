Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbRBHTej>; Thu, 8 Feb 2001 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130823AbRBHTeT>; Thu, 8 Feb 2001 14:34:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16256 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129626AbRBHTeL>; Thu, 8 Feb 2001 14:34:11 -0500
Date: Thu, 8 Feb 2001 14:32:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Wille Padnos <stephenwp@adelphia.net>
cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <3A82E27A.E718E175@adelphia.net>
Message-ID: <Pine.LNX.3.95.1010208135834.4529A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Stephen Wille Padnos wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Thu, 8 Feb 2001, Stephen Wille Padnos wrote:
> > 
> > > "Richard B. Johnson" wrote:
> > > [snip]
> > > > Another problem with 'volatile' has to do with pointers. When
> > > > it's possible for some object to be modified by some external
> > > > influence, we see:
> > > >
> > > >         volatile struct whatever *ptr;
> > > >
> > > > Now, it's unclear if gcc knows that we don't give a damn about
> > > > the address contained in 'ptr'. We know that it's not going to
> > > > change. What we are concerned with are the items within the
> > > > 'struct whatever'. From what I've seen, gcc just reloads the
> > > > pointer.
> > > >
> [snip]
> 
> > Yes. My point is that a lot of authors have declared just about everything
> > 'volatile' `grep volatile /usr/src/linux/drivers/net/*.c`, just to
> > be "safe". It's likely that there are many hundreds of thousands of
> > unneeded register-reloads because of this.
> > 
> > It might be useful for somebody who has a lot of time on his/her
> > hands to go through some of these drivers.
> 
> I would be willing to do this (on the slow boat - I don't have THAT much
> spare time :), but only if we can be sure that the gcc optimizer will
> correctly handle a normal pointer to volatile data.  Your experiences
> would seem to indicate that the optimizer needs fixing before much
> effort should be spent on this.
> 

Well the question for that is; "What compiler?". I'm currently
using egcs-2.91.66, one of the "approved" versions for compiling
the kernel. It treats all volatiles about the same:


volatile int i;
volatile int *p;
int volatile *q;
volatile int * volatile r;

void foo()
{
   while(*p == i) 
       ;
   while(*q == i) 
       ;
   while(*r == i) 
       ;
}
...makes :


	.file	"main.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl foo
	.type	 foo,@function
foo:
	pushl %ebp
	movl %esp,%ebp
	nop
	.align 4
.L2:
	movl p,%eax
	movl (%eax),%edx
	movl i,%eax
	cmpl %eax,%edx
	je .L4
	jmp .L3
	.align 4
.L4:
	jmp .L2
	.align 4
.L3:
	nop
	.align 4
.L5:
	movl q,%eax
	movl (%eax),%edx
	movl i,%eax
	cmpl %eax,%edx
	je .L7
	jmp .L6
	.align 4
.L7:
	jmp .L5
	.align 4
.L6:
	nop
	.align 4
.L8:
	movl r,%eax
	movl (%eax),%edx
	movl i,%eax
	cmpl %eax,%edx
	je .L10
	jmp .L9
	.align 4
.L10:
	jmp .L8
	.align 4
.L9:
.L1:
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 foo,.Lfe1-foo
	.comm	i,4,4
	.comm	p,4,4
	.comm	q,4,4
	.comm	r,4,4
	.ident	"GCC: (GNU) egcs-2.91.66 19990314 (egcs-1.1.2 release)"


Since there seems to be a rather big difference between what is
expected to be done, and what happens to be the result, this
certainly contributes to the possible over-use of 'volatile' in
some kernel code. 

It's certainly better to be safe than sorry, but in some cases "safe"
is just a bit "strange". FYI, ../linux/drivers/net/atp.c doesn't use
'volatile' at all. However, ../linux/drivers/net/bmac.c uses it 40
times. I'll bet a buck that both of the drivers work and the one
without 'volatile' keywords does the work with fewer instructions.

These are just two drivers chosen at random. The driver I've been
working on to make  'bullet proof', pcnet32.c uses 'volatile' twice.
And, at least in one occasion, the wrong thing is declared volatile
(the value in a pointer to a structure ), however gcc doesn't seem
to care because it reloads the values of the structure members every time,
anyway. So, in this case, the address-value in the pointer will never
change, but gcc reloads all the pointed-to members anyway, so the
'volatile' keyword not useful.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbUCJNVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 08:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUCJNVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 08:21:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24711 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262605AbUCJNU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 08:20:56 -0500
Date: Wed, 10 Mar 2004 08:21:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jaco Kroon <jkroon@cs.up.ac.za>
cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stack allocation and gcc
In-Reply-To: <404F104C.2030206@cs.up.ac.za>
Message-ID: <Pine.LNX.4.53.0403100806570.15421@chaos>
References: <404F09C6.7030200@softhome.net> <404F104C.2030206@cs.up.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The caller expects that the space for the second set of local
variables in the second program unit is not allocated until the
program unit is entered.

I don't know why he would expect this behavior. Certainly
the space for the local variables in the first program unit
is allocated at compile-time. I don't know why he would
expect that the variables in the second or subsequent
program units would be handled any differently.

I have seen this misconception before. If the caller needs
to dynamically allocate local space, dependent upon condition,
he should do something like this:

foo(....)
{
    size_t len;
    char buf0[SOME_SIZE];
    len = strlen(buf0) + 1;
    {
        buf1[len];		// Second program unit buffer

    }

This ends up being coded as a simple subtraction from the stack-
pointer to allocate the new space in the new program unit.

In general, the allocation for all local variables is done
at compile-time and the allocation for all globals is done
at link-time. In this context, 'allocation' means calculation
of offsets and displacements, not the allocation and relocation
that occurs when a program is executed.


On Wed, 10 Mar 2004, Jaco Kroon wrote:

> Hi Ihar,
>
> In your code you have 3 buffers, one in the mani branch of 32 bytes and
> one of 32 bytes in each of the sub branches.  This adds up to a total of
> 64 bytes since as you say, the two buffers named buf2[32] can be
> shared.  Thus it is 32 bytes for buf and 32 bytes for the shared
> buffer.  Now if you look at the function startup code:
>
>    0:   55                      push   %ebp
>    1:   89 e5                   mov    %esp,%ebp
>    3:   83 ec 68                sub    $0x68,%esp
>
> THe push saves the frame pointer (ebp).  The mov sets up the new stack
> frame and the sub allocates space of 68 bytes on the stack, 4 bytes more
> than the expected 64, this is probably for temporary storage required
> somewhere in the function.  As such, gcc does not allocate 32 bytes too
> many (at least not on i386, but probably not on other architectures either).
>
> Jaco
>
> Ihar 'Philips' Filipau wrote:
>
> > Hello All!
> >
> >    [ please cc: me ]
> >
> >    I have observed funny behaviour of both gcc 2.95/322 on ppc32 and
> > i686 platforms.
> >
> >    Have written this routine and compiled it with 'gcc -O2':
> >
> > int a(int v)
> > {
> >         char buf[32];
> >
> >         if (v > 5) {
> >                 char buf2[32];
> >                 printf( buf, buf2 );
> >         } else {
> >                 char buf2[32];
> >                 printf( buf, buf2 );
> >         }
> >         return 1;
> > }
> >
> >    I expected that stack on every branch of 'if(v>5)' will be
> > allocated later - but seems that gcc allocate stack space once and in
> > this case it will 'overallocate' 32 bytes - 'char buf2' will be
> > allocated twice for every branch. On i686 gcc allocates 108 bytes, on
> > ppc32 it allocates 116 bytes. (additional space seems to be induced by
> > printf() call)
> >    Adding to this routine something like 'do { char a[32]; }
> > while(0);' several times shows that stack buffers are not reused - and
> > allocated for every this kind of context separately.
> >
> >    As to my understanding - since this buffers do live in different
> > mutually exclusive contextes - they can be reused. But this seems to
> > be not case. Waste of precious kernel stack space - and waste of d-cache.
> >
> >    I have read 'info gcc' - but found nothing relevant to this.
> >    I've checked ppc abi - but found no limitations to reuse of stack
> > space.
> >
> >    Is it expected behaviour of compiler? gcc feature?
> >
> >    [ I have created macro which opens into inline function call which
> > utilizes va_list - on ppc32 va_list adds at least 32 bytes to stack
> > use. Seems to be bad idea for kernel-space, since every use if macro
> > adds to stack use (10 macro calls == 320 bytes). Easy to rewrite to
> > not to use va_list - but have I *NO* stack allocation check script in
> > place - this stuff could easily get into production release. Not nice. ]
> >
> >    disassembling outputs:
> >
> ===========================================
> This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
> Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
> ===========================================
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267878AbTBYQFi>; Tue, 25 Feb 2003 11:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268011AbTBYQFi>; Tue, 25 Feb 2003 11:05:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31108 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267878AbTBYQFe>; Tue, 25 Feb 2003 11:05:34 -0500
Date: Tue, 25 Feb 2003 11:17:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andreas Schwab <schwab@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <Pine.LNX.4.44.0302250712110.10210-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.95.1030225105753.18866A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Linus Torvalds wrote:

> 
> On Tue, 25 Feb 2003, Andreas Schwab wrote:
> > |> 
> > |> The point is that the compiler should see that the run-time value of i is 
> > |> _obviously_never_negative_ and as such the warning is total and utter 
> > |> crap.
> > 
> > This requires a complete analysis of the loop body, which means that the
> > warning must be moved down from the front end (the common type of the
> > operands only depends on the type of the operands, not of any current
> > value of the expressions).
> 
> So? Gcc does that anyway. _Any_ good compiler has to.
> 
> And if the compiler isn't good enough to do it, then the compiler 
> shouldn't be warning about something that it hasn't got a clue about.
> 
> > |>    and anybody who writes 'array[5UL]' is considered a stupid git and a 
> > |>    geek. Face it.
> > 
> > But array[-1] is wrong.  An array can never have a negative index (I'm
> > *not* talking about pointers).
> 
> You're wrong.
> 
> Yes, when declaring an array, you cannot use "array[-1]". But that's not 
> because the thing is unsigned: the standard says that the array 
> declaration has to be a "integer value larger than zero". It is not 
> unsigned: it's _positive_.
> 
> However, in _indexing_ an array (as opposed to declaring it), "array[-1]" 
> is indeed perfectly fine, and is defined by the C language to be exactly 
> the same as "*(array-1)". And negative values are perfectly fine, even for 
> arrays. Trivial example:
> 
> 	int x[2][2];
> 
> 	int main(int argc, char **argv)
> 	{
> 		return x[1][-1];
> 	}
> 
> 
> the above is actually a well-defined C program, and 100%
> standards-conforming ("strictly conforming").
> 
> 		Linus
> 

I'm glad you tackled that. I was going to write a response, but
backed off because I'm getting meek in my old age. I do wish to
add that, even in ix86 assembly language, indexing by using a
register and a memory oprand is a signed displacement, i.e,

here:	.byte	0
foo:	.byte	0

        movl	$0xffffffff, %ebx
	movl	foo,(%ebx), %eax

... accesses a memory location one byte before label foo, i.e.,
foo[-1] or here[0].  This means that with a N-bit addressing,
indexed addressing cannot access more than 2^(N-1) memory locations.

Something to consider when trying to access large arrays. For
instance, if an operating system were to allow flat-mode access from
0x00000000 to 0xffffffff memory addresses in 32-bit user-mode, could
you actually use all that address space in 'C'? 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.



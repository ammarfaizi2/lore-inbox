Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272702AbSISTdR>; Thu, 19 Sep 2002 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272778AbSISTdR>; Thu, 19 Sep 2002 15:33:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18818 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272702AbSISTdP>; Thu, 19 Sep 2002 15:33:15 -0400
Date: Thu, 19 Sep 2002 15:40:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Richard Henderson <rth@twiddle.net>
cc: Brian Gerst <bgerst@didntduck.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
In-Reply-To: <20020919115747.A22594@twiddle.net>
Message-ID: <Pine.LNX.3.95.1020919152301.15882B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Richard Henderson wrote:

> On Thu, Sep 19, 2002 at 02:51:44PM -0400, Brian Gerst wrote:
> > > The parameter area belongs to the callee, and it may *always* be modified.
> > 
> > The parameters can not be modified if they are declared const though, 
> > that's my point.
> 
> Yes they can.
> 
> 	extern void bar(int x, int y, int z);
> 	void foo(const int a, const int b, const int c)
> 	{
> 	  bar(a+1, b+1, c+1);
> 	}
> 
>         subl    $12, %esp
>         movl    20(%esp), %eax
>         incl    %eax
>         movl    %eax, 20(%esp)
>         movl    16(%esp), %eax
>         incl    %eax
>         incl    24(%esp)
>         movl    %eax, 16(%esp)
>         addl    $12, %esp
>         jmp     bar
> 
> (Not sure why gcc doesn't use incl on all three memories, nor
> should it allocate that stack frame...)
> 
> 
> r~
> 

Well it's not modifying those values. It's putting the
constant value into a register and modifying the value
in the register before calling a function that takes int.
Note that the parameter passed to the function, a, b, and c,
are local copies. gcc can whack those anyway it wants. In
fact, it does strange things above which may not be valid.
It subtracts an offset from esp for local variables ($12).
There aren't any local variables!. Therefore, it has to
access the passed parameters at their pushed offset + 12.
Then, after it's through mucking with them, it collapses
the local stack area (levels the stack), then jumps
to the called function. It will use the early 'call'
return-value to return to the caller.
It's really bad code because it could have done:

	incl	$0x04(%esp)
	incl	$0x08(%esp)
	incl	$0x1c(%esp)
	jmp	bar

Note that, in every case, the constant value was pushed onto the
stack and this function called. That copy of the constant value
can be trashed anyway the callee wants. It's his copy.


I thought you were going to do something like:

Script started on Thu Sep 19 15:22:05 2002
# cat zzz.c

int foo(const int a, const int b, const int c)
{
    a += b;
    a += c;
    return a;
}
# gcc -c -o zzz zzz.c
zzz.c: In function `foo':
zzz.c:6: warning: assignment of read-only location
zzz.c:7: warning: assignment of read-only location
# exit
exit

Script done on Thu Sep 19 15:22:23 2002

Which makes gcc barf when you attempt to modify the
const value. This allows you to check if the code is
doing the wrong thing.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


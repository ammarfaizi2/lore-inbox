Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264125AbRFYLc5>; Mon, 25 Jun 2001 07:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264090AbRFYLcs>; Mon, 25 Jun 2001 07:32:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3458 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264062AbRFYLck>; Mon, 25 Jun 2001 07:32:40 -0400
Date: Mon, 25 Jun 2001 07:32:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Michael Meissner <meissner@spectacle-pond.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules
In-Reply-To: <20010624202654.B30355@munchkin.spectacle-pond.org>
Message-ID: <Pine.LNX.3.95.1010625072259.5434A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, Michael Meissner wrote:

> On Sat, Jun 23, 2001 at 10:43:14PM -0400, Richard B. Johnson wrote:
> > Previous to the "Draft" "Proposal" of C98, there were no such
> > requirements. And so-called ANSI -C specifically declined to
> > define any order within structures.
> 
> As one of the founding members of the X3J11 ANSI committee, and having served
> on the committee for 10 1/2 years, I can state categorically that Appendix A
> of
> the original K&R (which was one of the 3 base documents for ANSI C) had the
> requirement that non-bitfield fields are required to have monotonically
> increasing addresses (bitfields don't have addresses, and different compiler
> ABIs do lay them out in different fashions within the words).  C89 never
> changed the wording that mandates this.
> 
> -- 
> Michael Meissner, Red Hat, Inc.  (GCC group)
> PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
> Work:	  meissner@redhat.com		phone: +1 978-486-9304
> Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
> 

The layout of structures is logical, not physical, and in fact
must be. This became a requirement after the 'const' keyword
was accepted.

If the structure members we located exactly as written, then
the following structure would not be possible:

struct s {
    int a;
    int b;
    const char c[0x10];
    int d;
    } s = { 0x01, 0x02, "Hello World", 0x04 };

It is quite correct to mix read-only data and writable data within
a structure. A correctly operating compiler will put the read-only
data with other read-only data and, if this area is protected either
because it's in ROM, or the OS traps, not allow it to be written.
This means that it must be some place else than where it's denoted
in a visual representation of the structure. This is one of
the main reasons why one cannot assume that the memory layout
is represented by the logical layout of the structure.

In short, a structure is a logical representation of an array
of aggregate types, not a physical representation.

With `gcc` the following compiles with a warning about 'const', but it
still compiles and runs.

#include <stdio.h>
#include <string.h>

struct s {
    int a;
    int b;
    const char c[0x10];
    int d;
    } s = { 0x01, 0x02, "Hello World", 0x04 };

int main()
{
    printf("a = %p\n", &s.a);
    printf("b = %p\n", &s.b);
    printf("c = %p\n", s.c);
    printf("d = %p\n", &s.d);
    strcpy(s.c, "So much for rules");
    puts(s.c); 
    return 0;
}

This compiles and runs because gcc does not put the "const char"
string in ".rodata" as it is supposed to do. It just throws it in
with with ".data" so you get the behavior that many persons expect,
while refusing to do what the code told it to do. This is an example
of the Gnu-ism where the compiler thinks it "knows more than the
programmer". Further, since gcc does this, many persons think that
this is "correct" or "how it is supposed to be" or "complies with
CX standard", etc.

If you are writing execute-in-place code (NVRAM), with only a few
kilobytes of RAM, you are in a world of hurt with such a compiler.
That's why you don't use gcc for this. Instead, you use a compiler
which produces code "as written" for such a project.

	.file	"xxx.c"
	.version	"01.01"
gcc2_compiled.:
.globl s
.data
	.align 4
	.type	 s,@object
	.size	 s,28
s:
	.long	1
	.long	2
	.string	"Hello World"
	.zero	4
	.long	4
		.section	.rodata
.LC0:
	.string	"a = %p\n"
.LC1:
	.string	"b = %p\n"
.LC2:
	.string	"c = %p\n"
.LC3:
	.string	"d = %p\n"
.LC4:
	.string	"So much for rules"
.text
	.align 16

There is no additional overhead from putting data types where
the programmer told the compiler to put them. When referencing
the R/O data, the compiler "knows" where it put it. It is free
to use whatever addressing it wants. In the code generated
above, the compiler should have done:

s:
	.long	1
	.long	2
	.section	.rodata
	.string	"Hello World"
	.zero	4
	.previous
	.long	4
	.section	.rodata

But if it did this, member 'd' would follow member 'b' in the
structure, which is not what the usual programmer might expect.
Member 'c', the R/O data would be, correctly, at some "strange"
offset unrelated to the other structure members. 


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.



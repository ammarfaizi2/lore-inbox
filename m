Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWGGXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWGGXGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWGGXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:06:42 -0400
Received: from mail.gmx.net ([213.165.64.21]:62438 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932249AbWGGXGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:06:41 -0400
X-Authenticated: #5039886
Date: Sat, 8 Jul 2006 01:06:38 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060707230638.GA30008@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	arjan@infradead.org
References: <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.07.07 15:51:11 -0400, linux-os (Dick Johnson) wrote:
> 
> On Fri, 7 Jul 2006, Krzysztof Halasa wrote:
> 
> > "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
> >
> >> extern int spinner;
> >>
> >> funct(){
> >>      while(spinner)
> >>          ;
> >>
> >> The 'C' compiler has no choice but to actually make that memory access
> >> and read the variable because the variable is in another module (a.k.a.
> >> file).
> >
> > defiant:/tmp/khc$ gcc --version
> > gcc (GCC) 4.1.1 20060525 (Red Hat 4.1.1-1)
> > defiant:/tmp/khc$ cat test.c
> > extern int spinner;
> >
> > void funct(void)
> > {
> >     while(spinner)
> >         ;
> > }
> > defiant:/tmp/khc$ gcc -Wall -O2 -c test.c
> > defiant:/tmp/khc$ objdump -d test.o
> >
> > test.o:     file format elf32-i386
> >
> > Disassembly of section .text:
> >
> > 00000000 <funct>:
> >   0:   a1 00 00 00 00          mov    0x0,%eax
> >   5:   55                      push   %ebp
> >   6:   89 e5                   mov    %esp,%ebp
> >   8:   85 c0                   test   %eax,%eax
> >   a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
> >  10:   75 fe                   jne    10 <funct+0x10>
> >  12:   5d                      pop    %ebp
> >  13:   c3                      ret
> >
> > "0x0" is, of course, for relocation.
> 
> 
> So read the code; you have "10:   jne 10", jumping to itself
> forever, without even doing anything else to set the flags, much
> less reading a variable.

Well, you said that the compiler is forced to make the memory access,
given the topic of this discussion probably noone assumed that you meant
exactly one memory access. Of course that code is broken, but you seemed
to say that it is not.

> >> However, if I have the same code, but the variable is visible during
> >> compile time, i.e.,
> >>
> >> int spinner=0;
> >>
> >> funct(){
> >>      while(spinner)
> >>          ;
> >>
> >> ... the compiler may eliminate that code altogether because it
> >> 'knows' that spinner is FALSE, having initialized it to zero
> >> itself.
> >
> > defiant:/tmp/khc$ cat test.c
> > int spinner = 0;
> >
> > void funct(void)
> > {
> >     while(spinner)
> >         ;
> > }
> > defiant:/tmp/khc$ gcc -Wall -O2 -c test.c
> > defiant:/tmp/khc$ objdump -d test.o
> >
> > 00000000 <funct>:
> >   0:   a1 00 00 00 00          mov    0x0,%eax
> >   5:   55                      push   %ebp
> >   6:   89 e5                   mov    %esp,%ebp
> >   8:   85 c0                   test   %eax,%eax
> >   a:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
> >  10:   75 fe                   jne    10 <funct+0x10>
> >  12:   5d                      pop    %ebp
> >  13:   c3                      ret
> >
> 
> Then, you have exactly the same thing here:
>    10:   75 fe                   jne    10 <funct+0x10>
> 
> Same bad code.

Which proves you wrong, you said the compiler would optimize it away o.O

> >> Since spinner is global in scope, somebody surely could have
> >> changed it before funct() was even called, but the current gcc
> >> 'C' compiler doesn't care and may optimize it away entirely.
> >
> > Personally I don't think such C compiler even existed. HISOFT C
> > on ZX Spectrum could be a good candidate but I think it didn't
> > have any optimizer :-)
> >
> >> To
> >> prevent this, you must declare the variable volatile. To do
> >> otherwise is a bug.
> >
> > Nope. Volatile just means that every read (and write) must actually
> > access the variable. Note that the compiler optimized out accesses
> > to the variable in the loop - while it has to check at the beginning
> > of funct(), it knows that the variable is constant through funct().
> >
> > Note that "volatile" is not exactly what we usually want, but it
> > does the job (i.e., the program doesn't crash, but the code is
> > probably suboptimal).
> >
> >> That said, I think that the current
> >> implementation of 'volatile' is broken because the compiler
> >> seems to believe that the variable has moved! It recalculates
> >> the address of the variable as well as accessing its value.
> >> This is what makes the code generation problematical.
> >
> > You must be using a heavily broken compiler:
> >
> > defiant:/tmp/khc$ cat test.c
> > volatile int spinner = 0;
> >
> > void funct(void)
> > {
> >     while(spinner)
> >         ;
> > }
> > defiant:/tmp/khc$ gcc -Wall -O2 -c test.c
> > defiant:/tmp/khc$ objdump -d test.o
> >
> > 00000000 <funct>:
> >   0:   55                      push   %ebp
> >   1:   89 e5                   mov    %esp,%ebp
> >   3:   a1 00 00 00 00          mov    0x0,%eax
> >   8:   85 c0                   test   %eax,%eax
> >   a:   75 f7                   jne    3 <funct+0x3>
> >   c:   5d                      pop    %ebp
> >   d:   c3                      ret
> 
> This is the only code that works. Guess why it worked? Because
> you declared the variable volatile.

The inline assembly works as well, it is made volatile and gcc will not
mess with it.

> Now Linus declares that instead of declaring an object volatile
> so that it is actually accessed every time it is referenced, he wants
> to use a GNU-ism with assembly that tells the compiler to re-read
> __every__ variable existing im memory, instead of just one. Go figure!

That wasn't Linus. Arjan suggested using barrier() in the right places.
What Linus did was just pointing out that volatile is the wrong thing to
use and that some inline assembly code had "=m" outputs instead of "+m".

The memory clobber was already there for the locking primitives and
AFAICT it is required.

lock(foo_lock);
foo = 5;
unlock(foo_lock);

// do something else

lock(foo_lock);
while (foo = 5);
unlock(foo_lock);

foo might have changed while the cpu was doing something else, but
without the memory clobber, the compiler might assume that foo is
unchanged. Making foo_lock volatile won't help here and making
everything that requires a lock volatile will get you nothing but crappy
code  (but hey, you can avoid the memory clobber!).

> Reference:
> /usr/src/linux-2.6.16.4/include/linux/compiler-gcc.h:
> #define barrier() __asm__ __volatile__("": : :"memory")

Björn

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314041AbSD1SHZ>; Sun, 28 Apr 2002 14:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314179AbSD1SHY>; Sun, 28 Apr 2002 14:07:24 -0400
Received: from egil.codesourcery.com ([66.92.14.122]:10189 "EHLO
	taltos.codesourcery.com") by vger.kernel.org with ESMTP
	id <S314041AbSD1SHX>; Sun, 28 Apr 2002 14:07:23 -0400
Date: Sun, 28 Apr 2002 11:07:20 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: Assembly question
Message-ID: <20020428180720.GT26266@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020426081723.8083A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
From: Zack Weinberg <zack@codesourcery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Johnson wrote:
> Gabriel Paubert wrote:
> > Mark Zealey wrote:
> > > Szekeres Istvan wrote:
> > >> void p_memset_dword( void *d, int b, int l ) {
> > >>    __asm__ ("rep\n\t"
> > >>             "stosl\n\t"
> > >>             : : "D" (d), "a" (b), "c" (l) 
> > >>               : "memory","edi", "eax", "ecx");
> > >> }
> > >
> > > An input or output operand is implicitly clobbered, so it should be
> > ^^^^^
> > I had expected gcc specialists to jump on that one: if you don't
> > explicitly tell gcc that an input is clobbered, it may reuse it later if
> > it needs the same value. So the clobbers are necessary...
> 
>     : : "D" (d), "a" (b), "c" (l) : "memory","edi", "eax", "ecx"
> ... is correct. Registers EDI, EAX, and ECX are altered and memory
> is changed. Nothing having to do with the 'input' is altered in
> any meaningful sense.

As usual you are completely wrong.  Clobbers can be used ONLY for
registers that do not already appear in either the input or output
list.  In this case, it is the input registers that are modified.  You
have to use notation that makes that explicit.

The correct way to write this asm statement with GCC 2.95 or later is

  asm volatile
	  ("rep; stosl"
           : "+D" (d), "+c" (l)  /* read and write edi, ecx */
           : "a" (b)
           : "memory");

With earlier versions you have to use a more verbose notation.

Some further notes:

rep stosl doesn't change %eax, so a plain input parameter can be used
for that argument.

GCC assumes that any asm with output parameters has no side effects.
The memory clobber doesn't count.  Therefore, it will notice that d
and l are not used again and delete the whole asm statement, unless
you qualify it with 'volatile'.

There is no point in using __asm__ instead of asm, unless you are
writing code which has to compile with -pedantic on.

zw

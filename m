Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265940AbUGHJk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUGHJk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 05:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUGHJk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 05:40:27 -0400
Received: from ltgp.iram.es ([150.214.224.138]:23937 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S265940AbUGHJkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 05:40:21 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 8 Jul 2004 11:32:50 +0200
To: tom st denis <tomstdenis@yahoo.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [OT] Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040708093249.GC32629@iram.es>
References: <20040707184737.GA25357@infradead.org> <20040707185340.42091.qmail@web41112.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040707185340.42091.qmail@web41112.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 11:53:40AM -0700, tom st denis wrote:
> --- Christoph Hellwig <hch@infradead.org> wrote:
> > On Wed, Jul 07, 2004 at 11:41:50AM -0700, tom st denis wrote:
> > > Um, actually "char" like "int" and "long" in C99 is signed.  So
> > while
> > > you can write 
> > > 
> > > signed int x = -3;
> > > 
> > > You don't have to.  in fact if you "have" to then your compiler is
> > > broken.  Now I know that GCC offers "unsigned chars" but that's an
> > > EXTENSION not part of the actual standard.  
> > 
> > ------------------------------ snip -----------------------------
> >  [#15]  The  three types char, signed char, and unsigned char
> >         are   collectively   called   the   character   types.   The
> >         implementation  shall  define  char  to have the same range,
> > 	representation,  and  behavior  as  either  signed  char or
> > 	unsigned char.35)
> > ------------------------------ snip -----------------------------
> 
> Right.  Didn't know that.  Whoa.  So in essence "char" is not a safe
> type.

It depends what you use it for, but it typically is not. 

The _very_ common mistake is assigning the result of fgetc/getc/getchar
(which are defined to return an _unsigned_ char cast to an int or EOF) 
to a plain char and then comparing it with -1 to check for EOF: 

1) it will never detect the EOF if the char is unsigned (PPC)

2) it will stop on a ÿ (that's an y with a diaeresis) on Intel. This
character is infrequent in the languages I use but it occasionally 
happens. 

Of course people who only use plain 7 bit ASCII never hit the bug,
but as soon as you go into Latin-$n encodings you may hit them (I'm 
only restricting myself to character sets based on the Latin alphabet). 

And no the solution is not to use -fsigned-char or -funsigned char
as an optin to GCC. Most of the time it only changes the kind of bugs 
that are hidden in the code, and 2) above is statistically harder to 
hit than 1).

> 
> > > As for writing portable code, um, jacka#!, BitKeeper, you know,
> > that
> > > thingy that hosts the Linux kernel?  Yeah it uses LibTomCrypt.  Why
> > not
> > > goto http://libtomcrypt.org and find out who the author is.  Oh
> > yeah,
> > > that would be me.  Why not email Wayne Scott [who has code in
> > > LibTomCrypt btw...] and ask him about it?

Yes, I know and I use BK. But given the fact that you insult me for 
better knowing C rules than you, I'm seriously considering switch 
to subversion or arch instead.

Argh, I've mentioned BK. There should be a Goldwin's law equivalent
for BitKeeper on lkml ;-)

> > > 
> > > Who elses uses LibTomCrypt?  Oh yeah, Sony, Gracenote, IBM [um Joy
> > > Latten can chip in about that], Intel, various schools including
> > > Harvard, Stanford, MIT, BYU, ...
> > 
> > Tons of people use windows aswell.  You just showed that you don't
> > know
> > C well enough, so maybe someone should better do an audit for your
> > code ;-)
> 
> To be honest I didn't know that above.  That's why I'm always explicit.
>  [btw my code builds in MSVC, BCC and ICC as well].
> 
> You don't need to know such details to be able to develop in C.  I'm
> sure if you walked into [say] Redhat and gave an "on the spot C quiz"
> about obscure rules they would fail.  You have to use some common sense
> and apply the more relevant rules.  

Well, I consider the rules about plain char to be among the most
relevant, since I've been hit by them _way_ _more_ than about any 
other badly known C rule.

And finally, I'd personnaly prefer the char to be unsigned, for several
reasons:
- its name which suggests that it is an enumeration of symbols. 
- strcmp and friends do the comparisons using _unsigned_ char,
despite the fact that the prototype declare plain char parameters
- the aforementioned fgetc/getc/getchar issues.
  
  
BTW, this signed/unsigned mess is a reason for some weirdness like 
tables with 384 entries in libc/ctype/ctype.h:


/* These are defined in ctype-info.c.
   The declarations here must match those in localeinfo.h.

   In the thread-specific locale model (see `uselocale' in <locale.h>)
   we cannot use global variables for these as was done in the past.
   Instead, the following accessor functions return the address of
   each variable, which is local to the current thread if multithreaded.

   These point into arrays of 384, so they can be indexed by any `unsigned
   char' value [0,255]; by EOF (-1); or by any `signed char' value
   [-128,-1).  ISO C requires that the ctype functions work for `unsigned
   char' values and for EOF; we also support negative `signed char' values
   for broken old programs.  
   
 [snipped]

Not specifying the signedness of the char types is one of C's original
mistakes, and the one that statistically mostly affects me.

	Gabriel (the only good char is the unsigned char)
 

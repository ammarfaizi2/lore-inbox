Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRHaSOb>; Fri, 31 Aug 2001 14:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268837AbRHaSOU>; Fri, 31 Aug 2001 14:14:20 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:45583 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S268835AbRHaSOH>; Fri, 31 Aug 2001 14:14:07 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108311813.f7VIDjF25751@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: linux-kernel@vger.kernel.org
Date: Fri, 31 Aug 2001 20:13:45 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Peter T. Breuer" <ptb@it.uc3m.es>
> > From: "Herbert Rosmanith" <herp@wildsau.idv.uni-linz.ac.at>
> >
> > if sizeof(typeof(a))==sizeof(int) && sizeof(typeof(b))==sizeof(int) &&
> >    ( _a < 0 && _b > 0 || _a > 0 && b < 0 )
> >       BUG() // signed unsigned int compare
> 
> What makes sizeof(int) so magic?

ask your compiler.

> Are you saying that the problems don't arise between signed long long
> and unsigned long long?

no.

> I saw an example that seemed generic for all signed unsigned
> comparisons, namely that signed int and unsigned int are compared as
> unsigned, so (unsigned)2 < (signed)-1. 

which is wrong. so?

> Are you saying that signed long and unsigned long are NOT compared as
> unsigned iff sizeof(long) != sizeof(int).  Woooo!  Who wrote the C spec?
> No kidding? There is a special clause for comparisons that use the
> native machine word?

excuse me, pete, but being sarcastic does not suite you well:

in Message-Id: <200108311322.PAA12269@nbd.it.uc3m.es>
you write:
> #define MIN(x,y) ({\
>    const typeof(x) _x = ~(typeof(x))0; \
>    const typeof(y) _y = ~(typeof(y))0; \
>    if (sizeof(_x) != sizeof(_y)) \
>      MINMAX_BUG; \


this is just not right. you don't  even honour if x and y are of the
same signedness! if x and y are of the same signedness, a comparison
can be done at absolutely no risk regardless of the size!

and even *if* the sizes differ, there are cases, where the comparison
still can be done at no risk. namely:

 signed short / unsigned char       ->  OK
 unsigned short / signed char       ->  OK
 signed int / unsigned char         ->  OK
 signed int / unsigned short        ->  OK
 signed long long / unsigned char   ->  OK
 signed long long / unsigned short  ->  OK

(I don't know about signed long long / unsigned int, I'd have to ask the
compiler/assembler. but I guess it will be okay, too)

but:

  unsigned int / signed char        -> fails.
  unsigned int / signed short       -> fails.
  unsigned long long / signed char  -> fails.
  unsigned long long / signed short -> fails.
  unsigned long long / signed int   -> fails.

I haven't really verified all cases, they are a conclusion from seeing
the code gcc generates.

if we follow your minmax-macro code:

>    if ((_x > (typeof(x))0 && _y < (typeof(y))0) \
>    ||  (_x < (typeof(x))0 && _y > (typeof(y))0)) \
>      MINMAX_BUG; \
>    __MIN(x,y); \
>  })

if I see this right, after requiring the size be the same, you also
require the same signdness?

but:

 : 	char a; unsigned char b;
 : 
 : 	a=-1;	b=255;
 : 	if (a<b) ....

will work perfectly. same applies for short a/unsigned short b;





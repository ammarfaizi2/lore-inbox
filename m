Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRKSTjS>; Mon, 19 Nov 2001 14:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280659AbRKSTjJ>; Mon, 19 Nov 2001 14:39:09 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:13331 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S276135AbRKSTiy>;
	Mon, 19 Nov 2001 14:38:54 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111191938.fAJJckA14340@oboe.it.uc3m.es>
Subject: Re: if (a & X || b & ~Y) in dasd.c
In-Reply-To: <200111191840.fAJIej230821@deathstar.prodigy.com> from "bill davidsen"
 at "Nov 19, 2001 01:40:45 pm"
To: "bill davidsen" <davidsen@tmr.com>
Date: Mon, 19 Nov 2001 20:38:46 +0100 (MET)
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"bill davidsen wrote:"
>   If the code does what I think it does, it works as written. However, I
> usually would throw in parenthesis on something like this to be sure
> that the next person reading the code won't waste time thinking about

Which is WHY you do not put in parentheses.

C is designed with precedences that make sense. You can write
conditions the way they ought to be written, without parentheses.

   a && b || c && d

is read exactly the same way as you would read

   a * b  +  c * d

and I have no idea why people would think otherwise. && is the logical
multiplicative operator (1*x = x, x*0 = 0, x*y = y*x, x*(y*z) = (x*y)*z),
and || is the logical addition operator (x+0 = x, x+y = y +x,
x+(y+z)=(x+y)+z)) and they distribute correctly (x*(y+z) = (x*y)+(x*z)),
so why should you treat them as though they were some strange thing
from mars that needs parentheses?

> it. I always thought that good code was literature, which could be read,
> understood, and enjoyed by many.

Exactly so. So don't put in extra punctuation to help people that can't
read or you'll spoil it for us. Parentheses make things illegible, as
surely as ((2)=(((1))+((1)))) :-). If an expression is difficult for
you, don't write it!

Additive operators in C have weaker priority than multiplicative
operators at the same level.  = is weaker than anything.  Relational
operators are next weakest.  Then bitwise operators.  Then logical
operators.  Then arithmetic operators, then monary operators, which are
strongest of all.

That's the natural way. It means you can write, instead of

   *x++ += (((a+2) << 2) > (b-4));

   *x++ += a+2 << 2  >  b-4;

(but that's illegible simply by virtue of having too complicated a RHS
in either case), or

   x = a & b || c & d;

because the & binds more tightly than || by virtue of being
bitwise, not logical. If you were to write

   x = a & b | c & d;

that  would also be right, because & binds more tightly by virtue of
being multiplicative.

   x = a && b || c && d

is also right, for the same reason. All have the same logical
semantics, two have the same bitwise semantics. Two have the
same arithmetic semantics, I think ... obviously you can also add

   x = a * b + c * d

to the list, and more variants - though you wouldn't want to.

Where you might get caught out is by not realizing that << is 
weaker than arithmetic ops, so 

   *x++ += a+2 << 2  >  b-4;

(what I wrote before) is NOT

   *x++ += a + 2<<2  >  b-4;

nor

   *x++ += a+2  <<  2 > b-4

nor

   *x++ += a   +   2  <<  2>b   -   4

Blech. I can't think of any more eccentric interpretations. The
principle is that the higher level and more additive an operator is,
the weaker it is.  This is intuitive. You only need to parenthise
weak operators when you want them to be evaluated before a strong
operator acts. Thus

  *x++ +=  *((x | 0x01) + (1<<*x)) 

to be silly. The commonest mistake is writing

  x = y << z + w

instead of

  x = y << (z++w)

But compare

  x = y ** z + w

(should the power operator exist) and you'll see why it's wrong. << is
precisely a power operator, and not treating it as such is the error.


Peter

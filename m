Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272704AbRHaO3p>; Fri, 31 Aug 2001 10:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272706AbRHaO3c>; Fri, 31 Aug 2001 10:29:32 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:38412 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272704AbRHaO3Y>; Fri, 31 Aug 2001 10:29:24 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108311428.f7VEStH24660@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: ptb@it.uc3m.es
Date: Fri, 31 Aug 2001 16:28:55 +0200 (MET DST)
Cc: zippel@linux-m68k.org, ptb@it.uc3m.es, patl@cag.lcs.mit.edu,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "A month of sundays ago Roman Zippel wrote:"
> > On Fri, 31 Aug 2001, Peter T. Breuer wrote:
> >
> > >    if (sizeof(_x) != sizeof(_y)) \
> > >      MIN_BUG(); \
> >
> > What bug are you trying to fix here?
>
> Wake up!

good morning, peter.

try comparing e.g. unsigned char with signed short.

roman is right if he asks "What bug are you trying to fix here?" sure,
sometimes there is a bug, sometimes there is not. so with the question
"*what* bug" roman surely means, which situation do you want to identify
as the buggy one?

if all you do is to compare the size of the operands without taking
into account the architectural limit, you will also mock about
different-sized comparison which are perfectly legal and not buggy
at all.

look at this code:

  : #include        <stdio.h>
  : 
  : int main() {
  : unsigned short us;
  : signed char sc;
  : 
  :         us=65535;
  :         sc=-2;
  :         if (us>sc) printf("us>sc %d %d\n",us,sc);
  : 
  :         return 0;
  : }

which compiles to:

  :      movw $65535,-2(%ebp)
  :      movb $-2,-3(%ebp)
  :      xorl %eax,%eax
  :      movw -2(%ebp),%ax
  :      movsbl -3(%ebp),%edx
  :      cmpl %edx,%eax
  :      jle .L3

you see this? short and char get expanded to 32bit int (I have a x86),
and a signed comparison can be done without danger. "jle" jumps if
SF != OF, which accounts to "op1 < op2" in a signed compare. the
"unsigned short" quantum gets expanded to an "unsigned int", which
is no problem, since the bit16-31 will be 0. the "signed char" will
also be expanded to 32bit and eventually (for negative values) have
bit31-bit8 "1". thus, a signed compare with 32bits will work perfectly
well for an unsiged 16bit value.

The problem arises when one of the variables cannot be expanded any
more. Of course, the compiler could generate code to i.e. expand
int32 to long long, but this has not be done, may be or may not be
done in a future release or whatever.

For instance:

  : int main() {
  : unsigned int ui;
  : signed char sc;
  : 
  :         ui=1;
  :         sc=-2;
  :         if (ui>sc) printf("ui>sc %d %d\n",ui,sc);
  : 
  :         return 0;
  : }

will not work as expected.

the reason is that:

  :         movl $1,-4(%ebp)
  :         movb $-2,-5(%ebp)
  :         movsbl -5(%ebp),%eax
  :         cmpl %eax,-4(%ebp)
  :         jbe .L3

"jbe" honours CF and ZF, which accounts to an *unsigned* compare.
however, the negative "signed char" got expanded to 0xffffffff,
which is, in an unsigned compare-context, greater than 0x00000001.

I hope I've shown that "sizeof(a) != sizeof(b)" is not neccessarily
*always* a buggy situation.

Even with int, a "signed int" with an "unsigned char" compare could
be done. The buggy situation is when the bigger variable is unsigned,
in size equal to the architectural limit, and the smaller variable
is signed.

I hope I got that right.

cheers,
herp
 






Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272556AbRH3X2q>; Thu, 30 Aug 2001 19:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272557AbRH3X2f>; Thu, 30 Aug 2001 19:28:35 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:44554 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272556AbRH3X2Q>;
	Thu, 30 Aug 2001 19:28:16 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108302327.f7UNRvl04257@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <s5gheup6ugt.fsf@egghead.curl.com> from "Patrick J. LoPresti" at
 "Aug 30, 2001 06:42:10 pm"
To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
Date: Fri, 31 Aug 2001 01:27:57 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Patrick J. LoPresti wrote:"
> This is a MUCH nicer solution.  max() is a well-defined mathematical
> concept; it is simply the larger of its two arguments, period.  It is
> C's *promotion* rules that kill you, especially signed->unsigned
> promotion.  So just forbid them, at least when they implicit.
> 
> You can argue about whether the "differing sizes" case should be a
> BUG(), since the output will still be mathematically correct.  It

To give you all something definite to look at, here's some test code:

// standard good 'ol faithful version
#define __MIN(x,y) ({\
   typeof(x) _x = x; \
   typeof(y) _y = y; \
   _x < _y ? _x : _y ; \
 })

// possible implemetation with type sanity checks - alter to taste
#define MIN(x,y) ({\
   const typeof(x) _x = ~(typeof(x))0; \
   const typeof(y) _y = ~(typeof(y))0; \
   void MIN_BUG(); \
   if (sizeof(_x) != sizeof(_y)) \
     MIN_BUG(); \
   if ((_x > 0 && _y < 0) || (_x < 0 && _y > 0)) \
     MIN_BUG(); \
   __MIN(x,y); \
 })

// test code that compiles with no complaints with -O1 -Wall
int main() {
  unsigned i = 1;
  unsigned j = -2;
  return MIN(i,j);
}

// test code that complains at link time (in this version) with ..
//  gcc -o test -O1 -Wall test.c
// /tmp/cczJbwv5.o: In function `main':
// /tmp/cczJbwv5.o(.text+0x7): undefined reference to `MIN_BUG'
// collect2: ld returned 1 exit status
//
int main() {
  unsigned i = 1;
  signed j = -2;
  return MIN(i,j);
}

> depends on how often it is useful to compare (say) unsigned chars
> against ints, and on whether the compiler warns about cases where you
> try to stuff the return value into a too-small container.  I bet that
> just forbidding signed->unsigned promotion would be enough.

Possibly. I have little clue as to the real extent of the problem.

Peter

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130021AbRBHBYt>; Wed, 7 Feb 2001 20:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130920AbRBHBYj>; Wed, 7 Feb 2001 20:24:39 -0500
Received: from d-dialin-1244.addcom.de ([62.96.164.44]:61422 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130021AbRBHBYa>; Wed, 7 Feb 2001 20:24:30 -0500
Date: Thu, 8 Feb 2001 02:24:59 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.4.10.10102071336230.5084-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0102080159070.1082-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Linus Torvalds wrote:

> No. The optimization is entirely legal - but the fact that
> "constant_test_bit()" uses a "volatile unsigned int *" is the reason why
> gcc thinks it can't optimize it.

This thing did attract me somewhat and I decided to learn a little about 
compilers.

Result: Unfortunately it's not just the volatile, there's a bunch of 
conditions you have to fulfill to have the compiler optimize this. (Sounds 
like work for the compiler guys).

Test program is attached, inspecting the code (egcs 2.91.66 and 
gcc-2.96 (-69) generate the same code gives the following conclusions:

- f1(unsigned long f): manually optimized

	if (f & ((1 << 1) | (1 << 2) | (1 << 4))) {

  -> optimized code (of course)


- f2(unsigned long f): leave some work to the compiler

	if ((f & (1 << 1)) || (f & (1 << 2)) || (f & (1 << 4))) {

  -> optimized code (good)


- f3(unsigned int f): use constant_test_bit macro
	
	  if (constant_test_bit(1, &f) || constant_test_bit(2, &f) || 
	      constant_test_bit(4, &f)) {
 
  -> optimized code

  where

	#define constant_test_bit(nr, addr) \
	(((1UL << (nr & 31)) & ((unsigned int*)(addr))[nr >> 5]) != 0)

  (doesn't optimize when putting *const* unsigned int there)

- f4: same thing as f3, but use (unsigned long f) instead of 
  (unsigned int f)
  
  -> no optimization

- f5: same thing as f3, but use inline function for constant_test_bit

  -> no optimization

- f6: same thing as f3, but use test_bit instead of constant_test_bit,
  where

	#define test_bit(nr,addr) \
	(__builtin_constant_p(nr) ? \
	constant_test_bit((nr),(addr)) : \
	variable_test_bit((nr),(addr)))

  -> no optimization


Conclusion: With the compilers tested, lots of cases are not optimized 
although the could be in theory:
- casting even from unsigned int to unsigned long breaks optimization
- macros are better than inline
- Even though evaluated at compile time, __builtin_constant_p breaks
  optimization here, too.

BTW: volatile makes optimization impossible as well, of course, it leads 
to repeated reloads of the variable, whereas otherwise it's cached in a 
register in the above "no optimization" cases. That's expected behavior.

--Kai

Test code:
----------

#define ADDR (*(volatile long *) addr)

static __inline__ int inl_constant_test_bit(int nr, const void * addr)
{
        return ((1UL << (nr & 31)) & (((unsigned int *) addr)[nr >> 5])) != 0;
}

#define constant_test_bit(nr, addr) (((1UL << (nr & 31)) & ((unsigned int*)(addr))[nr >> 5]) != 0)

static __inline__ int variable_test_bit(int nr, volatile void * addr)
{
        int oldbit;

        __asm__ __volatile__(
                "btl %2,%1\n\tsbbl %0,%0"
                :"=r" (oldbit)
                :"m" (ADDR),"Ir" (nr));
        return oldbit;
}

#define test_bit(nr,addr) \
(__builtin_constant_p(nr) ? \
 constant_test_bit((nr),(addr)) : \
 variable_test_bit((nr),(addr)))




int f1(unsigned long f)
{
  if (f & ((1 << 1) | (1 << 2) | (1 << 4))) {
    return 1;
  }
  return 0;
}

int f2(unsigned long f)
{
  if ((f & (1 << 1)) || (f & (1 << 2)) || (f & (1 << 4))) {
    return 1;
  }
  return 0;
}

int f3(unsigned int f)
{
  if (constant_test_bit(1, &f) || constant_test_bit(2, &f) || constant_test_bit(4, &f)) {
    return 1;
  }
  return 0;
}

int f4(unsigned long f)
{
  if (constant_test_bit(1, &f) || constant_test_bit(2, &f) || constant_test_bit(4, &f)) {
    return 1;
  }
  return 0;
}

int f5(unsigned int f)
{
  if (inl_constant_test_bit(1, &f) || inl_constant_test_bit(2, &f) || inl_constant_test_bit(4, &f)) {
    return 1;
  }
  return 0;
}

int f6(unsigned int f)
{
  if (test_bit(1, &f) || test_bit(2, &f) || test_bit(4, &f)) {
    return 1;
  }
  return 0;
}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

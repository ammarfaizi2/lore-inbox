Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSKIEJD>; Fri, 8 Nov 2002 23:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSKIEJC>; Fri, 8 Nov 2002 23:09:02 -0500
Received: from dp.samba.org ([66.70.73.150]:15329 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264724AbSKIEI7>;
	Fri, 8 Nov 2002 23:08:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dipankar Sarma <dipankar@gamebox.net>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Re: UP went into unexpected trashing 
In-reply-to: Your message of "Fri, 08 Nov 2002 12:10:14 -0800."
             <Pine.LNX.4.44.0211081206140.4471-100000@penguin.transmeta.com> 
Date: Sat, 09 Nov 2002 14:16:19 +1100
Message-Id: <20021109041542.054AF2C0DF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In message <Pine.LNX.4.44.0211081206140.4471-100000@penguin.transmeta.com> you 
write:
> 
> On Sat, 9 Nov 2002, Dipankar Sarma wrote:
> > 
> > Or add a check in there. I can't figure out a way to avoid the extra 
> > conditional branch anyway :)
> 
> I'd actually rather change the calling convention, and say that the only 
> valid test is for testing the return value "being in range".

At least gcc 3.0 doesn't do the optimization for you, unfortunately 8(

So I agree, although I'd prefer the stricter definition.

Rusty.
PS.  Previous documentation was written by a bad monkey, so I've fixed
     it to actually say something useful, too.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/asm-i386/bitops.h working-2.5-bk-find_first_bit/include/asm-i386/bitops.h
--- linux-2.5-bk/include/asm-i386/bitops.h	2002-11-09 13:33:20.000000000 +1100
+++ working-2.5-bk-find_first_bit/include/asm-i386/bitops.h	2002-11-09 14:12:32.000000000 +1100
@@ -263,10 +263,10 @@ static __inline__ int variable_test_bit(
 /**
  * find_first_zero_bit - find the first zero bit in a memory region
  * @addr: The address to start the search at
- * @size: The maximum size to search
+ * @size: The maximum size to search (may be rounded up by BITS_PER_LONG)
  *
- * Returns the bit-number of the first zero bit, not the number of the byte
- * containing a bit.
+ * Returns the bit-number of the first zero bit (not the number of the byte
+ * containing the bit) or a value >= size if none found.
  */
 static __inline__ int find_first_zero_bit(unsigned long * addr, unsigned size)
 {
@@ -295,10 +295,10 @@ static __inline__ int find_first_zero_bi
 /**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
- * @size: The maximum size to search
+ * @size: The maximum size to search (may be rounded up by BITS_PER_LONG)
  *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
+ * Returns the bit-number of the first set bit (not the number of the byte
+ * containing the bit) or a value >= size if none found.
  */
 static __inline__ int find_first_bit(unsigned long * addr, unsigned size)
 {
@@ -321,10 +321,14 @@ static __inline__ int find_first_bit(uns
 }
 
 /**
- * find_next_zero_bit - find the first zero bit in a memory region
+ * find_next_zero_bit - find the next zero bit in a memory region
  * @addr: The address to base the search on
  * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
+ * @size: The maximum size to search (may be rounded up by BITS_PER_LONG)
+ * 
+ * Returns the bit-number of the first zero bit >= offset (not the
+ * number of the byte containing the bit), or a value >= size if none
+ * found.
  */
 static __inline__ int find_next_zero_bit(unsigned long * addr, int size, int offset)
 {
@@ -354,10 +358,14 @@ static __inline__ int find_next_zero_bit
 }
 
 /**
- * find_next_bit - find the first set bit in a memory region
+ * find_next_bit - find the next set bit in a memory region
  * @addr: The address to base the search on
  * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
+ * @size: The maximum size to search (may be rounded up by BITS_PER_LONG)
+ * 
+ * Returns the bit-number of the first bit set >= offset (not the
+ * number of the byte containing the bit) or a value >= size if none
+ * found.
  */
 static __inline__ int find_next_bit(unsigned long *addr, int size, int offset)
 {

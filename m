Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbVHIRyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVHIRyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVHIRyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:54:35 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:49542 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932560AbVHIRyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:54:35 -0400
Date: Tue, 9 Aug 2005 10:54:34 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Marc Singer <elf@buici.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi
Message-ID: <20050809175434.GA23389@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808174721.GA2853@buici.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 10:47:21AM -0700, Marc Singer wrote:
> On Mon, Aug 08, 2005 at 07:35:36PM +0200, Marcel Holtmann wrote:
> > > > +	if (NULL == dev || NULL == driver) {
> > > 
> > > Put the variable on the left side, gcc will complain if you incorrectly
> > > put a "=" instead of a "==" here, which is all that you are defending
> > > against with this style.
> > 
> > I think in this case the preferred way is
> > 
> > 	if (!dev || !driver) {
> > 
> 
> That's not a guaranteed equivalence in the C standard.  Null pointers
> may not be zero.  I don't think we have any targets that work this
> way, however there is nothing wrong with explicitly testing for NULL.

False.  The expression  "!x" is precisely equivalent to "x==0", no
matter what the type of x is. [1]  And furthermore, NULL==0. [2]
Ergo, "NULL == dev" and "!dev" are defined to be equivalent.

What you're confused about is that the *representation* of a null
pointer constant does not necessarily have to be all-bits-zero.  That
is, the following code fragment might print something on a
standard-compliant C implementation:

	void *a = 0; unsigned char *p = (unsigned char *)&a;
	int i;
	for(i=0; i<sizeof(a); i++)
		if(p[i] != 0) printf("p[%d] = %02x!\n", i, p[i]);

That does not change the fact that the source-code fragment "NULL" is
defined to be equivalent to the source-code fragment "0".  Simply the
compiler must do whatever trickery necessary to ensure the correct
values get generated in the object code for my above hypothetical
architecture when I say "void *a = 0;".

This is very similar to how floating point is handled in the abstract
machine definition of the standard.  Consider a weird FP implementation
where 0.0 has a not-all-bits-zero representation, and change 'a' in my
example above to type 'double'.  Just because 0.0 is stored as the bit
pattern 0x8000000000000000 does not mean that I have to write something
other than "double a = 0;"!

And furthermore, all of this was well-understood in the C89 standard;
it's not new in the C99 standard, although there are some
clarifications.

[1] ISO/IEC 9899:1999 6.5.3.3 Unary arithmetic operators

  (5) The result of the logical negation operator ! is 0 if the value of
  its operand compares unequal to 0, 1 if the value of its operand
  compares equal to 0. The result has type int.  The expression !E is
  equivalent to (0==E).

[2] ISO/IEC 9899:1999 7.17

  The following types and macros are defined in the standard header
  <stddef.h>.  ...
         NULL
  which expands to an implementation-defined null pointer constant...

 and 6.3.2.3 Pointers
  (3) An integer constant expression with the value 0, or such an
  expression cast to type void *, is called a null pointer constant.

-andy

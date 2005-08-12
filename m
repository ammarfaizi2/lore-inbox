Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVHLKsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVHLKsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVHLKsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:48:14 -0400
Received: from science.horizon.com ([192.35.100.1]:34623 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750965AbVHLKsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:48:13 -0400
Date: 12 Aug 2005 06:48:03 -0400
Message-ID: <20050812104803.21700.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-os@analogic.com
Subject: Re: CCITT-CRC16 in kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508111256440.15112@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The "Bible" has been:
>  	http://www.joegeluso.com/software/articles/ccitt.htm

This fellow is just plain Confused.

First of all, The Standard Way to do it is to preset to -1 *and* to
invert the result.  Any combination is certainly valid, but if you don't
invert the CRC before appending it, you fail to detect added or deleted
trailing zero bits, which can be A Bad Thing in some applications.

Secondly, I see what he's on about "trailing zero bits", but he isn't
aware that *everyone* uses the "implicit" algorithm, so the reason that
the specs don't explain that very well is that the spec writers forgot
there was any other way to do it.

So his long-hand calculations are just plain WRONG.  Presetting the CRC
accumulator to -1 is equivalent to *inverting the first 16 bits of the
message*, and NOT to prepending 16 1 bits.

Also, he's got his bit ordering wrong.

The correct way to do it, long-hand, is this:

Polynomial: x^16 + x^12 + x^5 + 1.  In bits, that's 10001000000100001
Message: ascii "A", 0x41.
Convert to bits, lsbit first: 10000010
Append trailing padding to hold CRC: 100000100000000000000000
Invert first 16 bits: 011111011111111100000000

Now let's do the long division.  You can compute the quotient, but it's
not needed for anything, so I'm not bothering to write it down:

011111011111111100000000
 10001000000100001
 -----------------
  11100111110111010
  10001000000100001
  -----------------
   11011111100110110
   10001000000100001
   -----------------
    10101111000101110
    10001000000100001
    -----------------
      10011100000111100
      10001000000100001
      -----------------
        0101000000111010 - Final remainder

XOR trailing padding with computed CRC (since we used padding of zero,
that's equivalent to overwriting it): 100000100101000000111010 
Or, if the CRC is inverted: 100000101101011111000101

To double-check, let's verify that CRC.  I'm verifying the
non-inverted CRC, so I expect a remainder of zero:

Received message:     100000100101000000111010 
Invert first 16 bits: 011111011010111100111010 

011111011010111100111010 
 10001000000100001
 -----------------
  11100110100111011
  10001000000100001
  -----------------
   11011101000110101
   10001000000100001
   -----------------
    10101010000101001
    10001000000100001
    -----------------
      10001000000100001
      10001000000100001
      -----------------
         000000000000000 - Final remainder

Now, note how in each step, the decision whether to XOR with the 17-bit
polynomial is made based soley on the leading bit of the remainder.
The trailing 16 bits are modified (by XOR with the polynomial), but
not examined.

This leads to a standard optimization, where the bits from the dividend
are not merged into the working remainder until the moment they are
needed.  Each step, the leading bit of the 17-bit remainder is XORed
with the next dividend bit, and the polynomial is XORed in as required
to force the leading bit to 0.  Then the remainder is shifted, discarding
the leading 0 bit and shifting in a trailing 0 bit.

This technique avoids the need for explicit padding, and is the way
that the computation is invariably performed in all but pedagogical
implementations.

Also, the awkward 17-bit size of the remainder register can be reduced
to 16 bits with care, as at any given moment, one of the bits is known
to be zero.  It is usually the trailing bit, but between the XOR and
the shift, it is the leading bit.

(Again, recall that in a typical software implementation, the "leading
bit" is the lsbit and the "trailing bit" is the msbit.  Because the
CRC algorithm does not use addition or carries or anything of the sort,
it does not care which convention software uses.)

> I have spent over a week grabbing everything on the Web that
> could help decipher the CCITT CRC and they all show this
> same kind of code and same kind of organization. Nothing
> I could find on the Web is like the linux kernel ccitt_crc.
> Go figure.

Funny, I can find it all over the place:
http://www.nongnu.org/avr-libc/user-manual/group__avr__crc.html
http://www.aerospacesoftware.com/checks.htm
http://www.bsdg.org/SWAG/CRC/0011.PAS.html
http://www.ethereal.com/lists/ethereal-dev/200406/msg00414.html
http://pajhome.org.uk/progs/crcsrcc.html
http://koders.com/c/fidE2A434B346BFDCD29DA556A54E37C99E403ED26B.aspx

> Do you suppose it was bit-swapped to bypass a patent?

There's no patent.  That's just the way that the entire SDLC family of
protocols (HDLC, LAPB, LAPD, SS#7, X.25, AX.25, PPP, IRDA, etc.) do it.
They transmit lsbit-first, so they compute lsbit-first.

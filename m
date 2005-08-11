Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVHKVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVHKVwR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVHKVwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:52:17 -0400
Received: from science.horizon.com ([192.35.100.1]:53068 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932261AbVHKVwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:52:16 -0400
Date: 11 Aug 2005 17:52:09 -0400
Message-ID: <20050811215209.27443.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-os@analogic.com
Subject: Re: CCITT-CRC16 in kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508111058580.14789@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> CRC-CCITT = X^16 + X^12 + X^5 + X^0 = 0x8408, and NOT 0x1021
>> CRC-16 =  X^16 + X^15 + X^2 + X^0 = 0xa001, and NOT 0x8005
>>
> 
> Thank you very much for your time, but what you say is completely
> different than anything else I have found on the net.
> 
> Do the math:
> 
>  	2^ 16 = 65536
>  	2^ 12 =  4096
>  	2^  5 =    32
>  	2^  0 =     1
> ----------------------
>                  69655 = 0x11021
> 
> That's by convention 0x1021 as the X^16 is thrown away. I have
> no clue how you could possibly get 0x8408 out of this, nor
> how the CRC of 1 could possibly lie at offset 128 in a table
> of CRC polynomials. Now I read it in the header, but that
> doesn't make it right.

The thing is that X is not 2.  x is a formal variable with
no defined value.

	x^0  is represented as to 0x8000
	x^5  is represented as to 0x0400
	x^12 is represented as to 0x0008
        x^16 is not represented by any bit
	TOTAL:                    0x8408

> The "RS-232C" order to which you refer simply means that the
> string of "bits" needs to handled as a string of bytes, not
> words or longwords, in other words, not interpreted as
> words, just bytes. If this isn't correct then ZMODEM and
> a few other protocols are wrong. You certainly don't
> swap every BIT in a string do you? You are not claiming
> that (0x01 == 0x80) and (0x02 == 0x40), etc, are you?

Not at all.  To repeat:

- A CRC is computed over a string of *bits*.  All of its error-corection
  properties are described in terms of *bit* patterns and *bit* positions
  and runs of adjacent *bits*.  It does not know or care about larger
  structures such a bytes.

- The CRC algorithm requires that the *first* bit it sees is the
  coefficient of the highest power of x, and the *last* bit it sees is
  the coefficient of x^0.  This is because it's basically long division.

- If you are working in software, you (the implementor) must define a
  mapping between a byte string and a bit string.  There are only two
  mappings that make any sense at all:
  1) The least-significant bit of each byte is considered "first",
     and the most-significant is considered "last".
  2) The most-significant bit of each byte is considered "first",
     and the least-significant is considered "last".

The logic of the CRC *does not care* which one you choose, but you have
to choose one.  If the bytes are to be converted to bit-serial form, it
is best to choose the form actually used for transmission to preserve the
burst error detection properies of the CRC.  Note that:

- Many people (including, apparently, you) find the second choice a bit
  easier to visualize, as bit i is the coefficient of x^i.
- The first choice is
  a) Easier to implement in software, and
  b) Matches RS-232 transmission order, and
  c) Is used by hardware such as the Z8530 SCC and MPC860 QUICC, and
  d) Is the form invariably used by experienced software implementors.

If you have some wierd piece of existing hardware, it might have chosen
either.  Just try them both and see which works.

However, if your hardware uses the opposite bit ordering within bytes,
DO NOT ATTEMPT to "fix" lib/crc-ccitt.c.  It will break all of the
existing users of the code.

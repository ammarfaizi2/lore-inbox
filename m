Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVHJUuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVHJUuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVHJUuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:50:09 -0400
Received: from science.horizon.com ([192.35.100.1]:24373 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030260AbVHJUuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:50:08 -0400
Date: 10 Aug 2005 16:50:05 -0400
Message-ID: <20050810205005.10963.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-os@analogic.com
Subject: Re: CCITT-CRC16 in kernel
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anybody know what the CRC of a known string is supposed
> to be? I have documentation that states that the CCITT CRC-16
> of "123456789" is supposed to be 0xe5cc and "A" is supposed
> to be 0x9479. The kernel one doesn't do this. In fact, I
> haven't found anything on the net that returns the "correct"
> value regardless of how it's initialized or how it's mucked
> with after the CRC (well I could just set the CRC to 0 and
> add the correct number). Anyway, how do I use the crc_citt
> in the kernel? I've grepped through some drivers that use
> it and they all seem to check the result against some
> magic rather than performing the CRC of data, but not the
> CRC, then comparing it to the CRC. One should not have
> to use magic to verify a CRC, one should just perform
> a CRC on the data, but not the CRC, then compare the result
> with the CRC. Am I missing something here?

There are two common 16-bit CRC polynomials.
The original IBM CRC-16 is x^16 + x^15 + x^2 + 1.
The more popular CRC-CCITT is x^16 + x^12 + x^5 + 1.

Both of thse include (x+1) as a factor, so provide parity detection,
detecting all odd-bit errors, at the expense of reducing the largest
detectable 2-bit error from 65535 bits to 32767.

All CRC algorithms work on bit strings, so an endianness convention
for bits within a byte is always required.  Unless specified, the
little-endian RS-232 serial transmission order is generally assumed.
That isl the least significant bit of the first byte is "first".

This bit string is equated to a polynomial where the first bit is
the coefficient of the highest power of x, and the last bit (msbit of
the last byte) is the coefficient of x^0.

(Some people think of this as big-endian, and get all confused.)

Using this bit-ordering, and omitting the x^16 term as is
conventional (it's implicit in the implementation), the polynomials
come out as:
CRC-16: 0xa001
CRC-CCITT: 0x8408

The mathematically "cleanest" CRC has the unfortunate property that
leading or trailing zero bits can be added or removed without affecting
the CRC computation.  That is, they are not detected as errors.
For fixed-size messages, this does not matter, but for variable-sized
messages, a way to detect inserted or deleted padding is desirable.

To detect leading padding, it is customary to invert the first 16 bits
of the message.  This is equivalent to initializing the CRC accumulator
to all-ones rather than 0, and is invariably implemented that way.

This change is duplicated on CRC verification, and has no effect on the
final result.

To detect trailing padding, it is customary to invert all 16 bits of
the CRC before appending it to the message.  This has an effect on
CRC verification.

One way to CRC-check a message is to compute the CRC of the entire
message *including* the CRC.  You can see this in many link-layer protocol
specifications which place the trailing frame delimiter after the CRC,
because the decoding hardware doesn't need to know in advance where the
message stops and the CRC starts.

If the CRC is NOT inverted, the CRC of a correct message should be zero.
If the CRC is inverted, the correct CRC is a non-zero constant.  You can
still use the same "checksum everything, including the original CRC"
technique, but you have to compare with a non-zero result value.

For CRC-16, the final result is x^15 + x^3 + x^2 + 1 (0xb001).
For CRC-CCITT, the final result is x^13+x^11+x^10+x^8+x^x^3+x^2+x+1 (0xf0b8).

The *other* think you have to do is append the checksum to the message
correctly.  As mentioned earlier, the lsbit of a byte is considered
first, so the lsbyte of the 16-bit accumulator is appended first.


Anyway, with all this, and using preset-to-all-ones:
CRC-CCITT of "A" is 0x5c0a, or f5 a3 when inverted and converted to bytes.
CRC-CCITT of "123456789" is 0x6f91, or 63 90.
(When preset to zero, the values are 0x538d and 0x2189, respectively.
That would be 8d 53 or 89 21 if *not* inverted.)

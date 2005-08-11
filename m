Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVHKPU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVHKPU3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVHKPU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:20:28 -0400
Received: from spirit.analogic.com ([208.224.221.4]:31507 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751081AbVHKPU1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:20:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050811144457.2598.qmail@science.horizon.com>
References: <20050811144457.2598.qmail@science.horizon.com>
X-OriginalArrivalTime: 11 Aug 2005 15:20:13.0436 (UTC) FILETIME=[2B9CBBC0:01C59E88]
Content-class: urn:content-classes:message
Subject: Re: CCITT-CRC16 in kernel
Date: Thu, 11 Aug 2005 11:19:59 -0400
Message-ID: <Pine.LNX.4.61.0508111058580.14789@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CCITT-CRC16 in kernel
Thread-Index: AcWeiCumU7UtH3xwR9KhrF13SnrjJA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <linux@horizon.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005 linux@horizon.com wrote:

>>> Using this bit-ordering, and omitting the x^16 term as is
>>> conventional (it's implicit in the implementation), the polynomials
>>> come out as:
>>> CRC-16: 0xa001
>>> CRC-CCITT: 0x8408
>>
>> Huh? That's the problem.
>>
>> X^16 + X^12 + X^5 + X^0 = 0x1021, not 0xa001
>>
>> Also,
>>
>> X^16 + X^15 + X^2 + X^0 = 0x8005, not 0x8408
>
> You're wrong in two ways:
> 1) You've got CRC-16 and CRC-CCITT mixed up, and
> 2) You've got the bit ordering backwards.  Remember, I said very clearly,
>   the lsbit is the first bit, and the first bit is the highest power
>   of x.  You can reverse the convention and still have a CRC, but that's
>   not the way it's usually done and it's more awkward in software.
>
> CRC-CCITT = X^16 + X^12 + X^5 + X^0 = 0x8408, and NOT 0x1021
> CRC-16 =  X^16 + X^15 + X^2 + X^0 = 0xa001, and NOT 0x8005
>

Thank you very much for your time, but what you say is completely
different than anything else I have found on the net.

Do the math:

 	2^ 16 = 65536
 	2^ 12 =  4096
 	2^  5 =    32
 	2^  0 =     1
----------------------
                 69655 = 0x11021

That's by convention 0x1021 as the X^16 is thrown away. I have
no clue how you could possibly get 0x8408 out of this, nor
how the CRC of 1 could possibly lie at offset 128 in a table
of CRC polynomials. Now I read it in the header, but that
doesn't make it right.

The "RS-232C" order to which you refer simply means that the
string of "bits" needs to handled as a string of bytes, not
words or longwords, in other words, not interpreted as
words, just bytes. If this isn't correct then ZMODEM and
a few other protocols are wrong. You certainly don't
swap every BIT in a string do you? You are not claiming
that (0x01 == 0x80) and (0x02 == 0x40), etc, are you?

According to the stuff on the web, CCITT just refers
to a CRC-16 with all bits set to begin with, and the
polynominal cited above. The end result is not inverted
nor byte-swapped.

>> Attached is a program that will generate a table of polynomials
>> for the conventional CRC lookup-table code. If you look at
>> the table in the kernel code, offset 1, you will see that
>> the polynomial is 0x1189. This corresponds to the CRC of
>> the value 1. It does not correspond to either your polynomials
>> or the ones documented on numerous web pages.
>

Well the table provided worked for a couple of years. I was
just trying to use the stuff in the kernel rather than some
"roll-your-own".

> No, it doesn't.  The table entry at offset *128* is the CRC polynomial,
> which is 0x8408, exactly as the comment just above the table says.
>
>
>> I think somebody just guessed and came up with "magic" because the
>> table being used isn't correct.
>
> The table being used is 100% correct.  There is no mistake.
> If you think you've found a mistake, there's something you're not
> understanding.
>
> Sorry to be so blunt, but it's true.
>
>>> The *other* think you have to do is append the checksum to the message
>>> correctly.  As mentioned earlier, the lsbit of a byte is considered
>>> first, so the lsbyte of the 16-bit accumulator is appended first.
>
>> Right, but the hardware did that. I have no control over that. I
>> have to figure out if:
>>
>> (1) It started with 0xffff or something else.
>> (2) It was inverted after.
>> (3) The result was byte-swapped.
>>
>> With the "usual" CRC-16 that I used before, using the lookup-
>> table that is for the 0x1021 polynomial, hardware was found
>> to have inverted and byte-swapped, but started with 0xefde
>> (0x1021 inverted). Trying to use the in-kernel CRC, I was
>> unable to find anything that made sense.
>
> You can get rid of the starting value and inversion by XORing together
> two messages (with valid CRCs) of equal length.  The result has a valid
> CRC with preset to 0 and no inversion.  You can figure that out later.
>
> Then, the only questions are the polynomial and bit ordering.
> (You can also have a screwed-up CRC byte ordering, but that's rare
> except in software written by people who don't know better.  Hardware
> invariably gets it right.)
>
> As I said, the commonest case is to consider the lsbit first.
> However, some implementations take the msbit of each byte first.
>
> Here's code to do it both ways.  This is the bit-at-a-time version,
> not using a table.  You can verify that the first implementation,
> fed an initial crc=0, poly=0x8408, and all possible 1-byte messages,
> produces the table in crc-ccitt.c.
>
> /*
> * Expects poly encoded so 0x8000 is x^0 and 0x0001 is x^15.
> * CRC should be appended lsbyte first.
> */
> uint16_t
> crc_lsb_first(uint16_t crc, uint16_t poly, unsigned char const *p, size_t len)
> {
> 	while (len--) {
> 		unsigned i;
> 		crc ^= (unsigned char)*p++;
> 		for (i = 0; i < 8; i++)
> 			crc = (crc >> 1) ^ ((crc & 1) ? poly : 0);
> 	}
> 	return crc;
> }
>
> /*
> * Expects poly encoded so 0x0001 is x^0 and 0x8000 is x^15.
> * CRC should be appended msbyte first.
> */
> uint16_t
> crc_msb_first(uint16_t crc, uint16_t poly, unsigned char const *p, size_t len)
> {
> 	while (len--) {
> 		unsigned i;
> 		crc ^= (uint16_t)(unsigned char)*p++ << 8;
> 		for (i = 0; i < 8; i++)
> 			crc = (crc << 1) ^ ((crc & 0x8000) ? poly : 0);
> 	}
> 	return crc;
> }
>
> If you're trying to reverse-engineer an unknown CRC, get two valid
> messages of the same length, form their XOR, and try a few different
> polynomials.  (There's a way to do it more efficiently using a GCD, but
> on a modern machine, it's faster to try all 32768 possible polynomials
> than to write and debug the GCD code.)
>
> After that, you can figure out the preset and final inversion, if any.
> For fixed-length messages, you can merge them into a single 16-bit
> constant that you can include at the beginning or the end, but if
> you have variable-length messages, it matters.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVHKMQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVHKMQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVHKMQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:16:25 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:34053 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932377AbVHKMQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:16:25 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C59E6E.77987B00"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050810205005.10963.qmail@science.horizon.com>
References: <20050810205005.10963.qmail@science.horizon.com>
X-OriginalArrivalTime: 11 Aug 2005 12:16:14.0707 (UTC) FILETIME=[78045C30:01C59E6E]
Content-class: urn:content-classes:message
Subject: Re: CCITT-CRC16 in kernel
Date: Thu, 11 Aug 2005 08:15:56 -0400
Message-ID: <Pine.LNX.4.61.0508110750400.14121@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: CCITT-CRC16 in kernel
Thread-Index: AcWebngOTylEDDHdTImP+roFzOFDug==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <linux@horizon.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C59E6E.77987B00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Wed, 10 Aug 2005 linux@horizon.com wrote:

>> Does anybody know what the CRC of a known string is supposed
>> to be? I have documentation that states that the CCITT CRC-16
>> of "123456789" is supposed to be 0xe5cc and "A" is supposed
>> to be 0x9479. The kernel one doesn't do this. In fact, I
>> haven't found anything on the net that returns the "correct"
>> value regardless of how it's initialized or how it's mucked
>> with after the CRC (well I could just set the CRC to 0 and
>> add the correct number). Anyway, how do I use the crc_citt
>> in the kernel? I've grepped through some drivers that use
>> it and they all seem to check the result against some
>> magic rather than performing the CRC of data, but not the
>> CRC, then comparing it to the CRC. One should not have
>> to use magic to verify a CRC, one should just perform
>> a CRC on the data, but not the CRC, then compare the result
>> with the CRC. Am I missing something here?
>
> There are two common 16-bit CRC polynomials.
> The original IBM CRC-16 is x^16 + x^15 + x^2 + 1.
> The more popular CRC-CCITT is x^16 + x^12 + x^5 + 1.
>
> Both of thse include (x+1) as a factor, so provide parity detection,
> detecting all odd-bit errors, at the expense of reducing the largest
> detectable 2-bit error from 65535 bits to 32767.
>
> All CRC algorithms work on bit strings, so an endianness convention
> for bits within a byte is always required.  Unless specified, the
> little-endian RS-232 serial transmission order is generally assumed.
> That isl the least significant bit of the first byte is "first".
>
> This bit string is equated to a polynomial where the first bit is
> the coefficient of the highest power of x, and the last bit (msbit of
> the last byte) is the coefficient of x^0.
>
> (Some people think of this as big-endian, and get all confused.)
>
> Using this bit-ordering, and omitting the x^16 term as is
> conventional (it's implicit in the implementation), the polynomials
> come out as:
> CRC-16: 0xa001
> CRC-CCITT: 0x8408
>

Huh? That's the problem.

X^16 + X^12 + X^5 + X^0 =3D 0x1021, not 0xa001

Also,

X^16 + X^15 + X^2 + X^0 =3D 0x8005, not 0x8408

Attached is a program that will generate a table of polynomials
for the conventional CRC lookup-table code. If you look at
the table in the kernel code, offset 1, you will see that
the polynomial is 0x1189. This corresponds to the CRC of
the value 1. It does not correspond to either your polynomials
or the ones documented on numerous web pages.

> The mathematically "cleanest" CRC has the unfortunate property that
> leading or trailing zero bits can be added or removed without affecting
> the CRC computation.  That is, they are not detected as errors.
> For fixed-size messages, this does not matter, but for variable-sized
> messages, a way to detect inserted or deleted padding is desirable.
>

So yes, we start with 0xffff.

> To detect leading padding, it is customary to invert the first 16 bits
> of the message.  This is equivalent to initializing the CRC accumulator
> to all-ones rather than 0, and is invariably implemented that way.
>
> This change is duplicated on CRC verification, and has no effect on the
> final result.
>
> To detect trailing padding, it is customary to invert all 16 bits of
> the CRC before appending it to the message.  This has an effect on
> CRC verification.
>
> One way to CRC-check a message is to compute the CRC of the entire
> message *including* the CRC.  You can see this in many link-layer=
 protocol
> specifications which place the trailing frame delimiter after the CRC,
> because the decoding hardware doesn't need to know in advance where the
> message stops and the CRC starts.
>
> If the CRC is NOT inverted, the CRC of a correct message should be zero.
> If the CRC is inverted, the correct CRC is a non-zero constant.  You can
> still use the same "checksum everything, including the original CRC"
> technique, but you have to compare with a non-zero result value.
>
> For CRC-16, the final result is x^15 + x^3 + x^2 + 1 (0xb001).
> For CRC-CCITT, the final result is x^13+x^11+x^10+x^8+x^x^3+x^2+x+1=
 (0xf0b8).
>

I think somebody just guessed and came up with "magic" because the
table being used isn't correct.

> The *other* think you have to do is append the checksum to the message
> correctly.  As mentioned earlier, the lsbit of a byte is considered
> first, so the lsbyte of the 16-bit accumulator is appended first.
>

Right, but the hardware did that. I have no control over that. I
have to figure out if:

(1) It started with 0xffff or something else.
(2) It was inverted after.
(3) The result was byte-swapped.

With the "usual" CRC-16 that I used before, using the lookup-
table that is for the 0x1021 polynomial, hardware was found
to have inverted and byte-swapped, but started with 0xefde
(0x1021 inverted). Trying to use the in-kernel CRC, I was
unable to find anything that made sense.

>
> Anyway, with all this, and using preset-to-all-ones:
> CRC-CCITT of "A" is 0x5c0a, or f5 a3 when inverted and converted to=
 bytes.
> CRC-CCITT of "123456789" is 0x6f91, or 63 90.
> (When preset to zero, the values are 0x538d and 0x2189, respectively.
> That would be 8d 53 or 89 21 if *not* inverted.)
>

Thanks.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :


****************************************************************
The information transmitted in this message is confidential and may be=
 privileged.  Any review, retransmission, dissemination, or other use of=
 this information by persons or entities other than the intended recipient=
 is prohibited.  If you are not the intended recipient, please notify=
 Analogic Corporation immediately - by replying to this message or by=
 sending an email to DeliveryErrors@analogic.com - and destroy all copies=
 of this information, including any attachments, without reading or=
 disclosing them.

Thank you.
------_=_NextPart_001_01C59E6E.77987B00
Content-Type: TEXT/PLAIN;
	name="gentable.c"
Content-Transfer-Encoding: base64
Content-Description: gentable.c
Content-Disposition: attachment;
	filename="gentable.c"

Ly8tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09DQovLw0KLy8gIENvcHlyaWdodChjKSAgMjAwNCAgQW5hbG9n
aWMgQ29ycG9yYXRpb24NCi8vDQovLyAgVGhpcyBwcm9ncmFtIG1heSBiZSBkaXN0cmlidXRlZCB1
bmRlciB0aGUgR05VIFB1YmxpYyBMaWNlbnNlDQovLyAgdmVyc2lvbiAyLCBhcyBwdWJsaXNoZWQg
YnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwNCi8vICA1OSBUZW1wbGUgUGxh
Y2UsIFN1aXRlIDMzMCBCb3N0b24sIE1BLCAwMjExMS4NCi8vDQovLy09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0NCg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5jbHVkZSA8
c3RyaW5nLmg+DQojaW5jbHVkZSA8c3RkaW50Lmg+DQoNCi8vLT0tPS09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tDQov
Lw0KLy8gQ2FsY3VsYXRlIHRoZSB2YWx1ZSB0byBYT1IgaW50byB0aGUgc2hpZnRlZCBDUkMgcmVn
aXN0ZXIgZm9yIHRoZQ0KLy8gZ2l2ZW4gaW5wdXQuIEJpdHMgc2hvdWxkIGJlIHRoZSAid2lkdGgi
IG9mIHRoZSBjaHVuayBiZWluZyBvcGVyYXRlZCBvbi4NCi8vIFBvbHkgaXMgdGhlIHBvbHlub21p
YWwgdG8gdXNlIGxpa2UgMHgxMDIxLg0KLy8NCi8vIENyZWF0ZWQgMTItTUFZLTIwMDQgUmljaGFy
ZCBCLiBKb2huc29uICAgICAgIHJqb2huc29uQGFuYWxvZ2ljLmNvbQ0KLy8NCnVpbnQxNl90IGNy
YzE2KHVpbnQxNl90IHZhbCwgc2l6ZV90IGJpdHMsIHVpbnQxNl90IHBvbHkpDQp7DQogICAgICAg
IHVpbnQxNl90IHhvcjsNCiAgICAgICAgICAgICAgICANCiAgICAgICAgdmFsIDw8PSAoMTYgLSBi
aXRzKTsNCg0KICAgICAgICB3aGlsZShiaXRzLS0pDQogICAgICAgIHsNCiAgICAgICAgICAgIHhv
ciA9ICh2YWwgJiAweDgwMDApID8gcG9seSA6IDA7DQogICAgICAgICAgICB2YWwgPDw9IDE7DQog
ICAgICAgICAgICB2YWwgXj0geG9yOw0KICAgICAgICB9DQogICAgICAgIHJldHVybiB2YWw7DQp9
DQovLy09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LQ0KDQojZGVmaW5lIE5SX0JJVFMgOA0KDQppbnQgbWFpbihp
bnQgYXJncywgY2hhciAqYXJndltdKQ0Kew0KICAgIHNpemVfdCBpLCBjb3VudDsNCiAgICB1aW50
MzJfdCBwb2x5Ow0KICAgIGlmKGFyZ3MgPCAyKQ0KICAgIHsNCiAgICAgICAgZnByaW50ZihzdGRl
cnIsICJVc2FnZTpcbiVzIFtwb2x5XVxuIiwgYXJndlswXSk7DQogICAgICAgIGV4aXQoRVhJVF9G
QUlMVVJFKTsNCiAgICB9DQogICAgcG9seSA9IDB4MDA7DQogICAgc3NjYW5mKGFyZ3ZbMV0sICIl
MDR4IiwgJnBvbHkpOw0KICAgIGlmKCFwb2x5KQ0KICAgIHsNCiAgICAgICAgZnByaW50ZihzdGRl
cnIsICIlcyBpcyBub3QgYSB2YWxpZCBwYXJhbWV0ZXJcbiIsIGFyZ3ZbMV0pOw0KICAgICAgICBl
eGl0KEVYSVRfRkFJTFVSRSk7DQogICAgfQ0KICAgIGNvdW50ID0gMSA8PCBOUl9CSVRTOw0KICAg
IHByaW50ZigiLy9cbi8vIENSQy0xNiBMb29rdXAgdGFibGUgZm9yICV1IGJpdHMgcGVyIGl0ZXJh
dGlvbi4iXA0KICAgICAgICAgICAiIEZ1bGwgV09SRCBwZXIgZW50cnlcbi8vXG4iLCBOUl9CSVRT
ICk7DQogICAgcHJpbnRmKCJzdGF0aWMgY29uc3QgdWludDE2X3QgQ1JDJXNfdGFibGVbJXVdID0g
eyIsIGFyZ3ZbMV0sIGNvdW50ICk7DQogICAgZm9yKGkgPSAwOyBpIDwgY291bnQ7IGkrKykNCiAg
ICB7DQogICAgICAgIGlmKCEoaSAlIDgpKQ0KICAgICAgICAgICAgcHJpbnRmKCJcblx0Iik7DQog
ICAgICAgIHByaW50ZigiMHglMDR4IiwgY3JjMTYoaSwgTlJfQklUUywgcG9seSkpOw0KICAgICAg
ICBpZihpKzEgIT0gY291bnQpDQogICAgICAgICAgICBwcmludGYoIiwgIik7DQogICAgfQ0KICAg
IHByaW50ZigiXG59O1xuIiApOw0KICAgIHJldHVybiAwOw0KfQ0KLy8tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0t
PS0NCi8vLT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LT0tDQovLy09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0t
PS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LQ0K

------_=_NextPart_001_01C59E6E.77987B00--

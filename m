Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318677AbSG0CD1>; Fri, 26 Jul 2002 22:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318678AbSG0CD1>; Fri, 26 Jul 2002 22:03:27 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:21766 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318677AbSG0CD0>;
	Fri, 26 Jul 2002 22:03:26 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207270205.g6R253P35635@saturn.cs.uml.edu>
Subject: Re: [PATCH -ac] Panicking in morse code
To: j.schmidt@paradise.net.nz (Jens Schmidt)
Date: Fri, 26 Jul 2002 22:05:03 -0400 (EDT)
Cc: root@chaos.analogic.com, davidsen@tmr.com (Bill Davidsen),
       phillips@arcor.de (Daniel Phillips), arodland@noln.com (Andrew Rodland),
       linux-kernel@vger.kernel.org
In-Reply-To: <3D41DA4E.B243E55E@paradise.net.nz> from "Jens Schmidt" at Jul 27, 2002 11:25:02 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Schmidt writes:

> I am not a "morse" guy myself, but appreciate this idea.

Yeah, same here. I have to wonder if morse is the
best encoding, since many people don't know it.
The vast majority of us would need a microphone and
translator program anyway, so a computer-friendly
encoding makes more sense. Modems don't do morse.

>    (less common)
>    Brackets (parentheses) -.--.-

Left/right just assumed?

>    Procedure codes
>    Commence transmission  -.-.-   (CT)
>    Wait                   .-...   (AS)
>    End of message         .-.-.   (AR)
>    End of work            ...-.-  (SK)
>    The procedure codes are sent as a single character

If morse fans actually know these, then an interpretation
for correct usage in an oops would need to be determined.

>   If the duration of a dot is taken to be one unit then
>   that of a dash is three units.
>   The space between the components of one character is one
>   unit, between characters is three units and between
>   words seven units.

The ARRL doesn't do this below 18 WPM. They use an
alternate timing (Farnsworth) that sends characters
at 18 WPM and adds extra space to slow down the result.

http://www.arrl.org/files/infoserv/tech/code-std.txt

The latest patch was doing 12 WPM. At that speed,
the ARRL would use Farnsworth timing.

>>>>>>> +static const char * morse[] = {
>>>>>>> +     ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */

Packing into bytes while still being readable:

#define o 0  // dot
#define _ 1  // dash
#define PACK(a,b,c,d,e,f,g,h) (((((((a*2+b)*2+c)*2+d)*2+e)*2+f)*2+g)*2+h)
#define M7(a,b,c,d,e,f,g) PACK(1,a,b,c,d,e,f,g)
#define M6(b,c,d,e,f,g)   PACK(0,1,b,c,d,e,f,g)
#define M5(c,d,e,f,g)     PACK(0,0,1,c,d,e,f,g)
#define M4(d,e,f,g)       PACK(0,0,0,1,d,e,f,g)
#define M3(e,f,g)         PACK(0,0,0,0,1,e,f,g)
#define M2(f,g)           PACK(0,0,0,0,0,1,f,g)
#define M1(g)             PACK(0,0,0,0,0,0,1,g)

static const u8 morse[] = {
  M2(o,_), M4(_,o,o,o), M4(_,o,_,o), M3(_,o,o),   // A B C D
  M1(o), M4(o,o,_,o), M3(_,_,o), M4(o,o,o,o),     // E F G H

I suspect it's false economy to not encode all of ASCII.
If you have all of ASCII, then the ugly switch() goes away
and all you need is a foo&0x7f to ensure things don't go
from bad to worse.

>> The '.' (also called full-stop) is 6 elements long. The ',' is also
>> 6 elements long. For a correct implimentation, i.e., one that sounds
>> correct, you need to encode a 'pause' element into each symbol. This
>> is because the pause between Morse characters is sometimes ahead
>> of a character and sometimes behind a character (the pause is ahead
>> of characters starting with a dot and after characters ending with a
>> dot, including characters of all dots -- except for numbers, which
>> have pauses after them). In a previously life, I had to develop
>> the correct "fist" to pass the Socond Class Radio Telegraph License.

If this is desirable, which I doubt, then it's best generated
by looking at the characters.

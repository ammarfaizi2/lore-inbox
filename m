Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129387AbQKYFEF>; Sat, 25 Nov 2000 00:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129697AbQKYFDz>; Sat, 25 Nov 2000 00:03:55 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:51217 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129387AbQKYFDw>;
        Sat, 25 Nov 2000 00:03:52 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011250433.eAP4Xbf113799@saturn.cs.uml.edu>
Subject: Re: silly [< >] and other excess
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 24 Nov 2000 23:33:37 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011230753.eAN7rOt14124@flint.arm.linux.org.uk> from "Russell King" at Nov 23, 2000 07:53:24 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> Albert D. Cahalan writes:

>>> they are not only references to
>>> kernel functions, but also kernel data and read only data within
>>> the kernel text segment.
>>
>> 1. this is harmless
>> 2. this is useful (you might get a variable's name)
>
> Wrong.  Op-codes on this machine are organised such that bits 31-28
> indicate the "condition" that the instruction executes.  All 16
> combinations are meaningful.  This means that any 32-bit value can
> appear to be an instruction OR data.  It takes human intellect to
> decide which it is.  No machine can tell you that.

You haven't shown me to be wrong. How exactly is it harmful to
err on the side of doing symbol lookups that aren't required?
Maybe you'd like an example; I'll provide one below.

>> Nope. You get the unmolested oops and some symbol data.
>> If there isn't any symbol for 0x424a5149, so what? It is
>> no big deal to look up a few opcodes in the symbol table
>> by accident.
>
> But there could well be a symbol for 0xc0023004, but it also
> corresponds to the instruction:
>
> 	andgt   r3, r2, r4

Yes. So what?

> "Perform a logical AND operation between r2 and r4 and place the result
>  in r3 if the condition codes indicate the `Greater Than' condition"
>
> In addition, the kernel may not be compiled to run at address 0xC.......
> but at address 0x6....... or maybe even 0xe.......  Guess what 0xE means
> in the high nibble of the op-code?  "Always", or "Unconditional".

Again, not a problem. Here is the example:

---- example crash ----
kernel NULL (0000002c) accessed from c01a4b98
GPRs c0294041 00000000 c01a4600 0000000a 00000200 c0258000 ffffffff
OSRs 00000000 00403100 c0100000 00000002
RAR c0105344 SP c0294080 FCR 00000000 FSR 00000000
Stack: 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000
Trace: bad stack frame
Code: 8a739052 c000000a 41310001 87052926
-----------------------

Then it gets run through a simple tool that never fails to look
up a symbol that needs to be looked up:

---- example report of the above crash ----
kernel NULL (0000002c) accessed from c01a4b98
GPRs c0294041 00000000 c01a4600 0000000a 00000200 c0258000 ffffffff
OSRs 00000000 00403100 c0100000 00000002
RAR c0105344 SP c0294080 FCR 00000000 FSR 00000000
Stack: 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000
Trace: bad stack frame
Code: 8a739052 c000000a 41310001 87052926

Symbols:
c000000a __start
c0105344 qfs_frob_directory
c01a4600 qfs_cleaner
c01a4b98 qfs_hash_file_record
-------------------------------------------

Well, that first symbol (__start) was really "jump +10", but the
extra noise doesn't hurt anyone. You get what you need, no matter
how mangled the oops is. It can be word-wrapped, missing chunks...
The tool doesn't need to care.

Code disassembly is useful too, and again it is best to err on
the side of decoding more than is required. Remember that users
tend to mangle oops data. If the FCR register get disassembled
as a breakpoint instruction... hey, just ignore the extra noise.

When tools really try to understand an oops, they screw up.
They ignore data that should be looked up as symbols.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

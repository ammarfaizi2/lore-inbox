Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRHMFDK>; Mon, 13 Aug 2001 01:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269801AbRHMFCu>; Mon, 13 Aug 2001 01:02:50 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:44306 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S269796AbRHMFCa>;
	Mon, 13 Aug 2001 01:02:30 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108130502.f7D52eI16075@saturn.cs.uml.edu>
Subject: Re: __asm__ usage ????
To: vraghava_raju@yahoo.com (Raghava Raju)
Date: Mon, 13 Aug 2001 01:02:40 -0400 (EDT)
Cc: egger@suse.de (Daniel Egger), linux-kernel@vger.kernel.org
In-Reply-To: <20010811210336.39004.qmail@web20001.mail.yahoo.com> from "Raghava Raju" at Aug 11, 2001 02:03:36 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raghava Raju writes:

>>> 	__asm__ __volatile__(SMP_WMB "\
>>> 1:	lwarx 	%0,0,%3
>>> 	andc  	%0,%0,%2
>>> 	stwcx 	%0,0,%3
>>> 	bne 	1b"
>>> 	SMP_MB
>>> 	: "=&r" (old), "=m" (*p)
>>> 	: "r" (mask), "r" (p), "m" (*p)
>>> 	: "cc")"
>>>         4) I think in power PC we can't access
>>> directly the contents of memory, but we should
>>> give addresses of memory in registers then use
>>> registers in instructions to access memory. But in
>>> above example he is using %3 in lwarx command
>>> accessing that memory directly. Is my
>> interpretation
>>> of above instructions wrong.
>>
>> Yes, you're wrong. By issuing an "r" (p) the p
>> (which is a pointer in this case) is assigned
>> to a register which is then used in the load
>> command as the absolute address.
>
>    What I meant is that say in command
>     "andc  	%0,%0,%2" he is directly accessing the
>     contents of memory and using them in "andc". But

NO! He is not doing that. The compiler changes the
above into this:

1. address generation for the variable "p"
2. whatever SMP_WMB is
3. something like "lwarx r5,0,r8" (gcc picks the registers)
4. something like "andc  r5,r5,r7"
5. something like "stwcx r5,0,r8"
6. a branch back to the lwarx
7. whatever SMP_MB is

Note: the lwarx is a special type of load instruction.

>     it seems to be that he should use indirectly, like
>    storing the address of variable in register. Then
>    use register in "andc" instead of directly using
>    %0(i.e accessing memory directly). Correct me if

The funny notation at the end instructs gcc to load the
variable into a register and save it back as needed.

>    I am wrong since powerPC mannual described that
>    we should not use memory directly in instructions.

You may not use memory directly in the andc instruction.

>>> 6) Finally I want to write a simple programme
>>> to write the contents of a local variable "xyz"
>>> into register r33, then store the contents of
>>> r33 into local variable "abc". Kindly would u
>>> give me a sample code of doing it.
>>
>> Negative for two reasons: There is no register 33
>> (at least) on 32bit PPC CPUs, and second, you
>> normally don't want to hardcode registers in
>> inline assembly. If you really want to then use
>> normal assembly.
>>
>> But for your example:
>> long xyz, abc;
>>
>> __asm__ __volatile__ ("mr %0,%1\n\t": "r" (abc) :
>> "r" (xyz));
>>
>> However this is a really dumb example.
>
> Here I dont bother about logic of the example, but
> I want know how to load the value of some (valid
> register, if not r33 something else in powerPC)
> register into a local variable xyz and vice versa.

Stop thinking like this. You can not write good code if you
insist on choosing registers. The strange gcc assembly notation
is designed to let you cooperate with the compiler. Rather than
saying you want "r33" you say you want "any normal integer
register containing the content of variable xyz". Then gcc will
pick a free register, call it %0 or %1 or whatever, and load it
with variable "xyz".

If variable "xyz" is already in register r6, then why wouldn't
you want to use r6 for your assembly? If you pick a specific
register, then the compiler might have to copy from r6 into the
one you specified. That would be bad. When you let gcc choose,
it picks a register that is good to use.

Looking at this again:

__asm__ __volatile__ (
"mr %0,%1"               /* %0 and %1 may represent r6 */
: "=r" (abc)             /* the output (can have many!) */
: "r" (xyz)              /* the input (can have many!) */
:                        /* no special registers will be modified */
);

You could even code this as a NOP, using the funny constraint notation
to make gcc do the copy for you. Simply specify that the input is to
be the exact same register as the input. I think it is something
like this:

__asm__ __volatile__ (
""                       /* just empty -- don't even need a NOP */
: "=r" (abc)             /* let gcc select an output register */
: "0" (xyz)              /* ask gcc to use the same register for input */
:                        /* no special registers will be modified */
);

Well there you go. This makes gcc load xyz into a register if it isn't
already in one, then makes gcc assume that the register contains the
new value for abc.

Be careful about the constraint letters you choose. For most PowerPC
instructions, any integer register will do. For load/store instructions,
the CPU treats r0 as a special case. You might need to change the "r"
to something else, like "b" or "a" maybe. Look it up in the gcc manual.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVC3QZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVC3QZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 11:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVC3QZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 11:25:27 -0500
Received: from alog0692.analogic.com ([208.224.223.229]:15310 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262322AbVC3QZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 11:25:07 -0500
Date: Wed, 30 Mar 2005 11:23:25 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: "H. J. Lu" <hjl@lucon.org>, binutils@sources.redhat.com,
       GNU C Library <libc-alpha@sources.redhat.com>, Andi Kleen <ak@muc.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment
 register access)
In-Reply-To: <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0503301120130.27995@chaos.analogic.com>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org>
 <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org>
 <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org>
 <20050330040017.GA29523@lucon.org> <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Linus Torvalds wrote:

>
> [ binutils and libc back in the discussion - I don't know why they got
>  dropped ]
>
> On Tue, 29 Mar 2005, H. J. Lu wrote:
>>
>> There is no such an instruction of "movl %ds,(%eax)". The old assembler
>> accepts it and turns it into "movw %ds,(%eax)".
>
> I disagree. Violently. As does the old assembler, which does not turn
> "mov" into "movw" as you say. AT ALL.
>
> A "movw" has a 0x66 prefix. The assembler agree with me. Plain logic
> agrees with me. Being consistent _also_ agrees with me (it's the same damn
> instruction to move to a register, for chrissake!)
>
> "movw" is totally different from "movl". They _act_ the same, but that's
> like saying that "orw $5,%ax" is the same as "orl $5,%eax". They also
> _act_ the same, but that IN NO WAY makes them the same.
>
> According to your logic, the assembler should disallow "orl $5,ax" because
> it does the same thing as "or $5,%eax" and "orw $5,%eax", and thus to
> "protect" the user, the user should not be able to say the size
> explicitly.
>
> The fact is, every single "mov" instruction takes the size hint, and it
> HAS MEANING, even if the meaning is only about performance, not about
> semantics. In other words, yes, in the specific case of "mov segment to
> memory", it ends up being only a performance hit, but as such IT DOES HAVE
> MEANING. And in fact, even if it didn't end up having any meaning at all,
> it's still a good idea as just a consistency issue.
>
> Dammit, if I say "orl $5,%eax", I mean "orl $5,%eax", and if the assembler
> complains about it or claims it is the same as "orw $5,%ax", then the
> assembler is fundamentally BROKEN.
>
> None of your arguments have in any way responded to this fact.
>
> If you think people should use just "mov", then fine, let people use
> "mov". That's their choice - the same way you can write just "or $5,%eax"
> and gas will pick the 32-bit version based on the register name, yes, you
> should be able to write just "mov %fs,mem", and gas will pick whatever
> version using its heuristics for the size (in this case the 32-bit, since
> it does the same thing and is smaller and faster).
>
> And "mov" has always worked. The kernel just doesn't use it much, because
> the kernel - for good historical reasons - doesn't trust gas to pick sizes
> of instructions automagically.
>
> And the fact that it is obvious that gas _should_ pick the 32-bit format
> of the instruction when you do not specify a size does NOT MEAN that it's
> wrong to specify the size explicitly.
>
> And your arguments that there is no semantic difference between the 16-bit
> and the 32-bit version IS MEANINGLESS. An assembler shouldn't care. This
> is not an argument about semantic difference. This is an argument over a
> user wanting to make the size explicit, to DOCUMENT it.
>
> The fact is, if users use "movl" and "movw" explicitly (and the kernel has
> traditionally been _very_ careful to use all instruction sizes explicitly,
> partly exactly because gas itself has been very happy-go-lucky about
> them), then that is a GOOD THING. It means that the instruction is
> well-defined to somebody who knows the x86 instruction set, and he never
> needs to worry or use "objdump" to see if gas was being stupid and
> generated the 16-bit version.
>
> 			Linus
> -


We went over this stuff when we first started using the
Intel 486. (Ref Intel 486 Microprocessor Programmers
reference manual, ISBN 1-55512-192-4)

Segment registers are really 32 bits in length. They
have a 'visible' part and an invisible part. The
visible part contains the 16-bit selector. The
invisible part contains the base address, limit,
etc., that was loaded from the GDT or the LDT.
(Ref. pp 5-9)

All access to these registers is 32 bits. If you
execute	'push ds' or 'pop ds' the stack-pointer
will move 4 bytes. An 0x66 override prefix is
ignored when accessing segment registers. It
should never be used. There is another override
prefix that can be used instead. The push ds
opcode is 0x1e and the pop ds opcode is 0x1f
if somebody wants to experiment.

Even a move from a CPU general purpose register
to a segment register is a 32-bit operation. If
you want to move the contents of a segment register
to memory or a register as a 16-bit action, for
instance not overwriting the high-word of a register,
the override prefix is 0x67, not 0x66. (Ref. pp 26-210)

This means that segment values stored in memory 
should really be aligned on 32-bit boundaries
so that extra clock-cycles are not wasted
accessing these registers. This also means
that they should be treated as (Posix) uint32_t
not uint16_t, even though the value will never
exceed 8192.

So if there are any "movw (mem), %ds" and
"movw %ds, (mem)" in the code. The sizeof(mem)
needs to be 32-bits and the 'w' needs to be removed.
Otherwise, we are wasting CPU cycles and/or fooling
ourselves. GAS needs to continue to generate whatever
it was fed, with appropriate diagnostics if it
is fed the wrong stuff.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVC3P6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVC3P6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVC3P4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:56:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:20690 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262296AbVC3P4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:56:03 -0500
Date: Wed, 30 Mar 2005 07:57:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. J. Lu" <hjl@lucon.org>, binutils@sources.redhat.com,
       GNU C Library <libc-alpha@sources.redhat.com>
cc: Andi Kleen <ak@muc.de>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment
 register access)
In-Reply-To: <20050330040017.GA29523@lucon.org>
Message-ID: <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org>
 <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org>
 <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org>
 <20050330040017.GA29523@lucon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ binutils and libc back in the discussion - I don't know why they got 
  dropped ]

On Tue, 29 Mar 2005, H. J. Lu wrote:
> 
> There is no such an instruction of "movl %ds,(%eax)". The old assembler
> accepts it and turns it into "movw %ds,(%eax)".

I disagree. Violently. As does the old assembler, which does not turn 
"mov" into "movw" as you say. AT ALL.

A "movw" has a 0x66 prefix. The assembler agree with me. Plain logic 
agrees with me. Being consistent _also_ agrees with me (it's the same damn 
instruction to move to a register, for chrissake!)

"movw" is totally different from "movl". They _act_ the same, but that's 
like saying that "orw $5,%ax" is the same as "orl $5,%eax". They also 
_act_ the same, but that IN NO WAY makes them the same.

According to your logic, the assembler should disallow "orl $5,ax" because
it does the same thing as "or $5,%eax" and "orw $5,%eax", and thus to
"protect" the user, the user should not be able to say the size
explicitly.

The fact is, every single "mov" instruction takes the size hint, and it
HAS MEANING, even if the meaning is only about performance, not about
semantics. In other words, yes, in the specific case of "mov segment to
memory", it ends up being only a performance hit, but as such IT DOES HAVE
MEANING. And in fact, even if it didn't end up having any meaning at all, 
it's still a good idea as just a consistency issue.

Dammit, if I say "orl $5,%eax", I mean "orl $5,%eax", and if the assembler 
complains about it or claims it is the same as "orw $5,%ax", then the 
assembler is fundamentally BROKEN.

None of your arguments have in any way responded to this fact. 

If you think people should use just "mov", then fine, let people use 
"mov". That's their choice - the same way you can write just "or $5,%eax" 
and gas will pick the 32-bit version based on the register name, yes, you 
should be able to write just "mov %fs,mem", and gas will pick whatever 
version using its heuristics for the size (in this case the 32-bit, since 
it does the same thing and is smaller and faster).

And "mov" has always worked. The kernel just doesn't use it much, because 
the kernel - for good historical reasons - doesn't trust gas to pick sizes 
of instructions automagically.

And the fact that it is obvious that gas _should_ pick the 32-bit format
of the instruction when you do not specify a size does NOT MEAN that it's
wrong to specify the size explicitly.

And your arguments that there is no semantic difference between the 16-bit 
and the 32-bit version IS MEANINGLESS. An assembler shouldn't care. This 
is not an argument about semantic difference. This is an argument over a 
user wanting to make the size explicit, to DOCUMENT it.

The fact is, if users use "movl" and "movw" explicitly (and the kernel has
traditionally been _very_ careful to use all instruction sizes explicitly,
partly exactly because gas itself has been very happy-go-lucky about
them), then that is a GOOD THING. It means that the instruction is
well-defined to somebody who knows the x86 instruction set, and he never
needs to worry or use "objdump" to see if gas was being stupid and
generated the 16-bit version.

			Linus

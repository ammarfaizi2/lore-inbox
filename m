Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVC3VLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVC3VLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVC3VLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:11:09 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:27366 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261563AbVC3VIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:08:04 -0500
Date: Wed, 30 Mar 2005 13:08:01 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: binutils@sources.redhat.com, Andi Kleen <ak@muc.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050330210801.GA15384@lucon.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org> <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org> <20050330040017.GA29523@lucon.org> <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 07:57:28AM -0800, Linus Torvalds wrote:
> 
> [ binutils and libc back in the discussion - I don't know why they got 
>   dropped ]

Removing glibc since it accesses segment register with proper
instructions.

> 
> On Tue, 29 Mar 2005, H. J. Lu wrote:
> > 
> > There is no such an instruction of "movl %ds,(%eax)". The old assembler
> > accepts it and turns it into "movw %ds,(%eax)".
> 
> I disagree. Violently. As does the old assembler, which does not turn 
> "mov" into "movw" as you say. AT ALL.

I should have made myself clear. By "movw %ds,(%eax)", I meant:

	8c 18	movw   %ds,(%eax)

That is what the assembler generates, and should have generated, for
"movw %ds,(%eax)" since Nov. 4, 2004.

> 
> A "movw" has a 0x66 prefix. The assembler agree with me. Plain logic 
> agrees with me. Being consistent _also_ agrees with me (it's the same damn 
> instruction to move to a register, for chrissake!)

This is a bug in asssembler and has been fixed on Nov. 4, 2004. If
you want the 0x66 prefix for "movw %ds,(%eax)", you need to use
"word movw %ds,(%eax)" with the new assembler.

> 
> The fact is, every single "mov" instruction takes the size hint, and it
> HAS MEANING, even if the meaning is only about performance, not about
> semantics. In other words, yes, in the specific case of "mov segment to
> memory", it ends up being only a performance hit, but as such IT DOES HAVE
> MEANING. And in fact, even if it didn't end up having any meaning at all, 
> it's still a good idea as just a consistency issue.

Accessing segment register is a very special case. It has been treated
differently by gas. Try "movw (%eax),%ds" with your gas. Gas doesn't
generate 0x66. The "movw %ds,(%eax)" bug was fixed last year.

> If you think people should use just "mov", then fine, let people use 

I only suggested "mov" for old assemblers.

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

For segment register access, there is no 16-bit nor 32-bit version.
There is only one version.

> is not an argument about semantic difference. This is an argument over a 
> user wanting to make the size explicit, to DOCUMENT it.

Are you suggesting that gas should put back 0x66 for both
"movw %ds,(%eax)" and "movw (%eax),%ds"?

> 
> The fact is, if users use "movl" and "movw" explicitly (and the kernel has
> traditionally been _very_ careful to use all instruction sizes explicitly,
> partly exactly because gas itself has been very happy-go-lucky about
> them), then that is a GOOD THING. It means that the instruction is
> well-defined to somebody who knows the x86 instruction set, and he never
> needs to worry or use "objdump" to see if gas was being stupid and
> generated the 16-bit version.

Allowing "movl %ds,(%eax)" has a possibilty that people assume it will
update 32bit memory location. That is how this issue was uncovered.
If you really don't like "mov %ds,(%eax)" and want to support the
old assembler, I can write a kernel patch to check asssembler to
use "movl" for the old asssembler and "movw" for the new assembler.

BTW, to report problems with assembler, there is

http://www.sourceware.org/bugzilla/

Or I can be reached at hjl@lucon.org.


H.J.

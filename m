Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVC3BxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVC3BxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVC3BxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:53:23 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:50336 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261709AbVC3BxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:53:13 -0500
Date: Tue, 29 Mar 2005 17:53:12 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050330015312.GA27309@lucon.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 04:30:01PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 28 Mar 2005, Andi Kleen wrote:
> >
> > "H. J. Lu" <hjl@lucon.org> writes:
> > > The new assembler will disallow them since those instructions with
> > > memory operand will only use the first 16bits. If the memory operand
> > > is 16bit, you won't see any problems. But if the memory destinatin
> > > is 32bit, the upper 16bits may have random values. The new assembler
> > 
> > Does it really have random values on existing x86 hardware?
> 
> The upper bits are not written at all, so it's not random.
> 
> > If it is a only a "theoretical" problem that does not happen
> > in practice I would advise to not do the change.
> 
> My preference too. The reason we use "movl" is because we really do want 
> the 32-bit versions, since they are faster. It's a conscious choice. In 
> contrast "movw" generates bigger and slower code on all assemblers out 
> there, and "mov" doesn't make it clear which one it is. Is it the slow 
> one, or the fast one? 

"mov" shouldn't generate the 0x66 prefix, at least with the assembler
since binutils 2.14.90.0.4 20030523. The assembler in CVS won't generate
0x66 for "movw" either.

> Now, those versions of gas may be so old that nobody cares, but the
> explicit size still is a GOOD THING. The size DOES MATTER. People who want

Suggesting "mov" instead of "movw" is for the existing assemblers. Or
kernel can check assembler version to decide if "movw" should be used.
I can verify the first Linux assembler which won't generate 0x66 for
"movw".

> the smaller and faster version do not want to just rely on gas
> automatically getting it right, especially since gas has historically been
> very very bad at getting things right.

We are fixing those issues in assembler. If people run into problems
like that with gas, they can report them. They will be fixed.

> 
> What is the advantage of not allowing "movl %ds,mem"? Really? Especially
> since I suspect the kernel is pretty much the only one who does this, and
> the kernel really does do it on purpose. The kernel explicitly wants the
> 32-bit version, knowing that the upper bits are undefined.
> 

Kernel has

	unsigned gsindex;
	asm volatile("movl %%gs,%0" : "=g" (gsindex));
	...
	if (gsindex)
		

It is OK if gcc never generates memory access like

	movl %gs,0x128(%rsp)

Otherwise, the upper bits in gsindex are undefined. The new
assembler will make sure that it won't happen.


H.J.

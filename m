Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVC3EAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVC3EAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 23:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVC3EAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 23:00:38 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:754 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261365AbVC3EAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 23:00:18 -0500
Date: Tue, 29 Mar 2005 20:00:17 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050330040017.GA29523@lucon.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org> <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 06:44:18PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 29 Mar 2005, H. J. Lu wrote:
> > 
> > > the smaller and faster version do not want to just rely on gas
> > > automatically getting it right, especially since gas has historically been
> > > very very bad at getting things right.
> > 
> > We are fixing those issues in assembler. If people run into problems
> > like that with gas, they can report them. They will be fixed.
> 
> It's fine if gas fixes things. It's not fine if gas breaks things that 
> used to work, for no really good reason.
> 
> > > What is the advantage of not allowing "movl %ds,mem"? Really? Especially
> > > since I suspect the kernel is pretty much the only one who does this, and
> > > the kernel really does do it on purpose. The kernel explicitly wants the
> > > 32-bit version, knowing that the upper bits are undefined.
> > > 
> > 
> > Kernel has
> > 
> > 	unsigned gsindex;
> > 	asm volatile("movl %%gs,%0" : "=g" (gsindex));
> 
> Ok, that's a real x86-64 bug, it seems. Andi, please fix, preferably by 
> just making the "g" be a "r".
> 
> However, your argument isn't very valid, since:
> 
> > The new assembler will make sure that it won't happen.
> 
> Not true, since the suggestion was just to change all segment "movl"  
> things to "mov", at which point the same old bug is still there, and the
> assembler didn't really help us at all.

The new assembler won't accept

	movl %gs,128(%rsp)

It makes it harder to generate binary code user doesn't tend. FWIW,
what I suggested are in

http://sourceware.org/ml/binutils/2005-03/msg00873.html

Thera are things like

-		asm volatile("movl %%fs,%0" : "=g" (fsindex)); 
+		asm volatile("movl %%fs,%0" : "=r" (fsindex)); 

> 
> See the problem? You're not actually protecting anything. The change just 
> makes it _harder_ to make sizes explicit, and suddenly we have to trust an 
> assembler to be clever about sizes, when that assembler historically has 
> definitely _not_ been very clever about them at all. 
> 

There is no such an instruction of "movl %ds,(%eax)". The old assembler
accepts it and turns it into "movw %ds,(%eax)". It won't catch problems
like

	unsigned fsindex;
	asm volatile("movl %%fs,%0" : "=m" (fsindex)); 

The "movw %ds,(%eax)" bug was fixed in binutils 2.15.94.0.1. Gas no
longer generates 0x66 for it. If you find gas preventing you from doing
what the hardware supports, I will be happy to fix it.


H.J.

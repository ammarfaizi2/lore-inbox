Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVC3A2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVC3A2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 19:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVC3A2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 19:28:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:36534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261682AbVC3A2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 19:28:40 -0500
Date: Tue, 29 Mar 2005 16:30:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: "H. J. Lu" <hjl@lucon.org>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment
 register access)
In-Reply-To: <m14qev3h8l.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org>
 <m14qev3h8l.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Mar 2005, Andi Kleen wrote:
>
> "H. J. Lu" <hjl@lucon.org> writes:
> > The new assembler will disallow them since those instructions with
> > memory operand will only use the first 16bits. If the memory operand
> > is 16bit, you won't see any problems. But if the memory destinatin
> > is 32bit, the upper 16bits may have random values. The new assembler
> 
> Does it really have random values on existing x86 hardware?

The upper bits are not written at all, so it's not random.

> If it is a only a "theoretical" problem that does not happen
> in practice I would advise to not do the change.

My preference too. The reason we use "movl" is because we really do want 
the 32-bit versions, since they are faster. It's a conscious choice. In 
contrast "movw" generates bigger and slower code on all assemblers out 
there, and "mov" doesn't make it clear which one it is. Is it the slow 
one, or the fast one? 

For example, "mov %ds,%eax" does seem to generate the (faster) 32-bit code
on modern assemblers, while "mov %ds,%ax" generates (slower) 16-bit code 
that leaves the high bits of %eax untouched. Sometimes you may want the 
slower one, sometimes the faster one. I have this pretty strong memory of 
old versions of gas not making any difference between %ax and %eax as a 
target, and that you really needed to set the size explicitly.

Now, those versions of gas may be so old that nobody cares, but the
explicit size still is a GOOD THING. The size DOES MATTER. People who want
the smaller and faster version do not want to just rely on gas
automatically getting it right, especially since gas has historically been
very very bad at getting things right.

What is the advantage of not allowing "movl %ds,mem"? Really? Especially
since I suspect the kernel is pretty much the only one who does this, and
the kernel really does do it on purpose. The kernel explicitly wants the
32-bit version, knowing that the upper bits are undefined.

		Linus

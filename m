Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992798AbWJUCiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992798AbWJUCiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 22:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992796AbWJUCiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 22:38:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992795AbWJUCit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 22:38:49 -0400
Date: Fri, 20 Oct 2006 19:37:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: ralf@linux-mips.org, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <20061020.191134.63996591.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0610201934170.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org>
 <20061021000609.GA32701@linux-mips.org> <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
 <20061020.191134.63996591.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, David Miller wrote:
>
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Fri, 20 Oct 2006 17:38:32 -0700 (PDT)
> 
> > I think (but may be mistaken) that ARM _does_ have pure virtual caches 
> > with a process ID, but people have always ended up flushing them at 
> > context switch simply because it just causes too much trouble.
> > 
> > Sparc? VIPT too? Davem?
> 
> sun4c is VIVT, but has no SMP variants.

You don't need SMP - we have sleeping sections here, so even threads on UP 
can trigger it. 

Now, to trigger it you need to have
 - virtual indexing not just by  address, but by some "address space 
   identifier" thing too
 - (in practice) a big enough cache that switching tasks wouldn't flush it 
   anyway.

> sun4m has both VIPT and PIPT.
> 
> > But it would be good to have something for the early -rc1 sequence for 
> > 2.6.20, and maybe the MIPS COW D$ patches are it, if it has performance 
> > advantages on MIPS that can also be translated to other virtual cache 
> > users..
> 
> I think it could help for sun4m highmem configs.

Well, if you can re-create the performance numbers (Ralf - can you send 
the full series with the final "remove the now unnecessary flush" to 
Davem?), that will make deciding things easier, I think.

I suspect sparc, mips and arm are the main architectures where virtually 
indexed caching really matters enough for this to be an issue at all.

		Linus

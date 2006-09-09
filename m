Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWIIDCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWIIDCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWIIDCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:02:37 -0400
Received: from ozlabs.org ([203.10.76.45]:55698 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932093AbWIIDCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:02:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
Date: Sat, 9 Sep 2006 13:02:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, akpm@osdl.org,
       segher@kernel.crashing.org, davem@davemloft.net
Subject: Re: Opinion on ordering of writel vs. stores to RAM
In-Reply-To: <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> I don't think anyting but a few SCSI drivers that are used on some ia64 
> boxes use mmiowb(). And it's currently a no-op not only on x86 but also on 

The examples in Documentation/memory-barriers.txt and
Documentation/DocBook/deviceiobook.tmpl only seem to say that mmiowb
is needed between a writel and a spin_unlock.

> powerpc. Probably because it's defined to be a barrier between _two_ MMIO 
> operations, while we should probably have things like
> 
>  a)
> 	.. regular mem store ..
> 	mem_to_io_barrier();
> 	.. IOMEM store ..
> 
>  b)
> 	.. IOMEM store ..
> 	io_to_mem_barrier();
> 	.. regular mem store ..
> 
> although it's quite possible that (a) never makes any sense at all.

Do you mean (b) never makes sense?  (a) is the classic scenario for a
device doing DMA to read a descriptor we've just constructed.

> That said, it's also entirely possible that what you _should_ do is to 
> just make sure that the	"sync" is always _before_ the IO op. But that 
> would require that you have one before an IO load too. Do you? I'm too 
> lazy to check.

Not at present; readX() have no barrier before the load.  They have a
barrier after the load that waits for the data to arrive before
allowing any following instructions to execute.

> (Keeping it inside a spinlock, I don't know. Spinlocks aren't _supposed_ 
> to order IO, so I don't _think_ that's necessarily an argument for doing 
> so. So your rationale seems strange. Even on x86, a spinlock release by 
> _no_ means would mean that an IO write would be "done").

Well, it's about ordering between multiple CPUs rather than the write
being "done".  I think the powerpc readX/writeX got to their current
form before the ia64 guys invented mmiowb().

I suspect the best thing at this point is to move the sync in writeX()
before the store, as you suggest, and add an "eieio" before the load
in readX().  That does mean that we are then relying on driver writers
putting in the mmiowb() between a writeX() and a spin_unlock, but at
least that is documented.

Paul.

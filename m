Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWIICmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWIICmr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 22:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWIICmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 22:42:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932074AbWIICmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 22:42:46 -0400
Date: Fri, 8 Sep 2006 19:42:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, akpm@osdl.org,
       segher@kernel.crashing.org, davem@davemloft.net
Subject: Re: Opinion on ordering of writel vs. stores to RAM
In-Reply-To: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Sep 2006, Paul Mackerras wrote:
> 
> Do you have an opinion about whether the MMIO write in writel() should
> be ordered with respect to preceding writes to normal memory?

It shouldn't. It's too expensive. The fact that PC's have nice memory 
consistency models means that most of the testing is going to be with the 
PC memory ordering, but the same way we have "smp_wmb()" (which is also a 
no-op on x86) we should probably have a "mmiowb()" there.

Gaah. Right now, mmiowb() is actually broken on x86 (it's an empty define, 
so it may cause compiler warnings about statements with no effects or 
something).

I don't think anyting but a few SCSI drivers that are used on some ia64 
boxes use mmiowb(). And it's currently a no-op not only on x86 but also on 
powerpc. Probably because it's defined to be a barrier between _two_ MMIO 
operations, while we should probably have things like

 a)
	.. regular mem store ..
	mem_to_io_barrier();
	.. IOMEM store ..

 b)
	.. IOMEM store ..
	io_to_mem_barrier();
	.. regular mem store ..

although it's quite possible that (a) never makes any sense at all.

That said, it's also entirely possible that what you _should_ do is to 
just make sure that the	"sync" is always _before_ the IO op. But that 
would require that you have one before an IO load too. Do you? I'm too 
lazy to check.

(Keeping it inside a spinlock, I don't know. Spinlocks aren't _supposed_ 
to order IO, so I don't _think_ that's necessarily an argument for doing 
so. So your rationale seems strange. Even on x86, a spinlock release by 
_no_ means would mean that an IO write would be "done").

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVF0AyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVF0AyB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVF0AyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:54:01 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25553
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261687AbVF0Axw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:53:52 -0400
Date: Sun, 26 Jun 2005 17:53:47 -0700 (PDT)
Message-Id: <20050626.175347.104031526.davem@davemloft.net>
To: marcelo.tosatti@cyclades.com
Cc: dan@embeddededge.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: increased translation cache footprint in v2.6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050626190944.GC6091@logos.cnet>
References: <20050626185210.GB6091@logos.cnet>
	<20050626.173338.41634345.davem@davemloft.net>
	<20050626190944.GC6091@logos.cnet>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Sun, 26 Jun 2005 16:09:44 -0300

> Thats a very interesting idea, will probably optimize performance in 
> general ("why did nobody thought of it before?" kind). 
> 
> The increase in TLB miss handler size might be offset by the reduced
> kernel misses...
> 
> Dan, what do you think? 

I doubt it, it cost a single comparison on sparc64 to implement this.

Basically, the TLB miss handler for data accesses on sparc64 looks
like the following.

Load the miss information:

	ldxa		[%g1 + %g1] ASI_DMMU, %g4	! Get TAG_ACCESS

If "TAG_CONTEXT_BITS" is zero, it's for the kernel:

	andcc		%g4, TAG_CONTEXT_BITS, %g0	! From Nucleus?
	be,pn		%xcc, 3f			! Yep, special processing
 ...

If the virtual address has the top-most bit set (and thus it's
"negative"), then it's in the physical memory direct mapping
area.  The trap handler register %g2 is preloaded with a fixed
value, that when XOR'd with the fault address information
produces a suitable PTE for loading right into the TLB.  This
PTE uses 4MB pages.

3:	brlz,pt		%g4, 9b				! Kernel virtual map?
	 xor		%g2, %g4, %g5			! Finish bit twiddles

 ...

Store the calculated TLB entry and return from the trap.

9:	stxa		%g5, [%g0] ASI_DTLB_DATA_IN	! Reload TLB
	retry						! Trap return

So that's 7 instructions, 2 instruction cache lines, with no main
memory accesses.  Surely the PPC folks can do something similar. :-)

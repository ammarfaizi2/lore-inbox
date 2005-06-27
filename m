Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVF0PtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVF0PtY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVF0Psx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:48:53 -0400
Received: from embeddededge.com ([209.113.146.155]:32263 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261408AbVF0PqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:46:23 -0400
In-Reply-To: <20050626190944.GC6091@logos.cnet>
References: <20050626172334.GA5786@logos.cnet> <20050626164939.2f457bf6.akpm@osdl.org> <20050626185210.GB6091@logos.cnet> <20050626.173338.41634345.davem@davemloft.net> <20050626190944.GC6091@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6a3846d2436994d94aeacb0b0850d5f5@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: increased translation cache footprint in v2.6
Date: Mon, 27 Jun 2005 11:46:08 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 26, 2005, at 3:09 PM, Marcelo Tosatti wrote:

> Thats a very interesting idea, will probably optimize performance in
> general ("why did nobody thought of it before?" kind).

I've done this before, used the pgd/pmd or pte  to hold large page
size entries.  The problem is the amount of code needed in the
tlbmiss handler to implement this.  The Linux page table structure
doesn't allow us to easily format this information, so we have lots
of code in the handler to fabricate these entries.  It's a significant
overhead for the normal 4K path that was hard to justify.

> The increase in TLB miss handler size might be offset by the reduced
> kernel misses...

We need to be optimizing the applications, since that is where the
real work is done and where the system spends most of it's time.
The kernel is easy to optimize with pinned entries, then we have the
best solution.  A minimal overhead for the 4K pages, plus an optimal
kernel mapping.

I do want the solution of variable page sizes in the kernel, because
we don't have to reserve wired entries, providing the best solution.
I'm always thinking of this and experiment with it from time to time, 
but
I haven't found a solution that is satisfactory to me :-)  Maybe 
something
like an early kernel/user test and separate code paths, but I now have
a solution that eliminates our current test, and I don't want to put it
back in :-)  My holy grail is a 4 instruction tlb miss handler, but I 
haven't
been able to get the PTEs formatted correctly so everyone is happy.


Thanks.

	-- Dan


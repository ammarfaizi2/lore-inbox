Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVF0QHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVF0QHJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVF0QCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:02:20 -0400
Received: from embeddededge.com ([209.113.146.155]:35591 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261296AbVF0P6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:58:10 -0400
In-Reply-To: <20050626.175347.104031526.davem@davemloft.net>
References: <20050626185210.GB6091@logos.cnet> <20050626.173338.41634345.davem@davemloft.net> <20050626190944.GC6091@logos.cnet> <20050626.175347.104031526.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <705a40397bb8383399109debccaebaa3@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: increased translation cache footprint in v2.6
Date: Mon, 27 Jun 2005 11:57:51 -0400
To: "David S. Miller" <davem@davemloft.net>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 26, 2005, at 8:53 PM, David S. Miller wrote:

> So that's 7 instructions, 2 instruction cache lines, with no main
> memory accesses.  Surely the PPC folks can do something similar. :-)

It's not that easy on the 8xx.  It actually implements a two level
hardware page table.  Basically, I want to load the PMD into the
first level of the hardware, then the PTE into the second level 
register.
We have to load both registers with some information, but I can't
get the control bits organized in the pmd/pte to do this easily.
There is also a fair amount of hardware assist in the MMU for
initializing these registers and providing page table offset computation
that we need to utilize.

With the right page table structure the tlb miss handler is very 
trivial.
Without it, we have to spend lots of time building the entries 
dynamically.
Because of the configurability of the address space among text, data,
IO, and uncached mapping, we simply can't test an address bit and
build a new TLB entry.  So, I want to use the existing page tables to
represent the spaces, then have the tlb miss handler just use that
information.  I'll take a closer look at the kernel/user separate code
paths again.

Thanks.

	-- Dan


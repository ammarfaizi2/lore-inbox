Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWDCJCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWDCJCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWDCJCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:02:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10254 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751607AbWDCJCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:02:15 -0400
Date: Mon, 3 Apr 2006 10:02:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-ID: <20060403090207.GB15606@flint.arm.linux.org.uk>
Mail-Followup-To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	pavel@ucw.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060402210003.GA11979@elf.ucw.cz> <20060402220807.GD13901@flint.arm.linux.org.uk> <20060402222314.GC12166@elf.ucw.cz> <20060403091504.ecd341a3.kamezawa.hiroyu@jp.fujitsu.com> <20060403073653.GA13275@flint.arm.linux.org.uk> <20060403164434.fdb5020c.kamezawa.hiroyu@jp.fujitsu.com> <20060403175603.7a3dd64f.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403175603.7a3dd64f.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 05:56:03PM +0900, KAMEZAWA Hiroyuki wrote:
> On Mon, 3 Apr 2006 16:44:34 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > On Mon, 3 Apr 2006 08:36:53 +0100
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > Hmm..from include/asm-arm/arch-clps711x/memory.h
> > 
> > ==
> > /*
> >  * Given a kaddr, LOCAL_MAR_NR finds the owning node of the memory
> >  * and returns the index corresponding to the appropriate page in the
> >  * node's mem_map.
> >  */
> > #define LOCAL_MAP_NR(addr) \
> >         (((unsigned long)(addr) & (NODE_MAX_MEM_SIZE - 1)) >> PAGE_SHIFT)
> > ==
> > 
> > Is this comment wrong ???

The comment isn't entirely accurate.

> All of sub-arch's comment says "Given a kaddr" but all of them just uses
> "offset".  So, paddr can be given as arg. 

Yes.

> __va()(or pfn_to_kaddr()) adds unnecessary calcs, so paddr should be used
> instead of kaddr.

The problem with __va() and pfn_to_kaddr() is that it adds unnecessary
calculation which the compiler can not optimise away.

>From the use of LOCAL_MAP_NR(), we know that it's returning an offset
into a particular node, and that there's a 1:1 relationship between
the virtual and physical addresses within nodes.  That means that
LOCAL_MAP_NR() can take either a virtual address, a physical address,
or even a byte offset into the node.

In turn, that means that we can pass it whatever address we happen to
have available at the time, or whichever is simpler to calculate.

In the cases you're looking at (pfn to map number) giving it pfn <<
PAGE_SHIFT is entirely sufficient, and is in fact optimal for
performance.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

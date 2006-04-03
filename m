Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWDCHhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWDCHhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 03:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWDCHhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 03:37:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61453 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751617AbWDCHhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 03:37:03 -0400
Date: Mon, 3 Apr 2006 08:36:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-ID: <20060403073653.GA13275@flint.arm.linux.org.uk>
Mail-Followup-To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060402210003.GA11979@elf.ucw.cz> <20060402220807.GD13901@flint.arm.linux.org.uk> <20060402222314.GC12166@elf.ucw.cz> <20060403091504.ecd341a3.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403091504.ecd341a3.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 09:15:04AM +0900, KAMEZAWA Hiroyuki wrote:
> On Mon, 3 Apr 2006 00:23:14 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> > > Not surprising given this gem:
> > > 
> > > > -#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
> > > 
> > > PAGE_OFFSET being 3GB - that's one hell of a shift value!
> > 
> > Unfortunately this is mainline now. Is there some better fix than
> > simply reverting the offending patches?
> 
> Maybe this one will fix (against 2.6.16-mm2)
> 
> LOCAL_MAP_NR(kaddr) returns page offset in a node.

LOCAL_MAP_NR does not take a kernel virtual address.  If you look at how
it's defined (Eg):

#define LOCAL_MAP_NR(addr) \
        (((unsigned long)(addr) & 0x07ffffff) >> PAGE_SHIFT)

then you will notice that it's actually converting an offset into a node
into an index.  This means that converting a PFN to a virtual address is
just a complete and utter waste of time.

So:

> -#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
> +#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR(__va((pfn) << PAGE_SHIFT)))

this should be:

#define arch_local_page_offset(pfn, nid) LOCAL_MAP_NR((pfn) << PAGE_SHIFT)

Please also avoid the over-use of parens.  It's a disease which just makes
things harder to read (eg, the have I got enough close parens at the end
of the line to balance.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVH3GVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVH3GVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 02:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVH3GVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 02:21:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44955 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750777AbVH3GVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 02:21:41 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: solving page table access attribute aliasing.
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
	<200508300230.39844.ak@suse.de>
	<m1ll2kmbxd.fsf@ebiederm.dsl.xmission.com>
	<200508300412.55027.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 30 Aug 2005 00:21:09 -0600
In-Reply-To: <200508300412.55027.ak@suse.de> (Andi Kleen's message of "Tue,
 30 Aug 2005 04:12:54 +0200")
Message-ID: <m1br3gq71m.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I agree that it is a good thing to solve the aliasing problem,
so we don't fight..

There are three cases we need to worry about physical addresses.
1) Physical addresses that we use as RAM that have a struct page.
2) Physical addresses without a struct page we map into kernel space.
3) Physical addresses without a struct page we map into user space.

There are two perspectives for solving this.
- phys_mem_access_prot/ia64_mem_attribute style.  Where we know
  at bootup what access attributes everything should have, and
  on every mmap simply force the attribute to the correct thing.

- We concede that we only know about ram with a struct page,
  and we let drivers do whatever they want so long as they don't
  use aliases.

Letting drivers/users decide is the interface we have now so
unless we wish to change the linux driver model we need to support
it.

>From this perspective I think the change should be quite simple.
We need a function: 
verify_pfn_mapping(unsigned long pfn, unsigned long size, pgprot_t prot);
That performs the following checks, on every page:

 - Is the page RAM with a struct page.  If so it must be mapped write
   back.  If we want anything else fail.

 - If the pfn is not RAM and already mapped and do the caching
   attributes in pgprot_t match.  If we want anything else fail.

 - If the pfn is not mapped, allow anything that is possible.

In addition we need a clean way of saying I don't care just
give me a mapping with the caching attributes that are already
being used, and if it is not in use give me a reasonable default.
Which is what ioremap seems to do today.

For the case where the physical address has a struct page we just need
to detect that.  

For the case where we are dealing with physical addresses without a
struct page we need a space efficient way to get this information.
For each user mapping we already have a vm_area_struct so it makes
sense to keep all of them on a linked list so we can walk through them
and find any user space mappings for a pfn.  For the kernel mapping
with ioremap we need an architecture specific implementation because
the mappings are handled in an architecture specific way.

Perversely mapping physical pages with ioremap or io_remap_pfn_range
may be the one case where huge pages are easy to allocate.  I believe
this is the primary reason why sparc64 does not use remap_pfn_range
in implementing io_remap_pfn_range.  So it may be worth looking
at using huge mappings remap_pfn_range as part of implementing alias
checking for all architectures.  

Unless I am hugely mistake every architecture that can set caching
attributes on the page tables needs this.

I am going to sleep now and work on implementing this in the morning.

Eric

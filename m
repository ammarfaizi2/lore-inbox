Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267504AbSLFCEZ>; Thu, 5 Dec 2002 21:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbSLFCEY>; Thu, 5 Dec 2002 21:04:24 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:8608 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267504AbSLFCEY>; Thu, 5 Dec 2002 21:04:24 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 5 Dec 2002 18:08:22 -0800
Message-Id: <200212060208.SAA05756@adam.yggdrasil.com>
To: david@gibson.dropbear.id.au
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
>On Thu, Dec 05, 2002 at 03:57:53AM -0800, Adam J. Richter wrote:
>> David Gibson wrote:
>> >Since, with James's approach you'd need a dma sync function (which
>> >might compile to NOP) in pretty much the same places you'd need
>> >map/sync calls, I don't see that it does make the source noticeably
>> >simpler.
>> 
>>         Because then you don't have to have a branch for
>> case where the platform *does* support consistent memory.

>Sorry, you're going to have to explain where this extra branch is, I
>don't see it.

	In linux-2.5.50/drivers/net/lasi_82596.c, the macros
CHECK_{WBACK,INV,WBACK_INV} have definitions like:

#define  CHECK_WBACK(addr,len) \
	do { if (!dma_consistent) dma_cache_wback((unsigned long)addr,len); } while (0)

	These macros are even used in IO paths like i596_rx().  The
"if()" statement in each of these macros is the extra branch that
disappears on most architectures under James's proposal.

[...]
>What performance advantages of consistent memory?  Can you name any
>non-fully-consistent platform where consistent memory is preferable
>when it is not strictly required?  For, all the non-consistent
>platforms I'm aware of getting consistent memory means disabling the
>cache and therefore is to be avoided wherever it can be.

	I believe that the cache synchronization operations for
nonconsistent memory are often expensive enough so that consistent
memory is faster on many platforms for small reads and writes, such as
dealing with control and status fields and hardware DMA lists.  For
example, pci_sync_single is 55 lines of C code in
linux-2.5.50/arch/sparc64/kernel/pci_iommu.c.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

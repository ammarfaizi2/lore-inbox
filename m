Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbSJWATl>; Tue, 22 Oct 2002 20:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSJWATl>; Tue, 22 Oct 2002 20:19:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6874 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261893AbSJWATk>;
	Tue, 22 Oct 2002 20:19:40 -0400
Date: Tue, 22 Oct 2002 17:20:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New panic (io-apic / timer?) going from 2.5.44 to 2.5.44-mm1
Message-ID: <442050000.1035332459@flay>
In-Reply-To: <3DB5E909.7F2AF339@digeo.com>
References: <440550000.1035330723@flay> <3DB5E909.7F2AF339@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hmmm ... 2.5.43-mm2 and 2.5.44 work fine, but 2.5.44-mm1 (and mm2)
>> panic consistently on boot for a 16 way NUMA-Q.
>> 
>> Normally this box will boot with TSC on or off. If anyone has any pointers as
>> to what's changed in the mm patchset going from 43-mm2 to 44-mm1 that
>> might have touched this area (I can't see anything), please poke me in the
>> eye. Otherwise I'll just keep digging into it ....
>> 
> 
> 
> Is possibly the code which defers the allocation of the per-cpu
> memory until the secondary processors are being brought online.

Aha ... ;-) thanks for the pointer. Will poke at that. 

> I've decided to toss that.  It's causing some grief for architectures,
> and only buys us 10k * (NR_CPUS - nr-cpus) worth of memory anyway.

Hmmm ... I guess people with SMP normally have lots of RAM anyway,
and those few that care could just config NR_CPUS down. Shame though,
automagical is much nicer. Maybe we can work out exactly why it's broken
instead.

> Well.  It would be useful for NUMA to be able to place the per-cpu storage
> into node-local memory.  But the code doesn't do that.  It just uses
> kmalloc on the boot cpu, and we don't have an alloc_pages_for_another_cpu()
> API..

Well at a page granularity level you have alloc_pages_node(cpu_to_node).
I suppose technically that's not guaranteed, but on boot it'll never fall back.
If you need it in permanent KVA, you can remap it into the vmalloc reserve
area.

Why do you need to do it that late, should be able to do it once you've parsed
mptables? alloc_bootmem / alloc_bootmem_node ?

M.


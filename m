Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVLBIzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVLBIzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 03:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbVLBIzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 03:55:41 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:27343 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750923AbVLBIzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 03:55:40 -0500
Message-ID: <43900BE3.5080000@cosmosbay.com>
Date: Fri, 02 Dec 2005 09:54:59 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, shai@scalex86.org
Subject: Re: [patch 3/3] x86_64: Node local PDA -- allocate node local memory
 for pda
References: <20051202081028.GA5312@localhost.localdomain> <20051202082309.GC5312@localhost.localdomain>
In-Reply-To: <20051202082309.GC5312@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 02 Dec 2005 09:55:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> Patch uses a static PDA array early at boot and reallocates processor PDA
> with node local memory when kmalloc is ready, just before pda_init.
> The boot_cpu_pda is needed sice the cpu_pda is used even before pda_init for
> that cpu is called (to set the static per-cpu areas offset table etc)
> 

That sounds great.

I have only have one suggestion : If kernel is not NUMA, then maybe we should 
avoid one indirection to get the pda, and avoid some code too.



include/asm-x86_64/pda.h

#if !defined(CONFIG_NUMA)
extern struct x8664_pda _cpu_pda[];
#define cpu_pda(i) (&_cpu_pda[i])
#else
extern struct x8664_pda *_cpu_pda[];
#define cpu_pda(i) (_cpu_pda[i])
#endif

arch/x86_64/kernel/setup64.c

#if !definedd(CONFIG_NUMA)
struct x8664_pda _cpu_pda[NR_CPUS] __cacheline_aligned;
#else
struct x8664_pda *_cpu_pda[NR_CPUS] __read_mostly;
struct x8664_pda boot_cpu_pda[NR_CPUS] __cacheline_aligned;
#endif


...
#if defined(CONFIG_NUMA)
	/* Allocate node local memory for AP pdas */
	if (cpu) {
		struct x8664_pda *newpda;
		newpda = kmalloc_node(sizeof (struct x8664_pda), GFP_ATOMIC,
				      cpu_to_node(cpu));
		if (newpda) {
			printk("Allocating node local PDA for cpu %d at 0x%lx\n",
				cpu, (unsigned long) newpda);
			memcpy(newpda, pda, sizeof (struct x8664_pda));
			pda = newpda;
			cpu_pda(cpu) = pda;
		}
		else
			printk("Could not allocate node local PDA for cpu %d\n",
				cpu);
	}
#endif



Eric

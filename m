Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVI2Nkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVI2Nkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVI2Nkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:40:51 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:18054 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932143AbVI2Nku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:40:50 -0400
Message-ID: <433BEED6.6000008@cosmosbay.com>
Date: Thu, 29 Sep 2005 15:40:38 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: [NUMA , x86_64] Why memnode_shift is chosen with the lowest possible
 value ?
References: <1127939141.26401.32.camel@localhost.localdomain>	<1127939593.26401.38.camel@localhost.localdomain>	<20050928232027.28e1bb93.akpm@osdl.org> <p73k6h0jjh3.fsf@verdi.suse.de>
In-Reply-To: <p73k6h0jjh3.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 29 Sep 2005 15:40:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi

I have a dual Opteron machine, with 8GB of ram on each node.
With latest kernels I have high CPU profiles in mm/slab.c
kfree() is NUMA aware, so far so good, but the price seems heavy.

I noticed in 2.6.14-rc2 syslog :

Node 0 MemBase 0000000000000000 Limit 00000001ffffffff
Node 1 MemBase 0000000200000000 Limit 00000003ffffffff
Using 23 for the hash shift. Max adder is 3ffffffff

instead of previous (2.6.13) :

Node 0 MemBase 0000000000000000 Limit 00000001ffffffff
Node 1 MemBase 0000000200000000 Limit 00000003ffffffff
Using 27 for the hash shift. Max adder is 3ffffffff

After some code review, I see NODEMAPSIZE raised from 0xff to 0xfff

  phys_to_nid() is now reading one byte out of 2048 bytes with 
(memnode_shift=23, units of 8MB).

But shouldnt we try to use the highest possible value for memnode_shift ?

Using memnode_shift=33 would access only 2 bytes from this memnodemap[], 
touching fewer cache lines (well , one cache line). kfree() and friends would 
be slightly faster, at least cache friendly.


Another question is :

Could we add in pda (struct x8664_pda) the node of the cpu ?

We currently do :

#define numa_node_id()             (cpu_to_node(raw_smp_processor_id()))

Instead of reading the processor_id from pda, then access cpu_to_node[], we 
could directly get this information from pda.

#if defined(CONFIG_NUMA)
static inline __attribute_pure__ int numa_node_id() { return read_pda(node);}
#else
#define numa_node_id()             0
#endif

Thank you

Eric

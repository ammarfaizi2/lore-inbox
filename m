Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUEOUlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUEOUlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 16:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUEOUlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 16:41:08 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:45739 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264731AbUEOUlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 16:41:05 -0400
Message-ID: <40A68056.6090606@BitWagon.com>
Date: Sat, 15 May 2004 13:40:54 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
References: <200405151442.i4FEgkjY001401@harpo.it.uu.se> <20040515191643.GA5748@colin2.muc.de>
In-Reply-To: <20040515191643.GA5748@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>+	if( perfctr_cstatus_has_tsc(cstatus) )
>>>+		rdtscl(ctrs->tsc);
>>>+	nrctrs = perfctr_cstatus_nractrs(cstatus);
>>>+	for(i = 0; i < nrctrs; ++i) {
>>>+		unsigned int pmc = state->pmc[i].map;
>>>+		rdpmc_low(pmc, ctrs->pmc[i]);
>>>+	}
>>>
>>>K8 has speculative rdtsc. Most likely you want a sync_core() somewhere
>>>in there.
>>
>>What's the cost for sync_core()? The counts don't have to be
>>perfect.
> 
> 
> It's a CPUID to force a pipeline flush. Let's say 20-30 cycles.

I want the kernel to avoid every delay that can be avoided.  Do not force
a pipeline flush for speculative rdtsc.  Besides those 20-30 cycles
there is register eviction for %eax, %ecx, %edx and save+restore for %ebx
(CPUID scribbles on 4 registers), plus possible branch misprediction if control
is not fall-through sequential.  Also, that kernel code probably is already
several dozen cycles after the most recent user-mode instruction
(the only thing that the user can control), so waiting for quiescent
pipeline is just the kernel lollygagging on itself.  Get to work!

-- 
John Reiser, jreiser@BitWagon.com


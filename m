Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWAWN3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWAWN3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWAWN3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:29:51 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:62429 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751445AbWAWN3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:29:51 -0500
Message-ID: <43D4DA15.4010009@cosmosbay.com>
Date: Mon, 23 Jan 2006 14:28:53 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: pravin shelar <pravins@calsoftinc.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] garbage values in file /proc/net/sockstat
References: <Pine.LNX.4.63.0601231206270.2192@pravin.s> <200601231224.16196.ak@suse.de>
In-Reply-To: <200601231224.16196.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 23 Jan 2006 14:28:54 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> On Monday 23 January 2006 12:21, pravin shelar wrote:
>> 	In 2.6.16-rc1-mm1, (for x86_64 arch) cpu_possible_map is not same 
>> as NR_CPUS (prefill_possible_map()). Therefore per cpu areas are allocated 
>> for cpu_possible cpus only (setup_per_cpu_areas()). This causes sockstat 
>> to return garbage value on x84_64 arch.
>>
>> So these per_cpu accesses are geting relocated (RELOC_HIDE) using
>> boot_cpu_pda[]->data_offset which is not initialized.
>>
>> There are other instances of same bug where per_cpu() macro is used
>> without cpu_possible() check. e.g. net/core/utils.c :: 
>> net_random_reseed(), net/core/dev.c :: net_dev_init(), etc.
>>
>> This patch fixes these bugs.
> 
> Thanks. Patches Look good.  Dave, can you push them for 2.6.16 still please?
> 

Shouldnt we force a page fault for not possible cpus in cpu_data
to catch all access to per_cpu(some_object, some_not_possible_cpu) ?

We can use a red zone big enough to hold the whole per_cpu data.

Something like :

file include/asm-x86_64/pgtable.h

#define CPUDATA_RED_ZONE 0xffff808000000000UL  /* start of percpu catcher */

file arch/x86_64/kernel/setup64.c

setup_per_cpu_areas(void)
{
...
     for (i = 0 ; i < NR_CPUS ; i++) {
         if (!cpu_possible(cpu))
             cpu_pda(i)->data_offset = CPUDATA_RED_ZONE - __per_cpu_start ;
     }
}

Eric


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422792AbWBIEgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422792AbWBIEgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbWBIEgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:36:23 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:31189 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1422792AbWBIEgW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:36:22 -0500
Message-ID: <43EAC6BE.2060807@cosmosbay.com>
Date: Thu, 09 Feb 2006 05:36:14 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
References: <200602051959.k15JxoHK001630@hera.kernel.org>	<Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>	<20060208190512.5ebcdfbe.akpm@osdl.org> <20060208190839.63c57a96.akpm@osdl.org>
In-Reply-To: <20060208190839.63c57a96.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Andrew Morton <akpm@osdl.org> wrote:
>> Users of __GENERIC_PER_CPU definitely need cpu_possible_map to be initialised
>>  by the time setup_per_cpu_areas() is called,
> 
> err, they'll need it once Eric's
> dont-waste-percpu-memory-on-not-possible-CPUs patch is merged..
> 
>> so I think it makes sense to
>>  say "thou shalt initialise cpu_possible_map in setup_arch()".
>>
>>  I guess Xen isn't doing that.  Can it be made to?
> 
> Lame fix:  cpu_possible_map = (1<<NR_CPUS)-1 in setup_arch().

I dont understand why this HOTPLUG stuff is problematic for Xen (or other 
arch) : If CONFIG_HOTPLUG_CPU is configured, then the map should be preset to 
CPU_MASK_ALL. Its even documented in line 332 of include/linux/cpumask.h

  *  #ifdef CONFIG_HOTPLUG_CPU
  *     cpu_possible_map - all NR_CPUS bits set

arch/i386/kernel/smpboot.c is doing the only sane stuff about it :

#ifdef CONFIG_HOTPLUG_CPU
cpumask_t cpu_possible_map = CPU_MASK_ALL;
#else
cpumask_t cpu_possible_map;
#endif

Some remarks :

1) These cpu_possible_map could have __read_mostly attribute.
2) cpu_possible(cpu) macro could be defined to 1 if CONFIG_HOTPLUG_CPU, or a 
test against NR_CPUS

#ifdef CONFIG_HOTPLUG_CPU
#define cpu_possible(cpu)   cpu_isset((cpu), cpu_possible_map)
#else
#define cpu_possible(cpu)   ((unsigned)(cpu) < NR_CPUS)
#endif

Eric

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSEXJNf>; Fri, 24 May 2002 05:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSEXJNe>; Fri, 24 May 2002 05:13:34 -0400
Received: from wiproecmx2.wipro.com ([164.164.31.6]:17099 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S317066AbSEXJNc>; Fri, 24 May 2002 05:13:32 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: <dipankar@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, "Rusty Russell" <rusty@rustcorp.com.au>,
        "Paul McKenney" <paul.mckenney@us.ibm.com>,
        <lse-tech@lists.sourceforge.net>
Subject: RE: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
Date: Fri, 24 May 2002 14:08:50 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBKEKPCJAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-abf5409b-42a7-47e8-ab21-678863ab28e0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20020524114318.A11249@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-abf5409b-42a7-47e8-ab21-678863ab28e0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


|> Hello, Dipankar,
|>
|> I would prefer to use the existing slab allocator for this.
|> I am not sure if I understand your requirements for the per-cpu
|> allocator correctly, please correct me if I do not.
|>
|> What I would like to see
|>
|> 1. Have per-cpu slabs instead of per-cpu cpucache_t. One should
|>    be able to tell for which caches we want per-cpu slabs. This
|>    way we can make even kmalloc per-cpu. Since most of the kernel
|>    would use and dispose memory before they migrate across cpus.
|>    I think this would be useful, but again no data to back it up.
|
|Allocating cpu-local memory is a different issue altogether.
|Eventually for NUMA support, we will have to do such allocations
|that supports choosing memory closest to a group of CPUs.
|
|The per-cpu data allocator allocates one copy for *each* CPU.
|It uses the slab allocator underneath. Eventually, when/if we have
|per-cpu/numa-node slab allocation, the per-cpu data allocator
|can allocate every CPU's copy from memory closest to it.
|
|I suppose you worked on DYNIX/ptx ? Think of this as dynamic
|plocal.


Sure, I understand what you are talking about now. That makes a lot
of sense, I will go through your document once more and read it.
I was thinking of the two combined (allocating CPU local memory
for certain data structs also includes allocating one copy per CPU).
Is there a reason to delay the implementation of CPU local memory,
or are we waiting for NUMA guys to do it? Is it not useful in an
SMP system to allocate CPU local memory?


|
|>
|> 2. I hate the use of NR_CPUS. If I compiled an SMP kernel on a two
|>    CPU machine, I still end up with support for 32 CPUs. What I would
|
|If you don't like it, just define NR_CPUS to 2 and recompile.
|

That does make sense, but I would like to keep my headers in sync, so that
all patches apply cleanly.

|
|>    like to see is that in new kernel code, we should use treat equivalent
|>    classes of CPUs as belonging to the same CPU. For example
|>
|>    void *blkaddrs[NR_CPUS];
|>
|>    while searching, instead of doing
|>
|>    blkaddrs[smp_processor_id()], if the slot for
|smp_processor_id() is full,
|>    we should look through
|>
|>    for (i = 0; i < NR_CPUS; i++) {
|>      look into blkaddrs[smp_processor_id() + i % smp_number_of_cpus()(or
|> whatever)]
|>      if successful break
|>    }
|
|How will it work ? You could be accessing memory beyond blkaddrs[].
|

Sorry that could happen, it should be (smp_processor_id + i) %
smp_number_of_cpus().


|I use NR_CPUS for allocations because if I don't, supporting CPU
|hotplug will be a nightmare. Resizing so many data structures is
|not an option. I believe Rusty and/or cpu hotplug work is
|adding a for_each_cpu() macro to walk the CPUs that take
|care of everything including sparse CPU numbers. Until then,
|I would use for (i = 0; i < smp_num_cpus; i++).

I think that does make a whole lot of sense, I was not thinking
about HotPluging CPUs (dumb me).


|
|Thanks
|--
|Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
|Linux Technology Center, IBM Software Lab, Bangalore, India.
|
|_______________________________________________________________


------=_NextPartTM-000-abf5409b-42a7-47e8-ab21-678863ab28e0
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is 
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying 
or dissemination of the information contained in the E-MAIL in any manner 
whatsoever is strictly prohibited.

***************************************************************************

------=_NextPartTM-000-abf5409b-42a7-47e8-ab21-678863ab28e0--

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSEXEfJ>; Fri, 24 May 2002 00:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314128AbSEXEfI>; Fri, 24 May 2002 00:35:08 -0400
Received: from wiproecmx2.wipro.com ([164.164.31.6]:54983 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S314096AbSEXEfH>; Fri, 24 May 2002 00:35:07 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: <dipankar@in.ibm.com>, <linux-kernel@vger.kernel.org>
Cc: "Rusty Russell" <rusty@rustcorp.com.au>,
        "Paul McKenney" <paul.mckenney@us.ibm.com>,
        <lse-tech@lists.sourceforge.net>
Subject: RE: [RFC] Dynamic percpu data allocator
Date: Fri, 24 May 2002 10:07:59 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBOEKFCJAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-4d95a9e9-3886-475f-b272-74cecfe84535"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20020523183835.E4714@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-4d95a9e9-3886-475f-b272-74cecfe84535
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello, Dipankar,

I would prefer to use the existing slab allocator for this.
I am not sure if I understand your requirements for the per-cpu
allocator correctly, please correct me if I do not.

What I would like to see

1. Have per-cpu slabs instead of per-cpu cpucache_t. One should
   be able to tell for which caches we want per-cpu slabs. This
   way we can make even kmalloc per-cpu. Since most of the kernel
   would use and dispose memory before they migrate across cpus.
   I think this would be useful, but again no data to back it up.

2. I hate the use of NR_CPUS. If I compiled an SMP kernel on a two
   CPU machine, I still end up with support for 32 CPUs. What I would
   like to see is that in new kernel code, we should use treat equivalent
   classes of CPUs as belonging to the same CPU. For example

   void *blkaddrs[NR_CPUS];

   while searching, instead of doing

   blkaddrs[smp_processor_id()], if the slot for smp_processor_id() is full,
   we should look through

   for (i = 0; i < NR_CPUS; i++) {
     look into blkaddrs[smp_processor_id() + i % smp_number_of_cpus()(or
whatever)]
     if successful break
   }

On a two CPU system 1,3,5 ... belong to the same equivalent class. So we
might
as well utilize them. Even with a per-cpu pool, threads could use the slots
in
the per-cpu equivalent classes in parallel (I have a very rough idea about
this).

Does any of this make sense,
Balbir


|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org
|[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Dipankar Sarma
|Sent: Thursday, May 23, 2002 6:39 PM
|To: linux-kernel@vger.kernel.org
|Cc: Rusty Russell; Paul McKenney; lse-tech@lists.sourceforge.net
|Subject: [RFC] Dynamic percpu data allocator
|
|
|If static percpu area is around, can dynamic percpu data allocator
|be far behind ;-)
|
|As a part of scalable kernel primitives work for higher-end SMP
|and NUMA architectures, we have been seeing increasing need
|for per-cpu data in various key areas. Rusty's percpu area
|work has added a way in 2.5 kernels to maintain static per-cpu
|data. Inspired by that work, I have implemented a dynamic per-cpu
|data allocator. Currently it is useful to us for -
|
|1. Per-cpu data in dynamically allocated structures.
|2. per-cpu statistics and reference counters
|3. Per-cpu data in drivers/modules.
|4. Scalable locking primitives like local spin only locks
|   (or even big reader locks).
|
|Included in this mail is a document that describes the allocator.
|I would really appreciate if people comment on it. I am
|particularly interested in eek-value of the interfaces,
|specially the bit about keeping the type information in
|a dummy variable in a union.
|
|The actual patch will follow soon, unless someone convince
|me quickly that there is an saner way to do this.
|
|Thanks
|--
|Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
|Linux Technology Center, IBM Software Lab, Bangalore, India.
|


------=_NextPartTM-000-4d95a9e9-3886-475f-b272-74cecfe84535
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

------=_NextPartTM-000-4d95a9e9-3886-475f-b272-74cecfe84535--

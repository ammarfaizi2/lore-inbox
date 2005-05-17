Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVEQXn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVEQXn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVEQXmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:42:13 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11729 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262008AbVEQXgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:36:51 -0400
Message-ID: <428A800D.8050902@us.ibm.com>
Date: Tue, 17 May 2005 16:36:45 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Christoph Lameter <christoph@lameter.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>	 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>	 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>	 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net> <1116289613.26955.14.camel@localhost>
In-Reply-To: <1116289613.26955.14.camel@localhost>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
>>+#ifdef CONFIG_NUMA
>>+#define NUMA_NODES MAX_NUMNODES
>>+#define NUMA_NODE_ID numa_node_id()
>>+#else
>>+#define NUMA_NODES 1
>>+#define NUMA_NODE_ID 0
>> #endif
> 
> 
> I think numa_node_id() should always do what you want.  It is never
> related to discontig nodes, and #defines down to the same thing you have
> in the end, anyway:
>         
>         #define numa_node_id()       (cpu_to_node(_smp_processor_id()))
>         
>         asm-i386/topology.h
>         #ifdef CONFIG_NUMA
>         ...
>         static inline int cpu_to_node(int cpu)
>         {
>                 return cpu_2_node[cpu];
>         }
>         
>         asm-generic/topology.h:
>         #ifndef cpu_to_node
>         #define cpu_to_node(cpu)        (0)
>         #endif
> 
> As for the MAX_NUMNODES, I'd just continue to use it, instead of a new
> #define.  There is no case where there can be more NUMA nodes than
> DISCONTIG nodes, and this assumption appears in plenty of other code.
> 
> I'm cc'ing Matt Dobson, who's touched this MAX_NUMNODES business a lot
> more recently than I.
> 
> -- Dave


You're right, Dave.  The series of #defines at the top resolve to the same
thing as numa_node_id().  Adding the above #defines will serve only to
obfuscate the code.

Another thing that will really help, Christoph, would be replacing all your
open-coded for (i = 0; i < MAX_NUMNODES/NR_CPUS; i++) loops.  We have
macros that make that all nice and clean and (should?) do the right thing
for various combinations of SMP/DISCONTIG/NUMA/etc.  Use those and if they
DON'T do the right thing, please let me know and we'll fix them ASAP.

for_each_cpu(i)
for_each_online_cpu(i)
for_each_node(i)
for_each_online_node(i)

Those 4 macros should replace all your open-coded loops, Christoph.

-Matt

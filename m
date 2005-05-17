Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVEQA1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVEQA1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 20:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVEQA1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 20:27:43 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:23013 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261334AbVEQA1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 20:27:39 -0400
Subject: Re: NUMA aware slab allocator V3
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com,
       "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>
In-Reply-To: <Pine.LNX.4.62.0505161713130.21512@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>
	 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>
	 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
Content-Type: text/plain
Date: Mon, 16 May 2005 17:26:53 -0700
Message-Id: <1116289613.26955.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_NUMA
> +#define NUMA_NODES MAX_NUMNODES
> +#define NUMA_NODE_ID numa_node_id()
> +#else
> +#define NUMA_NODES 1
> +#define NUMA_NODE_ID 0
>  #endif

I think numa_node_id() should always do what you want.  It is never
related to discontig nodes, and #defines down to the same thing you have
in the end, anyway:
        
        #define numa_node_id()       (cpu_to_node(_smp_processor_id()))
        
        asm-i386/topology.h
        #ifdef CONFIG_NUMA
        ...
        static inline int cpu_to_node(int cpu)
        {
                return cpu_2_node[cpu];
        }
        
        asm-generic/topology.h:
        #ifndef cpu_to_node
        #define cpu_to_node(cpu)        (0)
        #endif

As for the MAX_NUMNODES, I'd just continue to use it, instead of a new
#define.  There is no case where there can be more NUMA nodes than
DISCONTIG nodes, and this assumption appears in plenty of other code.

I'm cc'ing Matt Dobson, who's touched this MAX_NUMNODES business a lot
more recently than I.

-- Dave


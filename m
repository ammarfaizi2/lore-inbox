Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbSJ2XhP>; Tue, 29 Oct 2002 18:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSJ2XhP>; Tue, 29 Oct 2002 18:37:15 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:17322 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262083AbSJ2XhN> convert rfc822-to-8bit; Tue, 29 Oct 2002 18:37:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: colpatch@us.ibm.com
Subject: Re: [PATCH] topology for ia64
Date: Wed, 30 Oct 2002 00:43:01 +0100
User-Agent: KMail/1.4.1
Cc: davidm@hpl.hp.com, linux-ia64 <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200210051904.22480.efocht@ess.nec.de> <200210221123.37145.efocht@ess.nec.de> <3DBF096D.6080703@us.ibm.com>
In-Reply-To: <3DBF096D.6080703@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300043.01786.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 23:19, Matthew Dobson wrote:
> Hi Erich!  Apologies for the long response delay...  I think our mail
> server must be a bit lagged.  ;)

Should I use another email address?

> It looks good to me.  As far as this comment:
> +/*
> + * Returns the number of the first CPU on Node 'node'.
> + * Slow in the current implementation.
> + * Who needs this?
> + */
> +/* #define __node_to_first_cpu(node) pool_cpus[pool_ptr[node]] */
> +static inline int __node_to_first_cpu(int node)
>
> No one is using it now.  I think that I will probably deprecate this
> function in the near future as it is pretty useless.  Anyone looking for
> that functionality can just do an __ffs(__node_to_cpu_mask(node))
> instead, and hope that there is a reasonably quick implementation of
> __node_to_cpu_mask.

Yes, I know of one usage meanwhile. The problem I see is: as far as I
understand the CPUs are not sorted by the node numbers. The NUMA API
doesn't require that, I think. So finding the first CPU in a node is
not really useful for looping over the CPUs of only one node.

When you think of further developments of the NUMA API, I'd suggest
two:

1: Add a sorted list of the nodes and a pointer array into that list
pointing to the first CPU in the node. Like

int node_cpus[NR_CPUS];
int node_first_ptr[MAX_NUMNODES+1];

(or macros, doesn't matter).

Example: 2 nodes:
         node_cpus : 0 1 4 5 2 3 6 7
              node : 0 0 0 0 1 1 1 1
           pointer : ^       ^       ^
=> node_first_ptr[]: 0       4       8

One can initialize this easilly by using the __cpu_to_node()
macro. And with this you can loop over the cpus of one node by doing:

       for (i=node_first_ptr[node]; i<node_first_ptr[node+1]; i++) {
           cpu = node_cpus[i];
           ... do stuff with cpu ...
       }


2: In ACPI there is a table describing the latency ratios between the
nodes. It is called SLIT (System Locality Information Table). On an 8
node system (NEC TX7) this is a matrix of dimension numnodes*numnodes:

int __node_distance[ 8 * 8]    = { 10, 15, 15, 15, 20, 20, 20, 20,
                                   15, 10, 15, 15, 20, 20, 20, 20,
                                   15, 15, 10, 15, 20, 20, 20, 20,
                                   15, 15, 15, 10, 20, 20, 20, 20,
                                   20, 20, 20, 20, 10, 15, 15, 15,
                                   20, 20, 20, 20, 15, 10, 15, 15,
                                   20, 20, 20, 20, 15, 15, 10, 15,
                                   20, 20, 20, 20, 15, 15, 15, 10 };

#define node_distance(i,j)  __node_distance[i*8+j]

This means:
   node_distance(i,i) = 10   (i==j: same node, lowest latency)
   node_distance(i,j) = 15   (i!=j: different node, same supernode)
   node_distance(i,j) = 20   (i!=j: different node, different
                              supernode)

This macro or function describes the NUMA topology of a multi-level
system very well. As the table comes for free with NUMA systems with
ACPI (sooner or later they'll all have this, especially if they want
to run Windows, too), it would be easy to take it into the topology.h.

Regards,
Erich



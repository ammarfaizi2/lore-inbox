Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUH2RXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUH2RXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUH2RX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:23:29 -0400
Received: from holomorphy.com ([207.189.100.168]:49582 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268223AbUH2RXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:23:08 -0400
Date: Sun, 29 Aug 2004 10:22:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
Message-ID: <20040829172250.GM5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1093786747.1708.8.camel@mulgrave> <200408290948.06473.jbarnes@engr.sgi.com> <20040829170328.GK5492@holomorphy.com> <1093799390.10990.19.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093799390.10990.19.camel@mulgrave>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 13:03, William Lee Irwin III wrote:
>> -#define node_to_cpumask(node)	(cpu_online_map)
>> +#define node_to_cpumask(node)	(cpu_possible_map)

On Sun, Aug 29, 2004 at 01:09:49PM -0400, James Bottomley wrote:
> I really don't think so.  This macro is also used at runtime, so there
> it would return CPUs that aren't online.
> It does look like all runtime uses in sched.c pass node_to_cpumask
> through any_online_cpu(), so at least for the scheduler, the change may
> be safe, but you'd have to audit all other runtime uses.

./drivers/base/node.c:22:	cpumask_t mask = node_to_cpumask(node_dev->sysdev.id);
./arch/ia64/sn/io/sn2/ml_SN_intr.c:63:		cpu = first_cpu(node_to_cpumask(cnode));
./arch/ia64/sn/io/sn2/ml_SN_intr.c:69:		cpu = first_cpu(node_to_cpumask(node));
./arch/x86_64/mm/numa.c:30:cpumask_t     node_to_cpumask[MAXNODE]; 
./arch/x86_64/mm/numa.c:163:	set_bit(0, &node_to_cpumask[cpu_to_node(0)]);
./arch/x86_64/mm/numa.c:234:	node_to_cpumask[0] = cpumask_of_cpu(0);
./arch/x86_64/mm/numa.c:242:		set_bit(cpu, &node_to_cpumask[cpu_to_node(cpu)]);
./arch/x86_64/mm/numa.c:277:EXPORT_SYMBOL(node_to_cpumask);
./arch/x86_64/pci/k8-bus.c:57:						node_to_cpumask(NODE_ID(nid));
./include/asm-ppc64/topology.h:24:static inline cpumask_t node_to_cpumask(int node)
./include/asm-ppc64/topology.h:32:	tmp = node_to_cpumask(node);
./include/asm-x86_64/topology.h:16:extern cpumask_t     node_to_cpumask[];
./include/asm-x86_64/topology.h:21:#define node_to_first_cpu(node) 	(__ffs(node_to_cpumask[node]))
./include/asm-x86_64/topology.h:22:#define node_to_cpumask(node)		(node_to_cpumask[node])
./include/asm-generic/topology.h:38:#ifndef node_to_cpumask
./include/asm-generic/topology.h:39:#define node_to_cpumask(node)	(cpu_possible_map)
./include/asm-mips/mach-ip27/topology.h:8:#define node_to_cpumask(node)	(HUB_DATA(node)->h_cpus)
./include/asm-mips/mach-ip27/topology.h:9:#define node_to_first_cpu(node)	(first_cpu(node_to_cpumask(node)))
./include/asm-ia64/topology.h:29:#define node_to_cpumask(node) (node_to_cpu_mask[node])
./include/asm-ia64/topology.h:41:#define node_to_first_cpu(node) (__ffs(node_to_cpumask(node)))
./include/linux/topology.h:41:		__tmp__ = node_to_cpumask(node);				\
./include/asm-alpha/topology.h:25:static inline cpumask_t node_to_cpumask(int node)
./include/asm-i386/topology.h:51:static inline cpumask_t node_to_cpumask(int node)
./include/asm-i386/topology.h:59:	cpumask_t mask = node_to_cpumask(node);
./include/asm-i386/topology.h:66:	return node_to_cpumask(mp_bus_id_to_node[bus]);
./kernel/sched.c:3810:		mask = node_to_cpumask(node);
./kernel/sched.c:4059:		nodemask = node_to_cpumask(next_node);
./kernel/sched.c:4187:		cpumask_t nodemask = node_to_cpumask(cpu_to_node(i));
./kernel/sched.c:4267:		cpumask_t nodemask = node_to_cpumask(i);
./mm/page_alloc.c:1324:		tmp = node_to_cpumask(n);
./mm/vmscan.c:1127:	cpumask = node_to_cpumask(pgdat->node_id);
./mm/vmscan.c:1214:			mask = node_to_cpumask(pgdat->node_id);

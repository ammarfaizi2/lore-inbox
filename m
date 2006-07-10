Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161281AbWGJAbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbWGJAbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161283AbWGJAbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:31:52 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:7653 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161281AbWGJAbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:31:50 -0400
Date: Mon, 10 Jul 2006 09:34:18 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] remove empty node at boot time
Message-Id: <20060710093418.be084931.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200607071726.31646.bjorn.helgaas@hp.com>
References: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com>
	<200607071726.31646.bjorn.helgaas@hp.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 17:26:31 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Thursday 01 June 2006 05:04, KAMEZAWA Hiroyuki wrote:
> > Remove empty node -- a node which containes no cpu, no memory (and no I/O).
> > for ia64.
> > 
> > This patch online nodes which has available resouces and avoid onlining 
> > nodes which has only possible resouces.
> 
> This patch breaks my HP rx8640 box.  I suppose we have some unusual
> SRAT configuration.  I'll debug it more next week.  If there's something
> in particular I should look for, let me know.
> 
> Comparing old (working) with new (broken), I see:
> 
> - Number of logical nodes in system = 3
> + Number of logical nodes in system = 1
> 
> This box has two cells.  Each cell has four CPUs and some local memory.
> There is also an interleaved region that uses memory from both cells.
> I think firmware presents this as a logical node for each cell, plus
> one for the interleaved region.
> 
> This box is configured with minimal local memory on each cell (8MB).
> That's less than a granule, so we should discard it, leaving two nodes
> with CPUs but no memory, and a third node with all the interleaved
> memory but no CPUs.
> 

Then, your box has 
node 0 : cpu x 4, small memory
node 1 : cpu x 4, small memory
node 2 : big memory.

if above node 0 and node 1 disappears, it looks there are some bugs in
cpu detection.

> +	int i, cpu;
> +	/* online node if a node has available cpus */
> +	for (i = 0; i < srat_num_cpus; ++i)
> +		for (cpu = 0; cpu < available_cpus; ++cpu)
> +			if (smp_boot_data.cpu_phys_id[cpu] ==
> +				node_cpuid[i].phys_id) {
> +				node_set_online(node_cpuid[i].nid);
> +				break;
> +			}

Note:
smp_boot_data.cpu_phys_id[i] is set by acpi_parse_lsapic().
node_cpuid[j].phys_id is set by acpi_numa_processor_affinity_init().

-Kame


 

